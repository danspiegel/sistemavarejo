package Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

	public boolean salvarCliente(Cliente cliente) throws SQLException{
		Connection con = Conexao.getConnection();
	    String sql = "";
	    sql += "INSERT INTO clientes (id,nome,cpf) VALUES (?,?,?)";
	    PreparedStatement pst = con.prepareStatement(sql);
	    pst.setInt(1, cliente.getIdCliente());
	    pst.setString(2, cliente.getNome());
	    pst.setString(3, cliente.getCpf());
		try{
			int linhas = pst.executeUpdate();
			if (linhas > 0)
				return true;
		}catch(Exception ex){
			ex.getMessage();
		}finally{
			pst.close();
		    con.close();
		}
		return false;
	}
	
	public boolean atualizarCliente(Cliente cliente) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += "UPDATE clientes SET nome = ?, cpf = ? WHERE id = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, cliente.getNome());
		pst.setString(2, cliente.getCpf());
		pst.setInt(3, cliente.getIdCliente());
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
    
	public List<Cliente> listarClientes() throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " SELECT id, nome, cpf FROM clientes ORDER BY id";
		List<Cliente> clienteslista = new ArrayList<Cliente>();
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet resultado = null;
		try{
			resultado = pst.executeQuery();
			while (resultado.next()){
				Cliente cliente = new Cliente();
				cliente.setIdCliente(resultado.getInt("id"));
				cliente.setNome(resultado.getString("nome"));
				cliente.setCpf(resultado.getString("cpf"));
				clienteslista.add(cliente);	
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			resultado.close();
			pst.close();
			con.close();
		}
		return clienteslista;
	}
   
	public boolean excluirCliente(Cliente cliente) throws SQLException{
		Connection con = Conexao.getConnection();
		String sql = "";
		sql += " DELETE FROM clientes WHERE id = ? ";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, cliente.getIdCliente());
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
