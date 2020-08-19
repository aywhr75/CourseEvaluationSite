<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, intial-scale=1, shrink-to-fit=no">
	<title>COURSE EVALUATION WEB SITE</title>
	<!-- adding bootstrap CSS -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- adding custom CSS -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<% 
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please Login');");
		script.println("location.href='userLogin.jsp'"); 
		script.println("</script>");
		script.close();		
	}
%>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">COURSE EVALUATION WEB SITE</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nave-item active">
					<a class="nav-link" href="index.jsp">Main</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nave-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						Menu
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null){
%>
						<a class="dropdown-item" href="userLogin.jsp">LOGIN</a>
						<a class="dropdown-item" href="userJoin.jsp">SIGNUP</a>
<%
	}else{
%>
						<a class="dropdown-item" href="userLogout.jsp">LOGOUT</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="prof or course name" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
	<section class="container mt-5" style="max-width:560px;">
		<div class="alert alert-warning mt4" role="alert">
			Should be an email verified first to evaluation, didn't you get a verification email?
		</div>
		<a href="emailSendAction.jsp" class="btn btn-primary">Re-send verification email</a>
	</section>
	<footer class="bg-dark mt-4 p-5 text-center" style="color:#FFFFFF">
		Copyright &copy; 2020 YoungA Lee All Right Reserved.
	</footer>
	<!-- adding JQury JavaScript -->
	<script src="./js/jquery.min.js"></script>
	<!-- adding Popper JavaScript -->
	<script src="./js/popper.js"></script>
	<!-- adding Bootstrap JavaScript -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>