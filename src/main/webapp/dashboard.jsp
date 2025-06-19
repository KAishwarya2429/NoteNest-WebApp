<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="Entities.Note"%>

<%
if (session.getAttribute("user_id") == null) {
	session.setAttribute("user_id", 1); 
	session.setAttribute("user_name", "Aishwarya");
}

Integer userId = (Integer) session.getAttribute("user_id");
String userName = (String) session.getAttribute("user_name");

List<Note> notes = new ArrayList<>();

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
	Class.forName("org.postgresql.Driver");
	conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/notenest", "postgres", "password");

	String query = "SELECT note_id, title, content FROM notes WHERE user_id = ? ORDER BY created_at DESC LIMIT 6";
	ps = conn.prepareStatement(query);
	ps.setInt(1, userId);
	rs = ps.executeQuery();

	while (rs.next()) {
		int noteId = rs.getInt("note_id");
		String title = rs.getString("title");
		String content = rs.getString("content");

		notes.add(new Note(noteId, title, content));
	}
} catch (Exception e) {
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
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>NoteNest - Dashboard</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="css/style.css">
</head>
<body class="dashboard">

	<nav class="navbar navbar-expand-lg fixed-top dashboard-navbar-custom">
		<div class="container">
			<a class="navbar-brand dashboard-navbar-brand" href="dashboard.jsp">NoteNest</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#dashboardNavbarContent"
				aria-controls="dashboardNavbarContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-end"
				id="dashboardNavbarContent">
				<ul class="navbar-nav align-items-center">
					<li class="nav-item"><span class="nav-link dashboard-nav-link">Hello,
							<strong><%=userName%></strong>
					</span></li>
					<li class="nav-item"><a class="nav-link dashboard-nav-link"
						href="viewNote.jsp">View Notes</a></li>
					<li class="nav-item"><a class="nav-link dashboard-nav-link"
						href="user_settings.jsp">Settings</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container mt-5">
		<header class="dashboard-header">
			<h1>
				Welcome back,
				<%=userName%>!
			</h1>
			<p>Here are your latest notes.</p>
		</header>

		<div class="text-center mb-5">
			<a href="AddNewNotes.jsp" class="btn dashboard-btn-add-note">+
				Add New Note</a>
		</div>

		<div class="row g-4">
			<%
			if (notes.isEmpty()) {
			%>
			<div class="col-12 text-center">
				<p class="text-muted fs-5">No notes found. Start by adding a new
					note!</p>
			</div>
			<%
			} else {
			for (Note note : notes) {
			%>
			<div class="col-lg-4 col-md-6 col-sm-12">
				<div class="dashboard-note-card">
					<div class="dashboard-note-title"><%=note.getTitle()%></div>
					<div class="dashboard-note-body">
						<%=note.getContent().length() > 150 ? note.getContent().substring(0, 150) + "..." : note.getContent()%>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
