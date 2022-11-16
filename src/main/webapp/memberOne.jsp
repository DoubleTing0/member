<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//	1. 요청 분석
	
	
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
		<title>내 정보</title>
	</head>
	
	<body>
		<h1>내 정보</h1>
		
		<!-- 비밀번호를 제외한 모든 정보(컬럼) 출력 -->
		
		
		<div>
			<!-- 수정 전 비밀번호와 새로운 비밀번호 입력 받아야함  -->
			<a href = "<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호 수정</a>
			<!-- updateMemberPwAction.jsp 처리 -->
		</div>
		<div>
			<a href = "<%=request.getContextPath()%>/updateMemberForm.jsp">개인정보 수정</a>
			<!-- updateMemberAction.jsp 처리 / 비밀번호 수정은 불가능 -->
		</div>
		<div>
			<!-- 아이디 비밀번호 검증 -->
			<a href = "<%=request.getContextPath()%>/deleteMemberForm.jsp">회원 탈퇴</a>
			<!-- deleteMemberAction.jsp 처리 / 비밀번호 확인 후 삭제 -->
			<!-- 탈퇴 후 session.invaildate() -->
		</div>
	</body>
</html>