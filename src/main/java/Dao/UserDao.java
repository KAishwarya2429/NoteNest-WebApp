package Dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Entities.User;
import Entities.Note;
import MyHelper.MyHelper;

public class UserDao {

    // Register new user
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)";
        try (Connection con = MyHelper.getConnection(); 
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Login user by email and password hash
    public User loginUser(String email, String passwordHash) {
        String query = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
        try (Connection con = MyHelper.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, passwordHash);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Add a new note
    public boolean addNote(Note note) {
        String query = "INSERT INTO notes (user_id, title, content, category, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = MyHelper.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, note.getUserId());
            stmt.setString(2, note.getTitle());
            stmt.setString(3, note.getContent());
            stmt.setString(4, note.getCategory());

            Timestamp createdAt = note.getCreatedAt() != null ? note.getCreatedAt()
                    : new Timestamp(System.currentTimeMillis());
            Timestamp updatedAt = note.getUpdatedAt() != null ? note.getUpdatedAt()
                    : new Timestamp(System.currentTimeMillis());

            stmt.setTimestamp(5, createdAt);
            stmt.setTimestamp(6, updatedAt);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all notes by a specific user
    public List<Note> getNotesByUserId(int userId) {
        List<Note> notes = new ArrayList<>();
        String query = "SELECT * FROM notes WHERE user_id = ?";
        try (Connection con = MyHelper.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Note note = new Note(
                        rs.getInt("note_id"),
                        rs.getInt("user_id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("category"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                notes.add(note);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notes;
    }

    // Update an existing note
    public boolean updateNote(Note note) {
        String query = "UPDATE notes SET title = ?, content = ?, category = ?, updated_at = ? WHERE note_id = ?";
        try (Connection con = MyHelper.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, note.getTitle());
            stmt.setString(2, note.getContent());
            stmt.setString(3, note.getCategory());
            stmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(5, note.getNoteId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a note by ID
    public boolean deleteNoteById(int noteId) {
        String query = "DELETE FROM notes WHERE note_id = ?";
        try (Connection con = MyHelper.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, noteId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get a single note by ID
    public Note getNoteById(int noteId) {
        String query = "SELECT * FROM notes WHERE note_id = ?";
        try (Connection con = MyHelper.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, noteId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Note(
                        rs.getInt("note_id"),
                        rs.getInt("user_id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("category"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all notes (admin view)
    public List<Note> getAllNotes() {
        List<Note> notes = new ArrayList<>();
        String query = "SELECT * FROM notes";
        try (Connection con = MyHelper.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Note note = new Note(
                        rs.getInt("note_id"),
                        rs.getInt("user_id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("category"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                notes.add(note);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notes;
    }
}
