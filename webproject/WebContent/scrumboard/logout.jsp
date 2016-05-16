<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>logout</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		alert("로그아웃 되었습니다.");
		location.href = "login_form.jsp"
	</script>
</body>
</html>