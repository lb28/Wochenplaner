<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.util.Utilities"%>
<%@page import="de.uulm.sopra.luisb.wochenplaner.db.UserTable"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Raleway:200" />
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,700,700italic,300italic'
	rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Wochenplaner</title>
</head>
<%
	//caching prevention (setting these as meta tags does not work)
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	
	String source_page = request.getParameter("source_page");
	UserTable currentUserTable = null;

	if (session.getAttribute("currentUserID") == null) {
		response.sendRedirect("index.jsp");

		//check if the source is the tabledata page
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


<body>
	<h3 id="rightheader">
		<span id="clockString"> <script type="text/javascript">
			var d = new Date();
			document.write("Datum: " + d.toLocaleString());
		</script>
		</span>
	</h3>
	<!-- 'menu' buttons -->
	<form class="table_btns" action="index.jsp">
		<input class="table_btns" type="submit" value="Logout" /> <input
			type="hidden" name="source_page" value="table.jsp_logout" />
	</form>
	<input class="table_btns" type="button"
		onclick="window.location='printTable.jsp'" value="Drucken" />


	<!-- table body is created with for loops -->
	<table>
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
				%><td class="table_data"
					onclick="window.open('tabledata.jsp?cell=<%=day + ":" + hour%>', 'popup', 'width=450,height=400, scrollbars=no, toolbar=no, status=no, resizable=no, menubar=no, location=top, directories=no, top=50, left=50')"
					onmouseover="this.bgColor='#EEEEEE'"
					onmouseout="this.bgColor='#FFFFFF'"
					onmousedown="this.bgColor='#AAAAAA'"
					onmouseup="this.bgColor='#EEEEEE'">
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