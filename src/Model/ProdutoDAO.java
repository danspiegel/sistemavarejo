package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {
	
	public boolean salvarProduto(Produto produto) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		String sqlestoque = "";
		sql += " INSERT INTO produtos (id, descricao, valor, unidades, id_estoque) VALUES (?,?,?,?,?) ";
		sqlestoque += " UPDATE estoques SET totalunidades = totalunidades + ? WHERE id = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, produto.getIdProduto());
		pst.setString(2, produto.getDescricao());
		pst.setFloat(3, produto.getValor());
		pst.setInt(4, produto.getUnidades());
		pst.setInt(5, produto.getIdEstoque());
		PreparedStatement pstestoques = con.prepareStatement(sqlestoque);
		pstestoques.setInt(1, produto.getUnidades());
		pstestoques.setInt(2, produto.getIdEstoque());
		try {
			int linhas = pst.executeUpdate();
			if (linhas > 0){
				int linhasestoque = pstestoques.executeUpdate();
				if (linhasestoque > 0)
					return true;
			}
		}catch (Exception ex){
			ex.printStackTrace();
		}finally{
			pstestoques.close();
			pst.close();
			con.close();
		}
		return false;
	}
	
	public boolean atualizarProduto(Produto produto) throws SQLException{
		Connection con = Conexao.getConnection();
		String sqlattestoqueini = "";
		String sqlattprodutos = "";
		String sqlattestoquefim = "";
		sqlattestoqueini += " UPDATE estoques SET totalunidades = totalunidades - (SELECT unidades FROM produtos WHERE id = ?) ";
		sqlattestoqueini += " WHERE id = (SELECT id_estoque FROM produtos WHERE id = ?) ";
		sqlattprodutos += " UPDATE produtos SET descricao = ?, valor = ?, unidades = ?, id_estoque = ? WHERE id = ? ";
		sqlattestoquefim += " UPDATE estoques SET totalunidades = totalunidades + ? ";
		sqlattestoquefim += " WHERE id = (SELECT id_estoque FROM produtos WHERE id = ?) ";
		PreparedStatement pstestoqueini = con.prepareStatement(sqlattestoqueini);
		pstestoqueini.setInt(1, produto.getIdProduto());
		pstestoqueini.setInt(2, produto.getIdProduto());
		PreparedStatement pstprodutos = con.prepareStatement(sqlattprodutos);
		pstprodutos.setString(1, produto.getDescricao());
		pstprodutos.setFloat(2, produto.getValor());
		pstprodutos.setInt(3, produto.getUnidades());
		pstprodutos.setInt(4, produto.getIdEstoque());
		pstprodutos.setInt(5, produto.getIdProduto());
		PreparedStatement pstestoquefim = con.prepareStatement(sqlattestoquefim);
		pstestoquefim.setInt(1, produto.getUnidades());
		pstestoquefim.setInt(2, produto.getIdProduto());
		try{
			int linhasestoqueini = pstestoqueini.executeUpdate();
			if (linhasestoqueini > 0){
				int linhasprodutos = pstprodutos.executeUpdate();
				if (linhasprodutos > 0){
					int linhasestoquefim = pstestoquefim.executeUpdate();
					if (linhasestoquefim > 0)
						return true;
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			pstestoqueini.close();
			pstprodutos.close();
			pstestoquefim.close();
			con.close();
		}
		return false;
	}
	
	public List<Produto> listarProdutos() throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " SELECT id, descricao, valor, id_estoque, unidades FROM produtos ";
		sql += " ORDER BY id ";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet resultado = null;
		List<Produto> produtoslista = new ArrayList<Produto>();
		try{
			resultado = pst.executeQuery();
			while (resultado.next()){
				Produto produto = new Produto();
				produto.setIdProduto(resultado.getInt("id"));
				produto.setDescricao(resultado.getString("descricao"));
				produto.setValor(resultado.getFloat("valor"));
				produto.setUnidades(resultado.getInt("unidades"));
				produto.setIdEstoque(resultado.getInt("id_estoque"));
				produtoslista.add(produto);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			resultado.close();
			pst.close();
			con.close();
		}
		return produtoslista;
	}
	
	public List<Produto> listarProdutosDisponiveis() throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " SELECT id, descricao, valor, id_estoque, unidades FROM produtos WHERE unidades > 0 ";
		sql += " ORDER BY id ";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet resultado = null;
		List<Produto> produtoslista = new ArrayList<Produto>();
		try{
			resultado = pst.executeQuery();
			while (resultado.next()){
				Produto produto = new Produto();
				produto.setIdProduto(resultado.getInt("id"));
				produto.setDescricao(resultado.getString("descricao"));
				produto.setValor(resultado.getFloat("valor"));
				produto.setUnidades(resultado.getInt("unidades"));
				produto.setIdEstoque(resultado.getInt("id_estoque"));
				produtoslista.add(produto);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			resultado.close();
			pst.close();
			con.close();
		}
		return produtoslista;
	}

	public boolean excluirProduto(Produto produto) throws SQLException{
		Connection con = Conexao.getConnection();
		String sqlestoque = "";
		String sqlproduto = "";
		sqlestoque += " UPDATE estoques SET totalunidades = totalunidades-(SELECT unidades FROM produtos WHERE id = ?) ";
		sqlestoque += " WHERE id = ? ";
		sqlproduto += " DELETE FROM produtos WHERE id = ? ";
		PreparedStatement pstestoque = con.prepareStatement(sqlestoque);
		pstestoque.setInt(1, produto.getIdProduto());
		pstestoque.setInt(2, produto.getIdEstoque());
		PreparedStatement pstproduto = con.prepareStatement(sqlproduto);
		pstproduto.setInt(1, produto.getIdProduto());
		try{
			int linhasestoque = pstestoque.executeUpdate();
			if (linhasestoque > 0){
				int linhasproduto = pstproduto.executeUpdate();
				if (linhasproduto > 0)
					return true;
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			pstestoque.close();
			pstproduto.close();
			con.close();
		}
		return false;
	}
}
