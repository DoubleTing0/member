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
	
	String memberNewPw = request.getParameter("memberNewPw");
	
	
	//로그인 되어 있을 때 코드 실행
	if(member.memberId == null || member.memberId.equals("")) {
		// 세션의 loginMemberId 가 null or 공백이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}
	
	// 디버깅 코드
	System.out.println(member.memberId + " <--member.memberId");
	
	
	
	// 오류 메세지 초기화
	String updatePwMsg = null;
	
	if(member.memberPw == null || memberNewPw == null || member.memberPw.equals("") || memberNewPw.equals("")) {
		
		// 공백이나 null 넘어올 경우 updatePwMsg 출력
		// get방식 한글 안깨지도록 인코딩
		updatePwMsg = URLEncoder.encode("모든 항목을 입력해 주세요", "UTF-8"); 
	
		// 현재 비밀번호와 새로운 비밀번호가 공백 or null 이면 updateMemberPwForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/updateMemberPwForm.jsp?updatePwMsg=" + updatePwMsg);
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

	
	// 현재 비밀번호가 틀리거나 / 새로운 비밀번호가 현재 비밀번호랑 같으면 변경 X
	
	// memberPwSql
	// SELECT member_id memberId, member_pw memberPw FROM member 
	// WHERE member_id =? AND member_pw = PASSWORD(?) AND member_pw != PASSWORD(?)";
	String memberPwSql = "SELECT member_id memberId, member_pw memberPw FROM member WHERE member_id =? AND member_pw = PASSWORD(?) AND member_pw != PASSWORD(?)";
	
	// memberPwSql 실행할 객체 생성
	PreparedStatement memberPwStmt = conn.prepareStatement(memberPwSql);
	
	// ? 대입
	memberPwStmt.setString(1, member.memberId);
	memberPwStmt.setString(2, member.memberPw);
	memberPwStmt.setString(3, memberNewPw);
	
	// ResultSet 에 저장
	ResultSet memberPwRs = memberPwStmt.executeQuery();
	if(!(memberPwRs.next())) {
		
		// 현재 비밀번호가 틀릴경우 updatePwMsg 출력
		// get방식 한글 안깨지도록 인코딩
		updatePwMsg = URLEncoder.encode("현재 비밀번호와 새로운 비밀번호가 올바르지 않습니다.", "UTF-8"); 
	
		// updateMemberPwForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/updateMemberPwForm.jsp?updatePwMsg=" + updatePwMsg);
		
		// DB 종료
		memberPwRs.close();
		memberPwStmt.close();
		conn.close();
		
		return;
		
		
	} 
	
	// 디버깅 코드
	System.out.println(memberPwRs.getString("memberPw") + " <-- mPR(memberPw)");
	

	
	// 비밀번호 변경 되는 경우
	
	// updatePwSql
	String updatePwSql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ? AND member_pw = PASSWORD(?)";
	
	// updatePwSql 실행할 객체 생성
	PreparedStatement updatePwStmt = conn.prepareStatement(updatePwSql);
	
	// updatePwSql ? 대입
	updatePwStmt.setString(1, memberNewPw);
	updatePwStmt.setString(2, member.memberId);
	updatePwStmt.setString(3, member.memberPw);
	
	// 쿼리 실행 후 완료 된 쿼리 개수 반환하는 row
	int row = updatePwStmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("비밀번호 변경 완료");
	} else {
		System.out.println("비밀번호 변경 완료");
		
	}
	
	// DB 종료
	memberPwRs.close();
	memberPwStmt.close();
	updatePwStmt.close();
	conn.close();

	
	// 비밀번호 변경 후 새로운 비밀번호로 로그인
	
	// 세션 초기화
	session.invalidate();
	
	// loginForm.jsp  redirect
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	
	
%>
