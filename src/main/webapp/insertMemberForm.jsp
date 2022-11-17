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
				<h1>회원가입</h1>
			</div>
		
			<div>&nbsp;</div>
			
			<div class = "text-danger text-center">
				<!-- 모든 항목 입력하지 않았을 때 => insertMsg != null -->
				<%
					if(insertMsg != null) {
				%>
						<span><%=insertMsg %></span>
				<%
					}
				%>
				
				<!-- 아이디가 중복 되었을 때 => idMsg != null -->
				<%
					if(idMsg != null) {
				%>
						<span><%=idMsg %></span>
				<%
					}
				%>
			</div>
		
			<div>
				<form action = "<%=request.getContextPath()%>/insertMemberAction.jsp" method = "post">
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
				
					<div class = "text-center">
						<button type = "submit" class = "btn btn-outline-primary rounded-5">완료</button>
					</div>
				
				</form>
			</div>
		
		
		</div>
	</body>
</html>