<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="webproject.CardClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<jsp:useBean id="Beans" class="webproject.ScrumBeans"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	String savePath = "C:/Users/Na Young/Desktop/workspace/webproject/WebContent/WEB-INF/upload";
	int sizeLimit = 1024 * 1024 * 10000; //10KB 제한

	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8",
			new DefaultFileRenamePolicy());

	String cid = multi.getParameter("cid");
	int cid_int = Integer.parseInt(cid);
	CardClass c = Beans.getCard(cid_int);
	String content = c.getContent();
	content = content.replaceAll("<br>", "\n");
	c.setContent(content);
%>
<title><%=c.getName()%> 수정하기</title>
</head>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login_form.css" type="text/css">
<script>
function deleteFile(cid){
	document.location.href="delFile.jsp?cid=" + cid;
}
</script>
<body>
	<center>
		<form name="form1" action="modify_upload.jsp" method="post"
			enctype="multipart/form-data">
			<input type="hidden" name="pid" value="<%=c.getPid()%>"> <input
				type="hidden" name="cid" value="<%=c.getCid()%>"> <br>
			<br>
			<table>
				<tr>
					<th>Card Name</th>
					<td><input type="text" name="name" value="<%=c.getName()%>"></td>
				</tr>
				<tr>
					<th>Content</th>
					<td><textarea name="content" cols="110" rows="10"><%=c.getContent()%></textarea></td>
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
					<td>
						<% if(c.getFile() != null){ %>
							<%=c.getFile()%>
						<input type="button" value="X"	onclick="javascript:deleteFile(<%=c.getCid()%>)">
						<%} %>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="file" name="file"></td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input type="hidden" name="action" value="modifyCard"> 
						<input type="submit" class="submit" value="확인"> 
						<input type="button" class="submit" value="취소" onclick="history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>