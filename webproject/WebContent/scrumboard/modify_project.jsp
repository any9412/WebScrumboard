<%@page import="webproject.MemberClass"%>
<%@page import="webproject.ProjectClass"%>
<%@page import="webproject.UserClass"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<jsp:useBean id="Beans" class="webproject.ScrumBeans"></jsp:useBean>
<jsp:useBean id="user" class="webproject.UserClass"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	int pid = Integer.parseInt(request.getParameter("pid"));
	ProjectClass p = Beans.getProject(pid);
%>
<title><%=p.getTitle()%> 수정하기</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login_form.css" type="text/css">
</head>
<script type="text/javascript">
function search(pid) {
	document.location.href="control.jsp?action=searchMemID&pid=" + pid + "&smi="+document.form1.search_mem_id.value;
}

function CheckDate(){
	var form = document.form1;
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
		sDate.focus();
		return;
	}
	
	form.submit();
}

</script>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<center>
		<form name="form1" action="control.jsp" method="post">
			<br> <br>
			<table>
				<tr>
					<th>Project Name</th>
					<td><input type="text" name="title" value="<%=p.getTitle()%>"></td>
				</tr>
				<tr>
					<th>Member</th>
					<td><input type="text" name="search_mem_id"
						placeholder="멤버ID를 검색하세요."> <input type="button"
						class="addmember" value="멤버 추가" onclick="search(<%=p.getPid()%>)"></td>
				</tr>
				<tr>
					<td colspan="3" align="center"><select name="member">
							<%
								ArrayList<String> list = (ArrayList<String>) session.getAttribute("memberlist");
								if (list != null) {
									for (String member : list) {
							%>
							<option>
								<%=member%>
							</option>
							<%
								}
								}
							%>
					</select></td>
				</tr>
				<tr>
					<th>Start Date</th>
					<td><input type="date" name="pstartdate"
						value="<%=p.getPstartdate()%>"></td>
				</tr>
				<tr>
					<th>End Date</th>
					<td><input type="date" name="penddate"
						value="<%=p.getPenddate()%>"></td>
					<!-- 값이 안 넘어옴 -->
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="hidden" name="pid"
						value="<%=p.getPid()%>"> <input type="hidden"
						name="action" value="modifyProject"> 
						<br>
						<input type="button" class="submit" value="확인" onclick="javascript:CheckDate()"> 
						<input type="button" class="submit" value="취소" onclick="javascript:history.go(-1)"></td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>