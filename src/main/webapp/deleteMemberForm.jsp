<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
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