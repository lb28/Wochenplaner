package de.uulm.sopra.luisb.wochenplaner.db;

import java.sql.*;

public class DBConnection {
	
	public Connection getConnection() {
		
		
		
		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
		} catch (ClassNotFoundException e) {
			System.out.println("driver not found: " + e);
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		
		String url="jdbc:mysql://localhost:3306/wochenplaner";
		String user="root";
		String password="root";
		
		Connection connection = null;
		
		try {
			connection = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;		
	}
	
	public void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		DBConnection dbcon = new DBConnection();
		Connection connection = dbcon.getConnection();
		System.out.println(connection);
		dbcon.closeConnection(connection);
	}

}
