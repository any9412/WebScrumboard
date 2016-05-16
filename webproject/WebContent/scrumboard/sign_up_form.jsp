<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<jsp:useBean id="user" class="webproject.UserClass"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/login_form.css"
	type="text/css">
</head>
<script>
	
<%request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");%>
	function CheckID() {
		document.location.href = "control.jsp?action=checkID&uid="
				+ document.form1.uid.value; //DB에 id가 있는지만 확인하면 되므로
	}

	function CheckLength() {
		var form = document.form1;
		if (form.password.value.length < 8) {
			pwd = alert("비밀번호의 길이는 8자리 이상이어야 합니다. 다시 작성하세요.");
			form.password.value = "";
			form.pw_check.value = "";
			return;
		}

		if (form.password.value != form.pw_check.value) {
			pwd = alert("비밀번호가 일치하지 않습니다. 다시 압력하세요.");
			form.pw_check.value = null;
			form.pw_check.focus();
			return;
		}

		form.submit();
	}

	function CheckWrite() {
		var form = document.form1;
		if (form.uid.value == "") // form 에 있는 name 값이 없을 때
		{
			alert("아이디를 입력해주세요."); // 경고창 띄움
			form.name.focus(); // form 에 있는 name 위치로 이동
			return;
		}
		if (form.name.value == "") // form 에 있는 name 값이 없을 때
		{
			alert("이름을 입력해주세요."); // 경고창 띄움
			form.name.focus(); // form 에 있는 name 위치로 이동
			return;
		}

		if (form.password.value == "") {
			alert("비밀번호를 입력해주세요.");
			form.password.focus();
			return;
		}
		
		if (form.pw_check.value == "") {
			alert("비밀번호를 재입력해주세요.");
			form.pw_check.focus();
			return;
		}

		CheckLength();
	}
</script>
<%
	String check = "TRUE";
%>
<body>
	<center>
		<form name="form1" action="control.jsp" method="post">
			<input type="hidden" name="action" value="register"> <br>
			<br>
			<br>
			<h1>회원가입해쥬</h1>
			<br>
			<br>
			<br>
			<table>
				<tr>
					<th><font size="3">아&nbsp;&nbsp;이&nbsp;&nbsp;디</font></th>
					<td><font size="4"> <input type="text" name="uid"
							placeholder="&nbsp;&nbsp;아이디">
					</font></td>
					<td><input type="button" class="overlap" value="중복확인"
						onclick="javascript:CheckID()"></td>
				</tr>
				<tr>
					<th><font size="3">이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</font></th>
					<td><font size="4"> <input type="text" name="name"
							placeholder="&nbsp;&nbsp;이름">
					</font></td>
				</tr>
				<tr>
					<th><font size="3">비밀&nbsp;번호</font></th>
					<td><font size="4"> <input type="password"
							name="password" placeholder="&nbsp;&nbsp;비밀번호는 8자리 이상">
					</font></td>
				</tr>
				<tr>
					<th><font size="3">비밀번호 재입력</font></th>
					<td><font size="4"> <input type="password"
							name="pw_check" placeholder="&nbsp;&nbsp;●●●●●●●●●">
					</font></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><br>
					<br> <input type="hidden" name="Is_Checked"
						value="<%=check%>"> <input type="button" class="button"
						value="확인" onclick="javascript:CheckWrite()">
						<input type="button" class="button"
						value="취소" onclick="javascript:history.go(-1)">
						</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>