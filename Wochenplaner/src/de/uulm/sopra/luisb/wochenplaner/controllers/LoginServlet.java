package de.uulm.sopra.luisb.wochenplaner.controllers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import de.uulm.sopra.luisb.wochenplaner.db.User;
import de.uulm.sopra.luisb.wochenplaner.db.UserTable;
import de.uulm.sopra.luisb.wochenplaner.util.Utilities;

/**
 * handles login and redirects to the users table view if successful, or to an
 * error Message otherwise
 * 
 * @author Luis
 *
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session == null) {
			response.sendRedirect("error.jsp");
		} else {

			String source_page = request.getParameter("source_page");

			// check if there is a source at all (there should be)
			if (source_page == null) {
				response.sendRedirect("index.jsp");

				// check if the source is the login page
			} else if (source_page.equals("index.jsp")) {
				
				String email = request.getParameter("login_email");
				String password = request.getParameter("login_pw");
				if (email == null || password == null || email.length() == 0 || password.length() == 0) {
					session.setAttribute("errorMessage", "Gib alle Daten ein!");
					response.sendRedirect("error.jsp");
				} else if (Utilities.validatePassword(email, password)) {
					User currentUser = Utilities.selectUser(email);
					int currentUserID = currentUser.getUser_id();
					UserTable currentUserTable = Utilities.getTable(currentUserID);
					// bind the users id and table to the session, so that the other pages can retrieve that data
					session.setAttribute("currentUserID", currentUserID);
					session.setAttribute("currentUserTable", currentUserTable);
					// redirect to the table page if login was successful
					response.sendRedirect("table.jsp");
				} else {
					session.setAttribute("errorMessage", "Falsche E-Mail-Adresse oder falsches Passwort");
					response.sendRedirect("error.jsp");
				}
			
			} else {
				session.setAttribute("errorMessage", "(unknown source: '"+source_page+"')");
				response.sendRedirect("error.jsp");
			}

		}

	}

}
