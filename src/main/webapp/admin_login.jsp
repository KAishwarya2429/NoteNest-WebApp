<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Admin Login - NoteNest</title>

<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />

<link rel="stylesheet" href="css/style.css" />
</head>
<body id="adminlogin_page">

	<div class="adminlogin_container container mt-5"
		style="max-width: 400px;">
		<h2 class="adminlogin_title text-center mb-4">Admin Login</h2>

		<form action="admin_login" method="post" autocomplete="off">
			<div class="adminlogin_input-group mb-3">
				<label for="adminlogin_username" class="adminlogin_label form-label">Username</label>
				<input type="text" name="username" id="adminlogin_username"
					class="adminlogin_input form-control" placeholder="Enter username"
					required autofocus autocomplete="username" />
			</div>

			<div class="adminlogin_input-group mb-4">
				<label for="adminlogin_password" class="adminlogin_label form-label">Password</label>
				<input type="password" name="password" id="adminlogin_password"
					class="adminlogin_input form-control" placeholder="Enter password"
					required autocomplete="current-password" />
			</div>

			<button type="submit" class="adminlogin_btn btn btn-primary w-100">Login</button>
		</form>

		<%
		String errorMessage = (String) request.getAttribute("errorMessage");
		if (errorMessage != null) {
		%>
		<div class="alert alert-danger mt-3" role="alert">
			<%=errorMessage%>
		</div>
		<%
		}
		%>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
