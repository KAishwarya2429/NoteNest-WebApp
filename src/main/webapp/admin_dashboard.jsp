<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Entities.Note"%>
<%@ page import="Entities.User"%>
<%@ page import="Dao.NoteDao"%>
<%@ page import="Dao.DashboardDao"%>

<%
String adminName = "Admin";

NoteDao noteDao = new NoteDao();
DashboardDao userDao = new DashboardDao();

List<Note> notes = noteDao.getAllNotes();
List<User> users = userDao.getAllUsers();

if (notes == null) {
	notes = new java.util.ArrayList<>();
}
if (users == null) {
	users = new java.util.ArrayList<>();
}

request.setAttribute("notes", notes);
request.setAttribute("users", users);

int noteCount = notes.size();
int userCount = users.size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Admin Dashboard - NoteNest</title>

<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<style>
body.admindashboard {
	font-family: 'Roboto', sans-serif;
	background-color: #f5f7fa;
	padding-top: 70px;
}

nav.admin-navbar {
	background-color: #1e3c72;
}

nav.admin-navbar .navbar-brand, nav.admin-navbar .nav-link {
	color: #fff;
}

nav.admin-navbar .nav-link:hover {
	text-decoration: underline;
}

.dashboard-title-section h1 {
	font-weight: 700;
	margin-bottom: 5px;
	color: #1e3c72;
}

.dashboard-title-section p {
	color: #4a4a4a;
	font-size: 1.1rem;
}

.summary-cards {
	margin-top: 40px;
}

.card-summary {
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
	transition: transform 0.2s;
}

.card-summary:hover {
	transform: translateY(-5px);
}

.card-summary h5 {
	font-weight: 600;
	color: #1e3c72;
}

.card-summary p {
	font-size: 1.4rem;
	font-weight: bold;
	color: #343a40;
}
</style>
</head>
<body class="admindashboard">

	<nav class="navbar navbar-expand-lg fixed-top admin-navbar shadow-sm">
		<div class="container">
			<a class="navbar-brand" href="admin_dashboard.jsp">NoteNest Admin</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#adminNavbar"
				aria-controls="adminNavbar" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse justify-content-end"
				id="adminNavbar">
				<ul class="navbar-nav align-items-center me-4">
					<li class="nav-item"><a class="nav-link"
						href="admin_users.jsp">Users</a></li>
					<li class="nav-item"><a class="nav-link"
						href="admin_notes.jsp">Notes</a></li>
					<li class="nav-item"><a class="nav-link"
						href="admin_settings.jsp">Settings</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container" id="admin-dashboard">
		<div class="dashboard-title-section text-center">
			<h1>
				Welcome,
				<%=adminName%>
				👋
			</h1>
			<p>Here’s an overview of your platform’s activity</p>
		</div>
		<div class="row summary-cards justify-content-center">
			<div class="col-md-5 mb-4">
				<div class="card card-summary p-4 text-center">
					<h5>Total Users</h5>
					<p><%=users.size()%></p>
				</div>
			</div>

			<div class="col-md-5 mb-4">
				<div class="card card-summary p-4 text-center">
					<h5>Total Notes</h5>
					<p><%=notes.size()%></p>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>