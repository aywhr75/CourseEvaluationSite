package evaluation;

public class EvaluationDTO {
	int evaluationID;
	String userID;
	String subjectCode;
	String professorName;
	int courseYear;
	String semesterDivide;
	String courseDivide;
	String evaluationTitle;
	String evaluationContent;
	String totalScore;
	String difficulty;
	String gradingLevel;
	String attendance;
	int likeCount;
	
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getSubjectCode() {
		return subjectCode;
	}
	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public int getCourseYear() {
		return courseYear;
	}
	public void setCourseYear(int courseYear) {
		this.courseYear = courseYear;
	}
	public String getSemesterDivide() {
		return semesterDivide;
	}
	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}
	public String getCourseDivide() {
		return courseDivide;
	}
	public void setCourseDivide(String courseDivide) {
		this.courseDivide = courseDivide;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getDifficulty() {
		return difficulty;
	}
	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}
	public String getGradingLevel() {
		return gradingLevel;
	}
	public void setGradingLevel(String gradingLevel) {
		this.gradingLevel = gradingLevel;
	}
	public String getAttendance() {
		return attendance;
	}
	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public EvaluationDTO(int evaluationID, String userID, String subjectCode, String professorName, int courseYear,
			String semesterDivide, String courseDivide, String evaluationTitle, String evaluationContent,
			String totalScore, String difficulty, String gradingLevel, String attendance, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.subjectCode = subjectCode;
		this.professorName = professorName;
		this.courseYear = courseYear;
		this.semesterDivide = semesterDivide;
		this.courseDivide = courseDivide;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.totalScore = totalScore;
		this.difficulty = difficulty;
		this.gradingLevel = gradingLevel;
		this.attendance = attendance;
		this.likeCount = likeCount;
	}
	
}
