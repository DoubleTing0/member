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
		<title></title>
	</head>
	
	<body>
		<div>
			<div>
				<span><%=(String) (session.getAttribute("loginMemberId")) %> 님 반갑습니다.</span>
				<a href = "<%=request.getContextPath() %>/memberOne.jsp">내 정보</a>
				<a href = "<%=request.getContextPath() %>/logout.jsp">로그아웃</a>
			</div>
		
			<div>
				<h1>멤버 페이지 입니다.</h1>
			</div>
		
		</div>
	</body>
</html>