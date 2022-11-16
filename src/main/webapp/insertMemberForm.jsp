<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%
	// 1. 요청 분석
	
	// 모든 항목을 입력하지 않았을 때 insertMsg 받아오기
	String insertMsg = request.getParameter("insertMsg");
	String idMsg = request.getParameter("idMsg");


%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 가입</title>
	</head>
	
	<body>
		<div>
		
			<div>
				<h1>회원가입</h1>
			</div>
		
		
			<!-- 모든 항목 입력하지 않았을 때 => insertMsg != null -->
			<%
				if(insertMsg != null) {
			%>
					<div style = "color : red;">
						<span><%=insertMsg %></span>
					</div>
			<%
				}
			%>
			
			<!-- 아이디가 중복 되었을 때 => idMsg != null -->
			<%
				if(idMsg != null) {
			%>
					<div style = "color : red;">
						<span><%=idMsg %></span>
					</div>
			<%
				}
			%>
		
			<div>
				<form action = "<%=request.getContextPath()%>/insertMemberAction.jsp" method = "post">
					<div>
						<table>
							<tr>
								<td>
									<label for = "memberId">회원 아이디</label>
								</td>
								<td>
									<input type = "text" name = "memberId" id = "memberId">
								</td>
							</tr>
							
							<tr>
								<td>
									<label for = "memberPw">회원 패스워드</label>
								</td>
								<td>
									<input type = "password" name = "memberPw" id = "memberPw">
								</td>
							</tr>
							
							<tr>
								<td>
									<label for = "memberName">회원 이름</label>
								</td>
								<td>
									<input type = "text" name = "memberName" id = "memberName">
								</td>
							</tr>
						</table>
						
					</div>
				
					<div>
						<button type = "submit">완료</button>
					</div>
				
				</form>
			</div>
		
		
		</div>
	</body>
</html>