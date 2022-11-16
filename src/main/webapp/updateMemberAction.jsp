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
	
	Member member = new Member();
	member.memberId = (String) (session.getAttribute("loginMemberId"));
	member.memberName = request.getParameter("memberName");

	//로그인 되어 있을 때 코드 실행
	if(member.memberId == null || member.memberId.equals("")) {
		// 세션의 loginMemberId 가 null or 공백이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}
	
	// 오류 메세지 초기화
	String updateMbMsg = null;
	
	if(member.memberName == null || member.memberName.equals("")) {
		

		// 공백이나 null 넘어올 경우 updateMbMsg 출력
		// get방식 한글 안깨지도록 인코딩
		updateMbMsg = URLEncoder.encode("모든 항목을 입력해 주세요", "UTF-8"); 
	
		// 모든 항목 중 하나라도 공백 or null 이면 updateMemberForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/updateMemberForm.jsp?updateMbMsg=" + updateMbMsg);
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
	
	
	// updateMemberSql
	String updateMbSql = "UPDATE member SET member_name = ? WHERE member_id = ?";
	
	// updateMemberSql 실행할 객체 생성
	PreparedStatement updateMbStmt = conn.prepareStatement(updateMbSql);
	
	// updateMbSql ? 대입
	updateMbStmt.setString(1, member.memberName);
	updateMbStmt.setString(2, member.memberId);
	
	
	// 쿼리 실행후 완료된 쿼리 개수 반환하는 row
	int row = updateMbStmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("내 정보 수정 완료");
	} else {
		System.out.println("내 정보 수정 실패");
	}

	// DB 종료
	updateMbStmt.close();
	conn.close();
	
	
	// 수정 후 memberOne.jsp 로 redirect
	response.sendRedirect(request.getContextPath() + "/memberOne.jsp");


%>
