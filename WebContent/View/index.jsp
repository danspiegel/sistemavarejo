<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Calendar" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/valida_campos.js"></script>
<title>Sistema de Varejo Web - Vendedor</title>
</head>
<body>
<div class="container">
  <h2>SISTEMA DE VAREJO WEB</h2>
  <ul class="nav nav-tabs">
    <li class="active"><a name="vendedor" href="<c:url value="index.jsp"/>"><input type="hidden" name="menu" value="1"/>Vendedor</a></li>
    <li><a name="clientes" href="<c:url value="clientes.jsp"/>"><input type="hidden" name="menu" value="2"/>Clientes</a></li>
	<li><a name="produtos" href="<c:url value="produtos.jsp"/>"><input type="hidden" name="menu" value="3"/>Produtos</a></li>
	<li><a name="estoques" href="<c:url value="estoques.jsp"/>"><input type="hidden" name="menu" value="4"/>Estoques</a></li>
	<li><a name="vendas" href="<c:url value="vendas.jsp"/>"><input type="hidden" name="menu" value="5"/>Vendas</a></li>
	<a href="http://localhost:8080/sistemavarejo/ControladorLogout"><button class="btn btn-info">Sair</button></a>
  </ul>
  <div class="tab-content">
    <% Calendar calendario = Calendar.getInstance(); %>
  	<c:set var="hora" value="<%= calendario.get(Calendar.HOUR_OF_DAY) %>"/>
  	<c:choose>
  		<c:when test="${hora >= 5 && hora < 12}">
  			<c:set var="mensagem" value="Bom Dia"/>
  		</c:when>
  		<c:when test="${hora >= 12 && hora < 18}">
  			<c:set var="mensagem" value="Boa Tarde"/>
  		</c:when>
  		<c:when test="${hora >= 18 && hora < 24}">
  			<c:set var="mensagem" value="Boa Noite"/>
  		</c:when>
  		<c:otherwise>
  			<c:set var="mensagem" value="Boa Madrugada"/>
  		</c:otherwise>
  	</c:choose>
  	<h3>${mensagem} ${nome}</h3>
  	<br/>
  	<c:set var="vendedorstatus" value='<%= session.getAttribute("vendedorstatus") %>'/>
    <c:choose>
        <c:when test="${vendedorstatus == 3}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Dados pessoais alterados com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("vendedorstatus"); %>
        </c:when>
        <c:when test="${vendedorstatus == 4}">
        	<div class="alert alert-error">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Erro ao alterar os dados pessoais, tente novamente mais tarde.</strong>
        	</div>
        	<% session.removeAttribute("vendedorstatus"); %>
        </c:when>
        <c:when test="${vendedorstatus == 5}">
        	<div class="alert alert-success">
        		<button type="button" class="close" data-dismiss="alert">×</button>
        		<strong>Dados da conta alterados com sucesso.</strong>
        	</div>
        	<% session.removeAttribute("vendedorstatus"); %>
        </c:when>
        <c:when test="${vendedorstatus == 6}">
			<div class="alert alert-error">
  		    	<button type="button" class="close" data-dismiss="alert">×</button>
  		    	<strong>Erro ao alterar os dados da conta, tente novamente mais tarde.</strong>
			</div>
			<% session.removeAttribute("vendedorstatus"); %>
		</c:when>
	</c:choose>
  	<div>
		<div class="col-md-4">
			<c:set var="id" value='<%= session.getAttribute("id") %>'/>
			<c:set var="login" value='<%= session.getAttribute("login") %>'/>
			<c:set var="nome" value='<%= session.getAttribute("nome") %>'/>
			<c:set var="senha" value='<%= session.getAttribute("senha") %>'/>
			<c:set var="cpf" value='<%= session.getAttribute("cpf") %>'/>
			<jsp:useBean id="vendedor" class="Model.Vendedor">
				<jsp:setProperty name="vendedor" property="idVendedor" value="${id}"/>
				<jsp:setProperty name="vendedor" property="login" value="${login}"/>
				<jsp:setProperty name="vendedor" property="nome" value="${nome}"/>
				<jsp:setProperty name="vendedor" property="senha" value="${senha}"/>
				<jsp:setProperty name="vendedor" property="cpf" value="${cpf}"/>
			</jsp:useBean>
			<c:if test="${id == null}">
				<c:redirect url="login.jsp"/>
			</c:if>
			<font size="4" face="verdana"><b>DADOS PESSOAIS</b></font>
			<br/>
			<br/>
			<font size="3" face="verdana">Nome:</font>
			<br/>
			<input id="nome" name="nome" type="text" value="${nome}" class="form-control input-md" required="" readonly="true">
        	<font size="3" face="verdana">CPF:</font>
        	<br/>
        	<input id="cpf" name="cpf" type="text" value="${cpf}" class="form-control input-md" required="" readonly="true">
        	<br/>
        	<button id="alterar_dados" class="btn btn-info" data-toggle="modal" data-target="#dados_vendedor">Alterar Dados</button>
    		<br/>
    		<br/>
    		<font size="4" face="verdana"><b>DADOS DA CONTA</b></font>
			<br/>
			<br/>
    		<font size="3" face="verdana">Login:</font>
    		<br/>
        	<input id="login" name="login" type="text" value="${login}" class="form-control input-md" required="" readonly="true">
	    	<font size="3" face="verdana">Senha:</font>
	    	<br/>
        	<input id="senhaatual" name="senhaatual" type="password" value="${senha}" class="form-control input-md" required="" readonly="true">
        	<br/>
    		<button id="alterar_senha" class="btn btn-info" data-toggle="modal" data-target="#senha_vendedor">Alterar Senha</button>
    		<br/>
    	</div>
    </div>
  </div>
</div>
<div class="modal fade" id="dados_vendedor" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Dados Pessoais - Edição</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorVendedor">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="3">
								<input type="hidden" name="idVendedor" value="${id}">
								<input id="nome" name="nome" type="text" value="${nome}" class="form-control input-md" required="">
							</div>
							<div class="col-md-4">
								<input id="cpf" name="cpf" type="text" value="${cpf}" class="form-control input-md" required="">
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
<div class="modal fade" id="senha_vendedor" role="dialog">
    <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
    			<button type="button" class="close" data-dismiss="modal">&times;</button>
    			<h4 class="modal-title">Dados da Conta - Edição</h4>
    		</div>
    		<form class="form-horizontal" method="post" action="../ControladorVendedor">
    			<div class="modal-body">
    				<fieldset>
						<div class="form-group">
							<div class="col-md-4">
								<input name="codigoacao" type="hidden" value="4">
								<input type="hidden" name="idVendedor" value="${id}">
								<input id="txtSenha" name="senha" type="password" placeholder="Nova Senha" class="form-control input-md" required="">
							</div>
							<div class="col-md-4">
								<input id="confirmarsenha" type="password" placeholder="Confirmar Senha" class="form-control input-md input-block-level" required="" oninput="validaSenha(this)">
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