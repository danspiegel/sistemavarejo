package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class VendedorDAO {
	
	public boolean verificarVendedor(Vendedor vendedor) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " SELECT id, nome, cpf FROM vendedores WHERE login = ? AND senha = ? ";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, vendedor.getLogin());
		pst.setString(2, vendedor.getSenha());
		ResultSet resultado = null;
		try{
			resultado = pst.executeQuery();
			if (resultado.next()){
				vendedor.setIdVendedor(resultado.getInt("id"));
				vendedor.setNome(resultado.getString("nome"));
				vendedor.setCpf(resultado.getString("cpf"));
				return true;
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			resultado.close();
			pst.close();
			con.close();
		}
		return false;
	}
	
	public boolean salvarVendedor(Vendedor vendedor) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += "INSERT INTO vendedores (nome,login,senha,cpf) VALUES (?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, vendedor.getNome());
		pst.setString(2, vendedor.getLogin());
		pst.setString(3, vendedor.getSenha());
		pst.setString(4, vendedor.getCpf());
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
	
	public boolean atualizarDadosPessoaisVendedor(Vendedor vendedor) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += "UPDATE vendedores SET nome = ?, cpf = ? WHERE id = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, vendedor.getNome());
		pst.setString(2, vendedor.getCpf());
		pst.setInt(3, vendedor.getIdVendedor());
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
	
	public boolean atualizarDadosContaVendedor(Vendedor vendedor) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += "UPDATE vendedores SET senha = ? WHERE id = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, vendedor.getSenha());
		pst.setInt(2, vendedor.getIdVendedor());
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
