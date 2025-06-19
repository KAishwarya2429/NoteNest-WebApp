<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%
Entities.Admins admin = (Entities.Admins) session.getAttribute("adminUser");
if (admin == null) {
	response.sendRedirect("admin_login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Settings</title>
<style>
body {
	background: #f0f2f5;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin: 0;
	padding: 0;
}

.settings-container {
	max-width: 500px;
	margin: 80px auto;
	background: #ffffff;
	padding: 40px 30px;
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 30px;
}

label {
	font-weight: 600;
	margin-top: 15px;
	display: block;
	color: #555;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px 12px;
	margin-top: 6px;
	border: 1px solid #ccc;
	border-radius: 8px;
	outline: none;
	transition: 0.3s;
}

input[type="text"]:focus, input[type="password"]:focus {
	border-color: #007bff;
	box-shadow: 0 0 4px rgba(0, 123, 255, 0.3);
}

input[type="submit"] {
	width: 100%;
	background-color: #0A66C2;
	color: white;
	padding: 12px;
	border: none;
	border-radius: 8px;
	margin-top: 25px;
	font-size: 16px;
	cursor: pointer;
	transition: 0.3s ease;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}

.message {
	text-align: center;
	margin-top: 20px;
	font-weight: bold;
	color: #d8000c;
}

.success {
	color: green;
}
</style>
</head>
<body>
	<div class="settings-container">
		<h2>Admin Settings</h2>
		<form action="admin_settings" method="post">
			<label>Username:</label> <input type="text" name="username"
				value="<%=admin.getUsername()%>" required> <label>Current
				Password:</label> <input type="password" name="currentPassword" required>

			<label>New Password:</label> <input type="password"
				name="newPassword"> <label>Confirm New Password:</label> <input
				type="password" name="confirmPassword"> <input type="submit"
				value="Update Settings">
		</form>

		<%
		if (request.getAttribute("message") != null) {
		%>
		<div
			class="message <%=request.getAttribute("message").toString().toLowerCase().contains("success") ? "success" : ""%>">
			<%=request.getAttribute("message")%>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>
