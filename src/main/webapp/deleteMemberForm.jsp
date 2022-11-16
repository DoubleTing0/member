<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%

	// 1. 요청 분석
	// 오류 메세지 받아오기
	String deleteMbMsg = request.getParameter("deleteMbMsg");


	//로그인 되어 있을때 들어올수 있음
	if(session.getAttribute("loginMemberId") == null || session.getAttribute("loginMemberId").equals("")) {
		
		// 세션의 loginMemberId 가 null or 공백이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}


%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 탈퇴</title>
	</head>
	
	<body>
		<div>
			
			<div>
				<h1>회원 탈퇴</h1>			
			</div>
		
			<!-- 오류 메세지 출력 -->
			<div>
				<%
					if(deleteMbMsg != null) {
				%>
						<span><%=deleteMbMsg %></span>
				<%
					}
				%>
			
			</div>
			
			<div>
				<form action = "<%=request.getContextPath() %>/deleteMemberAction.jsp">
					<div>
						<table>
							<tr>
								<td>비밀번호 :</td>
								<td>
									<input type = "password" name = "memberPw">
								</td>
							</tr>
						
						</table>
					
					</div>
				
					<div>
						<button type = "submit">탈퇴</button>
					</div>
				
				</form>
			
			</div>
		
		
		</div>
	</body>
</html>