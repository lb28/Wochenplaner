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
 * Servlet for getting the user table from the Database and binding it to the session
 * (gets called from table.jsp in case the table is null (for example if the session is running
 * and you go directly to the table page
 */
@WebServlet("/TableServlet")
public class TableServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TableServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String source_page = request.getParameter("source_page");
		
		if (source_page == null) {
			session.setAttribute("errorMessage", "(source:null)");
			response.sendRedirect("error.jsp");
		} else if (session.getAttribute("currentUserID") == null) {
			session.setAttribute("errorMessage", "(id:null)");
			response.sendRedirect("error.jsp");			
		} else if (source_page.equals("table.jsp")) {
			int currentUserID = (Integer) session.getAttribute("currentUserID");
			UserTable currentUserTable = Utilities.getTable(currentUserID);
			session.setAttribute("currentUserTable", currentUserTable);
			response.sendRedirect("table.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
