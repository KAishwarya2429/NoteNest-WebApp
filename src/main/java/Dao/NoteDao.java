// In path: /src/Dao/NoteDao.java
package Dao;

import java.sql.*;
import java.util.*;
import Entities.Note;
import MyHelper.MyHelper;

public class NoteDao {
	public List<Note> getAllNotes() {
		List<Note> notes = new ArrayList<>();
		String query = "SELECT * FROM notes";
		try (Connection con = MyHelper.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Note note = new Note(rs.getInt("note_id"), rs.getInt("user_id"), rs.getString("title"),
						rs.getString("content"), rs.getString("category"), rs.getTimestamp("created_at"),
						rs.getTimestamp("updated_at"));
				notes.add(note);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return notes;
	}
}
