<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<%
	String pid = request.getParameter("pid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=pid%> 카드 생성하기</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login_form.css" type="text/css">
</head>
<script type="text/javascript">
function CheckWrite(){
	var form = document.form1;
	   if( form.name.value == "" )   // form 에 있는 name 값이 없을 때
	   {
	    alert( "카드명을 적어주세요" ); // 경고창 띄움
	    form.name.focus();   // form 에 있는 name 위치로 이동
	    return;
	   }
	 
	   if( form.content.value == "" )
	   {
	    alert( "내용을 적어주세요" );
	    form.content.focus();
	    return;
	   }
	   
	   form.submit();
  }

</script>
<body>
	<center>
		<form name="form1" action="upload.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="pid" value="<%=pid %>">
			<br><br>
			<table>
				<tr>
					<th>Card Name</th>
					<td><input type="text" name="name" placeholder="카드명을 입력하시오."></td>
				</tr>
				<tr>
					<th>Content</th>
					<td><textarea name="content" cols="110" rows="10" placeholder="내용을 입력하시오."></textarea></td>
				</tr>
				<tr>
					<th>Select Board</th>
					<td><select name="select_board">
							<option value="0" selected>Stories</option>
							<option value="1">To do</option>
							<option value="2">In process</option>
							<option value="3">Testing</option>
							<option value="4">Done</option>
					</select></td>
				</tr>
				<tr>
					<th>Attachment</th>
					<td><input type="file" name="file"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" class="submit" value="확인" onclick="javascript:CheckWrite()">
						<input type="submit" class="submit" value="취소" onclick="history.go(-1)">
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>