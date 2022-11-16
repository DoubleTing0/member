<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 세션을 초기화(리셋)
	session.invalidate();
	response.sendRedirect(request.getContextPath() + "/loginForm.jsp");

%>
