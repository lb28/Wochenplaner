<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.UserTable"%>

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
<title>Wochenplaner</title>
</head>
<%
	UserTable currentUserTable = null;

	if (session.getAttribute("currentUserID") == null) {
		response.sendRedirect("index.jsp");

	} else {
		int currentUserID = (Integer) session.getAttribute("currentUserID");
		currentUserTable = Utilities.getTable(currentUserID);
%>

<!-- displays the clock String on the top -->
<script language="javascript">
	var d = new Date();
	setInterval(clock, 1000);
	var counter = 0;
	function clock() {
		d = new Date();
		document.getElementById("clockString").innerHTML = ("Datum: " + d
				.toLocaleString());
	}
</script>

<script language="javascript">
	function printAndGoBack() {
		window.print();
		window.location='table.jsp';
	}
</script>

<body onload="printAndGoBack()">
	<!--
	<h2>
		<span id="clockString"> <script type="text/javascript">
			var d = new Date();
			document.write("Datum: " + d.toLocaleString());
		</script></span>
	</h2>
	-->
	

	<!-- table body is created with for loops -->
	<table class="printTable_small">
		<thead>
			<tr>
				<th></th>
				<th>Mo</th>
				<th>Di</th>
				<th>Mi</th>
				<th>Do</th>
				<th>Fr</th>
				<th>Sa</th>
				<th>So</th>
			</tr>
		</thead>
		<tbody>
			<%
				//loop over the rows
					for (int hour = 0; hour < 14; hour++) {
			%><tr>
				<td class="time">
					<%
						if (hour + 7 < 10) {
									out.print("0");
								}
								out.print(hour + 7);
					%>:00
				</td>
				<%
					//loop over the columns
							for (int day = 0; day < 7; day++) {
				%><td class="table_data">
					<%
						if (currentUserTable != null) {
							out.println(currentUserTable.getEntry(day, hour));
						}
					%>
				</td>
				<%
					}
				%>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
	<%
		}
	%>


</body>
</html>