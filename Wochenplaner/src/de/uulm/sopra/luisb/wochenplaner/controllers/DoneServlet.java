package de.uulm.sopra.luisb.wochenplaner.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import de.uulm.sopra.luisb.wochenplaner.db.User;
import de.uulm.sopra.luisb.wochenplaner.db.UserTable;
import de.uulm.sopra.luisb.wochenplaner.util.Utilities;

/**
 * Servlet that holds the logic for the done.jsp page
 */
@WebServlet("/DoneServlet")
public class DoneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoneServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String source_page = request.getParameter("source_page");
		UserTable userTable = null;
		
		if (session.getAttribute("currentUserID") == null) {
			response.sendRedirect("index.jsp");
		} else {
			int currentUserID = (Integer) session.getAttribute("currentUserID");

			if (source_page == null) {
				response.sendRedirect("table.jsp");
			} else {
				if (source_page.equals("tabledata.jsp_edit")) {
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					String newEntry = request.getParameter("edit_title");
					String newDescription = request.getParameter("edit_description");
					userTable = Utilities.getTable(currentUserID);
					if (Utilities.updateEntry(currentUserID, day, hour, newEntry, newDescription) == false) {
						session.setAttribute("popup", true);
						session.setAttribute("errorMessage", "Update fehlgeschlagen.");
						response.sendRedirect("error.jsp");
					} else {
						if (userTable.contains(newEntry)) {
							// update the session object for the view
							userTable = Utilities.getTable(currentUserID);
							session.setAttribute("currentUserTable", userTable);
							request.setAttribute("source_page", "DoneServlet");
							RequestDispatcher rd = request.getRequestDispatcher("setAllDescriptions.jsp");
							rd.forward(request, response);
						} else {
							// update the session object for the view
							userTable = Utilities.getTable(currentUserID);
							session.setAttribute("currentUserTable", userTable);
							request.setAttribute("source_page", "DoneServlet_edit");
							RequestDispatcher rd = request.getRequestDispatcher("done.jsp");
							rd.forward(request, response);
						}
					}

				} else if (source_page.equals("tabledata.jsp_delete")) {
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					if (Utilities.deleteEntry(currentUserID, day, hour) == false) {
						session.setAttribute("popup", true);
						session.setAttribute("errorMessage", "Löschen fehlgeschlagen.");
						response.sendRedirect("error.jsp");
					} else {
						// update the session object for the view
						userTable = Utilities.getTable(currentUserID);
						session.setAttribute("currentUserTable", userTable);
						request.setAttribute("source_page", "DoneServlet_delete");
						RequestDispatcher rd = request.getRequestDispatcher("done.jsp");
						rd.forward(request, response);
					}
				
				} else if (source_page.equals("tabledata.jsp_deleteAll")) {
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					userTable = Utilities.getTable(currentUserID);
					String event = userTable.getEntry(day, hour);
					if (Utilities.deleteAllEvents(currentUserID, event) == false) {
						session.setAttribute("popup", true);
						session.setAttribute("errorMessage", "Löschen fehlgeschlagen.");
						response.sendRedirect("error.jsp");
					} else {
						// update the session object for the view
						userTable = Utilities.getTable(currentUserID);
						session.setAttribute("currentUserTable", userTable);
						request.setAttribute("source_page", "DoneServlet_deleteAll");
						RequestDispatcher rd = request.getRequestDispatcher("done.jsp");
						rd.forward(request, response);
					}
				} else if (source_page.equals("tabledata.jsp_move")) {
					int newDay = Integer.parseInt(request.getParameter("newDay"));
					int newHour = Integer.parseInt(request.getParameter("newHour"));
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					String newDayString = Utilities.getDay(newDay);
					userTable = Utilities.getTable(currentUserID);
					String oldEntry = userTable.getEntry(newDay, newHour);
					
					if ((oldEntry == null) || (oldEntry.equals(""))) {
						if (Utilities.moveEntry(currentUserID, day, hour, newDay, newHour) == false) {
							session.setAttribute("popup", true);
							session.setAttribute("errorMessage", "Verschieben fehlgeschlagen.");
							response.sendRedirect("error.jsp");
						} else {
							// update the session object for the view
							userTable = Utilities.getTable(currentUserID);
							session.setAttribute("currentUserTable", userTable);
							request.setAttribute("source_page", "DoneServlet_moveEntry");
							RequestDispatcher rd = request.getRequestDispatcher("done.jsp");
							rd.forward(request, response);
						}
					} else {
						RequestDispatcher rd = request.getRequestDispatcher("moveEntry.jsp");
						rd.forward(request, response);
					}
					
				} else if (source_page.equals("moveEntry.jsp")) {
					int newDay = Integer.parseInt(request.getParameter("newDay"));
					int newHour = Integer.parseInt(request.getParameter("newHour"));
					int day = Integer.parseInt(request.getParameter("day"));
					int hour = Integer.parseInt(request.getParameter("hour"));
					
					if (Utilities.moveEntry(currentUserID, day, hour, newDay, newHour) == false) {
						session.setAttribute("popup", true);
						session.setAttribute("errorMessage", "Verschieben fehlgeschlagen.");
						response.sendRedirect("error.jsp");
					} else {
						// update the session object for the view
						userTable = Utilities.getTable(currentUserID);
						session.setAttribute("currentUserTable", userTable);
						request.setAttribute("source_page", "DoneServlet_moveEntry");
						RequestDispatcher rd = request.getRequestDispatcher("done.jsp");
						rd.forward(request, response);
					}	
					
					
				} else if (source_page.equals("deleteAccount.jsp")) {
					User currentUser = Utilities.selectUser(currentUserID);
					String email = currentUser.getUser_email();
					String password = request.getParameter("delete_pw");
					if (Utilities.validatePassword(email, password)) {
						if (Utilities.deleteUser(currentUserID) == false) {
							// %><h2>Fehler!</h2>
							// <p>Löschen fehlgeschlagen.</p>
							// <input type="button"
							// onclick="window.location='table.jsp'" value="Zum
							// Wochenplaner"/>
							// <%
						} else {
							// session.invalidate();
							// %><h3>Account erfolgreich gelöscht.</h3>
							// <input type="button"
							// onclick="window.location='index.jsp'" value="Zur
							// Startseite" />
							// <%
						}
					} else {
						// %><h2>Fehler!</h2>
						// <p>Löschen fehlgeschlagen.</p>
						// <input type="button"
						// onclick="window.location='table.jsp'" value="Zum
						// Wochenplaner"/>
						// <%
					}
				} else if (source_page.equals("done.jsp_setAllDescriptions")) {
					String entry = request.getParameter("entry");
					String newDescription = request.getParameter("description");
					
/* 					// debugging
					System.out.println("Entry: \""+entry+"\" ");
					System.out.println("Description: \""+newDescription+"\" ");
 */					
					int updateCount = Utilities.updateAll(currentUserID, entry, newDescription);
					
					if (updateCount == -1) {
						// %>
						// <h2>Fehler!</h2>
						// <p>Update fehlgeschlagen.</p>
						// <%
					 } else {
						// %>
						// <h2>Änderung für alle Termine gespeichert</h2>
						// <p>(<%=updateCount%> Einträge wurden
						// überschrieben)</p>
						// <input type="button" onclick="closeAndRefresh()"
						// value="Zum Wochenplaner" autofocus="autofocus" />
						// <%
					 }
				} else {
					//unknown source
					session.setAttribute("errorMessage", "(unknown source)");
					session.setAttribute("popup", true);
					response.sendRedirect("error.jsp");
				}
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
