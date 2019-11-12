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
<script type="text/javascript" src="../js/valida_campos.js"></script>
<script type="text/javascript" src="../js/janelas.js"></script>
<script type="text/javascript" src="../js/funcoes.js"></script>
<title>Sistema de Varejo Web - Produtos</title>
</head>
<body>
<div class="container">
  <h2>SISTEMA DE VAREJO WEB</h2>
  <ul class="nav nav-tabs">
    <li><a name="vendedor" href="<c:url value="index.jsp"/>">Vendedor</a></li>
    <li><a name="clientes" href="<c:url value="clientes.jsp"/>">Clientes</a></li>
	<li class="active"><a name="produtos" href="<c:url value="produtos.jsp"/>">Produtos</a></li>
	<li><a name="estoques" href="<c:url value="estoques.jsp"/>">Estoques</a></li>
	<li><a name="vendas" href="<c:url value="vendas.jsp"/>">Vendas</a></li>
	<a href="http://localhost:8080/sistemavarejo/ControladorLogout"><button class="btn btn-info">Sair</button></a>
  </ul>

  <div class="tab-content">
  	<h3>Produtos</h3>
  	<c:set var="produtostatus" value='<%= session.getAttribute("produtostatus") %>'/>
    <c:choose>
      	<c:when test="${produtostatus == 1}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Produto cadastrado com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("produtostatus"); %>
        </c:when>
        <c:when test="${produtostatus == 2}">
        	<div class="alert alert-danger">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Erro ao cadastrar produto, tente novamente mais tarde.</strong>
        	</div>
        	<% session.removeAttribute("produtostatus"); %>
        </c:when>
        <c:when test="${produtostatus == 3}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Produto alterado com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("produtostatus"); %>
        </c:when>
        <c:when test="${produtostatus == 4}">
			<div class="alert alert-danger">
  		    	<button type="button" class="close" data-dismiss="alert">×</button>
  		    	<strong>Erro ao alterar produto, tente novamente mais tarde.</strong>
			</div>
			<% session.removeAttribute("produtostatus"); %>
	  	</c:when>
	  	<c:when test="${produtostatus == 5}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Produto excluído com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("produtostatus"); %>
        </c:when>
        <c:when test="${produtostatus == 6}">
			<div class="alert alert-danger">
  		    	<button type="button" class="close" data-dismiss="alert">×</button>
  		    	<strong>Erro ao excluir produto, tente novamente mais tarde.</strong>
			</div>
			<% session.removeAttribute("produtostatus"); %>
		</c:when>
	</c:choose>
    <p id="descricao_produto">Veja a listagem de seus produtos e cadastre eles aqui.</p>
	<table>
    	<tr>
      		<td><button id="cadastrar_cliente" class="btn btn-info" data-toggle="modal" data-target="#cadastro_produto">Cadastrar</button></td>
	  	</tr>
	</table>
	<br/>
	<br/>
	<c:set var="id" value='<%= session.getAttribute("id") %>'/>
	<c:if test="${id == null}">
		<c:redirect url="login.jsp"/>
	</c:if>
	<div id="tabela_produtos">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>COD. PRODUTO</th>
					<th>NOME</th>
					<th>VALOR (R$)</th>
					<th>UNIDADES</th>
					<th>COD. ESTOQUE</th>
					<th></th>
				</tr>
			</thead>
			<jsp:useBean id="produtoDAO" class="Model.ProdutoDAO" />
			<tbody>
				<c:forEach items="${produtoDAO.listarProdutos()}" var="produto">
					<tr>
						<td>${produto.getIdProduto()}</td>
						<td>${produto.getDescricao()}</td>
						<td>
							<fmt:formatNumber value="${produto.getValor()}" maxFractionDigits="2" type="number"/>
						</td>
						<td>${produto.getUnidades()}</td>
						<td>${produto.getIdEstoque()}</td>
						<td>
							<img class="bt_editar_produto" src="../img/editar.png" title="Editar Produto" style="cursor:pointer" data-toggle="modal" data-target="#edicao_produto"/>
							<img class="bt_excluir_produto" src="../img/remover.png" title="Excluir Produto" style="cursor:pointer" data-toggle="modal" data-target="#exclusao"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty produtoDAO.listarProdutos()}">
					<tr>
						<td align="center" colspan="5">
							<font size="4" face="verdana"><b>NÃO EXISTEM PRODUTOS CADASTRADOS</b></font>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<div class="modal fade" id="cadastro_produto" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Cadastro de Produto</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorProduto">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="7">
								<input name="idProduto" type="text" placeholder="Digite o Código" class="form-control input-md" pattern="[0-9]+$" required oninput="validaCodigo(this)">
								<br/>
								<input name="descricao" type="text" placeholder="Digite o Nome" class="form-control input-md" required>
							</div>
							<div class="col-md-4">
								<input id="valor" name="valor" type="text" placeholder="Digite o Valor" class="form-control input-md" required oninput="validaValorProduto(this)">
								<br/>	
								<jsp:useBean id="estoqueDAO" class="Model.EstoqueDAO" />
								<select class="form-control" name="idEstoque" required>
									<option default></option>
									<option disabled>Selecione o Estoque</option>
									<c:forEach items="${estoqueDAO.listarEstoquesLivres()}" var="estoque">
										<option value="${estoque.getIdEstoque()}">${estoque.getIdEstoque()} - ${estoque.getDescricao()}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-4">
								<input name="unidades" type="text" placeholder="Digite as Unidades" class="form-control input-md" pattern="[0-9]+$" required oninput="validaUnidadesProduto(this)">
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
<div class="modal fade" id="edicao_produto" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Edição de Produto</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorProduto">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="8">
								<font size="2" face="verdana">Código:</font>
								<input id="idproduto" name="idProduto" type="text" class="form-control input-md" pattern="[0-9]+$" required readonly="true">
								<br/>
								<font size="2" face="verdana">Descrição:</font>
								<input id="descricaoproduto" name="descricao" type="text" class="form-control input-md" required>
							</div>
							<div class="col-md-4">
								<font size="2" face="verdana">Valor:</font>
								<input id="valorproduto" name="valor" type="text" class="form-control input-md" required oninput="validaValorProduto(this)">
								<br/>
								<font size="2" face="verdana">Estoque:</font>
								<jsp:useBean id="edicaoestoqueDAO" class="Model.EstoqueDAO" />
								<select id="estoqueproduto" class="form-control" name="idEstoque" required>
									<option disabled>Selecione o Estoque</option>
									<c:forEach items="${estoqueDAO.listarEstoquesLivres()}" var="estoque">
										<option value="${estoque.getIdEstoque()}">${estoque.getIdEstoque()} - ${estoque.getDescricao()}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-4">
								<font size="2" face="verdana">Unidades:</font>	
								<input id="unidadesproduto" name="unidades" type="text" value="${unidades}" class="form-control input-md" pattern="[0-9]+$" required oninput="validaUnidadesProduto(this)">
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
<div class="modal fade" id="exclusao" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<br/>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorProduto">
    			<div class="modal-body">
    				<fieldset>
    					<input name="codigoacao" type="hidden" value="9">
    					<input id="id_produto" name="idProduto" type="hidden">
    					<input id="id_estoque" name="idEstoque" type="hidden">
    					<font size="4" face="verdana">Deseja realmente excluir este produto?</font>
					</fieldset>
    			</div>
    			<div class="modal-footer">
    				<button type="submit" class="btn btn-default">Sim</button>
					<button type="button" class="btn btn-default" onclick="fechar()">Não</button>
    			</div>
    		</form>
		</div>
	</div>
</div>
</body>
</html>