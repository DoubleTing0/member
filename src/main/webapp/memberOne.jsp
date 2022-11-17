<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%
	//	1. 요청 분석
	
	
	//로그인 되어 있을때 들어올수 있음
	if(session.getAttribute("loginMemberId") == null) {
		// 세션의 loginMemberId 가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
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


	// memberSql
	String memberSql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ?";
	
	// memberSql 실행할 객체 생성
	PreparedStatement memberStmt = conn.prepareStatement(memberSql);
	
	// 디버깅 코드
	System.out.println((String) (session.getAttribute("loginMemberId")) + " <-- sessionId");
	
	// memberSql ? 대입
	memberStmt.setString(1, (String) (session.getAttribute("loginMemberId")));
	
	
	// ResultSet 에 저장
	ResultSet memberRs = memberStmt.executeQuery();
	
	// Member 객체 초기화
	Member member = null;
	if(memberRs.next()) {
		// Member 객체 생성
		member = new Member();
		
		member.memberId = memberRs.getString("memberId");
		member.memberName = memberRs.getString("memberName");
		
	}











%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내 정보</title>
		
		<!-- Bootstrap5를 참조한다 시작-->
		
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- Bootstrap5를 참조한다 끝-->
		
	</head>
	
	<body>
		<div class = "container">
			<div class = "text-center">
				<h1>내 정보</h1>
			</div>
			
			<!-- 비밀번호를 제외한 모든 정보(컬럼) 출력 -->
			
			<div class = "text-end">
				<!-- 수정 전 비밀번호와 새로운 비밀번호 입력 받아야함  -->
				<button type="button" class = "btn btn-outline-primary rounded-5" 
								onclick="location.href='<%=request.getContextPath() %>/updateMemberPwForm.jsp' ">비밀번호 수정</button>
				<!-- updateMemberPwAction.jsp 처리 -->
			
				<button type="button" class = "btn btn-outline-primary rounded-5" 
								onclick="location.href='<%=request.getContextPath() %>/updateMemberForm.jsp' ">개인정보 수정</button>
				<!-- updateMemberAction.jsp 처리 / 비밀번호 수정은 불가능 -->
			
				<!-- 아이디 비밀번호 검증 -->
				<button type="button" class = "btn btn-outline-primary rounded-5" 
								onclick="location.href='<%=request.getContextPath() %>/deleteMemberForm.jsp' ">회원 탈퇴</button>
				<!-- deleteMemberAction.jsp 처리 / 비밀번호 확인 후 삭제 -->
				<!-- 탈퇴 후 session.invaildate() -->
			</div>	
			
			
			
			
			
			
			<div class = "row justify-content-center">
				<table class = "table table-borderless w-auto text-center">
					<tr>
						<th>아이디</th>
						<td><%=member.memberId %></td>
						
					</tr>
					
					<tr>
						<th>이름</th>
						<td><%=member.memberName %></td>
					</tr>
						
				</table>
			
			</div>
			
			
		</div>
	</body>
</html>