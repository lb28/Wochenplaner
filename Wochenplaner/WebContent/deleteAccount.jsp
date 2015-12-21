<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Raleway:200" />
<link href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,700,700italic,300italic' rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Account löschen</title>
</head>
<body>
<%
if (session.getAttribute("currentUserID") == null) {
	response.sendRedirect("index.jsp");
} else {
	int currentUserID = (Integer) session.getAttribute("currentUserID");
}
%>

	<h2>
		Account löschen?
	</h2>
	
	<p>
	Wollen Sie ihren Account wirklich löschen?
	<br/>
	Es werden <b>alle</b> Veranstaltungen und Termine gelöscht.
	</p>
	<p>
	Falls ja, geben Sie ihr Passwort ein, um den Löschvorgang zu bestätigen.
	</p>
			
	<form action="done.jsp" method="post">
		Passwort: <input type="password" name="delete_pw" />
		<input type="submit" name="submit" value="Account löschen" />
		<input type="hidden" name="source_page" value="deleteAccount.jsp" />
	</form>
	<input type="button" onclick="window.location='table.jsp'" value="Abbrechen" />



</body>
</html>