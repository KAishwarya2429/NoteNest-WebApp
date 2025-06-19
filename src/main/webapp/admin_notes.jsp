<%@ page import="java.sql.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
String dbURL = "jdbc:postgresql://localhost:5432/notenest";
String dbUser = "postgres";
String dbPass = "password";

Class.forName("org.postgresql.Driver");

String action = request.getParameter("action");
String noteIdStr = request.getParameter("noteId");
int noteId = -1;
if (noteIdStr != null) {
	try {
		noteId = Integer.parseInt(noteIdStr);
	} catch (NumberFormatException e) {
		noteId = -1;
	}
}

String message = "";

try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {

	if ("delete".equalsIgnoreCase(action) && noteId != -1) {
		try (PreparedStatement ps = conn.prepareStatement("DELETE FROM notes WHERE note_id = ?")) {
	ps.setInt(1, noteId);
	int deleted = ps.executeUpdate();
	if (deleted > 0) {
		message = "Note deleted successfully.";
	} else {
		message = "Note not found or could not delete.";
	}
		}
		action = null; 
	}

	if ("update".equalsIgnoreCase(request.getMethod()) && noteId != -1) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");

		try (PreparedStatement ps = conn
		.prepareStatement("UPDATE notes SET title = ?, content = ?, category = ? WHERE note_id = ?")) {
	ps.setString(1, title);
	ps.setString(2, content);
	ps.setString(3, category);
	ps.setInt(4, noteId);

	int updated = ps.executeUpdate();
	if (updated > 0) {
		message = "Note updated successfully.";
		action = null; 
	} else {
		message = "Update failed.";
	}
		}
	}

	// For view or edit action, fetch note data
	String title = "";
	String content = "";
	String category = "";
	Timestamp createdAt = null;
	Timestamp updatedAt = null;

	if (("view".equalsIgnoreCase(action) || "edit".equalsIgnoreCase(action)) && noteId != -1) {
		try (PreparedStatement ps = conn.prepareStatement(
		"SELECT title, content, category, created_at, updated_at FROM notes WHERE note_id = ?")) {
	ps.setInt(1, noteId);
	try (ResultSet rs = ps.executeQuery()) {
		if (rs.next()) {
			title = rs.getString("title");
			content = rs.getString("content");
			category = rs.getString("category");
			createdAt = rs.getTimestamp("created_at");
			updatedAt = rs.getTimestamp("updated_at");
		} else {
			message = "Note not found.";
			action = null;
		}
	}
		}
	}

	// Fetch all notes for list view
	try (PreparedStatement psAll = conn.prepareStatement(
	"SELECT note_id, title, category, created_at, updated_at FROM notes ORDER BY created_at DESC");
	ResultSet rsAll = psAll.executeQuery()) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Manage Notes</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
</head>
<body>
	<div class="container mt-5">
		<h2 class="mb-4 text-center">Manage Notes</h2>

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
					<th>Note ID</th>
					<th>Title</th>
					<th>Category</th>
					<th>Created At</th>
					<th>Updated At</th>
					<th class="text-center">Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				boolean hasNotes = false;
				while (rsAll.next()) {
					hasNotes = true;
				%>
				<tr>
					<td><%=rsAll.getInt("note_id")%></td>
					<td><%=rsAll.getString("title")%></td>
					<td><%=rsAll.getString("category")%></td>
					<td><%=rsAll.getTimestamp("created_at")%></td>
					<td><%=rsAll.getTimestamp("updated_at")%></td>
					<td class="text-center"><a
						href="admin_notes.jsp?action=view&noteId=<%=rsAll.getInt("note_id")%>"
						class="btn btn-sm btn-info">View</a> <a
						href="admin_notes.jsp?action=edit&noteId=<%=rsAll.getInt("note_id")%>"
						class="btn btn-sm btn-warning">Edit</a> <a
						href="admin_notes.jsp?action=delete&noteId=<%=rsAll.getInt("note_id")%>"
						class="btn btn-sm btn-danger"
						onclick="return confirm('Are you sure you want to delete this note?');">Delete</a>
					</td>
				</tr>
				<%
				}
				%>
				<%
				if (!hasNotes) {
				%>
				<tr>
					<td colspan="6" class="text-center">No notes found.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

		<%
		} else if ("view".equalsIgnoreCase(action)) {
		%>
		<h3>Note Details</h3>
		<p>
			<strong>ID:</strong>
			<%=noteId%></p>
		<p>
			<strong>Title:</strong>
			<%=title%></p>
		<p>
			<strong>Category:</strong>
			<%=category != null ? category : "N/A"%></p>
		<p>
			<strong>Content:</strong>
		</p>
		<div class="border p-3 mb-3" style="white-space: pre-wrap;"><%=content != null ? content : ""%></div>
		<p>
			<strong>Created At:</strong>
			<%=createdAt%></p>
		<p>
			<strong>Updated At:</strong>
			<%=updatedAt%></p>
		<a href="admin_notes.jsp" class="btn btn-secondary">Back to list</a>

		<%
		} else if ("edit".equalsIgnoreCase(action)) {
		%>
		<h3>Edit Note</h3>
		<form method="post"
			action="admin_notes.jsp?action=update&noteId=<%=noteId%>">
			<div class="mb-3">
				<label class="form-label">Title:</label> <input type="text"
					name="title" class="form-control" value="<%=title%>" required />
			</div>
			<div class="mb-3">
				<label class="form-label">Category:</label> <input type="text"
					name="category" class="form-control" value="<%=category%>" />
			</div>
			<div class="mb-3">
				<label class="form-label">Content:</label>
				<textarea name="content" rows="6" class="form-control"><%=content%></textarea>
			</div>
			<button type="submit" class="btn btn-primary">Update</button>
			<a href="admin_notes.jsp" class="btn btn-secondary">Cancel</a>
		</form>
		<%
		}
		%>
	</div>
</body>
</html>

<%
} // end try for fetching all notes
} catch (Exception e) {
out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
}
%>
