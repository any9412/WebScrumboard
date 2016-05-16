<%@page import="webproject.MemberClass"%>
<%@page import="webproject.ProjectClass"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<jsp:useBean id="pnames" scope="request" class="java.util.ArrayList"></jsp:useBean>
<jsp:useBean id="Beans" class="webproject.ScrumBeans"></jsp:useBean>
<jsp:useBean id="project" class="webproject.ProjectClass"></jsp:useBean>
<jsp:useBean id="mids" class="webproject.MemberClass"></jsp:useBean>
<%
   Calendar now = Calendar.getInstance();
   int year = now.get(Calendar.YEAR);
   int month = now.get(Calendar.MONTH) + 1;
   String _year = request.getParameter("year");
   String _month = request.getParameter("month");
   if (_year != null)
      year = Integer.parseInt(_year);
   if (_month != null)
      month = Integer.parseInt(_month);
   now.set(year, month - 1, 1); //출력할년도, 월로 설정 
   year = now.get(Calendar.YEAR); //변화된 년, 월
   month = now.get(Calendar.MONTH) + 1;

   int end = now.getActualMaximum(Calendar.DAY_OF_MONTH); //해당월의 마지막 날짜 
   int w = now.get(Calendar.DAY_OF_WEEK);//1~7(일~토)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=session.getAttribute("loginID") %> 님의 계정
</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/login_form.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/account_form.css" type="text/css">
</head>
<script>
function modProject(pid){
	document.location.href = "modify_project.jsp?pid=" + pid;
}
function delProject(pid){
	result = confirm("정말로 삭제하시겠습니까?");
	
	if(result)
		document.location.href = "control.jsp?action=deleteProject&pid=" + pid;
}
</script>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	session.removeAttribute("memberlist");
%>
   <div align="right">
      <form name="form1" method="post" action="logout.jsp">
         <input type="submit" class="logout" value="Log Out">
      </form>
   </div>
   <center>
      <br>
      <br>
      <h1>프로젝트 달력</h1>
      <br>
      <table width="840" border="0" cellpadding="1" cellspacing="2">
         <tr height="120">
            <td align="center"><a
               href="account_form.jsp?year=<%=year%>&month=<%=month - 1%>">◀</a> <b><%=year%>年
                  <%=month%>月</b> <a
               href="account_form.jsp?year=<%=year%>&month=<%=month + 1%>">▶</a></td>
         </tr>
      </table>
      <table width="80%" border="0" cellpadding="2" cellspacing="1"
         bgcolor="#cccccc">
         <tr height="80%">
            <td align="center" bgcolor="#e6e4e6" width="10%"><font color="red">일</font></td>
            <td align="center" bgcolor="#e6e4e6" width="10%">월</td>
            <td align="center" bgcolor="#e6e4e6" width="10%">화</td>
            <td align="center" bgcolor="#e6e4e6" width="10%">수</td>
            <td align="center" bgcolor="#e6e4e6" width="10%">목</td>
            <td align="center" bgcolor="#e6e4e6" width="10%">금</td>
            <td align="center" bgcolor="#e6e4e6" width="10%"><font color="blue">토</font></td>
         </tr>
         <%
            int newLine = 0;
            //1일이 어느 요일에서 시작하느냐에 따른 빈칸 삽입
            out.println("<tr height='100'>");
            for (int i = 1; i < w; i++) {
               out.println("<td bgcolor='#ffffff'>&nbsp;</td>");
               newLine++;
            }

            String fc, bg;
            for (int i = 1; i <= end; i++) {
               fc = (newLine == 0) ? "red" : (newLine == 6 ? "blue" : "#000000");
               bg = "#ffffff";
               out.println("<td align='center' bgcolor=" + bg + "><font color=" + fc + ">" + i + "<br>");
               // 여기에 해당 계정의 프로젝트를 출력하는 코드 추가...
               for(ProjectClass pc : Beans.getProjectList())
               {
            	   for(MemberClass mc : Beans.getMemberList())
            	   {
            		   if(session.getAttribute("loginID").equals(mc.getUid()))
            		   {
            			   // year, month, i
            			   // 해당 사용자가 참여중인 프로젝트의 아이디를 가져옴
            			   int pid = mc.getPid();
            			   if(pid == pc.getPid())
            			   {
            			   	Date Sdate = new Date();
            			   	Sdate = pc.getPstartdate();
            			   
            			   	Date Edate = new Date();
            			   	Edate = pc.getPenddate();
            			   
            			   	String dstr = String.valueOf(year) + "-" + String.valueOf(month) + "-" + String.valueOf(i);
            			   	SimpleDateFormat trans = new SimpleDateFormat("yyyy-MM-dd");
            			   	Date dday = trans.parse(dstr);
            			   
            			   	String Pname = pc.getTitle();
            			   
            			   	if((dday.after(Sdate)||dday.compareTo(Sdate)==0)&&(dday.before(Edate)||dday.compareTo(Edate)==0))
            			   	{
            				   out.println("<font size=3 color='#000000'>" + Pname + "</font><br>");
            				   break;
            			   	}
            			   }
            		   }
            	   }
               }
               // 추가 종료...
               out.println("</font></td>");
               newLine++;
               if (newLine == 7 && i != end) {
                  out.println("</tr>");
                  out.println("<tr height='100'>");
                  newLine = 0;
               }
            }

            while (newLine > 0 && newLine < 7) {
               out.println("<td bgcolor='ffffff'>&nbsp;</td>");
               newLine++;
            }
            out.println("</tr>");
         %>
      </table>
      <!-- Calendar end -->

      <hr>
      <form name="form2" method="post" action="control.jsp">
         <input type="hidden" name="action" value="project">
         <table>
            <tr>
	            <%
	               for(ProjectClass pc : Beans.getProjectList()){
	                  for(MemberClass mc : Beans.getMemberList()){
	                     if(session.getAttribute("loginID").equals(mc.getUid())){
	                     	if(pc.getPid() == mc.getPid()){
	            %>
	               	<td>
	               		<input type="submit" class="titleA" value="<%=pc.getTitle() %>">
	               		<input type="hidden" name="pid" value="<%=pc.getPid() %>">
	            <%}}%>
	            	</td>
	            <%}}%>
            </tr>
            <tr>
	            <%
	               for(ProjectClass pc : Beans.getProjectList()){
	                  for(MemberClass mc : Beans.getMemberList()){
	                     if(session.getAttribute("loginID").equals(mc.getUid())){
	                     	if(pc.getPid() == mc.getPid()){
	            %>
	            	<td align="right">
	            		<input type="button" class="delete" value="수정" onclick="javascript:modProject(<%=pc.getPid() %>)">
	            		<% if(session.getAttribute("loginID").equals(pc.getUid())){	 %>           		
	            		<input type="button" class="delete" value="삭제" onclick="javascript:delProject(<%=pc.getPid() %>)">
	           			<%} else{ %>
	           			<input type="button" class="delete" value="나가기" onclick="javascript:delProject(<%=pc.getPid() %>)">
	            		<% }}}%>
	            	</td>
            <%}}%>
            </tr>
         </table>
      </form>
      <hr>
      <a href="create_project.jsp"> 
      	<input type="submit" class="submit" value="Add Project">
      </a>
   </center>
</body>
</html>