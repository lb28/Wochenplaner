<?xml version="1.0" encoding="ISO-8859-1" ?>
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
<title>Wochenplaner</title>
</head>
<body>
	<h2>
		<script language="javascript">
			var d = new Date();
			document.write("Datum: " + d.toUTCString().substring(0, 16));
		</script>
	</h2>

	<table>
		<tbody>
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
			<%
				//loop over the rows
				for (int i = 0; i < 14; i++) {
			%><tr>
				<td><%=i + 8%>:00</td>
				<%
					//loop over the columns
						for (int j = 0; j < 7; j++) {
				%><td><a target="popup"
					onclick="window.open('', 'popup', 'width=580,height=360,scrollbars=no, toolbar=no,status=no,resizable=no,menubar=no,location=left,directories=no,top=10,left=10')"
					href="http://google.de">Test</a></td>
				<%
					}
				%>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>

	<br />
	<input type="button" onclick="window.location='index.jsp'"
		value="Zur Startseite" />


</body>
</html>