<%@page import="webproject.CardClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<jsp:useBean id="Beans" class="webproject.ScrumBeans"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String cid = request.getParameter("cid");
	int cid_int = Integer.parseInt(cid);
	CardClass cc = Beans.getCard(cid_int);
%>
<title><%=cc.getName() %></title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login_form.css" type="text/css">
</head>
<script type="text/javascript">
function onDownload(file){
	document.location.href = "download.jsp?file=" + file;
}
function deleteCard(cid){
	document.location.href = "control.jsp?action=deleteCard&cid=" + cid
}
</script>
<body>
<center>
		<form name="form1" action="modify_card.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="cid" value="<%=cid %>">
			<br><br><br><br><br><br><br><br>
			<table cellspacing="20">
				<tr>
					<th>Card Name</th>
					<td><%=cc.getName() %></td>
				</tr>
				<tr>
					<th>Content</th>
					<td>
					<%=cc.getContent() %></td>
				</tr>
				<tr>
					<th>Attachment</th>
					<td>
					<% if(cc.getFile() != null){%>
						<%=cc.getFile() %>&nbsp;<input type="button" value="다운로드" onclick="javascript:onDownload('<%=cc.getFile() %>')">
					<%} %></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br><br><br>
						<input type="submit" class="submit" value="수정하기">
						<input type="button" class="submit" value="보드로 돌아가기" onclick="history.go(-1)">
						<input type="button" class="submit" value="삭제하기" onclick="javascript:deleteCard(<%=cid%>)">
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>