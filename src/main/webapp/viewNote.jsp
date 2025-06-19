<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, Entities.Note"%>

<%
Integer userId = (Integer) session.getAttribute("user_id");
String userName = (String) session.getAttribute("user_name");

if (userId == null) {
	response.sendRedirect("login.jsp");
	return;
}

List<Note> notes = new ArrayList<>();
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/notenest", "root", "password");

	String query = "SELECT note_id, title, content, category, created_at, updated_at FROM notes WHERE user_id = ? ORDER BY created_at DESC";
	ps = conn.prepareStatement(query);
	ps.setInt(1, userId);
	rs = ps.executeQuery();

	while (rs.next()) {
		Note note = new Note();
		note.setNoteId(rs.getInt("note_id"));
		note.setTitle(rs.getString("title"));
		note.setContent(rs.getString("content"));
		note.setCategory(rs.getString("category"));
		note.setCreatedAt(rs.getTimestamp("created_at"));
		note.setUpdatedAt(rs.getTimestamp("updated_at"));

		notes.add(note);
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
<title>Your Notes - NoteNest</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="css/style.css" />

<style>
body {
	font-family: 'Poppins', sans-serif;
	padding-top: 60px;
	background-color: #f9fafb;
}

.note-card {
	box-shadow: 0 4px 15px rgba(30, 60, 114, 0.1);
	border-radius: 12px;
	padding: 20px;
	background: white;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.note-title {
	font-weight: 600;
	font-size: 1.3rem;
	margin-bottom: 10px;
	color: #1e3c72;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.note-content {
	flex-grow: 1;
	color: #444;
	font-size: 1rem;
	overflow: hidden;
	max-height: 100px;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.note-footer {
	margin-top: 15px;
	font-size: 0.85rem;
	color: #888;
}
</style>
</head>
<body>

	<div class="container">
		<h2 class="mb-4">
			Hello,
			<%=userName%>! Here are your notes:
		</h2>

		<div class="row g-4">
			<%
			if (notes.isEmpty()) {
			%>
			<div class="col-12">
				<p class="text-muted fs-5 text-center">
					You have no notes yet. <a href="AddNewNotes.jsp">Add a new note</a>
					to get started!
				</p>
			</div>
			<%
			} else {
			for (Note n : notes) {
			%>
			<div class="col-md-4 col-sm-6">
				<div class="note-card">
					<div class="note-title"><%=n.getTitle()%></div>
					<div class="note-content">
						<%=n.getContent().length() > 150 ? n.getContent().substring(0, 150) + "..." : n.getContent()%>
					</div>
					<div class="note-footer">
						Category:
						<%=n.getCategory() != null && !n.getCategory().isEmpty() ? n.getCategory() : "None"%>
						<br /> Created:
						<%=n.getCreatedAt() != null ? n.getCreatedAt().toString() : "N/A"%>
						<br /> <a href="viewNoteDetails.jsp?noteId=<%=n.getNoteId()%>"
							class="btn btn-sm btn-outline-primary mt-2">View Details</a>
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
