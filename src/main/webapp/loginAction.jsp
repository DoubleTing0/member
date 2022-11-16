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
	
	// 에러메세지 loginMsg
	String loginMsg = URLEncoder.encode("아이디와 비밀번호가 올바르지 않습니다.", "UTF-8"); 


	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null 
		|| request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")) {
		
		// 아이디와 패스워드가 공백 or null 이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?loginMsg=" + loginMsg);
		return;
	}


	// Member 객체 생성 및 저장
	Member member = new Member();
	member.memberId = request.getParameter("memberId");
	member.memberPw = request.getParameter("memberPw");
	
	
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
	
	
	// sql
	String sql = "SELECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	
	// sql 실행할 객체 생성
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// sql ? 대입
	stmt.setString(1, member.memberId);
	stmt.setString(2, member.memberPw);
	
	ResultSet rs = stmt.executeQuery();
	
	
	String targetPage = "/loginForm.jsp?loginMsg=" + loginMsg;
	
	if(rs.next()) {
		
		//로그인 성공
		targetPage = "/memberIndex.jsp";

		session.setAttribute("loginMemberId", rs.getString("memberId"));
		// Object loginMemberId = rs.getString("memberId") // Object 타입 다형성
		// String loginMemberId = (string) (session.getAttribute("loginMemberId"))
		
	}
		rs.close();
		stmt.close();
		conn.close();
		response.sendRedirect(request.getContextPath() + targetPage);
		
	
	
	
	


%>
