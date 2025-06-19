<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Entities.User"%>
<%@ page import="Entities.Note"%>

<%
User user = (User) request.getAttribute("user");
List<Note> userNotes = (List<Note>) request.getAttribute("userNotes");

if (user == null) {
	user = new User(); // empty user to avoid null pointer
}
if (userNotes == null) {
	userNotes = new java.util.ArrayList<>();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>User Settings</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />

<style>
body {
	padding-top: 40px;
	background-color: #f8f9fa;
}

.settings-container {
	max-width: 700px;
	margin: auto;
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
	margin-bottom: 20px;
}
</style>
</head>
<body>

	<div class="container settings-container">
		<h2>User Settings</h2>
		<form action="UpdateUserServlet" method="post">
			<div class="mb-3">
				<label for="username" class="form-label">Username</label> <input
					type="text" class="form-control" id="username" name="username"
					required
					value="<%=user.getUsername() != null ? user.getUsername() : ""%>" />
			</div>

			<div class="mb-3">
				<label for="email" class="form-label">Email address</label> <input
					type="email" class="form-control" id="email" name="email" required
					value="<%=user.getEmail() != null ? user.getEmail() : ""%>" />
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">New Password (leave
					blank to keep current)</label> <input type="password" class="form-control"
					id="password" name="password" placeholder="Enter new password" />
			</div>

			<button type="submit" class="btn btn-primary">Update Profile</button>
		</form>

		<hr />

		<h3>Your Notes</h3>
		<%
		if (userNotes.isEmpty()) {
		%>
		<p>No notes found.</p>
		<%
		} else {
		%>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Note ID</th>
					<th>Title</th>
					<th>Preview</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Note note : userNotes) {
				%>
				<tr>
					<td><%=note.getNoteId()%></td>
					<td><%=note.getTitle()%></td>
					<td><%=note.getContent().length() > 100 ? note.getContent().substring(0, 100) + "..." : note.getContent()%></td>
					<td><a href="DeleteNoteServlet?noteId=<%=note.getNoteId()%>"
						class="btn btn-danger btn-sm"
						onclick="return confirm('Delete this note?');">Delete</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		%>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
