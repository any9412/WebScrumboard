<%@page import="webproject.CardClass"%>
<%@page import="webproject.ScrumBeans"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String savePath  = "C:/Users/Na Young/Desktop/workspace/webproject/WebContent/WEB-INF/upload/";
	String file_name;
	
	ScrumBeans Beans = new ScrumBeans();
	String cid = request.getParameter("cid");
	int cid_int = Integer.parseInt(cid);
	CardClass cc = Beans.getCard(cid_int);
	
	file_name = cc.getFile();
	
	File file = new File( savePath + file_name + "" );  // 파일 객체생성
	System.out.println(savePath + file_name);
	if( file.exists() ) 
		file.delete();
	
	cc.setFile(null);
	Beans.updateFile(cc.getCid(), cc.getFile());
	
	out.println("<script>history.go(-1);</script>");
%>