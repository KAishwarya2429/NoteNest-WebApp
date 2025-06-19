<%@ page import="java.sql.*"%>
<%
String userIdStr = request.getParameter("userId");
if (userIdStr == null) {
	response.sendRedirect("admin_users.jsp"); 
	return;
}

int userId = Integer.parseInt(userIdStr);

String username = null, email = null, userType = null;

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
		out.println("User not found!");
		return;
	}

} catch (Exception e) {
	e.printStackTrace();
} finally {
	try {
		if (rs != null)
	rs.close();
	} catch (Exception e) {
	}
	try {
		if (ps != null)
	ps.close();
	} catch (Exception e) {
	}
	try {
		if (conn != null)
	conn.close();
	} catch (Exception e) {
	}
}
%>

<!DOCTYPE html>
<html>
<head>
<title>View User</title>
</head>
<body>
	<h2>User Details</h2>
	<p>
		<strong>ID:</strong>
		<%=userId%></p>
	<p>
		<strong>Username:</strong>
		<%=username%></p>
	<p>
		<strong>Email:</strong>
		<%=email%></p>
	<p>
		<strong>User Type:</strong>
		<%=userType%></p>

	<a href="admin_users.jsp">Back to list</a>
</body>
</html>
