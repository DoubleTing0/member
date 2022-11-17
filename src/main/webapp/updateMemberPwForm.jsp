<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>



<%
	// 1. 요청 분석
	
	// updatePwMsg 받아오기
	String updatePwMsg = request.getParameter("updatePwMsg");
	
	
	//로그인 되어 있을때 들어올수 있음
	if(session.getAttribute("loginMemberId") == null) {
		// 세션의 loginMemberId 가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}




%>





<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 변경</title>
		
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
				<h1>비밀번호 변경</h1>
			</div>
			
			<div>&nbsp;</div>
			
			
			<!-- 오류 메세지 출력 -->
			<div class = "text-danger text-center">
				<%
					if(updatePwMsg != null) {
				%>
						<span><%=updatePwMsg %></span>
				<%
					}
				%>
			
			</div>
			
			
			
			
			
			<div>
				<form action = "<%=request.getContextPath() %>/updateMemberPwAction.jsp" method = "post">
					<div class = "row justify-content-center">
						<table class = "table table-borderless w-auto text-center">
							<tr>
								<td>현재 비밀번호</td>
								<td>
									<input type = "password" name = "memberPw">
								</td>
							</tr>
							
							<tr>
								<td>새로운 비밀번호</td>
								<td>
									<input type = "password" name = "memberNewPw">
								</td>
							</tr>
						
						</table>
					</div>
					
					<div class = "text-center">
						<button type = "submit" class = "btn btn-outline-primary rounded-5">변경</button>
					</div>
						
					
				</form>
			</div>
		
		
		</div>
		
		
	</body>
</html>