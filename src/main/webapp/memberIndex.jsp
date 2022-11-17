<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<%

	// 1. 요청 분석
	if(session.getAttribute("loginMemberId") == null) {
		// 세션에 loginMemberId가 없다면
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}


%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원</title>
		
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
				<h1>회원</h1>
			</div>
		
			
			<div class = "text-end">
				
				<button type="button" class = "btn btn-outline-primary rounded-5" 
								onclick="location.href='<%=request.getContextPath() %>/memberOne.jsp' ">내 정보</button>
				<button type="button" class = "btn btn-outline-primary rounded-5" 
								onclick="location.href='<%=request.getContextPath() %>/logoutAction.jsp' ">로그아웃</button>
				
			</div>
		
			<div>&nbsp;</div>
			
			<div class = "text-center">
				<h3><%=(String) (session.getAttribute("loginMemberId")) %> 님 반갑습니다.</h3>
			</div>
		
		</div>
	</body>
</html>