<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 완성</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login_form.css" type="text/css">
</head>
<body>
	<center>
		<br><br><br>
		<h1><%=request.getAttribute("uid") %>님의 회원가입을 축하합니다!!</h1>
		<br><br>
		<form name="form1" action="login_form.jsp">
			<input type="submit" class="submit" value="로그인 창으로 이동하기">
		</form>
	</center>
</body>
</html>