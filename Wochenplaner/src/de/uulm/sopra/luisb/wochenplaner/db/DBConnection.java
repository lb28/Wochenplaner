package de.uulm.sopra.luisb.wochenplaner.db;

import java.sql.*;

/**
 * @author Luis Beaucamp
 *
 */
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
			e.printStackTrace();
		} finally {
			closeConnection(connection);
		}
	}

	/**
	 * updates one cell of the Table
	 * 
	 * @param day
	 * @param hour
	 * @param newEntry
	 * @return true if the update was successful, false otherwise
	 */
	public boolean updateEntry(int user_id, int day, int hour, String newEntry, String newDescription) {
		// get the specified entry
		Connection connection = getConnection();
		PreparedStatement pstmt;

		try {
			pstmt = connection
					.prepareStatement("SELECT entry FROM usertable_" + user_id + " WHERE day = ? AND hour = ?");
			pstmt.setInt(1, day);
			pstmt.setInt(2, hour);
			ResultSet rs = pstmt.executeQuery();

			// if there was an entry, update it
			if (rs.next()) {
				pstmt = connection.prepareStatement(
						"UPDATE usertable_? SET entry = ?, description = ? WHERE day = ? AND hour = ?;");
				pstmt.setInt(1, user_id);
				pstmt.setString(2, newEntry);
				pstmt.setString(3, newDescription);
				pstmt.setInt(4, day);
				pstmt.setInt(5, hour);
				// execute the query and return true (success)
				pstmt.execute();
				return true;

				// if there was no entry, insert one
			} else {
				pstmt = connection.prepareStatement("INSERT INTO usertable_? (day,hour,entry,description) VALUES (?,?,?,?);");
				pstmt.setInt(1, user_id);
				pstmt.setInt(2, day);
				pstmt.setInt(3, hour);
				pstmt.setString(4, newEntry);
				pstmt.setString(5, newDescription);
				pstmt.execute();
				
				closeConnection(connection);
				return true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(connection);
			return false;
		}
	}

	public UserTable getTable(int user_id) {
		Connection connection = getConnection();
		String sql = "SELECT * FROM usertable_" + user_id + ";";
		PreparedStatement pstmt;
		String[][] entries = new String[7][14];
		String[][] descriptions = new String[7][14];
		UserTable userTable = null;
		int day = 0;
		int hour = 0;

		try {
			pstmt = connection.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				day = rs.getInt("day");
				hour = rs.getInt("hour");
				entries[day][hour] = rs.getString("entry");
				descriptions[day][hour] = rs.getString("description");
				// System.out.println(day+ " "+hour + " " + entries[day][hour]);
			}
			userTable = new UserTable(user_id, entries, descriptions);
			return userTable;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public User selectUser(int user_id) {
		User user = null;
		String email;
		String pwHash;
		Connection connection = getConnection();
		PreparedStatement pstmt;

		try {
			pstmt = connection.prepareStatement("SELECT * FROM user WHERE user_id = ?");
			pstmt.setInt(1, user_id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				email = rs.getString("user_email");
				pwHash = rs.getString("user_pwHash");

				user = new User(user_id, email, pwHash);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally {
			closeConnection(connection);
		}

		return user;
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
	 * deletes a user from the user table and drops his week table
	 * 
	 * @param email
	 * @return true if deletion was successful, or false if it was unsuccessful
	 */
	public boolean deleteUser(int id) {
		Connection connection = getConnection();
		PreparedStatement pstmt;

		try {
			pstmt = connection.prepareStatement("DELETE FROM user WHERE user_id = ?");
			pstmt.setInt(1, id);
			pstmt.execute();

			pstmt = connection.prepareStatement("DROP TABLE usertable_?");
			pstmt.setInt(1, id);
			pstmt.execute();

			return true;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			closeConnection(connection);
		}
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
			
			closeConnection(connection);
			return pwHash;
			
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(connection);
			return null;
		}
	}

	public boolean deleteAllEvents(int user_id, String event) {
		Connection connection = getConnection();
		PreparedStatement pstmt;

		try {
			pstmt = connection.prepareStatement("DELETE FROM usertable_? WHERE entry = ?");
			pstmt.setInt(1, user_id);
			pstmt.setString(2, event);
			pstmt.execute();

			// ...success
			closeConnection(connection);
			return true;
		} catch (SQLException e) {

			// ...failure
			e.printStackTrace();
			closeConnection(connection);
			return false;
		}
	}

	/**
	 * updates the descriptions of all events with a given entry.
	 * 
	 * @param user_id
	 * @param entry
	 * @param newDescription
	 * @return the update count, if the update was successful, 0 otherwise
	 */
	public int updateAll(int user_id, String entry, String newDescription) {
		Connection connection = getConnection();
		PreparedStatement pstmt;

		try {
			pstmt = connection.prepareStatement("UPDATE usertable_? SET description = ? WHERE entry = ?;");
			pstmt.setInt(1, user_id);
			pstmt.setString(2, newDescription);
			pstmt.setString(3, entry);
			int updateCount = pstmt.executeUpdate();
			closeConnection(connection);
			// ...success
			return updateCount;
		} catch (SQLException e) {
			e.printStackTrace();
			closeConnection(connection);
			// ...failure
			return -1;
		}
	}

	public static void main(String[] args) {
		
	}

}
