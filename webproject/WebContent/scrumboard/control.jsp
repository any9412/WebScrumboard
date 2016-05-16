<%@page import="com.sun.org.apache.bcel.internal.generic.ISUB"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="webproject.*"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="sun.nio.cs.HistoricallyNamedCharset"%>
<%@page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="Board" class="webproject.BoardClass" />
<jsp:useBean id="Card" class="webproject.CardClass" />
<jsp:useBean id="Member" class="webproject.MemberClass" />
<jsp:useBean id="Project" class="webproject.ProjectClass" />
<jsp:useBean id="User" class="webproject.UserClass" />
<jsp:useBean id="Beans" class="webproject.ScrumBeans" />
<jsp:useBean id="bids" scope="request" class="java.util.ArrayList"></jsp:useBean>
<jsp:setProperty property="*" name="User" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="errorPage.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");

	String action = request.getParameter("action");
	if (action.equals("login")) {
		String id = request.getParameter("uid");
		String pw = request.getParameter("password");
		if(!Beans.isUserExist(id)){
			out.println("<script>alert('요청하신 정보가 존재하지 않습니다. 다시입력해주세요.');history.go(-1);</script>");
		}
		else if (Beans.SearchId(id).equals(pw)) {
			session.setAttribute("loginID", id);
			pageContext.forward("account_form.jsp");
		} else {
			out.println("<script>alert('요청하신 정보가 존재하지 않습니다. 다시입력해주세요.');history.go(-1);</script>");
		}
	} else if (action.equals("addCard")) {
		String cName = request.getParameter("name");
		cName = new String(cName.getBytes("ISO-8859-1"), "UTF-8");
		String ctext = request.getParameter("content");
		ctext = new String(ctext.getBytes("ISO-8859-1"), "UTF-8");
		String selBoardstr = request.getParameter("select_board");

		int selBoard = Integer.parseInt(selBoardstr);
		//TODO attachment 구현
		String id = session.getAttribute("loginID").toString();
		int pid = Integer.parseInt(request.getParameter("pid"));

		Card.setName(cName);
		Card.setContent(ctext);
		Card.setBid(selBoard);
		Card.setPid(pid);

		Beans.insertCard(Card);

		response.sendRedirect("project_form.jsp?pid=" + pid);
	} else if (action.equals("deleteCard")) {
		String cid = request.getParameter("cid");
		int cid_int = Integer.parseInt(cid);
		CardClass cc = Beans.getCard(cid_int);

		String savePath  = "C:/Users/Na Young/Desktop/workspace/webproject/WebContent/WEB-INF/upload/";
		String file_name = cc.getFile();
		if(file_name != null){
			File file = new File( savePath + file_name + "" );  // 파일 객체생성
			System.out.println(savePath + file_name);
			if( file.exists() ) 
				file.delete();
		}
		if(Beans.deleteCard(cid_int))
			response.sendRedirect("project_form.jsp?pid=" + cc.getPid());
		else
			throw new Exception("Card 삭제 오류");
	} else if (action.equals("card")) {
		String cid = request.getParameter("cid");
		int cid_int = Integer.parseInt(cid);
		CardClass cc = Beans.getCard(cid_int);
		pageContext.forward("card_form.jsp?cid=" + cc.getCid() + "&pid=" + cc.getPid());
	} else if (action.equals("goProject")) {
		String pid = request.getParameter("pid");
		response.sendRedirect("project_form.jsp?pid="+pid);
	} else if (action.equals("addProject")) {
		String uid = session.getAttribute("loginID").toString();
		String title = request.getParameter("title");
		title = new String(title.getBytes("ISO-8859-1"), "UTF-8");

		String SDatstr = request.getParameter("pstartdate");
		SimpleDateFormat Ssdf = new SimpleDateFormat("yyyy-MM-dd");
		Date SDate_d = Ssdf.parse(SDatstr);
		java.sql.Date SDate = new java.sql.Date(SDate_d.getTime());

		String EDatstr = request.getParameter("penddate");
		SimpleDateFormat Esdf = new SimpleDateFormat("yyyy-MM-dd");
		Date EDate_d = Esdf.parse(EDatstr);
		java.sql.Date EDate = new java.sql.Date(EDate_d.getTime());

		Project.setTitle(title);
		Project.setPstartdate(SDate);
		Project.setPenddate(EDate);
		Project.setUid(uid);

		// Insert into database
		Beans.insertProject(Project);

		Member.setUid(uid);
		int pid = Beans.getPid(title, uid);
		Member.setPid(pid);
		Beans.insertBoard();
		// Insert into database
		Beans.insertMember(Member);
		pageContext.forward("account_form.jsp");
	} else if (action.equals("deleteProject")) {
		String uid = session.getAttribute("loginID").toString();
		int pid = Integer.parseInt(request.getParameter("pid"));
		ProjectClass p = Beans.getProject(pid);
		String savePath  = "C:/Users/Na Young/Desktop/workspace/webproject/WebContent/WEB-INF/upload/";
		
		if (uid.equals(p.getUid())) {
			for(CardClass cc : Beans.getCardList()){
				if(cc.getPid() == pid){
					if(cc.getFile() != null){
						String fname = cc.getFile();
						File file = new File( savePath + fname + "" );  // 파일 객체생성
						System.out.println(savePath + fname);
						if( file.exists() ) 
							file.delete();
					}
				}
			}
			
			// 프로젝트 생성자 본인이 프로젝트를 없애기를 희망
			// Delete Card table
			Beans.deleteAllCard(pid);
			// Delete Member table
			Beans.deleteProjectMember(pid);
			// Delete Project table
			Beans.deleteProject(pid);
		} else {
			Beans.deleteMember(pid, uid);
		}
		pageContext.forward("account_form.jsp");
	} else if (action.equals("modifyProject")) {
		int pid = Integer.parseInt(request.getParameter("pid"));
		ProjectClass p = Beans.getProject(pid);
		boolean check = false;

		String SDatstr = request.getParameter("pstartdate");
		SimpleDateFormat Ssdf = new SimpleDateFormat("yyyy-MM-dd");
		Date SDate_d = Ssdf.parse(SDatstr);
		java.sql.Date SDate = new java.sql.Date(SDate_d.getTime());
		p.setPstartdate(SDate);

		String EDatstr = request.getParameter("penddate");
		SimpleDateFormat Esdf = new SimpleDateFormat("yyyy-MM-dd");
		Date EDate_d = Esdf.parse(EDatstr);
		java.sql.Date EDate = new java.sql.Date(EDate_d.getTime());
		p.setPenddate(EDate);

		String title = request.getParameter("title");
		title = new String(title.getBytes("ISO-8859-1"), "UTF-8");

		p.setTitle(title);
		if (Beans.updateProject(p)) {
			ArrayList<String> list = (ArrayList<String>) session.getAttribute("memberlist");
			if (list != null) {
				for (String a : list) {
					MemberClass mc = new MemberClass();
					mc.setUid(a);
					mc.setPid(pid);
					for (MemberClass mc2 : Beans.getMemberList()) {
						if (mc2.getPid() == mc.getPid() && mc2.getUid() == mc.getUid()) {
							out.println("<script>alert('이미 존재하는 멤버입니다.');history.go(-1);</script>");
							break;
						} else
							check = true;
					}
					if (check) {
						Beans.insertMember(mc);
						check = false;
					}
				}
				//list.clear();
				//session.setAttribute("memberlist", list);
			}
			pageContext.forward("account_form.jsp");
		} else
			throw new Exception("Project 갱신 오류");
	} else if (action.equals("project")) {
		String pid = request.getParameter("pid");
		ProjectClass p = Beans.getProject(Integer.parseInt(pid));
		pageContext.forward("project_form.jsp?pid=" + p.getPid());
	} else if (action.equals("register")) {
		String uid = request.getParameter("uid");
		String name = request.getParameter("name");
		name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
		String password = request.getParameter("password");
		UserClass uc = Beans.getUser(uid);
		uc.setUid(uid);
		uc.setName(name);
		uc.setPassword(password);
		if (Beans.insertUser(uc)) {
			ArrayList<UserClass> datas = Beans.getUserList();
			request.setAttribute("datas", datas);
			request.setAttribute("uid", uid);
			pageContext.forward("new_account_created.jsp");
		} else {
			throw new Exception("DB 입력 오류");
		}
	} else if (action.equals("checkID")) {
		String id = request.getParameter("uid");
		if(id.equals("")){
			out.println("<script>alert('아이디를 입력해주세요.'); history.go(-1);</script>");
		}
		else if (Beans.isExist(id)) {
			out.println("<script>alert('아이디를 사용할 수 없습니다.'); history.go(-1);</script>");
		} else {
			out.println("<script>alert('아이디를 사용할 수 있습니다.'); history.go(-1);</script>");
		}
	} else if (action.equals("searchMemID")) {
		String smi = request.getParameter("smi");
		int pid = Integer.parseInt(request.getParameter("pid"));
		ProjectClass p = Beans.getProject(pid);
		boolean check = false;

		if (Beans.isUserExist(smi)) {
			if (p.getUid().equals(smi)) {
				out.println("<script>alert('이미 존재합니다.');history.go(-1);</script>");
			} else {
				ArrayList<String> list = (ArrayList) session.getAttribute("memberlist");
				if (list == null) {
					list = new ArrayList<String>();
					list.add(smi);
					session.setAttribute("memberlist", list);
				} else {
					for (String a : list) {
						if (a.equals(smi)) {
							out.println("<script>alert('멤버리스트에 이미 추가하셨습니다.');</script>");
							check = false;
							break;
						} else
							check = true;
					}
				}

				for (MemberClass mc : Beans.getMemberList()) {
					if (mc.getPid() == pid) {
						if (mc.getUid().equals(smi)) {
							out.println("<script>alert('이미 존재하는 멤버입니다.');</script>");
							check = false;
							break;
						}
					}
				}

				if (check) {
					list.add(smi);
				}
				
				out.println("<script>history.go(-1);</script>");
			}
		} else {
			out.println("<script>alert('찾을 수 없습니다. 다시 입력하세요.');history.go(-1);</script>");
		}
	} else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>