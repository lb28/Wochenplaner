package de.uulm.sopra.luisb.wochenplaner.db;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import de.uulm.sopra.luisb.wochenplaner.util.*;

public class User {
	private int user_id;
	private String user_email;
	private String pwHash;

	public User(String user_email, String password) {
		super();
		this.user_email = user_email;
		try {
			this.pwHash = PasswordHash.createHash(password);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			System.out.println("Something went wrong with hashing:");
			e.printStackTrace();
		}
	}

	
	// getters and setters
	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getPwHash() {
		return pwHash;
	}

	public void setPwHash(String pwHash) {
		this.pwHash = pwHash;
	}

}
