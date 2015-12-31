<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet"
		href="http://fonts.googleapis.com/css?family=Raleway:200">
		<link
			href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,700,700italic,300italic'
			rel='stylesheet' type='text/css' />
		<link rel="stylesheet" href="style.css" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Fehler</title>
	</head>
	<body>
	
		<script type="text/javascript">
			function closeAndRefresh() {
				opener.location.reload(true);
				self.close();
			}
		</script>
		
		<h2>Hoppla...</h2>
		
		<%
		if (session.getAttribute("errorMessage") != null) {
		String errorMessage = (String) session.getAttribute("errorMessage");
		%>
			<h3>Da ist etwas schief gegangen. Bitte gehe zurück zur Startseite.</h3>
			<p>Fehlermeldung: <%=errorMessage%></p>
		<%
		} else {
		%>
			<h3>Da ist etwas schief gegangen. Bitte gehe zurück zur Startseite.</h3>
		<%
		}
		
		boolean popup = false;
		if (session.getAttribute("popup") != null) {
			popup = (boolean) session.getAttribute("popup");
		}
		if (popup) {
			%>
			<button onclick="closeAndRefresh();">Zur Startseite</button>
			<%
		} else {
			%>
			<button onclick="window.location='index.jsp'">Zur Startseite</button>
			<%
		}
		%>
		
	</body>
</html>