package de.uulm.sopra.luisb.wochenplaner.db;

public class User {
	private int user_id;
	private String user_email;
	private String pwHash;

	public User(String user_email, String pwHash) {
		super();
		this.user_email = user_email;
		this.pwHash = pwHash;
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
