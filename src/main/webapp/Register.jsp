<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>NoteNest - Welcome</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
	rel="stylesheet">
<style>
* {
	font-family: 'Poppins', sans-serif;
}

body, html {
	margin: 0;
	padding: 0;
	height: 100%;
	overflow-x: hidden;
}

body {
	background: linear-gradient(135deg, #e6f0ff 0%, #ffffff 100%);
	background-attachment: fixed;
	position: relative;
}

.hero {
	height: 100vh;
	background:
		url('https://www.transparenttextures.com/patterns/cubes.png');
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	position: relative;
	padding: 0 20px;
}

.hero-content {
	background: rgba(255, 255, 255, 0.9);
	padding: 50px;
	border-radius: 25px;
	box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
	animation: fadeIn 1.5s ease, slideUp 1.2s ease;
	max-width: 700px;
	width: 100%;
}

.hero h1 {
	font-size: 3rem;
	font-weight: 600;
	margin-bottom: 20px;
	color: #1e3c72;
}

.hero p {
	font-size: 1.2rem;
	margin-bottom: 30px;
	color: #4a4a4a;
}

.btn-notenest {
	padding: 10px 28px;
	font-size: 1rem;
	border-radius: 30px;
	background: linear-gradient(to right, #1e3c72, #2a5298);
	color: white;
	border: none;
	transition: 0.3s ease-in-out;
}

.btn-notenest:hover {
	background: linear-gradient(to right, #2a5298, #1e3c72);
	transform: scale(1.05);
	box-shadow: 0 5px 15px rgba(30, 60, 114, 0.3);
}

.btn-outline-notenest {
	padding: 10px 28px;
	font-size: 1rem;
	border-radius: 30px;
	color: #1e3c72;
	border: 2px solid #1e3c72;
	background: transparent;
	transition: 0.3s ease-in-out;
}

.btn-outline-notenest:hover {
	background: #1e3c72;
	color: white;
	transform: scale(1.05);
	box-shadow: 0 5px 15px rgba(30, 60, 114, 0.2);
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
keyframes slideUp {from { transform:translateY(50px);
	opacity: 0;
}

to {
	transform: translateY(0);
	opacity: 1;
}

}
@media ( max-width : 768px) {
	.hero h1 {
		font-size: 2.2rem;
	}
	.hero-content {
		padding: 30px 20px;
	}
}
</style>
</head>
<body>
	<div class="hero">
		<div class="hero-content">
			<h1>
				Welcome to <span style="color: #2a5298;">NoteNest</span>
			</h1>
			<p>Organize your notes, ideas, and goals in one beautiful place.</p>
			<a href="login.jsp" class="btn btn-notenest me-3">Login</a> <a
				href="registers.jsp" class="btn btn-outline-notenest">Register</a>
		</div>
	</div>
</body>
</html>