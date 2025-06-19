package Dao;

import Entities.User;
import MyHelper.MyHelper;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDao {

	public List<User> getAllUsers() {
		List<User> users = new ArrayList<>();
		String query = "SELECT * FROM users";

		try (Connection con = MyHelper.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				User user = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("email"),
						rs.getString("password_hash"), rs.getTimestamp("created_at"), rs.getTimestamp("updated_at"));
				users.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return users;
	}
}
