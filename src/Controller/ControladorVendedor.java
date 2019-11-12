package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Vendedor;
import Model.VendedorDAO;

/**
 * Servlet implementation class ControladorVendedor
 */
@WebServlet("/ControladorVendedor")
public class ControladorVendedor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int codigoacao = Integer.parseInt(request.getParameter("codigoacao"));
		Vendedor vendedor = new Vendedor();
		if (request.getParameter("idVendedor") != null){
			vendedor.setIdVendedor(Integer.parseInt(request.getParameter("idVendedor")));
		}
		if (request.getParameter("nome") != null){
			vendedor.setNome(request.getParameter("nome"));
		}
		if (request.getParameter("cpf") != null){
			vendedor.setCpf(request.getParameter("cpf"));
		}
		if (request.getParameter("login") != null){
			vendedor.setLogin(request.getParameter("login"));
		}
		if (request.getParameter("senha") != null){
			vendedor.setSenha(request.getParameter("senha"));
		}
		VendedorDAO daovendedor = new VendedorDAO();
		
		
		if (codigoacao == 1){
			try{
				if (daovendedor.verificarVendedor(vendedor)){
					session.setAttribute("id", vendedor.getIdVendedor());
					session.setAttribute("login", request.getParameter("login"));
					session.setAttribute("senha", request.getParameter("senha"));
					session.setAttribute("nome", vendedor.getNome());
					session.setAttribute("cpf", vendedor.getCpf());
					response.sendRedirect("View/index.jsp");
				}else {
					session.removeAttribute("vendedorstatus");
					session.setAttribute("vendedorstatus", 0);
					session.setAttribute("logininvalido", 1);
					response.sendRedirect("View/login.jsp");			
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.removeAttribute("vendedorstatus");
				session.setAttribute("vendedorstatus", 0);
				session.setAttribute("logininvalido", 1);
				response.sendRedirect("View/index.jsp");
			}
		}else if (codigoacao == 2){
			try{
				if (daovendedor.salvarVendedor(vendedor)){
					session.setAttribute("vendedorstatus", 1);
					session.removeAttribute("logininvalido");
					session.setAttribute("logininvalido", 0);
					response.sendRedirect("View/login.jsp");
				}else {
					session.setAttribute("vendedorstatus", 2);
					response.sendRedirect("View/vendedores.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("vendedorstatus", 2);
				response.sendRedirect("View/vendedores.jsp");
			}
		}else if (codigoacao == 3){
			try{
				if (daovendedor.atualizarDadosPessoaisVendedor(vendedor)){
					session.removeAttribute("nome");
					session.removeAttribute("cpf");
					session.setAttribute("nome", vendedor.getNome());
					session.setAttribute("cpf", vendedor.getCpf());
					session.setAttribute("vendedorstatus", 3);
					response.sendRedirect("View/index.jsp");
				}else{
					session.setAttribute("vendedorstatus", 4);
					response.sendRedirect("View/index.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("vendedorstatus", 4);
				response.sendRedirect("View/index.jsp");
			}
		}else if (codigoacao == 4){
			try{
				if (daovendedor.atualizarDadosContaVendedor(vendedor)){
					session.removeAttribute("senha");
					session.setAttribute("senha", request.getParameter("senha"));
					session.setAttribute("vendedorstatus", 5);
					response.sendRedirect("View/index.jsp");
				}else{
					session.setAttribute("vendedorstatus", 6);
					response.sendRedirect("View/index.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("vendedorstatus", 6);
				response.sendRedirect("View/index.jsp");
			}
		}
		
	}

}
