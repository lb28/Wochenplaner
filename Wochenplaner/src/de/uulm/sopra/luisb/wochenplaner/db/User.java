package de.uulm.sopra.luisb.wochenplaner.db;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import de.uulm.sopra.luisb.wochenplaner.util.*;

public class User {
	private int id;
	private String email;
	private String pwHash;

	public User(String user_email, String password) {
		super();
		this.email = user_email;
		try {
			this.pwHash = PasswordHash.createHash(password);
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			System.out.println("Something went wrong with hashing:");
			e.printStackTrace();
		}
	}

	public User(int user_id, String user_email, String pwHash) {
		super();
		this.id = user_id;
		this.email = user_email;
		this.pwHash = pwHash;
	}




	// getters and setters
	public int getUser_id() {
		return id;
	}

	public void setUser_id(int user_id) {
		this.id = user_id;
	}

	public String getUser_email() {
		return email;
	}

	public void setUser_email(String user_email) {
		this.email = user_email;
	}

	public String getPwHash() {
		return pwHash;
	}

	public void setPwHash(String pwHash) {
		this.pwHash = pwHash;
	}

}
