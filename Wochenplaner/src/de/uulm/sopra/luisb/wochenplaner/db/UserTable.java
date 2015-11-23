package de.uulm.sopra.luisb.wochenplaner.db;

public class UserTable {
	private int user_id;
	private String[][] entries;
	
	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getEntry(int day, int hour) {
		return entries[day][hour];
	}

	public void setEntry(int day, int hour, String entry) {
		entries[day][hour] = entry;
	}

	public UserTable(int user_id, String[][] entries) {
		this.user_id = user_id;
		this.entries = entries;
	}
	
}
