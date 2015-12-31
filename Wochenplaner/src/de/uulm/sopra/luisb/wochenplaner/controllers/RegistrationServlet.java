package de.uulm.sopra.luisb.wochenplaner.controllers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import de.uulm.sopra.luisb.wochenplaner.db.User;
import de.uulm.sopra.luisb.wochenplaner.util.Utilities;

/**
 * handles registration
 * 
 * @author Luis
 *
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		HttpSession session = request.getSession(false);

		// don't let the user register if they are logged in
		if (session.getAttribute("currentUserID") != null) {
			response.sendRedirect("table.jsp");
		} else {

			String email = request.getParameter("reg_email");
			String pw1 = request.getParameter("reg_pw1");
			String pw2 = request.getParameter("reg_pw2");

			if (email != null && pw1 != null && pw2 != null && email.length() > 0 && pw1.length() > 0
					&& pw2.length() > 0) {
				if (Utilities.isValidAccount(email, pw1, pw2)) {
					User user = new User(email, pw1);
					if (Utilities.insertUser(user)) {
						session.setAttribute("email", email);
						request.setAttribute("source_page", "RegistrationServlet");

						RequestDispatcher rd = request.getRequestDispatcher("hello.jsp");
						rd.forward(request, response);

					} else {
						response.sendRedirect("error.jsp");
					}
				} else {
					session.setAttribute("errorMessage", "Gib eine gültige E-Mail-Adresse ein!");
					response.sendRedirect("error.jsp");
					System.out.println("falsche email");
				}
			} else {
				session.setAttribute("errorMessage", "Gib alle Daten ein!");
				response.sendRedirect("error.jsp");
			}

		}
	}

}
