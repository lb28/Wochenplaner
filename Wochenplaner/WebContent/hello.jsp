<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.User"%>
<%@page import="javax.websocket.Session"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Raleway:200">
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,700,700italic,300italic'
	rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Wochenplaner - Willkommen</title>
</head>
<body>
		<%
		String source_page = (String)request.getAttribute("source_page");

		//check if there is a source param at all (there should be)
		if (source_page == null) {
			response.sendRedirect("index.jsp");
			
		// check if the source is the Login Servlet
		} else if (source_page.equals("RegistrationServlet")) {
			String email = (String) session.getAttribute("email");
			%>
			<h2>Hallo <%=email%>, du bist jetzt registriert!</h2>
			<input type="button" onclick="window.location='index.jsp'" value="Zum Login" />
			<%
		} else {
			session.setAttribute("errorMessage", "(unknown source: "+source_page+")");
			response.sendRedirect("error.jsp");
		}
		%>

</body>
</html>