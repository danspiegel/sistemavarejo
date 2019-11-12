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
<title>Sistema de Varejo Web - Clientes</title>
</head>
<body>
<div class="container">
  <h2>SISTEMA DE VAREJO WEB</h2>
  <ul class="nav nav-tabs">
    <li><a name="vendedor" href="<c:url value="index.jsp"/>">Vendedor</a></li>
    <li class="active"><a name="clientes" href="<c:url value="clientes.jsp"/>">Clientes</a></li>
	<li><a name="produtos" href="<c:url value="produtos.jsp"/>">Produtos</a></li>
	<li><a name="estoques" href="<c:url value="estoques.jsp"/>">Estoques</a></li>
	<li><a name="vendas" href="<c:url value="vendas.jsp"/>">Vendas</a></li>
	<a href="http://localhost:8080/sistemavarejo/ControladorLogout"><button class="btn btn-info">Sair</button></a>
  </ul>

  <div class="tab-content">
      <h3>Clientes</h3>
      <c:set var="clientestatus" value='<%= session.getAttribute("clientestatus") %>'/>
      <c:choose>
      	<c:when test="${clientestatus == 1}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Cliente cadastrado com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("clientestatus"); %>
        </c:when>
        <c:when test="${clientestatus == 2}">
        	<div class="alert alert-danger">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Erro ao cadastrar cliente, tente novamente mais tarde.</strong>
        	</div>
        	<% session.removeAttribute("clientestatus"); %>
        </c:when>
        <c:when test="${clientestatus == 3}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Cliente alterado com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("clientestatus"); %>
        </c:when>
        <c:when test="${clientestatus == 4}">
			<div class="alert alert-danger">
  		    	<button type="button" class="close" data-dismiss="alert">×</button>
  		    	<strong>Erro ao atualizar cliente, tente novamente mais tarde.</strong>
			</div>
			<% session.removeAttribute("clientestatus"); %>
	  	</c:when>
	  	<c:when test="${clientestatus == 5}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Cliente excluído com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("clientestatus"); %>
        </c:when>
        <c:when test="${clientestatus == 6}">
			<div class="alert alert-danger">
  		    	<button type="button" class="close" data-dismiss="alert">×</button>
  		    	<strong>Erro ao excluir cliente, tente novamente mais tarde.</strong>
			</div>
			<% session.removeAttribute("clientestatus"); %>
	  	</c:when>
	  </c:choose>
      <p id="descricao_cliente">Veja a listagem de seus clientes e cadastre eles aqui.</p>
      <table>
      	<tr>
      		<td><button id="cadastrar_cliente" class="btn btn-info" data-toggle="modal" data-target="#cadastro_cliente">Cadastrar</button></td>
	  	</tr>
	  </table>
	  <br/>
	  <br/>
	  <c:set var="id" value='<%= session.getAttribute("id") %>'/>
	  <c:if test="${id == null}">
	  	<c:redirect url="login.jsp"/>
	  </c:if>
	  <div id="tabela_clientes">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>COD. CLIENTE</th>
					<th>NOME</th>
					<th>CPF</th>
					<th></th>
				</tr>
			</thead>
			<jsp:useBean id="clienteDAO" class="Model.ClienteDAO" />			
			<tbody>
				<c:forEach items="${clienteDAO.listarClientes()}" var="cliente">
					<tr>
						<td>${cliente.getIdCliente()}</td>
						<td>${cliente.getNome()}</td>
						<td>${cliente.getCpf()}</td>
						<td>
							<img class="bt_editar_cliente" src="../img/editar.png" title="Editar Cliente" style="cursor:pointer" data-toggle="modal" data-target="#edicao_cliente"/>
							<img class="bt_excluir_cliente" src="../img/remover.png" title="Excluir Cliente" style="cursor:pointer" data-toggle="modal" data-target="#exclusao"/>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty clienteDAO.listarClientes()}">
					<tr>
						<td align="center" colspan="3">
							<font size="4" face="verdana"><b>NÃO EXISTEM CLIENTES CADASTRADOS</b></font>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
      </div>
  </div>
</div>
<div class="modal fade" id="cadastro_cliente" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Cadastro de Cliente</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorCliente">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="1">
								<input name="idCliente" type="text" placeholder="Digite o Código" class="form-control input-md" size="10" pattern="[0-9]+$" required="" oninput="validaCodigo(this)">
								<br/>
								<input name="nome" type="text" placeholder="Digite o Nome" class="form-control input-md" required="">
							</div>
							<div class="col-md-4">
								<input name="cpf" type="text" placeholder="Digite o CPF" class="form-control input-md" size="10"pattern="[0-9]+$" required="" oninput="validaCpf(this)">
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
<div class="modal fade" id="edicao_cliente" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Edição de Cliente</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorCliente">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="2"/>
								<font size="2" face="verdana">Código:</font>
								<input id="idcliente" name="idCliente" type="text" class="form-control input-md" pattern="[0-9]+$" required="" readonly="true">
								<br/>
								<font size="2" face="verdana">Nome:</font>
								<input id="nomecliente" name="nome" type="text" class="form-control input-md" required="">
							</div>
							<div class="col-md-4">
								<font size="2" face="verdana">CPF:</font>
								<input id="cpfcliente" name="cpf" type="text" class="form-control input-md" pattern="[0-9]+$" required="">
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
    		<form class="form-horizontal" method="post" action="../ControladorCliente">
    			<div class="modal-body">
    				<fieldset>
    					<input name="codigoacao" type="hidden" value="3"/>
    					<input id="id_cliente" name="idCliente" type="hidden">
    					<font size="4" face="verdana">Deseja realmente excluir este cliente?</font>
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