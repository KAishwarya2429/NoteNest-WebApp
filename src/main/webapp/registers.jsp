<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>NoteNest - Register</title>
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
	background: linear-gradient(135deg, #e6f0ff 0%, #ffffff 100%);
	display: flex;
	align-items: center;
	justify-content: center;
}

.register-container {
	background: rgba(255, 255, 255, 0.95);
	padding: 40px 50px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 480px;
	animation: slideDown 1s ease forwards;
}

h2 {
	color: #1e3c72;
	margin-bottom: 25px;
	font-weight: 600;
	text-align: center;
}

.form-label {
	font-weight: 600;
	color: #3a3a3a;
}

.form-control {
	border-radius: 12px;
	padding: 12px 15px;
	font-size: 1rem;
	border: 1.8px solid #a3bffa;
	transition: border-color 0.3s ease;
}

.form-control:focus {
	border-color: #2a5298;
	box-shadow: 0 0 6px #2a5298;
}

.btn-register {
	background: linear-gradient(90deg, #1e3c72 0%, #2a5298 100%);
	color: white;
	font-weight: 600;
	border-radius: 30px;
	padding: 12px;
	width: 100%;
	font-size: 1.1rem;
	transition: 0.3s ease-in-out;
	border: none;
	margin-top: 15px;
}

.btn-register:hover {
	background: linear-gradient(90deg, #2a5298 0%, #1e3c72 100%);
	transform: scale(1.05);
	box-shadow: 0 8px 20px rgba(42, 82, 152, 0.4);
}

.text-center a {
	color: #2a5298;
	text-decoration: none;
	font-weight: 600;
	transition: color 0.3s ease;
}

.text-center a:hover {
	color: #1e3c72;
}

@
keyframes slideDown { 0% {
	opacity: 0;
	transform: translateY(-50px);
}

100


%
{
opacity


:


1
;


transform


:


translateY
(


0


)
;


}
}
@media ( max-width : 480px) {
	.register-container {
		padding: 30px 20px;
	}
}
</style>
</head>
<body>
	<div class="register-container shadow">
		<h2>Create your NoteNest account</h2>
		<form action="UserController" method="post">
			<input type="hidden" name="action" value="register" />
			<div class="mb-3">
				<label for="fullname" class="form-label">Full Name</label> <input
					type="text" class="form-control" id="username" name="username"
					placeholder="Your full name" required autofocus>
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">Email address</label> <input
					type="email" class="form-control" id="email" name="email"
					placeholder="you@example.com" required>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">Password</label> <input
					type="password" class="form-control" id="password" name="password"
					placeholder="Create a password" required minlength="6">
			</div>
			<div class="mb-3">
				<label for="confirm_password" class="form-label">Confirm
					Password</label> <input type="password" class="form-control"
					id="confirm_password" name="confirm_password"
					placeholder="Confirm your password" required minlength="6">
			</div>
			<button type="submit" class="btn btn-register">Register</button>
		</form>
		<p class="text-center mt-3">
			Already have an account? <a href="login.jsp">Login here</a>
		</p>
	</div>
</body>
</html>
