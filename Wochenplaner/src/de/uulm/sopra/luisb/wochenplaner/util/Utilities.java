package de.uulm.sopra.luisb.wochenplaner.util;

import javax.mail.internet.*;

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
		if (pw1.equals(pw2)) {
			if (isValidEmailAddress(email)) {
				return true;
			}
		}
		
		return false;
	}
}
