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
}
