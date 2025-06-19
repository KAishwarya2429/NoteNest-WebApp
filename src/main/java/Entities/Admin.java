package Entities;

import java.sql.Timestamp;

public class Admin extends User {
	private String adminLevel;
	private String permissions;

	public Admin() {
		super();
	}

	public Admin(int userId, String username, String email, String passwordHash, String userType, Timestamp createdAt,
			Timestamp updatedAt, String adminLevel, String permissions) {
		super(userId, username, email, passwordHash, userType, createdAt, updatedAt);
		this.adminLevel = adminLevel;
		this.permissions = permissions;
	}

	public String getAdminLevel() {
		return adminLevel;
	}

	public void setAdminLevel(String adminLevel) {
		this.adminLevel = adminLevel;
	}

	public String getPermissions() {
		return permissions;
	}

	public void setPermissions(String permissions) {
		this.permissions = permissions;
	}

	public boolean hasPermission(String permission) {
		if (permissions == null || permissions.isEmpty()) {
			return false;
		}
		String[] perms = permissions.split(",");
		for (String perm : perms) {
			if (perm.trim().equalsIgnoreCase(permission)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public String toString() {
		return "Admin{" + "userId=" + getUserId() + ", username='" + getUsername() + '\'' + ", email='" + getEmail()
				+ '\'' + ", userType='" + getUserType() + '\'' + ", adminLevel='" + adminLevel + '\''
				+ ", permissions='" + permissions + '\'' + '}';
	}
}
