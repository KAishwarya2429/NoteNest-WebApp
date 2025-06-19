package Entities;

import java.sql.Timestamp;

public class Note {
	private int noteId;
	private int userId;
	private String title;
	private String content;
	private String category;
	private Timestamp createdAt;
	private Timestamp updatedAt;

	public Note() {
	}

	public Note(int noteId, int userId, String title, String content, String category, Timestamp createdAt,
			Timestamp updatedAt) {
		this.noteId = noteId;
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.category = category;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	public Note(int userId, String title, String content, String category) {
		this.userId = userId;
		this.title = title;
		this.content = content;
		this.category = category;
	}

	public Note(int userId, String title, String content) {
		this.userId = userId;
		this.title = title;
		this.content = content;
	}

	public int getNoteId() {
		return noteId;
	}

	public void setNoteId(int noteId) {
		this.noteId = noteId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
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

	@Override
	public String toString() {
		return "Note{" + "noteId=" + noteId + ", userId=" + userId + ", title='" + title + '\'' + ", content='"
				+ content + '\'' + ", category='" + category + '\'' + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + '}';
	}
}
