<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 1. 요청 분석
	
	// 로그인이 되어 있을 때는 접근 불가
	if(session.getAttribute("loginMemberId") != null) {
		// 로그인이 되어 있다면 memberIndex.jsp  redirect
		response.sendRedirect(request.getContextPath() + "/memberIndex.jsp");
		return;
	}

	String loginMsg = request.getParameter("loginMsg");

%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		
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
				<h1>로그인</h1>
			</div>
			
			<div>&nbsp;</div>
			
			<!-- 오류 메세지 출력 -->
			<div class = "text-danger text-center">
				<%
					if(loginMsg != null) {
				%>
						<span><%=loginMsg %></span>
				<%
					}
				%>
			
			</div>
			
			
			<div>
				<form action = "<%=request.getContextPath() %>/loginAction.jsp" method = "post">
					<div class = "row justify-content-center">
						<table class = "table table-borderless w-auto text-center">
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
							
						</table>
					
					
					</div>
					
					<div>&nbsp;</div>
				
					<div class = "text-center">
						<button type = "submit" class = "btn btn-outline-primary rounded-5">로그인</button>
						
						<button type="button" class = "btn btn-outline-primary rounded-5" 
								onclick="location.href='<%=request.getContextPath() %>/insertMemberForm.jsp' ">회원가입</button>
						<!-- insertMemberForm.jsp, insertMemberAction.jsp redirect loginForm.jsp -->
						
					</div>
				
				
				</form>
				
			</div>
			
			
		
			
			
			
			
			
		</div>
		
		
		
	</body>
</html>