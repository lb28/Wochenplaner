<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.User"%>
<%@page import="javax.websocket.Session"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
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
<title>Wochenplaner - Willkommen</title>
</head>
<body>
	<%
		// first, determine if the user came from the reg page or login page
		String source_page = request.getParameter("source_page");

		//check if there is a source param at all (there should be)
		if (source_page == null) {
			response.sendRedirect("index.jsp");

		//check if the source is the login page
		} else if (source_page.equals("index.jsp")) {

			String email = request.getParameter("login_email");
			String password = request.getParameter("login_pw");
			int currentUserID = 0;
			if (Utilities.validatePassword(email, password)) {
				User currentUser = Utilities.selectUser(email);
				session.setAttribute("currentUserID", currentUser.getUser_id());
				
				//TODO include this line to skip the "hello" page and redirect to the table?
				response.sendRedirect("table.jsp");
				
				
	%>
	<h3>
		Hallo
		<%=email%>,
		willkommen bei deinem Wochenplaner!
	</h3>

	<form action="table.jsp" method="post">
		<input type="submit" name="submit" value="Zum Wochenplaner" /> <input
			type="hidden" name="source_page" value="hello.jsp" />
	</form>

	<%
		} else {
	%>
	<h2>Falsche E-Mail-Adresse oder falsches Passwort</h2>
	<%
		}
			//check if the source is the registration page
		} else if (source_page.equals("registration.jsp")) {
			String email = request.getParameter("reg_email");
			String pw1 = request.getParameter("reg_pw1");
			String pw2 = request.getParameter("reg_pw2");

			if (email != null && pw1 != null && pw2 != null && email.length() > 0 && pw1.length() > 0
					&& pw2.length() > 0) {
				if (Utilities.isValidAccount(email, pw1, pw2)) {
					User user = new User(email, pw1);
					Utilities.insertUser(user);
	%>
	<h2>
		Hallo
		<%=email%>, Du bist jetzt registriert!
	</h2>

	<input type="button" onclick="window.location='index.jsp'"
		value="Zum Login" />
	<%
		} else {
	%>
	<h2>Gib eine korrekte E-Mail ein!</h2>
	<%
		}
			} else {
	%>
	<h2>Gib alle Daten ein!</h2>
	<%
		}
		} else {
	%>
	<h2>Fehler, bitte geh zurück auf die Startseite</h2>
	<p>(unknown source)</p>
	<%
		}
	%>

	<input type="button" onclick="window.location='index.jsp'"
		value="Zurück" />

</body>
</html>