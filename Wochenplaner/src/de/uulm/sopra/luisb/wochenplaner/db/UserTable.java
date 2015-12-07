package de.uulm.sopra.luisb.wochenplaner.db;

/**
 * @author Luis
 *
 */
public class UserTable {
	private int user_id;
	private String[][] entries;
	private String[][] descriptions;
	
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
	
	public String getDescription(int day, int hour) {
		return descriptions[day][hour];
	}

	public void setDescription(int day, int hour, String entry) {
		descriptions[day][hour] = entry;
	}
	
	
	/** searches for an entry in the users table
	 * @param entry
	 * @return true, if the table contains the entry, false otherwise
	 */
	public boolean contains(String entry) {
		if (entry.equals("")) {
			return false;
		}
		for (int i = 0; i < entries.length; i++) {
			for (int j = 0; j < entries[0].length; j++) {
				if (entries[i][j].equals(entry)) {
					return true;
				}
			}
		}
		return false;
	}

	public UserTable(int user_id, String[][] entries, String[][] descriptions) {
		this.user_id = user_id;
		this.entries = entries;
		this.descriptions = descriptions;
		
		//set all the null values to ""
		for (int i = 0; i < entries.length; i++) {
			for (int j = 0; j < entries[0].length; j++) {
				if (entries[i][j] == null) {
					entries[i][j] = "";
				}
				if (descriptions[i][j] == null) {
					descriptions[i][j] = "";
				}
			}
		}
	}
	
}
