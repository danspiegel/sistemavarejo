package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Estoque;
import Model.EstoqueDAO;

/**
 * Servlet implementation class ControladorEstoque
 */
@WebServlet("/ControladorEstoque")
public class ControladorEstoque extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int codigoacao = Integer.parseInt(request.getParameter("codigoacao"));
		Estoque estoque = new Estoque();
		EstoqueDAO daoestoque = new EstoqueDAO();
		estoque.setIdEstoque(Integer.parseInt(request.getParameter("idEstoque")));
		estoque.setDescricao(request.getParameter("descricao"));
		if (request.getParameter("tamanho") != null){
			estoque.setTamanho(Integer.parseInt(request.getParameter("tamanho")));
		}
		
		if (codigoacao == 4){
			try{
				if (daoestoque.salvarEstoque(estoque)){
					session.setAttribute("estoquestatus", 1);
					response.sendRedirect("View/estoques.jsp");
				}else{
					session.setAttribute("estoquestatus", 2);
					response.sendRedirect("View/estoques.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("estoquestatus", 2);
				response.sendRedirect("View/estoques.jsp");
			}
		}else if (codigoacao == 5){
			try{
				if (daoestoque.atualizarEstoque(estoque)){
					session.setAttribute("estoquestatus", 3);
					response.sendRedirect("View/estoques.jsp");
				}else{
					session.setAttribute("estoquestatus", 4);
					response.sendRedirect("View/estoques.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("estoquestatus", 4);
				response.sendRedirect("View/estoques.jsp");
			}
		}else if (codigoacao == 6){
			try{
				if (daoestoque.excluirEstoque(estoque)){
					session.setAttribute("estoquestatus", 5);
					response.sendRedirect("View/estoques.jsp");
				}else{
					session.setAttribute("estoquestatus", 6);
					response.sendRedirect("View/estoques.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("estoquestatus", 6);
				response.sendRedirect("View/estoques.jsp");
			}
		}
		
	}

}
