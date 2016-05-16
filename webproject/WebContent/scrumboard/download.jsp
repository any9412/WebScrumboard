<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" errorPage="errorPage.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
 
 
<%
    request.setCharacterEncoding("UTF-8");

    // ���� ���ε�� ���
    String savePath = "C:/Users/Na Young/Desktop/workspace/webproject/WebContent/WEB-INF/upload";
    
 	String filename = request.getParameter("file");
 	filename = new String(filename.getBytes("ISO-8859-1"), "UTF-8");
 	// ���� ������ ���ϸ�
    String orgfilename = filename;
 
    InputStream in = null;
    OutputStream os = null;
    File file = null;
    boolean skip = false;
    String client = "";
 
 
    try{
         
        // ������ �о� ��Ʈ���� ���
        try{
            file = new File(savePath, filename);
            in = new FileInputStream(file);
        }catch(FileNotFoundException fe){
            skip = true;
        }
 
        client = request.getHeader("User-Agent");
 
        // ���� �ٿ�ε� ��� ����
        response.reset() ;
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Description", "JSP Generated Data");
 
 
        if(!skip){
 
            // IE
            if(client.indexOf("MSIE") != -1){
                response.setHeader ("Content-Disposition", "attachment; filename="+ new String(orgfilename.getBytes("ISO-8859-1"), "UTF-8"));
 
            }else{
                // �ѱ� ���ϸ� ó��
                orgfilename = new String(orgfilename.getBytes("UTF-8"),"iso-8859-1");
 
                response.setHeader("Content-Disposition", "attachment; filename=\"" + orgfilename + "\"");
                response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
            }
             
            response.setHeader ("Content-Length", ""+file.length() );
 
 
       
            os = response.getOutputStream();
            byte b[] = new byte[(int)file.length()];
            int leng = 0;
             
            while( (leng = in.read(b)) > 0 ){
                os.write(b,0,leng);
            }
 
        }else{
            response.setContentType("text/html;charset=UTF-8");
            out.println("<script language='javascript'>alert('������ ã�� �� �����ϴ�');history.back();</script>");
 
        }
         
        in.close();
        os.close();
 
    }catch(Exception e){
      e.printStackTrace();
    }
%>