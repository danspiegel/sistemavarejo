package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.ProdutoVenda;

public class VendaDAO {
	
	public List<Venda> listarVendas(int id) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " SELECT id, valor, id_cliente, datahora, valorpago, troco, id_produto, quantidade, valorproduto, id_vendedor FROM vendas ";
		sql += " INNER JOIN produto_vendas ON (id = id_venda) WHERE id_vendedor = ? ORDER BY datahora";
		List<Venda> vendalista = new ArrayList<Venda>();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, id);
		ResultSet resultado = null;
		try{
			resultado = pst.executeQuery();
			while (resultado.next()){
				Venda venda = new Venda();
				ProdutoVenda produtovenda = new ProdutoVenda();
				venda.setIdVenda(resultado.getInt("id"));
				venda.setValor(resultado.getFloat("valor"));
				venda.setIdCliente(resultado.getInt("id_cliente"));
				venda.setDatahora(resultado.getDate("datahora"));
				venda.setValorpago(resultado.getFloat("valorpago"));
				venda.setTroco(resultado.getFloat("troco"));
				venda.setIdVendedor(id);
				produtovenda.setIdProduto(resultado.getInt("id_produto"));
				produtovenda.setQuantidade(resultado.getInt("quantidade"));
				produtovenda.setValorproduto(resultado.getFloat("valorproduto"));
				produtovenda.setIdVenda(venda.getIdVenda());
				venda.setProdutovenda(produtovenda);
				vendalista.add(venda);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			resultado.close();
			pst.close();
			con.close();
		}
		return vendalista;
	}
	
	public boolean salvarVenda(Venda venda) throws SQLException{
		Connection con = Conexao.getConnection();
	    String sql = "";
	    String sqlprodutovenda = "";
	    String sqlatualizaproduto = "";
	    String sqlatualizaestoque = "";
	    sql += " INSERT INTO vendas (valor, id_cliente, id_vendedor, valorpago, troco) ";
	    sql += " VALUES (?,?,?,?,?) ";
	    sqlprodutovenda += " INSERT INTO produto_vendas (id_produto, id_venda, quantidade, valorproduto) ";
	    sqlprodutovenda += " VALUES (?, (SELECT MAX(id) FROM vendas), ?, ?) ";
	    sqlatualizaproduto += " UPDATE produtos SET unidades = unidades - ? WHERE id = ? ";
	    sqlatualizaestoque += " UPDATE estoques SET totalunidades = totalunidades - ? ";
	    sqlatualizaestoque += " WHERE id = (SELECT id_estoque FROM produtos WHERE id = ?) ";
	    PreparedStatement pst = con.prepareStatement(sql);
	    pst.setFloat(1, venda.getValor());
	    pst.setInt(2, venda.getIdCliente());
	    pst.setInt(3, venda.getIdVendedor());
	    pst.setFloat(4, venda.getValorpago());
	    pst.setFloat(5, venda.getTroco());
	    PreparedStatement pstprodutovenda = con.prepareStatement(sqlprodutovenda);
	    pstprodutovenda.setInt(1, venda.getProdutovenda().getIdProduto());
	    pstprodutovenda.setInt(2, venda.getProdutovenda().getQuantidade());
	    pstprodutovenda.setFloat(3, venda.getProdutovenda().getValorproduto());
	    PreparedStatement pstatualizaproduto = con.prepareStatement(sqlatualizaproduto);
	    pstatualizaproduto.setInt(1, venda.getProdutovenda().getQuantidade());
	    pstatualizaproduto.setInt(2, venda.getProdutovenda().getIdProduto());
	    PreparedStatement pstatualizaestoque = con.prepareStatement(sqlatualizaestoque);
	    pstatualizaestoque.setInt(1, venda.getProdutovenda().getQuantidade());
	    pstatualizaestoque.setInt(2, venda.getProdutovenda().getIdProduto());
	    try{
	    	int linhas = pst.executeUpdate();
	    	if (linhas > 0){
	    		int linhasprodutovenda = pstprodutovenda.executeUpdate();
	    		if (linhasprodutovenda > 0){
	    			int linhasatualizaproduto = pstatualizaproduto.executeUpdate();
	    			if (linhasatualizaproduto > 0){
	    				int linhasatualizaestoque = pstatualizaestoque.executeUpdate();
	    				if (linhasatualizaestoque > 0)
	    					return true;
	    			}
	    		}
	    	}
	    }catch(Exception ex){
	    	ex.printStackTrace();
	    }finally{
	    	pst.close();
	    	pstprodutovenda.close();
	    	pstatualizaproduto.close();
	    	pstatualizaestoque.close();
	    	con.close();
	    }
		return false;
	}
}
