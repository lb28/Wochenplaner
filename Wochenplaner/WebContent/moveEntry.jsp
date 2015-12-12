<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.UserTable"%>
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
	<title>Veranstaltung bearbeiten</title>
</head>

<body>

	<script type="text/javascript">
		function closeAndRefresh() {
			opener.location.reload(true);
			self.close();
		}
	</script>

	<%
		if (session.getAttribute("currentUserID") == null || request.getParameter("source_page") == null) {
			%>
			<h2>Fehler, bitte geh zurück auf die Startseite</h2>
			<%
			if (request.getParameter("source_page") == null) {
				%>
				<p>(source: null)</p>
				<input type="submit" onclick="window.location='index.jsp'"
					value="Zurück" />
				<%
			} else {
				%>
				<p>(id: null)</p>
				<input type="submit" onclick="closeAndRefresh();" value="Zurück" />
				<%
			}
		} else {
			int newDay = Integer.parseInt(request.getParameter("newDay"));
			int newHour = Integer.parseInt(request.getParameter("newHour"));
			int day = Integer.parseInt(request.getParameter("day"));
			int hour = Integer.parseInt(request.getParameter("hour"));
			int currentUserID = (Integer) session.getAttribute("currentUserID");
			String newDayString = Utilities.getDay(newDay);
			UserTable currentUserTable = Utilities.getTable(currentUserID);

			if (currentUserTable != null) {
				String oldEntry = currentUserTable.getEntry(newDay, newHour);
				if ((oldEntry == null) || (oldEntry.equals(""))) {
					if (Utilities.moveEntry(currentUserID, day, hour, newDay, newHour) == false) {
						%><h2>Fehler!</h2>
						<p>Verschieben fehlgeschlagen.</p>
						<input type="button" onclick="closeAndRefresh()"
							value="Zum Wochenplaner" autofocus="autofocus" />
						<%
					} else {
						%><h2>Änderung gespeichert</h2>
						<input type="button" onclick="closeAndRefresh()"
							value="Zum Wochenplaner" autofocus="autofocus" />
						<%
					}
					
				} else {
					%>
					<h3>Termin verschieben</h3>
					<%
						if (newDayString != null) {
					%>
					<p>
						nach:
						<%=newDayString%>,
						<%=newHour + 7%>
						Uhr
					</p>
					
					<form action="done.jsp" method="post">
					Durch Verschieben wird der Eintrag "<%=oldEntry%>" an diesem Termin überschrieben. Bist du sicher?
					<br/>
					<br/>
					<input type="hidden" name="source_page" value="moveEntry.jsp" />
					<input type="hidden" name="day" value="<%=day%>" />
					<input type="hidden" name="hour" value="<%=hour%>" />
					<input type="hidden" name="newDay" value="<%=newDay%>" />
					<input type="hidden" name="newHour" value="<%=newHour%>" />
					<input class="h_btns" type="submit" value="Ja"/>
					<input class="h_btns" type="button" value="Nein" onclick="window.close();"/>
					</form>
					<%
					}
				}
			}
	%>

	<%
		}
	%>

</body>
</html>