package Model;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

public class Conexao {
  public static String status = "";
  
  public static Connection getConnection(){
	    Connection con = null;
	    try{
	      Class.forName("org.postgresql.Driver").newInstance();
	      String url = "jdbc:postgresql://127.0.0.1/sistemavarejo";
	      con = DriverManager.getConnection(url,"postgres","postgres");
	      status = "Conexão Aberta!";
	    }catch(SQLException e){
	      status = e.getMessage();
	    }catch (ClassNotFoundException e){
	      status =e.getMessage();
	    }catch (Exception e){
	      status = e.getMessage();
	    }
	    return con;
  }
}