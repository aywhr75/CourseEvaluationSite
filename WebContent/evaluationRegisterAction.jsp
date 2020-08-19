<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
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
	
	request.setCharacterEncoding("UTF-8");
	String subjectCode = null;
	String professorName = null;
	int courseYear = 0;
	String semesterDivide = null;
	String courseDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String difficulty = null;
	String gradingLevel = null;
	String attendance = null;
	

	if(request.getParameter("subjectCode") != null) {
		subjectCode = (String) request.getParameter("subjectCode");
	}

	if(request.getParameter("professorName") != null) {
		professorName = (String) request.getParameter("professorName");
	}

	if(request.getParameter("courseYear") != null) {
		try{
			courseYear = Integer.parseInt(request.getParameter("courseYear"));
		}catch(Exception e){
			System.out.println("CourseYear error occur");
		}
	}
	if(request.getParameter("semesterDivide") != null) {
		semesterDivide = (String) request.getParameter("semesterDivide");
	}
	if(request.getParameter("courseDivide") != null) {
		courseDivide = (String) request.getParameter("courseDivide");
	}
	if(request.getParameter("evaluationTitle") != null) {
		evaluationTitle = (String) request.getParameter("evaluationTitle");
	}
	if(request.getParameter("evaluationContent") != null) {
		evaluationContent = (String) request.getParameter("evaluationContent");
	}
	if(request.getParameter("totalScore") != null) {
		totalScore = (String) request.getParameter("totalScore");
	}
	if(request.getParameter("difficulty") != null) {
		difficulty = (String) request.getParameter("difficulty");
	}
	if(request.getParameter("gradingLevel") != null) {
		gradingLevel = (String) request.getParameter("gradingLevel");
	}
	if(request.getParameter("attendance") != null) {
		attendance = (String) request.getParameter("attendance");
	}	
	
	if (subjectCode == null || professorName == null || courseYear == 0 || semesterDivide == null || courseDivide == null || evaluationTitle.equals("") || 
			evaluationContent.equals("") || totalScore == null || difficulty == null || gradingLevel == null || attendance == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please fill in all blanks');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else {
		EvaluationDAO evaluationDAO = new EvaluationDAO();
		int result = evaluationDAO.write(new EvaluationDTO(0, userID, subjectCode, professorName, courseYear, semesterDivide, courseDivide, evaluationTitle,
				evaluationContent, totalScore, difficulty, gradingLevel, attendance, 0));

		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Evaluation add fail');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp';");
			script.println("</script>");
			script.close();
			return;
		}

	}

%>


