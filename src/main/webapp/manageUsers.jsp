<%@ page import="java.sql.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String dbURL = "jdbc:mysql://localhost:3306/notenest";
String dbUser = "root";
String dbPass = "password";

Class.forName("com.mysql.cj.jdbc.Driver");

String action = request.getParameter("action");
String userIdStr = request.getParameter("userId");
int userId = -1;
if (userIdStr != null) {
	try {
		userId = Integer.parseInt(userIdStr);
	} catch (NumberFormatException e) {
		userId = -1;
	}
}

String message = "";

try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {

	// DELETE user
	if ("delete".equalsIgnoreCase(action) && userId != -1) {
		try (PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE user_id = ?")) {
	ps.setInt(1, userId);
	int deleted = ps.executeUpdate();
	if (deleted > 0) {
		message = "User deleted successfully.";
	} else {
		message = "User not found or could not delete.";
	}
		}
		action = null; // reset to show list after deletion
	}

	// UPDATE user - only on POST method & action=update
	if ("POST".equalsIgnoreCase(request.getMethod()) && "update".equalsIgnoreCase(action) && userId != -1) {
		String username = request.getParameter("username");
		String email = request.getParameter("email");

		try (PreparedStatement ps = conn
		.prepareStatement("UPDATE users SET username = ?, email = ? WHERE user_id = ?")) {
	ps.setString(1, username);
	ps.setString(2, email);
	ps.setInt(3, userId);

	int updated = ps.executeUpdate();
	if (updated > 0) {
		message = "User updated successfully.";
		action = null; // back to list
	} else {
		message = "Update failed.";
	}
		}
	}

	// For view or edit, fetch user data
	String username = "";
	String email = "";
	if (("view".equalsIgnoreCase(action) || "edit".equalsIgnoreCase(action)) && userId != -1) {
		try (PreparedStatement ps = conn.prepareStatement("SELECT username, email FROM users WHERE user_id = ?")) {
	ps.setInt(1, userId);
	try (ResultSet rs = ps.executeQuery()) {
		if (rs.next()) {
			username = rs.getString("username");
			email = rs.getString("email");
		} else {
			message = "User not found.";
			action = null;
		}
	}
		}
	}

	// Fetch all users
	try (PreparedStatement psAll = conn
	.prepareStatement("SELECT user_id, username, email FROM users ORDER BY user_id ASC");
	ResultSet rsAll = psAll.executeQuery()) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>User Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-4 text-center">User Management</h2>

		<%
		if (!message.isEmpty()) {
		%>
		<div class="alert alert-info"><%=message%></div>
		<%
		}
		%>

		<%
		if (action == null) {
		%>
		<table class="table table-bordered table-striped">
			<thead class="table-dark">
				<tr>
					<th>User ID</th>
					<th>Username</th>
					<th>Email</th>
					<th class="text-center">Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				boolean hasUsers = false;
				while (rsAll.next()) {
					hasUsers = true;
				%>
				<tr>
					<td><%=rsAll.getInt("user_id")%></td>
					<td><%=rsAll.getString("username")%></td>
					<td><%=rsAll.getString("email")%></td>
					<td class="text-center"><a
						href="manageUsers.jsp?action=view&userId=<%=rsAll.getInt("user_id")%>"
						class="btn btn-sm btn-info">View</a> <a
						href="manageUsers.jsp?action=edit&userId=<%=rsAll.getInt("user_id")%>"
						class="btn btn-sm btn-warning">Edit</a> <a
						href="manageUsers.jsp?action=delete&userId=<%=rsAll.getInt("user_id")%>"
						class="btn btn-sm btn-danger"
						onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
					</td>
				</tr>
				<%
				}
				%>
				<%
				if (!hasUsers) {
				%>
				<tr>
					<td colspan="4" class="text-center">No users found.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

		<%
		} else if ("view".equalsIgnoreCase(action)) {
		%>
		<h3>User Details</h3>
		<p>
			<strong>ID:</strong>
			<%=userId%></p>
		<p>
			<strong>Username:</strong>
			<%=username%></p>
		<p>
			<strong>Email:</strong>
			<%=email%></p>
		<a href="manageUsers.jsp" class="btn btn-secondary">Back to list</a>

		<%
		} else if ("edit".equalsIgnoreCase(action)) {
		%>
		<h3>Edit User</h3>
		<form method="post"
			action="manageUsers.jsp?action=update&userId=<%=userId%>">
			<div class="mb-3">
				<label class="form-label">Username:</label> <input type="text"
					name="username" class="form-control" value="<%=username%>"
					required />
			</div>
			<div class="mb-3">
				<label class="form-label">Email:</label> <input type="email"
					name="email" class="form-control" value="<%=email%>" required />
			</div>
			<button type="submit" class="btn btn-primary">Update</button>
			<a href="manageUsers.jsp" class="btn btn-secondary">Cancel</a>
		</form>
		<%
		}
		%>
	</div>
</body>
</html>

<%
} // end try for fetch all users
} catch (Exception e) {
out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
}
%>
