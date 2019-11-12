package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Cliente;
import Model.ClienteDAO;

/**
 * Servlet implementation class ControladorCliente
 */
@WebServlet("/ControladorCliente")
public class ControladorCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int codigoacao = Integer.parseInt(request.getParameter("codigoacao"));
		Cliente cliente = new Cliente();
		ClienteDAO daocliente = new ClienteDAO();
		cliente.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
		if (request.getParameter("cpf") != null){
			cliente.setCpf(request.getParameter("cpf"));
		}
		cliente.setNome(request.getParameter("nome"));
		
		if (codigoacao == 1){
			try{
				if (daocliente.salvarCliente(cliente)){
					session.setAttribute("clientestatus", 1);
					response.sendRedirect("View/clientes.jsp");
				}else{
					session.setAttribute("clientestatus", 2);
					response.sendRedirect("View/clientes.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("clientestatus", 2);
				response.sendRedirect("View/clientes.jsp");
			}
		}else if (codigoacao == 2){
			try{
				if (daocliente.atualizarCliente(cliente)){
					session.setAttribute("clientestatus", 3);
					response.sendRedirect("View/clientes.jsp");
				}else{
					session.setAttribute("clientestatus", 4);
					response.sendRedirect("View/clientes.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("clientestatus", 4);
				response.sendRedirect("View/clientes.jsp");
			}
		}else if (codigoacao == 3){
			try{
				if (daocliente.excluirCliente(cliente)){
					session.setAttribute("clientestatus", 5);
					response.sendRedirect("View/clientes.jsp");
				}else{
					session.setAttribute("clientestatus", 6);
					response.sendRedirect("View/clientes.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("clientestatus", 6);
				response.sendRedirect("View/clientes.jsp");
			}
		}
	}

}
