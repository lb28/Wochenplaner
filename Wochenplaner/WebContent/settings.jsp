<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.UserTable"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.User"%>
<%@page import="java.util.LinkedList"%>

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
	<title>Einstellungen</title>
</head>

<body>

	<%
		if (session.getAttribute("currentUserID") == null) {
	%>
	<h2>Fehler, bitte geh zurück auf die Startseite.</h2>
	<p>(id: null)</p>
	<input type="submit" onclick="window.location='index.jsp'" value="Zurück" />
	<%
		} else {
			int currentUserID = (Integer) session.getAttribute("currentUserID");
			User currentUser = Utilities.selectUser(currentUserID);
			if (currentUser == null) {
				%>
				<h2>Fehler, bitte geh zurück auf die Startseite.</h2>
				<p>(id: null)</p>
				<input type="button" onclick="window.location='index.jsp'" value="Zurück" />
				<%			
			} else {
				//is this bad practice? don't know what else to look for...
				if (currentUser.getUser_email().equals("luis.beaucamp@gmail.com")) {
					LinkedList<User> users = Utilities.getAllUsers();
					
					%>
					<form action="deleteAccount.jsp">
					
					Benutzer löschen: <select name="deleteUser_admin">
							<%
								for (int i = 0; i < users.size(); i++) {
									%>
									<option value="<%=users.get(i).getUser_id()%>"><%=users.get(i).getUser_email()%></option>
									<%
								}
							%>
						</select> 
					
						<input type="hidden" name="source_page" value="settings.jsp_admin" />
						<input type="submit" name="submit" value="Benutzer löschen" />
					</form>
					<%
					
				}
				
				//TODO change password option for every user.
				
			}
		}
	%>

</body>
</html>