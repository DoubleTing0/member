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


	//1. 요청 분석

	// updatePwMsg 받아오기
	String updateMbMsg = request.getParameter("updateMbMsg");
	
	
	//로그인 되어 있을때 들어올수 있음
	if(session.getAttribute("loginMemberId") == null || session.getAttribute("loginMemberId").equals("")) {
		// 세션의 loginMemberId 가 null or 공백이면 loginForm.jsp redirect
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
	String memberSql = "SELECT member_name memberName FROM member WHERE member_id = ?";
	
	// memberSql 실행할 객체 생성
	PreparedStatement memberStmt = conn.prepareStatement(memberSql);
	
	// 디버깅 코드
	System.out.println((String) (session.getAttribute("loginMemberId")) + " <-- sessionId");
	
	// memberSql ? 대입
	memberStmt.setString(1, (String) (session.getAttribute("loginMemberId")));
	
	
	// ResultSet 에 저장
	ResultSet memberRs = memberStmt.executeQuery();
	
	// 보편적인 사용을 위해 String 타입 변환
	
	String memberName = null;
	if(memberRs.next()) {
		
		memberName = memberRs.getString("memberName");
	}
	
	// 디버깅 코드
	System.out.println(memberName + " <--memberName");

%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내 정보 수정</title>
	</head>
	
	<body>
		<div>
			<div>
				<h1>내 정보 수정</h1>
			</div>
		
		
			
			<!-- 오류 메세지 출력 -->
			<div>
				<%
					if(updateMbMsg != null) {
				%>
						<span><%=updateMbMsg %></span>
				<%
					}
				%>
			
			</div>
		
		
			<div>
				<form action = "<%=request.getContextPath() %>/updateMemberAction.jsp">
					<div>
						<table border = "1">
							<tr>
								<td>이름</td>
								<td>
									<input type = "text" name = "memberName" value = "<%=memberName%>">
								</td>
							</tr>
									
						</table>
					
					
					</div>
					
					<div>
						<button type = "submit">수정</button>
					</div>
				
				</form>
			
			</div>
		
		
		
		</div>	
	</body>
</html>