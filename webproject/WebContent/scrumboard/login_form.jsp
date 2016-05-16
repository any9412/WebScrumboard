<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login_form.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/a_tag.css" type="text/css">
</head>
<script>
function CheckWrite() {
	var form = document.form1;
	if (form.uid.value == "") // form 에 있는 name 값이 없을 때
	{
		alert("아이디를 입력해주세요."); // 경고창 띄움
		form.name.focus(); // form 에 있는 name 위치로 이동
		return;
	}

	if (form.password.value == "") {
		alert("비밀번호를 입력해주세요.");
		form.password.focus();
		return;
	}

	form.submit();
}
</script>
<body>
	<center>
		<form name="form1" action="control.jsp" method="post">
			<input type="hidden" name="action" value="login">
			<br><br><br>
			<h1>환영합니다</h1>
			<br><br><br>
			<table>
				<tr>
					<th><font size="5">I&nbsp;D</font></th>
					<td><font size="5">
						<input type="text" name="uid" placeholder="&nbsp;&nbsp;아이디">
					</font></td>
				</tr>
				<tr>
					<th><font size="5">PW</font></th>
					<td><font size="5">
						<input type="password" name="password" placeholder="&nbsp;&nbsp;●●●●●●●●●">
					</font></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br><br>
						<input type="button" class="submit" value="로그인" onclick="javascript:CheckWrite()   ">
					</td>
				</tr>
			</table>
			<br><br>
			<a href="sign_up_form.jsp">회원가입</a>
		</form>
	</center>
</body>
</html>