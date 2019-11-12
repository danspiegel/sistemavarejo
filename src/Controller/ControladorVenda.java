package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Venda;
import Model.ProdutoVenda;
import Model.VendaDAO;

/**
 * Servlet implementation class ControladorVenda
 */
@WebServlet("/ControladorVenda")
public class ControladorVenda extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		Venda venda = new Venda();
		ProdutoVenda produtovenda = new ProdutoVenda();
		venda.setIdVendedor(Integer.parseInt(request.getParameter("idVendedor")));
		venda.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
		produtovenda.setIdProduto(Integer.parseInt(request.getParameter("idProduto")));
		produtovenda.setValorproduto(Float.parseFloat(request.getParameter("valorproduto")));
		produtovenda.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
		venda.setProdutovenda(produtovenda);
		venda.setValor(Float.parseFloat(request.getParameter("valor")));
		venda.setValorpago(Float.parseFloat(request.getParameter("valorpago")));
		venda.setTroco(Float.parseFloat(request.getParameter("troco")));
		VendaDAO daovenda = new VendaDAO();
		
		try{
			if (daovenda.salvarVenda(venda)){
				session.setAttribute("vendastatus", 1);
				response.sendRedirect("View/vendas.jsp");
			}else{
				session.setAttribute("vendastatus", 2);
				response.sendRedirect("View/vendas.jsp");
			}
		}catch(Exception ex){
			ex.printStackTrace();
			session.setAttribute("vendastatus", 2);
			response.sendRedirect("View/vendas.jsp");
		}
		
	}

}
