<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,700,700italic,300italic'
	rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Hello World!</title>
</head>
<body>
	<h2>
		<%
			String name = request.getParameter("name");
			if (name != null && name.length() > 0 && name.matches("[A-Za-z ]*")) {
				out.println("Hallo " + name + ", willkommen beim Wochenplaner!");
			} else {
				out.println("Gib nächstes mal einen richtigen Namen ein!");
			}
		%>
	</h2>

	

	<input type="button" onclick="window.location='table.jsp'"
		value="Zum Wochenplaner" />
	<input type="button" onclick="window.location='index.jsp'"
		value="Zurück" />

</body>
</html>