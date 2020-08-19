<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>

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
	request.setCharacterEncoding("UTF-8");
	String courseDivide = "All";
	String searchType = "Latest";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("courseDivide") != null){
		courseDivide = request.getParameter("courseDivide");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception e){
			System.out.println("Searching page error");
		}		
	}
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
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='emailSendConfirm.jsp'");
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
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="courseDivide" class="form-control mx-1 mt-2">
				<option value="All"> All </option>
				<option value="Major" <% if(courseDivide.equals("Subject")) out.println("selected"); %>> Major </option>
				<option value="General <% if(courseDivide.equals("Professor")) out.println("selected"); %>"> General </option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="Latest"> Latest </option>
				<option value="Recommendation" <% if(searchType.equals("Recommendation")) out.println("selected"); %>> Recommendation </option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="Enter values">
			<button type="submit" class="btn btn-primary mx-1 mt-2">Search</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">Evaluation</a>
		</form>
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(courseDivide, searchType, search, pageNumber);
	if(evaluationList != null)
	for(int i = 0; i < evaluationList.size(); i++) {
		if(i == 5) break;
		EvaluationDTO evaluation = evaluationList.get(i);
%>		
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= evaluation.getSubjectCode() %>&nbsp;<small><%= evaluation.getProfessorName() %></small></div>
					<div class="col-4 text-right">
						Total<span style="color:red;"><%= evaluation.getTotalScore() %></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%= evaluation.getEvaluationTitle() %>&nbsp;<small>(<%= evaluation.getCourseYear() %>,<%= evaluation.getSemesterDivide() %>)</small>
				</h5>
				<p class="card-text"><%= evaluation.getEvaluationContent() %></p>
				<div class="row">
					<div class="col-9 text-left">
						Difficulty <span style="color:red;"><%= evaluation.getDifficulty() %></span>
						Grading Level <span style="color:red;"><%= evaluation.getGradingLevel() %></span>
						Attendance <span style="color:red;"><%= evaluation.getAttendance() %></span>
					</div>
					
				</div>
			</div>
		</div>
<%
	}
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <= 0){	
	
%>
	<a class="page-link disabled">Previous</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(courseDivide, "UTF-8")%>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8")%>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=
	<%= pageNumber - 1%>">Previous</a>
<%
	}
%>
		</li>
<!-- 이부분 끼워넣기 -->
<li>
<%
	if(evaluationList.size() < 6){	
	
%>
	<a class="page-link disabled">Next</a>
<%
	}else{
%>
	<a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(courseDivide, "UTF-8")%>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8")%>&search=<%= URLEncoder.encode(search, "UTF-8")%>&pageNumber=
	<%= pageNumber + 1%>">Next</a>
<%
	}
%>
		</li>
	</ul>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">Make an Evaluate</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>Subject Code</label>
								<input type="text" name="subjectCode" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-6">
								<label>Professor Name</label>
								<input type="text" name="professorName" class="form-control" maxlength="20">							
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>Year of Course</label>
								<select name="courseYear" class="form-control">
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020" selected>2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
									<option value="2024">2024</option>
									<option value="2025">2025</option>
									<option value="2026">2026</option>
									<option value="2027">2027</option>
									<option value="2028">2028</option>
									<option value="2029">2029</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>Semester</label>
								<select name="semesterDivide" class="form-control">
									<option value="1st" selected>1st</option>
									<option value="2nd">2nd</option>
									<option value="3rd">3rd</option>
									<option value="4th">4th</option>
									<option value="5th">5th</option>
									<option value="6th">6th</option>									
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>Course Type</label>
								<select name="courseDivide" class="form-control">
									<option value="All" selected>All</option>
									<option value="Major">Major</option>
									<option value="General">General</option>							
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>Detail</label>
							<textarea name="evaluationContent" class="form-control" maxlength="750" style="height:180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>Difficulty</label>
								<select name="difficulty" class="form-control">
									<option value="Average" selected>Average</option>
									<option value="Easy">Easy</option>
									<option value="Hard">Hard</option>							
								</select>
							</div>							
							<div class="form-group col-sm-3">
								<label>Grading Level</label>
								<select name="gradingLevel" class="form-control">
									<option value="average" selected>Average</option>
									<option value="easy">Easy</option>
									<option value="tough">Tough</option>							
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>Attendance</label>
								<select name="attendance" class="form-control">
									<option value="mandatory" selected>Mandatory</option>
									<option value="nonMandatory">Non Mandatory</option>							
								</select>
							</div>														
							<div class="form-group col-sm-3">
								<label>Total</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>								
								</select>
							</div>							
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
					</form>
				
				</div>
			</div>
		</div>
	</div>
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