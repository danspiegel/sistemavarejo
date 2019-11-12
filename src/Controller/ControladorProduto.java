package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Produto;
import Model.ProdutoDAO;

/**
 * Servlet implementation class ControladorProduto
 */
@WebServlet("/ControladorProduto")
public class ControladorProduto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int codigoacao = Integer.parseInt(request.getParameter("codigoacao"));
		Produto produto = new Produto();
		ProdutoDAO daoproduto = new ProdutoDAO();
		if (request.getParameter("idProduto") != null){
			produto.setIdProduto(Integer.parseInt(request.getParameter("idProduto")));
		}
		if (request.getParameter("descricao") != null){
			produto.setDescricao(request.getParameter("descricao"));
		}
		if (request.getParameter("valor") != null){
			produto.setValor(Float.parseFloat(request.getParameter("valor")));
		}
		if (request.getParameter("idEstoque") != null){
			produto.setIdEstoque(Integer.parseInt(request.getParameter("idEstoque")));
		}
		
		if (request.getParameter("unidades") != null){
			produto.setUnidades(Integer.parseInt(request.getParameter("unidades")));
		}
		
		if (codigoacao == 7){
			try{
				if (daoproduto.salvarProduto(produto)){
					session.setAttribute("produtostatus", 1);
					response.sendRedirect("View/produtos.jsp");
				}else{
					session.setAttribute("produtostatus", 2);
					response.sendRedirect("View/produtos.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("produtostatus", 2);
				response.sendRedirect("View/produtos.jsp");
			}
		}else if (codigoacao == 8){
			try{
				if (daoproduto.atualizarProduto(produto)){
					session.setAttribute("produtostatus", 3);
					response.sendRedirect("View/produtos.jsp");
				}else{
					session.setAttribute("produtostatus", 4);
					response.sendRedirect("View/produtos.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("produtostatus", 4);
				response.sendRedirect("View/produtos.jsp");
			}
		}else if (codigoacao == 9){
			try{
				if (daoproduto.excluirProduto(produto)){
					session.setAttribute("produtostatus", 5);
					response.sendRedirect("View/produtos.jsp");
				}else{
					session.setAttribute("produtostatus", 6);
					response.sendRedirect("View/produtos.jsp");
				}
			}catch(Exception ex){
				ex.printStackTrace();
				session.setAttribute("produtostatus", 6);
				response.sendRedirect("View/produtos.jsp");
			}
		}
		
	}

}
