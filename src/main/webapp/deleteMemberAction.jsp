<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>



<%
	// 1. 요청 분석
	
	// Member 객체 생성
	Member member = new Member();
	member.memberId = (String) (session.getAttribute("loginMemberId"));
	member.memberPw = request.getParameter("memberPw");



	// 세션의 loginMemberId 가 null 이거나 공백이면 loginForm.jsp redirect
	if(member.memberId == null || member.memberId.equals("")) {
		
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}


	// 오류 메세지(공백이거나 틀릴 때)
	String deleteMbMsg = URLEncoder.encode("비밀번호가 올바르지 않습니다.", "UTF-8");
	
	if(member.memberPw == null || member.memberPw.equals("")) {
		
		// 공백이나 null 넘어올 경우 deleteMbMsg 출력
		// get방식 한글 안깨지도록 인코딩
		// 현재 비밀번호와 새로운 비밀번호가 공백 or null 이면 updateMemberPwForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/deleteMemberForm.jsp?deleteMbMsg=" + deleteMbMsg);
		return;
		
	}


	// 2. 요청 처리
	
	
	// DB 접속 준비
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://localhost:3306/gdj58";
	String dbUser = "root";
	String dbPw = "java1234";
	
	// 드라이버 로딩
	Class.forName(driver);
	
	// DB 접속
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	
	
	// deleteSql
	String deleteSql = "DELETE From member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	
	// deleteSql 실행할 객체 생성
	PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
	
	// dlelteSql ? 대입
	deleteStmt.setString(1, member.memberId);
	deleteStmt.setString(2, member.memberPw);
	
	// 쿼리 실행 후 완료한 개수 반환하는 row
	int row = deleteStmt.executeUpdate();
	
	// DB 종료
	deleteStmt.close();
	conn.close();
	
	if(row == 1) {
		System.out.println("회원 탈퇴 완료");
		
		
		// 세션 초기화
		session.invalidate();
		
		// loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		
	} else {
		System.out.println("회원 탈퇴 실패");
		
		// deleteMbMsg 보내면서 deleteMemberForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/deleteMemberForm.jsp?deleteMbMsg=" + deleteMbMsg);
		
	}
	
	


%>


