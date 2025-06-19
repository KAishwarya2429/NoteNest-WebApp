package Entities;

import java.sql.Timestamp;

public class User {
	private int userId;
	private String username;
	private String email;
	private String passwordHash;
	private String userType; // e.g., "user", "admin"
	private Timestamp createdAt;
	private Timestamp updatedAt;

	public User() {
	}

	public User(int userId, String username, String email, String passwordHash, String userType, Timestamp createdAt,
			Timestamp updatedAt) {
		this.userId = userId;
		this.username = username;
		this.email = email;
		this.passwordHash = passwordHash;
		this.userType = userType;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public User(int userId, String username, String email, String passwordHash, Timestamp createdAt,
			Timestamp updatedAt) {
		this.userId = userId;
		this.username = username;
		this.email = email;
		this.passwordHash = passwordHash;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Timestamp getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
}
