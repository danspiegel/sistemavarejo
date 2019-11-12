package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class EstoqueDAO {

	public boolean salvarEstoque(Estoque estoque) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += "INSERT INTO estoques (id,descricao,tamanho) VALUES (?,?,?)";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, estoque.getIdEstoque());
		pst.setString(2, estoque.getDescricao());
		pst.setInt(3, estoque.getTamanho());
		try {
			int linhas = pst.executeUpdate();
			if (linhas > 0)
				return true;
		}catch (Exception ex){
			ex.printStackTrace();
		}finally{
			pst.close();
			con.close();
		}
		return false;
	}
	
	public boolean atualizarEstoque(Estoque estoque) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " UPDATE estoques SET descricao = ?, tamanho = ? WHERE id = ? ";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, estoque.getDescricao());
		pst.setInt(2, estoque.getTamanho());
		pst.setInt(3, estoque.getIdEstoque());
		try{
			int linhas = pst.executeUpdate();
			if (linhas > 0){
				return true;
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			pst.close();
			con.close();
		}
		return false;
	}
	
	public List<Estoque> listarEstoques() throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " SELECT id, descricao, tamanho, totalunidades, (tamanho-totalunidades)espacolivre FROM estoques ";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet resultado = null;
		List<Estoque> estoqueslista = new ArrayList<Estoque>();
		try{
			resultado = pst.executeQuery();
			while (resultado.next()){
				Estoque estoque = new Estoque();
				estoque.setIdEstoque(resultado.getInt("id"));
				estoque.setDescricao(resultado.getString("descricao"));
				estoque.setTamanho(resultado.getInt("tamanho"));
				estoque.setTotalunidades(resultado.getInt("totalunidades"));
				estoque.setEspacolivre(resultado.getInt("espacolivre"));
				if (estoque.getEspacolivre() > 0){
					estoque.setSituacao("LIVRE");
				}else{
					estoque.setSituacao("LOTADO");
				}
				estoqueslista.add(estoque);	
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			resultado.close();
			pst.close();
			con.close();
		}
		return estoqueslista;
	}
	
	public List<Estoque> listarEstoquesLivres() throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " SELECT id, descricao, (tamanho-totalunidades)espacolivre FROM estoques WHERE totalunidades < tamanho ORDER BY id ";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet resultado = null;
		List<Estoque> estoqueslivres = new ArrayList<Estoque>();
		try{
			resultado = pst.executeQuery();
			while (resultado.next()){
				Estoque estoque = new Estoque();
				estoque.setIdEstoque(resultado.getInt("id"));
				estoque.setDescricao(resultado.getString("descricao"));
				estoque.setEspacolivre(resultado.getInt("espacolivre"));
				estoqueslivres.add(estoque);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			resultado.close();
			pst.close();
			con.close();
		}
		return estoqueslivres;
	}
	
	public boolean excluirEstoque(Estoque estoque) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " DELETE FROM estoques WHERE id = ? ";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, estoque.getIdEstoque());
		try{
			int linhas = pst.executeUpdate();
			if (linhas > 0)
				return true;
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			pst.close();
			con.close();
		}
		return false;
	}
}
