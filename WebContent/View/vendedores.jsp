<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sistema de Varejo Web - Login</title>
<!-- CSS -->
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/login.css" rel="stylesheet">
<script type="text/javascript" src="../js/valida_campos.js"></script>
</head>
<body>
	<h1 align="center">SISTEMA DE VAREJO WEB</h1>
	<h2 align="center">Cadastro do Vendedor</h2>
    <div class="container" id="container-login">
        <form class="form-signin" method="post" action="../ControladorVendedor">
			<c:set var="vendedorstatus" value='<%= session.getAttribute("vendedorstatus") %>'/>
        	<c:if test="${vendedorstatus == 2}">
				<div class="alert alert-error">
  		    		<strong>Erro ao cadastrar vendedor, tente novamente mais tarde.</strong>
				</div>
				<% session.removeAttribute("vendedorstatus"); %>
			</c:if>
			<input name="codigoacao" type="hidden" value="2">
			<input id="txtNome" type="text" class="input-block-level" placeholder="Nome" name="nome" value="" required>
			<input id="txtCpf" type="text" class="input-block-level" placeholder="CPF" name="cpf" value="" required oninput="validaCpf(this)">
            <input id="txtLogin" type="text" class="input-block-level" placeholder="Login" name="login" value="" required>
            <input id="txtSenha" type="password" class="input-block-level" placeholder="Senha" name="senha" value="" required>
            <input id="txtRepetirSenha" type="password" class="input-block-level" placeholder="Confirmar Senha" name="repetirsenha" required oninput="validaSenha(this)">

            <button class="btn btn-large btn-primary" type="submit">Gravar</button>
            <br/>
            <br/>
            <label class="cadastrar_vendedor"><a href="login.jsp">Já possui login?</a></label>
        </form>
    </div>
</body>
</html>