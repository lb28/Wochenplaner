package de.uulm.sopra.luisb.wochenplaner.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import de.uulm.sopra.luisb.wochenplaner.db.UserTable;
import de.uulm.sopra.luisb.wochenplaner.util.Utilities;

/**
 * handles printing of the small and large table
 */
@WebServlet("/PrintServlet")
public class PrintServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PrintServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String size = request.getParameter("size");

		if (session == null) {
			response.sendRedirect("error.jsp");
		} else if (size == null) {
			session.setAttribute("errorMessage", "(PrintServlet-size:null)");
			response.sendRedirect("error.jsp");
		} else if (session.getAttribute("currentUserID") == null) {
			session.setAttribute("errorMessage", "(PrintServlet-id:null)");
			response.sendRedirect("error.jsp");
		} else {
			int currentUserID = (Integer) session.getAttribute("currentUserID");
			UserTable currentUserTable = Utilities.getTable(currentUserID);
			
			// bind the table to the session
			session.setAttribute("currentUserTable", currentUserTable);
			
			//redirect to either the small printing page or the large one
			if (size.equals("small")) {
				response.sendRedirect("printTable_small.jsp");
			} else if (size.equals("large")) {
				response.sendRedirect("printTable.jsp");
			} else {
				session.setAttribute("errorMessage", "(PrintServlet-unknown size)");
				response.sendRedirect("error.jsp");
			}

		}
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
