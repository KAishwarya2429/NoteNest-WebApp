<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String userIdStr = request.getParameter("userId");
if (userIdStr == null) {
	response.sendRedirect("admin_users.jsp");
	return;
}

int userId = -1;
try {
	userId = Integer.parseInt(userIdStr);
} catch (NumberFormatException e) {
	response.sendRedirect("admin_users.jsp");
	return;
}

String username = "";
String email = "";
String userType = "";
String message = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {
	username = request.getParameter("username");
	email = request.getParameter("email");
	userType = request.getParameter("userType");

	Connection conn = null;
	PreparedStatement ps = null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notenest", "root", "password");
		ps = conn.prepareStatement("UPDATE users SET username=?, email=?, user_type=? WHERE user_id=?");
		ps.setString(1, username);
		ps.setString(2, email);
		ps.setString(3, userType);
		ps.setInt(4, userId);
		int updated = ps.executeUpdate();
		if (updated > 0) {
	response.sendRedirect("admin_users.jsp");
	return;
		} else {
	message = "Update failed. Please try again.";
		}
	} catch (Exception e) {
		message = "Error: " + e.getMessage();
		e.printStackTrace();
	} finally {
		if (ps != null)
	try {
		ps.close();
	} catch (Exception e) {
	}
		if (conn != null)
	try {
		conn.close();
	} catch (Exception e) {
	}
	}
} else {
	// Load user data
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notenest", "root", "password");
		ps = conn.prepareStatement("SELECT username, email, user_type FROM users WHERE user_id = ?");
		ps.setInt(1, userId);
		rs = ps.executeQuery();
		if (rs.next()) {
	username = rs.getString("username");
	email = rs.getString("email");
	userType = rs.getString("user_type");
		} else {
	response.sendRedirect("admin_users.jsp");
	return;
		}
	} catch (Exception e) {
		message = "Error: " + e.getMessage();
		e.printStackTrace();
	} finally {
		if (rs != null)
	try {
		rs.close();
	} catch (Exception e) {
	}
		if (ps != null)
	try {
		ps.close();
	} catch (Exception e) {
	}
		if (conn != null)
	try {
		conn.close();
	} catch (Exception e) {
	}
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit User</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
</head>
<body>
	<div class="container mt-5">
		<h2>Edit User</h2>

		<%
		if (!message.isEmpty()) {
		%>
		<div class="alert alert-danger"><%=message%></div>
		<%
		}
		%>

		<form method="post" action="editUser.jsp?userId=<%=userId%>">
			<div class="mb-3">
				<label class="form-label">Username:</label> <input type="text"
					name="username" class="form-control" value="<%=username%>"
					required>
			</div>
			<div class="mb-3">
				<label class="form-label">Email:</label> <input type="email"
					name="email" class="form-control" value="<%=email%>" required>
			</div>
			<div class="mb-3">
				<label class="form-label">User Type:</label> <select name="userType"
					class="form-select" required>
					<option value="User"
						<%="User".equals(userType) ? "selected" : ""%>>User</option>
					<option value="Admin"
						<%="Admin".equals(userType) ? "selected" : ""%>>Admin</option>
				</select>
			</div>
			<button type="submit" class="btn btn-primary">Update</button>
			<a href="admin_users.jsp" class="btn btn-secondary">Cancel</a>
		</form>
	</div>
</body>
</html>
