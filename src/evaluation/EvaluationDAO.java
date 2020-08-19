package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;


public class EvaluationDAO {

	public int write(EvaluationDTO evaluationDTO) {
		String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0);";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {			
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, evaluationDTO.getSubjectCode().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, evaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, evaluationDTO.getCourseYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, evaluationDTO.getCourseDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));			
			pstmt.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));			
			pstmt.setString(10, evaluationDTO.getDifficulty().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, evaluationDTO.getGradingLevel().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, evaluationDTO.getAttendance().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));

			return pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -1;

	}
	
	public ArrayList<EvaluationDTO> getList(String courseDivide, String searchType, String search, int pageNumber) {
		if(courseDivide.equals("All")) {
			courseDivide = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("Latest")) {
				SQL = "SELECT * FROM EVALUATION WHERE courseDivide LIKE ? AND CONCAT(subjectCode, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} else if(searchType.equals("Recommendation")) {
				SQL = "SELECT * FROM EVALUATION WHERE courseDivide LIKE ? AND CONCAT(subjectCode, professorName, evaluationTitle, evaluationContent) LIKE ? ORDER BY likeCount DESC LIMIT " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn = DatabaseUtil.getConnection(); // data base connect
			pstmt = conn.prepareStatement(SQL);  
			pstmt.setString(1, "%" + courseDivide + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)						
						);
						evaluationList.add(evaluation);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return evaluationList;
	}
}
