<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/valoresvenda.js"></script>
<script type="text/javascript" src="../js/funcoes.js"></script>
<title>Sistema de Varejo Web - Vendas</title>
</head>
<body>
<div class="container">
  <h2>SISTEMA DE VAREJO WEB</h2>
  <ul class="nav nav-tabs">
    <li><a name="vendedor" href="<c:url value="index.jsp"/>">Vendedor</a></li>
    <li><a name="clientes" href="<c:url value="clientes.jsp"/>">Clientes</a></li>
	<li><a name="produtos" href="<c:url value="produtos.jsp"/>">Produtos</a></li>
	<li><a name="estoques" href="<c:url value="estoques.jsp"/>">Estoques</a></li>
	<li class="active"><a name="vendas" href="<c:url value="vendas.jsp"/>">Vendas</a></li>
	<a href="http://localhost:8080/sistemavarejo/ControladorLogout"><button class="btn btn-info">Sair</button></a>
  </ul>
  
  <div class="tab-content">
  	<h3>Vendas</h3>
  	<c:set var="vendastatus" value='<%= session.getAttribute("vendastatus") %>'/>
    <c:choose>
      	<c:when test="${vendastatus == 1}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Venda cadastrado com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("vendastatus"); %>
        </c:when>
        <c:when test="${vendastatus == 2}">
        	<div class="alert alert-danger">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Erro ao cadastrar a venda, tente novamente mais tarde.</strong>
        	</div>
        	<% session.removeAttribute("vendastatus"); %>
        </c:when>
	</c:choose>
    <p id="descricao_produto">Veja a listagem de suas vendas e realize elas.</p>
	<table>
    	<tr>
      		<td><button id="cadastrar_venda" class="btn btn-info" data-toggle="modal" data-target="#cadastro_venda">Cadastrar</button></td>
	  	</tr>
	</table>
	<br/>
	<br/>
	<div id="tabela_clientes">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>COD. VENDA</th>
					<th>COD. CLIENTE</th>
					<th>COD. PRODUTO</th>
					<th>VALOR PRODUTO</th>
					<th>QUANTIDADE</th>
					<th>VALOR TOTAL</th>
					<th>VALOR PAGO</th>
					<th>TROCO</th>
					<th>DATA</th>
				</tr>
			</thead>
			<jsp:useBean id="vendaDAO" class="Model.VendaDAO"/>		
			<c:set var="codvendedor" value='<%= session.getAttribute("id") %>'/>
			<c:if test="${codvendedor == null}">
				<c:redirect url="login.jsp"/>
			</c:if>
			<tbody>
				<c:forEach items="${vendaDAO.listarVendas(codvendedor)}" var="venda">
					<tr align="center">
						<td>${venda.getIdVenda()}</td>
						<td>${venda.getIdCliente()}</td>
						<td>${venda.getProdutovenda().getIdProduto()}</td>
						<td>
							<fmt:formatNumber value="${venda.getProdutovenda().getValorproduto()}" type="currency"/>
						</td>
						<td>${venda.getProdutovenda().getQuantidade()}</td>
						<td>
							<fmt:formatNumber value="${venda.getValor()}" type="currency"/>
						</td>
						<td>
							<fmt:formatNumber value="${venda.getValorpago()}" type="currency"/>
						</td>
						<td>
							<fmt:formatNumber value="${venda.getTroco()}" type="currency"/>
						</td>
						<td>
							<fmt:formatDate pattern="dd/MM/yyyy" value="${venda.getDatahora()}"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty vendaDAO.listarVendas(codvendedor)}">
					<tr>
						<td align="center" colspan="9">
							<font size="4" face="verdana"><b>NÃO EXISTEM VENDAS CADASTRADAS POR VOCÊ</b></font>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
    </div>
  </div>
</div>
<div class="modal fade" id="cadastro_venda" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Cadastro de Venda</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorVenda">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">	
								<jsp:useBean id="clienteDAO" class="Model.ClienteDAO" />
								<jsp:useBean id="vendedor" class="Model.Vendedor" />
								<input type="hidden" name="idVendedor" value="<%= session.getAttribute("id")%>"/>
								<font size="2" face="verdana">Cliente:</font>
								<select class="form-control" name="idCliente" required>
									<option default></option>
									<option disabled>Selecione o Cliente</option>
									<c:forEach items="${clienteDAO.listarClientes()}" var="cliente">
										<option value="${cliente.getIdCliente()}">${cliente.getIdCliente()} - ${cliente.getNome()}</option>
									</c:forEach>
								</select>
								<jsp:useBean id="produtoDAO" class="Model.ProdutoDAO" />
								<font size="2" face="verdana">Produto:</font>
								<select class="form-control" id="idProduto" name="idProduto" required>
									<option default></option>
									<option disabled>Selecione o Produto</option>
									<c:forEach items="${produtoDAO.listarProdutosDisponiveis()}" var="produto">
										<option value="${produto.getIdProduto()}" valorProduto="${produto.getValor()}">${produto.getIdProduto()} - ${produto.getDescricao()}</option>
									</c:forEach>
								</select>
								<font size="2" face="verdana">Valor Produto:</font>
								<input id="valorproduto" name="valorproduto" type="text" value="" class="form-control input-md" required="" readonly="true">
							</div>
							<div class="col-md-4">
								<font size="2" face="verdana">Quantidade:</font>
								<input id="quantidade" name="quantidade" type="text" class="form-control input-md" pattern="[0-9]+$" required="">
								<font size="2" face="verdana">Valor Total:</font>
								<input id="valor" name="valor" type="text" class="form-control input-md" pattern="[0-9]+$" required="" readonly="true">
								<font size="2" face="verdana">Valor Pago:</font>
								<input id="valorpago" name="valorpago" type="text" class="form-control input-md" pattern="[0-9]+$" required="">
							</div>
							<div class="col-md-4">
								<font size="2" face="verdana">Troco:</font>
								<input id="troco" name="troco" type="text" class="form-control input-md" pattern="[0-9]+$" required="" readonly="true">
							</div>
						</div>
					</fieldset>
    			</div>
    			<div class="modal-footer">
    				<button type="submit" class="btn btn-default">Gravar</button>
    			</div>
    		</form>
		</div>
	</div>
</div>
</body>
</html>