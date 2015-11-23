package de.uulm.sopra.luisb.wochenplaner.util;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.mail.internet.*;

import de.uulm.sopra.luisb.wochenplaner.db.DBConnection;

public class Utilities {

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

	public static boolean isValidAccount(String email, String pw1, String pw2) {
		if (pw1.equals(pw2) && isValidEmailAddress(email)) {
			return true;
		}

		return false;
	}

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

	// for testing
	public static void main(String[] args) {

	}

}
