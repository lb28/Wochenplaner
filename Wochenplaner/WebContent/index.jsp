<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Raleway:200">
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,700,700italic,300italic'
	rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Wochenplaner - Startseite</title>
</head>
<%
	if (session.getAttribute("CurrentUserID") != null) {
		response.sendRedirect("table.jsp");
	}
%>


<body>
	<h1>Wilkommen!</h1>
	<h2>Login:</h2>
	<form action="hello.jsp" method="post">
		E-Mail : <input type="email" name="login_email"/> Passwort: <input
			type="password" name="login_pw"/> <input type="submit" name="submit"
			value="OK" /> <input type="hidden" name="source_page"
			value="index.jsp" />
	</form>

	<br />

	<input type="button" onclick="window.location='registration.jsp'"
		value="Hier gehts zur Registrierung" />


</body>
</html>