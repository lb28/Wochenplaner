<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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

		if (session.getAttribute("currentUserID") == null) {
			response.sendRedirect("index.jsp");
		} else {
			String source_page = (String) request.getAttribute("source_page");
			if (source_page == null) {
				session.setAttribute("errorMessage", "(setAllDescriptions.jsp-source:null)");
				response.sendRedirect("error.jsp");
			} else {
				if (source_page.equals("DoneServlet")) {
					String newEntry = request.getParameter("edit_title");
					String newDescription = request.getParameter("edit_description");
					%>
					<h2>Änderung gespeichert</h2>
					<p>
					Wollen Sie die neue Beschreibung für die bereits
					gespeicherten Termine
					von "<%=newEntry%>" übernehmen?
					</p>
					<form action="DoneServlet" method="post">
						<input type="submit" name="submit" value="Ja" />
						<input type="hidden" name="source_page" value="setAllDescriptions.jsp" />
						<input type="hidden" name="entry" value="<%=newEntry%>" />
						<input type="hidden" name="description" value="<%=newDescription%>" />
					</form>
					<input type="button" value="Nein" onclick="closeAndRefresh()" />
					<%
				}
			}
		}
	%>

</body>
</html>