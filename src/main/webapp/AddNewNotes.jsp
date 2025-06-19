<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<title>Add New Note - NoteNest</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />

<link rel="stylesheet" href="css/style.css">

</head>

<body id="newnote">

	<div class="container mt-5">
		<div class="form-container">
			<h2 class="text-center">Add New Note</h2>

			<form id="addNoteForm" action="UserController" method="post">
				<input type="hidden" name="action" value="addnote" /> <input
					type="hidden" name="user_id"
					value="<%=session.getAttribute("user_id")%>" />

				<div class="mb-3">
					<label for="title" class="form-label">Title <span
						class="text-danger">*</span></label> <input type="text" id="title"
						name="title" class="form-control" required maxlength="100"
						placeholder="Enter note title" />
				</div>

				<div class="mb-3">
					<label for="content" class="form-label">Content <span
						class="text-danger">*</span></label>
					<textarea id="content" name="content" class="form-control" rows="6"
						required placeholder="Write your note here..."></textarea>
				</div>

				<div class="mb-3">
					<label for="category" class="form-label">Category
						(Optional)</label> <input type="text" id="category" name="category"
						class="form-control" maxlength="50"
						placeholder="e.g., Work, Personal, Reminder" />
				</div>

				<div class="d-grid">
					<button type="submit" class="btn btn-primary btn-lg">Add
						Note</button>
				</div>
			</form>
		</div>
	</div>

	<script src="script/script.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>