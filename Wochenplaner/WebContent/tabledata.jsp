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

	<!-- puts the selected event in the form -->
	<script>
		function titlechange() {
			var edit_title = document.getElementById('edit_title');
			var e = document.getElementById("selectEvent");
			var str = e.options[e.selectedIndex].value;
			if (str === "new_event") {
				edit_title.disabled = false;
				edit_title.value = "";
			} else {
				edit_title.value = str;
			}
		}

		function selectionchange() {
			var edit_title = document.getElementById('edit_title');
			var x = document.getElementById("selectEvent");
			var index = 0;
			for (i = 0; i < x.length; i++) {
				if (x.options[i].text === edit_title.value) {
					index = i;
				}
			}
			x.selectedIndex = index;
		}
	</script>

	<%
		boolean popup;
	
		if (session.getAttribute("currentUserID") == null
			|| session.getAttribute("currentUserTable") == null
			|| request.getParameter("cell") == null) {
			
			if (request.getParameter("cell") == null) {
				popup = false;
				session.setAttribute("errorMessage", "(cell:null)");
				response.sendRedirect("error.jsp");
			} else {
				popup = true;
				session.setAttribute("popup", popup);
				response.sendRedirect("error.jsp");				
			}
		} else {
			String[] source = request.getParameter("cell").split(":");
			int day = Integer.parseInt(source[0]);
			int hour = Integer.parseInt(source[1]);
			int currentUserID = (Integer) session.getAttribute("currentUserID");

			UserTable currentUserTable = (UserTable) session.getAttribute("currentUserTable");
			LinkedList<String> uniqueEntries = Utilities.getUniqueEntries(currentUserTable);

			String entry = "";
			String description = "";
			String dayString = Utilities.getDay(day);
			entry = currentUserTable.getEntry(day, hour);
			description = currentUserTable.getDescription(day, hour);
			
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
	<form action="DoneServlet" method="post">
	
		<select id="selectEvent" onchange="titlechange();"
			title="Hier können Sie aus einer Liste bestehender Veranstaltungen wählen">
			<option value="new_event">neue Veranstaltung</option>
			<%
				//display all unique entries
					for (int i = 0; i < uniqueEntries.size(); i++) {
			%>
			<option value="<%=uniqueEntries.get(i)%>"
				<%if (uniqueEntries.get(i).equals(entry)) {%> selected <%}%>>
				<%=uniqueEntries.get(i)%>
			</option>
			<%
				}
			%>
		</select>
		 Titel: 
		<input type="text" id="edit_title" name="edit_title"
			value="<%=entry%>" onkeyup="selectionchange();"
			onchange="selectionchange();" autofocus="autofocus" />
		 Beschreibung:
		<input type="text" name="edit_description" value="<%=description%>" />
		<input type="submit" name="submit" value="Speichern" />
		<input type="hidden" name="source_page" value="tabledata.jsp_edit" />
		<input type="hidden" name="day" value="<%=day%>" />
		<input type="hidden" name="hour" value="<%=hour%>" />
	</form>

	<!-- form for deleting an entry -->
	<form action="DoneServlet" method="post">
		<input type="submit" name="submit" value="Eintrag löschen" />
		<input type="hidden" name="source_page" value="tabledata.jsp_delete" />
		<input type="hidden" name="day" value="<%=day%>" />
		<input type="hidden" name="hour" value="<%=hour%>" />
	</form>

	<!-- form for deleting all entries of an event -->
	<form action="DoneServlet" method="post">
		<input type="submit" name="submit" value="Veranstaltung löschen" />
		<input type="hidden" name="source_page" value="tabledata.jsp_deleteAll" />
		<input type="hidden" name="day"	value="<%=day%>" />
		<input type="hidden" name="hour" value="<%=hour%>" />
	</form>
	
	<%
	if(!(currentUserTable.getEntry(day, hour).equals(""))) {  
	%>
		<!-- horizontal line for separation -->
		<hr />		
	
		<!-- form for moving an entry -->
		<form action="DoneServlet" id="moveEntry">
		Termin verschieben: <select name="newDay">
				<%
					for (int d = 0; d < 7; d++) {
				%>
				<option value="<%=d%>"><%=Utilities.getDay(d)%></option>
				<%
					}
				%>
			</select> 
			
			<select name="newHour">
				<%
					for (int h = 0; h < 14; h++) {
				%>
				<option value="<%=h%>">
					<%
						if (h + 7 < 10) {
									out.print("0");
								}
								out.print(h + 7);
					%>:00
				</option>
				<%
					}
				%>
			</select>
		
			<input type="hidden" name="source_page" value="tabledata.jsp_move" />
			<input type="hidden" name="day" value="<%=day%>" />
			<input type="hidden" name="hour" value="<%=hour%>" />
			<input type="submit" name="submit" value="Verschieben" />
		</form>
		
	<%
	}
	%>

	<hr />

	<input type="button" onclick="window.close()" value="Abbrechen" />
	<%
		}
	%>

</body>
</html>