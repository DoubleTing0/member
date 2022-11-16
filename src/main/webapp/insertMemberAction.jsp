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
	
	// 회원정보를 담을 Member 객체 생성
	Member member = new Member();

	member.memberId = request.getParameter("memberId");
	member.memberPw = request.getParameter("memberPw");
	member.memberName = request.getParameter("memberName");

	if(member.memberId == null || member.memberPw == null || member.memberName == null 
			|| member.memberId.equals("") || member.memberPw.equals("") || member.memberName.equals("")) {
		
		// 공백이나 null 넘어올 경우 insertMsg 출력
		// get방식 한글 안깨지도록 인코딩
		String insertMsg = URLEncoder.encode("모든 항목을 입력해 주세요", "UTF-8"); 
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?insertMsg=" + insertMsg);
		
		
		
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
	
	// 아이디 중복 확인
	String idSql = "SELECT member_id FROM member WHERE member_id = ?";
	
	// idSql 실행할 객체 생성
	PreparedStatement idStmt = conn.prepareStatement(idSql);
	
	// idSql ? 대입
	idStmt.setString(1, member.memberId);
	
	// ResultSet 에 저장
	ResultSet idRs = idStmt.executeQuery();
	
	if(idRs.next()) {
		
		// idRs.next() 참이면 아이디가 중복, idMsg 출력
		// get방식 한글 안깨지도록 인코딩
		String idMsg = URLEncoder.encode("아이디가 중복되었습니다.", "UTF-8"); 
		response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?idMsg=" + idMsg);
		
		// DB 종료
		idStmt.close();
		conn.close();
		
		return;
		
		
	}
	
	
	
	
	
	
	// 회원가입 sql
	String insertSql = "INSERT INTO member (member_id, member_pw, member_name) VALUES (?, PASSWORD(?), ?)";
	
	// insertSql 실행할 객체 생성
	PreparedStatement insertStmt = conn.prepareStatement(insertSql);
	
	// insertSql 중 ? 대입
	insertStmt.setString(1, member.memberId);
	insertStmt.setString(2, member.memberPw);
	insertStmt.setString(3, member.memberName);
	
	// 쿼리 실행 후 완료된 쿼리문 개수 반환하는 row
	int row = insertStmt.executeUpdate();
	
	// row를 통해 실패여부 확인
	if(row == 1) {
		System.out.println("회원 가입 완료");
		
		// 회원가입 완료 후 loginForm.jsp Redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		
	} else {
		System.out.println("회원 가입 실패");
	}
	
	// DB 종료
	insertStmt.close();
	conn.close();

%>
