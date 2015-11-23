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

		String url = "jdbc:mysql://localhost:3306/wochenplaner";
		String user = "root";
		String password = "root";

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

	/*
	 * inserts user into the database
	 * 
	 */
	public void insert(User user) {
		Connection connection = getConnection();
		PreparedStatement pstmt;
		int id;
		try {

			pstmt = connection.prepareStatement("INSERT INTO user (user_email, user_pwHash) VALUES (?, ?);");
			pstmt.setString(1, user.getUser_email());
			pstmt.setString(2, user.getPwHash());
			pstmt.execute();

			pstmt = connection.prepareStatement("SELECT user_id FROM user WHERE user_email = ?");
			pstmt.setString(1, user.getUser_email());
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getInt("user_id");
				createTable(id);
			}

		} catch (SQLException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} finally {
			closeConnection(connection);
		}

	}

	public void createTable(int user_id) {
		Connection connection = getConnection();
		String sql = "CREATE TABLE usertable_" + user_id
				+ " (day INT NOT NULL, hour INT NOT NULL, entry VARCHAR(128) NULL, PRIMARY KEY (day, hour));";
		PreparedStatement pstmt;
		try {
			pstmt = connection.prepareStatement(sql);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConnection(connection);
		}
	}

	// TODO insert entry into table
	// TODO update entry

	public UserTable getTable(int user_id) {
		Connection connection = getConnection();
		String sql = "SELECT * FROM usertable_" + user_id + ";";
		PreparedStatement pstmt;
		String[][] entries = new String[6][13];
		int day = 0;
		int hour = 0;

		try {
			pstmt = connection.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				day = rs.getInt("day");
				hour = rs.getInt("hour");
				entries[day][hour] = rs.getString("entry");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public User selectUser(String email) {
		User user = null;
		int id;
		String pwHash;
		Connection connection = getConnection();
		PreparedStatement pstmt;

		try {
			pstmt = connection.prepareStatement("SELECT * FROM user WHERE user_email = ?");
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				id = rs.getInt("user_id");
				email = rs.getString("user_email");
				pwHash = rs.getString("user_pwHash");

				user = new User(id, email, pwHash);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			closeConnection(connection);
		}

		return user;
	}

	/**
	 * Returns the stored password hash for the given email address
	 * 
	 * @param email
	 *            - the email address of the user
	 * @return the stored password hash
	 */
	public String getHash(String email) {

		String pwHash = null;
		Connection connection = getConnection();
		PreparedStatement pstmt;

		try {
			pstmt = connection.prepareStatement("SELECT user_pwHash FROM user WHERE user_email = ?");
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				pwHash = rs.getString("user_pwHash");
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			closeConnection(connection);
		}

		return pwHash;
	}

	public static void main(String[] args) {
		// DBConnection dbc = new DBConnection();
		// System.out.println(dbc.selectUser("admin@admin.de"));
	}

}
