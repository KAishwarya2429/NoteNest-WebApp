package Dao;

import Entities.Admins;
import java.sql.*;

public class AdminDao {

    private Connection conn;

    public AdminDao(Connection conn) {
        this.conn = conn;
    }

    // Validate admin login, return Admins object if credentials match
    public Admins validateAdmin(String username, String password) throws SQLException {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);  // Consider hashing password before query
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Admins admin = new Admins();
                    admin.setAdminId(rs.getInt("admin_id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPassword(rs.getString("password"));
                    admin.setCreatedAt(rs.getTimestamp("created_at"));
                    return admin;
                }
            }
        }
        return null;  // invalid username/password
    }

    // Update admin details by admin_id
    public boolean updateAdmin(Admins admin) throws SQLException {
        String sql = "UPDATE admin SET username = ?, password = ? WHERE admin_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, admin.getUsername());
            stmt.setString(2, admin.getPassword());  // Consider hashing password before update
            stmt.setInt(3, admin.getAdminId());
            return stmt.executeUpdate() > 0;
        }
    }
}
