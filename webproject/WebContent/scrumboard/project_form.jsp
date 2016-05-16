<%@page import="webproject.MemberClass"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="webproject.ProjectClass"%>
<%@page import="webproject.CardClass"%>
<%@page import="webproject.BoardClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<jsp:useBean id="Beans" class="webproject.ScrumBeans"></jsp:useBean>
<%
	String pid = request.getParameter("pid");
	int pid_int = Integer.parseInt(pid);
	ProjectClass pc = Beans.getProject(pid_int);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=pc.getTitle()%> 프로젝트</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/login_form.css"
	type="text/css">
</head>
<script type="text/javascript">
function goCard(cid){
	document.location.href="card_form.jsp?cid=" + cid;
}
</script>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<div align="right">
		<form name="form1" method="post" action="logout.jsp">
			<input type="submit" class="logout" value="Log Out"> <a
				href="account_form.jsp"><br>
			<br> <input type="button" class="back" value="계정으로 돌아가기"> </a>
			<hr>
			<h3><%=pc.getTitle()%> 프로젝트 멤버</h3>
			<table>
				<tr>
				<%
					for (MemberClass mc : Beans.getMemberList()) {
						if (mc.getPid() == pid_int) {
							String uid = mc.getUid();
				%>
					<td class="td2" align="right"><%=uid%></td>
				<%}}%>
				</tr>
			</table>
		</form>
	</div>
	<center>
		<form name="form2" method="post">
			<table>
				<tr>
					<th>Stories 내용</th>
					<th>To do 내용</th>
					<th>In process 내용</th>
					<th>Testing 내용</th>
					<th>Done 내용</th>
				</tr>
				<tr>
					<td valign="top">
						<table align="center">
							<tr>
								<%
									for (CardClass cc : Beans.getCardList()) {
										if (cc.getPid() == pid_int) {
											if (cc.getBid() == 0) {
								%>
								<td><input type="button" class="card" value="<%=cc.getName()%>"
									onclick="javascript:goCard(<%=cc.getCid()%>)"></td>
							</tr>
							<% }}} %>
						</table>
					</td>
					<td valign="top">
						<table align="center">
							<%
								for (CardClass cc : Beans.getCardList()) {
									if (cc.getPid() == pid_int) {
										if (cc.getBid() == 1) {
							%>
							<tr>
								<td><input type="button" class="card" value="<%=cc.getName()%>"
									onclick="javascript:goCard(<%=cc.getCid()%>)"></td>
							</tr>
							<% }}} %>
						</table>
					</td>
					<td valign="top">
						<table align="center">
							<%
								for (CardClass cc : Beans.getCardList()) {
									if (cc.getPid() == pid_int) {
										if (cc.getBid() == 2) {
							%>
							<tr>
								<td><input type="button" class="card" value="<%=cc.getName()%>"
									onclick="javascript:goCard(<%=cc.getCid()%>)"></td>
							</tr>
							<% }}} %>
						</table>
					</td>
					<td valign="top">
						<table align="center">
							<%
								for (CardClass cc : Beans.getCardList()) {
									if (cc.getPid() == pid_int) {
										if (cc.getBid() == 3) {
							%>
							<tr>
								<td><input type="button" class="card" value="<%=cc.getName()%>"
									onclick="javascript:goCard(<%=cc.getCid()%>)"></td>
							</tr>
							<% }}} %>
						</table>
					</td>
					<td valign="top">
						<table align="center">
							<%
								for (CardClass cc : Beans.getCardList()) {
									if (cc.getPid() == pid_int) {
										if (cc.getBid() == 4) {
							%>
							<tr>
								<td><input type="button" class="card" value="<%=cc.getName()%>"
									onclick="javascript:goCard(<%=cc.getCid()%>)"></td>
							</tr>
							<% }}} %>
						</table>
					</td>
			</table>
		</form>
		<br>
		<br>
		<form name="form3" method="post" action="create_card.jsp">
			<input type="hidden" name="pid" value="<%=pid%>"> <input
				type="submit" class="submit" value="카드 추가">
		</form>
	</center>
</body>
</html>