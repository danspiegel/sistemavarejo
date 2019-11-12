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
</head>
<body>
	<!-- Login -->
	<h1 align="center">SISTEMA DE VAREJO WEB</h1>
	<h2 align="center">Área do Vendedor</h2>
    <div class="container" id="container-login">
        <form class="form-signin" method="post" action="../ControladorVendedor">
        	<c:set var="logininvalido" value='<%= session.getAttribute("logininvalido") %>'/>
        	<c:set var="vendedorstatus" value='<%= session.getAttribute("vendedorstatus") %>'/>
        	<c:if test="${logininvalido == 1}">
				<div class="alert alert-error">
  		    		<strong>Usuário ou senha inválido.</strong>
				</div>
				<% session.removeAttribute("logininvalido"); %>
			</c:if>
			<c:if test="${vendedorstatus == 1}">
        		<div class="alert alert-success">
        			<strong>Vendedor cadastrado com sucesso.</strong>
        		</div>
        		<% session.removeAttribute("vendedorstatus"); %>
        	</c:if>
			<input name="codigoacao" type="hidden" value="1">
            <input type="text" class="input-block-level" placeholder="Login do Vendedor" name="login" required>
            <input type="password" class="input-block-level" placeholder="Senha do Vendedor" name="senha" required>

            <label class="cadastrar_vendedor"><a href="vendedores.jsp">Cadastrar-se</a></label>
		
            <button class="btn btn-large btn-primary" type="submit">Entrar</button>
        </form>
    </div>
    <!-- Login -->
</body>
</html>