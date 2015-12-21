package de.uulm.sopra.luisb.wochenplaner.util;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.Collections;
import java.util.LinkedList;

import javax.mail.internet.*;

import de.uulm.sopra.luisb.wochenplaner.db.DBConnection;
import de.uulm.sopra.luisb.wochenplaner.db.User;
import de.uulm.sopra.luisb.wochenplaner.db.UserTable;

public class Utilities {

	//validation already happens on the jsp (html5 input type email), but this validates again
	public static boolean isValidEmailAddress(String email) {
		boolean result = true;
		try {
			InternetAddress emailAddr = new InternetAddress(email);
			emailAddr.validate();
		} catch (AddressException ex) {
			result = false;
		}
		return result;
	}

	//for verifying if the user entered correct data in the registration form
	public static boolean isValidAccount(String email, String pw1, String pw2) {
		if (pw1.equals(pw2) && isValidEmailAddress(email)) {
			return true;
		}

		return false;
	}
	
	//validates a password using the PasswordHash class
	public static boolean validatePassword(String email, String password) {
		DBConnection dbc = new DBConnection();
		boolean isValid = false;

		if (isValidEmailAddress(email)) {
			String correctHash = dbc.getHash(email);

			if (correctHash == null) {
				return false;
			}

			try {
				isValid = PasswordHash.validatePassword(password, correctHash);
			} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
				System.out.println("Something went wrong while validating the password:");
				e.printStackTrace();
			}

		}

		return isValid;
	}

	public static String getDay(int index) {
		String[] days = { "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag" };
		if (index < 7) {
			return days[index];
		} else {
			return null;
		}
	}

	/**
	 * returns an array with all unique entries (e.g. the events)
	 */
	public static LinkedList<String> getUniqueEntries(int user_id) {
		UserTable userTable = getTable(user_id);
		LinkedList<String> uniqueEntries = new LinkedList<>();

		for (int hour = 0; hour < 14; hour++) {
			for (int day = 0; day < 7; day++) {
				String entry = userTable.getEntry(day, hour);
				//if the entry is not in the list yet and it is not empty, add it to the list
				if (!(uniqueEntries.contains(entry)) && (!entry.equals(""))) {
					uniqueEntries.add(entry);
				}
			}
		}
		
		return uniqueEntries;
	}

	public static User selectUser(String email) {
		DBConnection dbc = new DBConnection();
		return dbc.selectUser(email);
	}
	
	public static User selectUser(int user_id) {
		DBConnection dbc = new DBConnection();
		return dbc.selectUser(user_id);
	}

	public static void insertUser(User user) {
		DBConnection dbc = new DBConnection();
		dbc.insert(user);
	}
	
	public static boolean deleteUser(int id) {
		DBConnection dbc = new DBConnection();
		return dbc.deleteUser(id);
	}
	
	public static UserTable getTable(int user_id) {
		DBConnection dbc = new DBConnection();
		return dbc.getTable(user_id);
	}
	
	public static int updateAll(int user_id, String entry, String newDescription) {
		DBConnection dbc = new DBConnection();
		return dbc.updateAll(user_id, entry, newDescription);
	}
	
	public static boolean deleteEntry(int user_id, int day, int hour) {
		return updateEntry(user_id, day, hour, "", "");
	}
	
	public static boolean updateEntry(int user_id, int day, int hour, String newEntry, String newDescription) {
		DBConnection dbc = new DBConnection();
		return dbc.updateEntry(user_id, day, hour, newEntry, newDescription);
	}
	
	public static boolean moveEntry(int user_id, int day, int hour, int newDay, int newHour) {
		DBConnection dbc = new DBConnection();
		return dbc.moveEntry (user_id, day, hour, newDay, newHour);
	}
	
	public static boolean deleteAllEvents(int user_id, String event) {
		DBConnection dbc = new DBConnection();
		return dbc.deleteAllEvents(user_id, event);
	}

	// for testing
	public static void main(String[] args) {

	}

}
