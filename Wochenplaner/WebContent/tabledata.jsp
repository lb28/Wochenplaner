<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.UserTable"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	<title>Veranstaltung bearbeiten</title>
</head>
<body>

	<%
		if (session.getAttribute("currentUserID") == null || request.getParameter("cell") == null) {
	%>
	<h2>Fehler, bitte geh zurück auf die Startseite</h2>
	<p>(source: null)</p>
	<input type="submit" onclick="window.location='index.jsp'"
		value="Zurück" />
	<%
		} else {
			String[] source = request.getParameter("cell").split(":");
			int day = Integer.parseInt(source[0]);
			int hour = Integer.parseInt(source[1]);
			int currentUserID = (Integer) session.getAttribute("currentUserID");
			UserTable currentUserTable = Utilities.getTable(currentUserID);
			String entry = "";
			String description = "";
			String dayString = Utilities.getDay(day);
			if (currentUserTable != null) {
				entry = currentUserTable.getEntry(day, hour);
				description = currentUserTable.getDescription(day, hour);
			}
	%>

	<h3>Veranstaltung bearbeiten</h3>
	<%
		if (dayString != null) {
	%>
	<p>
		<%=dayString%>,
		<%=hour + 7%>
		Uhr
	</p>
	<%
		}
	%>
	
	<!-- form for editing an entry -->
	<form action="done.jsp" method="post">
		Titel: <input type="text" name="edit_title" value="<%=entry%>"
			autofocus="autofocus" /> Beschreibung: <input type="text"
			name="edit_description" value="<%=description%>" /> <input
			type="submit" name="submit" value="Speichern" /> <input
			type="hidden" name="source_page" value="tabledata.jsp_edit" /> <input
			type="hidden" name="day" value="<%=day%>" /> <input type="hidden"
			name="hour" value="<%=hour%>" />
	</form>

	<!-- form for deleting an entry -->
	<form action="done.jsp" method="post">
		<input type="submit" name="submit" value="Eintrag löschen" /> <input
			type="hidden" name="source_page" value="tabledata.jsp_delete" /> <input
			type="hidden" name="day" value="<%=day%>" /> <input type="hidden"
			name="hour" value="<%=hour%>" />
	</form>

	<!-- form for editing an entry -->
	<form action="done.jsp" method="post">
		<input type="submit" name="submit" value="Alle Termine der Verantstaltung löschen" /> <input
			type="hidden" name="source_page" value="tabledata.jsp_deleteAll" /> <input
			type="hidden" name="day" value="<%=day%>" /> <input type="hidden"
			name="hour" value="<%=hour%>" />
	</form>


	<input type="button" onclick="window.close()" value="Abbrechen" />
	<%
		}
	%>

</body>
</html>