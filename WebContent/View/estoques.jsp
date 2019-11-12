<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>Sistema de Varejo Web - Estoques</title>
</head>
<body>
<div class="container">
  <h2>SISTEMA DE VAREJO WEB</h2>
  <ul class="nav nav-tabs">
    <li><a name="vendedor" href="<c:url value="index.jsp"/>">Vendedor</a></li>
    <li><a name="clientes" href="<c:url value="clientes.jsp"/>">Clientes</a></li>
	<li><a name="produtos" href="<c:url value="produtos.jsp"/>">Produtos</a></li>
	<li class="active"><a name="estoques" href="<c:url value="estoques.jsp"/>">Estoques</a></li>
	<li><a name="vendas" href="<c:url value="vendas.jsp"/>">Vendas</a></li>
	<a href="http://localhost:8080/sistemavarejo/ControladorLogout"><button class="btn btn-info">Sair</button></a>
  </ul>

  <div class="tab-content">
  	<h3>Estoques</h3>
  	<c:set var="estoquestatus" value='<%= session.getAttribute("estoquestatus") %>'/>
    <c:choose>
      	<c:when test="${estoquestatus == 1}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Estoque cadastrado com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("estoquestatus"); %>
        </c:when>
        <c:when test="${estoquestatus == 2}">
        	<div class="alert alert-error">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Erro ao cadastrar estoque, tente novamente mais tarde.</strong>
        	</div>
        	<% session.removeAttribute("estoquestatus"); %>
        </c:when>
        <c:when test="${estoquestatus == 3}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Estoque alterado com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("estoquestatus"); %>
        </c:when>
        <c:when test="${estoquestatus == 4}">
			<div class="alert alert-error">
  		    	<button type="button" class="close" data-dismiss="alert">×</button>
  		    	<strong>Erro ao alterar estoque, tente novamente mais tarde.</strong>
			</div>
			<% session.removeAttribute("estoquestatus"); %>
	  	</c:when>
	  	<c:when test="${estoquestatus == 5}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Estoque excluído com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("estoquestatus"); %>
        </c:when>
        <c:when test="${estoquestatus == 6}">
			<div class="alert alert-error">
  		    	<button type="button" class="close" data-dismiss="alert">×</button>
  		    	<strong>Erro ao excluir estoque, tente novamente mais tarde.</strong>
			</div>
			<% session.removeAttribute("estoquestatus"); %>
		</c:when>
	</c:choose>
    <p id="descricao_produto">Veja a listagem de seus estoques e cadastre eles aqui.</p>
	<table>
    	<tr>
      		<td><button id="cadastrar_cliente" class="btn btn-info" data-toggle="modal" data-target="#cadastro_estoque">Cadastrar</button></td>
	  	</tr>
	</table>
	<br/>
	<br/>
	<c:set var="id" value='<%= session.getAttribute("id") %>'/>
	<c:if test="${id == null}">
		<c:redirect url="login.jsp"/>
	</c:if>
	<div id="tabela_produtos">
		<table class="table table-striped" id="gridestoque">
			<thead>
				<tr>
					<th>COD. ESTOQUE</th>
					<th>DESCRIÇÃO</th>
					<th>TAMANHO</th>
					<th>TOTAL UNIDADES</th>
					<th>STATUS</th>
					<th></th>
				</tr>
			</thead>
			<jsp:useBean id="estoqueDAO" class="Model.EstoqueDAO" />
			<tbody>
				<c:forEach items="${estoqueDAO.listarEstoques()}" var="estoque">
					<tr>
						<td>${estoque.getIdEstoque()}</td>
						<td>${estoque.getDescricao()}</td>
						<td>${estoque.getTamanho()}</td>
						<td>${estoque.getTotalunidades()}</td>
						<c:if test="${estoque.getSituacao() == 'LIVRE'}">
							<td><font color="green"><b>${estoque.getSituacao()}</b></font></td>
						</c:if>
						<c:if test="${estoque.getSituacao() == 'LOTADO'}">
							<td><font color="red"><b>${estoque.getSituacao()}</b></font></td>
						</c:if>
						<td>
							<img class="bt_editar_estoque" src="../img/editar.png" title="Editar Estoque" style="cursor:pointer" data-toggle="modal" data-target="#edicao_estoque"/>
							<img class="bt_excluir_estoque" src="../img/remover.png" title="Excluir Estoque" style="cursor:pointer" data-toggle="modal" data-target="#exclusao"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty estoqueDAO.listarEstoques()}">
					<tr>
						<td align="center" colspan="5">
							<font size="4" face="verdana"><b>NÃO EXISTEM ESTOQUES CADASTRADOS</b></font>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<div class="modal fade" id="cadastro_estoque" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Cadastro de Estoque</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorEstoque">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="4">
								<input name="idEstoque" type="text" placeholder="Digite o Código" class="form-control input-md" pattern="[0-9]+$" required="" oninput="validaCodigo(this)">					<br/>
								<input name="descricao" type="text" placeholder="Digite o Nome" class="form-control input-md" required="">
							</div>
							<div class="col-md-4">
								<input name="tamanho" type="text" placeholder="Digite o Tamanho" class="form-control input-md" pattern="[0-9]+$" required="" oninput="validaTamanhoEstoque(this)">	
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
<div class="modal fade" id="edicao_estoque" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Edição de Estoque</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorEstoque">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="5">
								<font size="2" face="verdana">Código:</font>
								<input id="idestoque" name="idEstoque" type="text" class="form-control input-md" pattern="[0-9]+$" required="" readonly="true">
								<br/>
								<font size="2" face="verdana">Descrição:</font>
								<input id="descricaoestoque" name="descricao" type="text" class="form-control input-md" required="">
							</div>
							<div class="col-md-4">
								<font size="2" face="verdana">Tamanho:</font>
								<input id="tamanhoestoque" name="tamanho" type="text" class="form-control input-md" pattern="[0-9]+$" required="" oninput="validaTamanhoEstoque(this)">	
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
    		<form class="form-horizontal" method="post" action="../ControladorEstoque">
    			<div class="modal-body">
    				<fieldset>
    					<input name="codigoacao" type="hidden" value="6">
    					<input id="id_estoque" name="idEstoque" type="hidden">
    					<font size="4" face="verdana">Ao apagar o estoque todos os produtos que estiverem nele também serão apagados. Deseja realmente excluir este estoque?</font>
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