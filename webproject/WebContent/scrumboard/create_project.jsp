<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 생성하기</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/login_form.css"
	type="text/css">
</head>
<body>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트 생성하기</title>
</head>
<script type="text/javascript">
	function CheckWrite() {
		var form = document.form1;
		if (form.title.value == "") // form 에 있는 name 값이 없을 때
		{
			alert("프로젝트명을 적어주세요."); // 경고창 띄움
			form.name.focus(); // form 에 있는 name 위치로 이동
			return;
		}

		if (form.pstartdate.value == "") {
			alert("프로젝트 시작 날짜를 정해주세요.");
			form.pstartdate.focus();
			return;
		}

		if (form.penddate.value == "") {
			alert("프로젝트 종료 날짜를 정해주세요.");
			form.penddate.focus();
			return;
		}

		var sDate = form.pstartdate.value;
		var eDate = form.penddate.value;
		
		var arr1 = sDate.split('-');
	    var arr2 = eDate.split('-');
	    var dat1 = new Date(arr1[0], arr1[1], arr1[2]);
	    var dat2 = new Date(arr2[0], arr2[1], arr2[2]);
	    
	    var s = dat1.getTime();
	    var e = dat2.getTime();
		
		if (s > e) {
			alert("날짜를 다시 설정해주세요.");
			sDate = null;
			eDate = null;
			sDate.focus();
			return;
		}

		form.submit();
	}
</script>
<body>
	<center>
		<form name="form1" action="control.jsp" method="post">
			<input type="hidden" name="action" value="addProject"> <br>
			<br>
			<table cellspacing="10">
				<br>
				<br>
				<br>
				<tr>
					<th>Project Name</th>
					<td><input type="text" name="title"
						placeholder="프로젝트명을 입력하시오."></td>
				</tr>
				<tr>
					<th>Start Date</th>
					<td><input type="date" name="pstartdate"></td>
				</tr>
				<tr>
					<th>End Date</th>
					<td><input type="date" name="penddate"></td>
				</tr>
				<tr>
					<th>프로젝트 작성자</th>
					<td><%=session.getAttribute("loginID").toString()%></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><br> <input type="button"
						class="title" value="확인" onclick="javascrip:CheckWrite()">
						<input type="button" class="title" value="취소"
						onclick="javascrip:history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>
</body>
</html>