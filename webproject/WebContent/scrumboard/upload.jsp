<%@page import="webproject.ScrumBeans"%>
<%@page import="webproject.CardClass"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<jsp:useBean id="Beans" class="webproject.ScrumBeans"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8"); 
	
	String savePath = "C:/Users/Na Young/Desktop/workspace/webproject/WebContent/WEB-INF/upload";
	int sizeLimit = 1024*1024*10000; //10KB 제한
	
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	
	String name = multi.getParameter("name");
	String content = multi.getParameter("content");
	String select_board = multi.getParameter("select_board");
	String file = multi.getFilesystemName("file");
	int bid = Integer.parseInt(select_board);
	int pid = Integer.parseInt(multi.getParameter("pid"));
	
	content = content.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	CardClass card = new CardClass();
	
	card.setName(name);
	card.setContent(content);
	card.setBid(bid);
	card.setPid(pid);
	card.setFile(file);

	String path = savePath + "/" + file;
	
	if(Beans.insertCard(card))
		response.sendRedirect("control.jsp?action=goProject&pid="+pid);
	else
		throw new Exception("Card 삽입 오류");
	
%>