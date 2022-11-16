<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
									<input type = "text" name = "memberName">
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