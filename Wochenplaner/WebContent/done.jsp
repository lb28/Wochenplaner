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
<title>Best�tigung</title>
</head>

<script type="text/javascript">
	function closeAndRefresh() {
		opener.location.reload(true);
		self.close();
	}
</script>


<!-- this page serves as a handler for many different forms throughout the application -->


<body>

	<%
		String source_page = (String) request.getAttribute("source_page");

		if (session.getAttribute("currentUserID") == null) {
			response.sendRedirect("index.jsp");
		} else {
			int currentUserID = (Integer) session.getAttribute("currentUserID");

			if (source_page == null) {
				session.setAttribute("errorMessage", "(done.jsp-source:null)");
				session.setAttribute("popup", false);
				response.sendRedirect("error.jsp");
			} else {
				// show view according to source
				if (source_page.equals("DoneServlet_edit")
				|| source_page.equals("DoneServlet_delete")
				|| source_page.equals("DoneServlet_deleteAll")
				|| source_page.equals("DoneServlet_moveEntry")) {
					%>
					<h2>�nderung gespeichert</h2>
					<input type="button" onclick="closeAndRefresh();" value="Zum Wochenplaner" autofocus="autofocus" />
					<%	
				} else if (source_page.equals("DoneServlet_deleteAccount")) {
					session.invalidate();
					%>
					<h3>Account erfolgreich gel�scht.</h3>
					<input type="button" onclick="window.location='index.jsp'" value="Zur Startseite" />
					<%
				} else if (source_page.equals("DoneServlet_setAllDescriptions")) {
					%>
					<h2>�nderung f�r alle Termine gespeichert</h2>
					<%
					if (request.getAttribute("updateCount") != null) {
						int updateCount = (Integer) request.getAttribute("updateCount");
						%>
						<p>(<%=updateCount%> Eintr�ge wurden ge�ndert)</p>
						<%
					}
					%>	
					<input type="button" onclick="closeAndRefresh()" value="Zum Wochenplaner" autofocus="autofocus" />
					<%
				}
			}
		}
	%>
	
</body>
</html>