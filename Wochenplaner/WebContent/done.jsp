<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.UserTable"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>

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
<title>Bestätigung</title>
</head>

<script type="text/javascript">
	function closeAndRefresh() {
		opener.location.reload(true);
		self.close();
	}
</script>

<body>

	<%
		String source_page = request.getParameter("source_page");

		if (session.getAttribute("currentUserID") == null) {
			response.sendRedirect("index.jsp");
		} else {
			int currentUserID = (Integer) session.getAttribute("currentUserID");

			if (source_page == null) {
				response.sendRedirect("table.jsp");
			} else {
				if (source_page.equals("tabledata.jsp_edit")) {
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					String newEntry = request.getParameter("edit_title");
					String newDescription = request.getParameter("edit_description");
					UserTable userTable = Utilities.getTable(currentUserID);					
					if (Utilities.updateEntry(currentUserID, day, hour, newEntry, newDescription) == false) {
	%><h2>Fehler!</h2>
	<p>Update fehlgeschlagen.</p>
	<input type="button" onclick="closeAndRefresh()"
		value="Zum Wocheplaner" autofocus="autofocus" />
	<%
		} else {
						if (userTable.contains(newEntry)) {
	%>
	<h2>Änderung gespeichert</h2>
	<p>
		Wollen Sie die neue Beschreibung für die bereits gespeicherten Termine
		von "<%=newEntry%>" übernehmen?
	</p>
	<form action="setAllDescriptions.jsp" method="post">
		<input type="submit" name="submit" value="Ja" /> <input
			type="hidden" name="source_page" value="done.jsp_setAllDescriptions" />
		<input type="hidden" name="entry" value="<%=newEntry%>" /> <input
			type="hidden" name="description" value="<%=newDescription%>" />
	</form>
	<input type="button" value="Nein" onclick="closeAndRefresh()" />
	<%
		} else {
	%><h2>Änderung gespeichert</h2>
	<input type="button" onclick="closeAndRefresh()"
		value="Zum Wocheplaner" autofocus="autofocus" />
	<%
		}
					}

				} else if (source_page.equals("tabledata.jsp_delete")) {
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					if (Utilities.deleteEntry(currentUserID, day, hour) == false) {
	%><h2>Fehler!</h2>
	<p>Löschen fehlgeschlagen.</p>
	<input type="button" onclick="closeAndRefresh()"
		value="Zum Wocheplaner" autofocus="autofocus" />
	
	<%
		} else {
	%><h2>Änderung gespeichert</h2>
	<input type="button" onclick="closeAndRefresh()"
		value="Zum Wocheplaner" autofocus="autofocus" />
	<%
		}
				} else if (source_page.equals("tabledata.jsp_deleteAll")) {
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					UserTable userTable = Utilities.getTable(currentUserID);
					String event = userTable.getEntry(day, hour);
					if (Utilities.deleteAllEvents(currentUserID, event) == false) {
	%><h2>Fehler!</h2>
	<p>Löschen fehlgeschlagen.</p>
	<input type="button" onclick="closeAndRefresh()"
		value="Zum Wocheplaner" autofocus="autofocus" />
	<%
		} else {
	%><h2>Änderung gespeichert</h2>
	<input type="button" onclick="closeAndRefresh()"
		value="Zum Wocheplaner" autofocus="autofocus" />
	<%
		}
				}
			}
		}
	%>
	
</body>
</html>