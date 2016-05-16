package webproject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ScrumBeans {

	Connection conn = null;
	PreparedStatement pstmt = null;

	// 데이터베이스 연결 관련 정보를 문자열로 선언
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://127.0.0.1:3306/scrumboard"; // 내 mysql 스키마로

	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url, "jspbook_ny", "1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// User

	public boolean updateUser(UserClass user) {
		connect();

		String sql = "update User set password=? where uid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getPassword());
			pstmt.setString(2, user.getUid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean deleteUser(String id) {
		connect();

		String sql = "delete from User where uid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public boolean insertUser(UserClass user) {
		connect();

		String sql = "insert into User values(?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUid());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getPassword());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public UserClass getUser(String gb_id) {
		connect();

		String sql = "select * from User where uid=?";
		UserClass user = new UserClass();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gb_id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			user.setUid(rs.getString("uid"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return user;
	}

	public ArrayList<UserClass> getUserList() {
		connect();

		ArrayList<UserClass> datas = new ArrayList<UserClass>();

		String sql = "select * from User order by uid desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				UserClass user = new UserClass();

				user.setUid(rs.getString("uid"));
				user.setName(rs.getString("name"));
				user.setPassword(rs.getString("password"));
				datas.add(user);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	// Member

	public boolean updateMember(MemberClass member) {
		connect();

		String sql = "update Member set uid=?, pid=? where mid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getUid());
			pstmt.setInt(2, member.getPid());
			pstmt.setInt(3, member.getMid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean deleteMember(int id) {
		connect();

		String sql = "delete from Member where mid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public boolean insertMember(MemberClass member) {
		connect();

		String sql = "insert into Member(uid, pid) values(?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getUid());
			pstmt.setInt(2, member.getPid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public MemberClass getMember(int gb_id) {
		connect();

		String sql = "select * from Member where mid=?";
		MemberClass member = new MemberClass();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gb_id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			member.setMid(rs.getInt("mid"));
			member.setUid(rs.getString("uid"));
			member.setPid(rs.getInt("pid"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return member;
	}

	public ArrayList<MemberClass> getMemberList() {
		connect();

		ArrayList<MemberClass> datas = new ArrayList<MemberClass>();

		String sql = "select * from Member order by mid desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberClass member = new MemberClass();

				member.setMid(rs.getInt("mid"));
				member.setUid(rs.getString("uid"));
				member.setPid(rs.getInt("pid"));
				datas.add(member);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	// Project

	public boolean updateProject(ProjectClass project) {
		connect();

		String sql = "update Project set title=?, pstartdate=?, penddate=?, uid=? where pid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, project.getTitle());
			pstmt.setDate(2, project.getPstartdate());
			pstmt.setDate(3, project.getPenddate());
			pstmt.setString(4, project.getUid());
			pstmt.setInt(5, project.getPid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean deleteProject(int project_id) {
		connect();

		String sql = "delete from Project where pid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, project_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public boolean insertProject(ProjectClass project) {
		connect();

		String sql = "insert into Project(title , pstartdate, penddate, uid) values(?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, project.getTitle());
			pstmt.setDate(2, project.getPstartdate());
			pstmt.setDate(3, project.getPenddate());
			pstmt.setString(4, project.getUid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public ProjectClass getProject(int project_id) {
		connect();

		String sql = "select * from Project where pid=?";
		ProjectClass project = new ProjectClass();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, project_id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			project.setPid(rs.getInt("pid"));
			project.setTitle(rs.getString("title"));
			project.setPstartdate(rs.getDate("pstartdate"));
			project.setPenddate(rs.getDate("penddate"));
			project.setUid(rs.getString("uid"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return project;
	}

	public ArrayList<ProjectClass> getProjectList() {
		connect();

		ArrayList<ProjectClass> projectDatas = new ArrayList<ProjectClass>();

		String sql = "select * from Project order by pid desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ProjectClass project = new ProjectClass();
				project.setPid(rs.getInt("pid"));
				project.setTitle(rs.getString("title"));
				project.setPstartdate(rs.getDate("pstartdate"));
				project.setPenddate(rs.getDate("penddate"));
				project.setUid(rs.getString("uid"));
				projectDatas.add(project);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return projectDatas;
	}

	// Card

	public boolean updateCard(CardClass card) {
		connect();

		String sql = "update Card set name=?, content=?, bid=?, pid=?, file=? where cid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, card.getName());
			pstmt.setString(2, card.getContent());
			pstmt.setInt(3, card.getBid());
			pstmt.setInt(4, card.getPid());
			pstmt.setString(5, card.getFile());
			pstmt.setInt(6, card.getCid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean deleteCard(int card_id) {
		connect();

		String sql = "delete from Card where cid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, card_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public boolean insertCard(CardClass card) {
		connect();

		String sql = "insert into Card(name, content, bid, pid, file) values(?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, card.getName());
			pstmt.setString(2, card.getContent());
			pstmt.setInt(3, card.getBid());
			pstmt.setInt(4, card.getPid());
			pstmt.setString(5, card.getFile());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public CardClass getCard(int card_id) {
		connect();

		String sql = "select * from Card where cid=?";
		CardClass card = new CardClass();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, card_id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			card.setCid(rs.getInt("cid"));
			card.setName(rs.getString("name"));
			card.setContent(rs.getString("content"));
			card.setBid(rs.getInt("bid"));
			card.setPid(rs.getInt("pid"));
			card.setFile(rs.getString("file"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return card;
	}

	public ArrayList<CardClass> getCardList() {
		connect();

		ArrayList<CardClass> cardDatas = new ArrayList<CardClass>();

		String sql = "select * from Card order by cid desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				CardClass card = new CardClass();

				card.setCid(rs.getInt("cid"));
				card.setName(rs.getString("name"));
				card.setContent(rs.getString("content"));
				card.setBid(rs.getInt("bid"));
				card.setPid(rs.getInt("pid"));
				card.setFile(rs.getString("file"));
				cardDatas.add(card);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return cardDatas;
	}

	// Board

	public boolean updateBoard(BoardClass board) {
		connect();

		String sql = "update Board set name=? where bid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getName());
			pstmt.setInt(2, board.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean deleteBoard(int board_id) {
		connect();

		String sql = "delete from Board where bid=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public boolean insertBoard() {
		connect();

		String sql = "insert into Board values(0,'Stories');";
        String sql2 = "insert into Board values(1,'To do');";
        String sql3 = "insert into Board values(2,'In progress');";
        String sql4 = "insert into Board values(3,'Testing');";
        String sql5 = "insert into Board values(4,'Done');";
        try{
       	 System.out.println("sql 전");
           pstmt = conn.prepareStatement(sql);
           pstmt.executeUpdate();
           pstmt = conn.prepareStatement(sql2);
           pstmt.executeUpdate();
           pstmt = conn.prepareStatement(sql3);
           pstmt.executeUpdate();
           pstmt = conn.prepareStatement(sql4);
           pstmt.executeUpdate();
           pstmt = conn.prepareStatement(sql5);
           pstmt.executeUpdate();
           System.out.println("sql후");
        }
        catch(SQLException e){
           e.printStackTrace();
           return false;
        }
        finally {
           disconnect();
        }
        
        return true;
	}

	public BoardClass getBoard(int board_id) {
		connect();

		String sql = "select * from Board where ㅠid=?";
		BoardClass board = new BoardClass();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			board.setBid(rs.getInt("id"));
			board.setName(rs.getString("name"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return board;
	}

	public ArrayList<BoardClass> getBoardList() {
		connect();

		ArrayList<BoardClass> boardDatas = new ArrayList<BoardClass>();

		String sql = "select * from Board order by bid desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardClass board = new BoardClass();

				board.setBid(rs.getInt("bid"));
				board.setName(rs.getString("name"));
				boardDatas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return boardDatas;
	}

	public ArrayList<Integer> getPid(int id) {
		connect();

		ArrayList<Integer> pids = new ArrayList<Integer>();
		String sql = "select pid from Member where uid = " + id;

		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Integer pid;
				pid = rs.getInt("pid");
				pids.add(pid);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return pids;
	}

	public ArrayList<Integer> getBid(int id) {
		connect();

		ArrayList<Integer> bids = new ArrayList<Integer>();
		String sql = "select bid from Board where pid = " + id;

		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Integer bid;
				bid = rs.getInt("bid");
				bids.add(bid);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return bids;
	}

	public ArrayList<Integer> getCid(int id) {
		connect();

		ArrayList<Integer> cids = new ArrayList<Integer>();
		String sql = "select cid from Card where bid = " + id;

		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Integer cid;
				cid = rs.getInt("cid");
				cids.add(cid);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cids;
	}

	public ArrayList<String> getPname(ArrayList<Integer> pid) {
		connect();

		int index = 0;
		ArrayList<String> pname = new ArrayList<String>();

		for (index = 0; index < pid.size(); index++) {
			String sql = "select title from Project where pid = " + pid.get(index);

			try {
				pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					String title;
					title = rs.getString("title");
					pname.add(title);
				}
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return pname;
	}

	public ArrayList<String> getBname(ArrayList<Integer> bid) {
		connect();

		ArrayList<String> bname = new ArrayList<String>();

		for (int index = 0; index < bid.size(); index++) {
			String sql = "select name from Board where bid = " + bid;

			try {
				pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					String name;
					name = rs.getString("name");
					bname.add(name);
				}
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return bname;
	}

	public ArrayList<String> getCname(ArrayList<Integer> cid) {
		connect();

		ArrayList<String> cname = new ArrayList<String>();

		for (int index = 0; index < cid.size(); index++) {
			String sql = "select name from Card where cid = " + cid;

			try {
				pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					String name;
					name = rs.getString("name");
					cname.add(name);
				}
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return cname;
	}

	public String SearchId(String id) {
		connect();

		String pw = null;
		String sql = "select * from User";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				if (id.equals(rs.getString("uid"))) {
					pw = rs.getString("password");
					break;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return pw;
	}

	public boolean isExist(String id) {
		connect();

		String sql = "select uid from User";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery(sql);
			while (rs.next()) {
				if (id.equals(rs.getString("uid"))) {
					return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public boolean isUserExist(String id) {
		connect();

		String sql = "select uid from User where uid='" + id + "'"; // 이거 고쳐야함
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery(sql);
			if (rs.next()) {
				return true;
			} else
				return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public String getMemberID(String uid) {
		String sql = "select uid from User where uid=" + uid;
		String id = null;
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery(sql);
			if (rs.next())
				id = rs.getString("uid");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}

	public int getPid(String Pname, String uid) {
		connect();
		int id = 0;
		String sql = "select pid from Project where title='" + Pname + "' and uid='" + uid + "'";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				id = rs.getInt("pid");
			}
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			disconnect();
		}

		return id;
	}

	public boolean deleteProjectMember(int pid) {
		connect();
		String sql = "delete m1 from Member as m1 Inner Join Member as m2 on m1.mid = m2.mid where m2.pid=?";
		try {
			pstmt = conn.prepareStatement("SET SQL_SAFE_UPDATES=0");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}
	
	public boolean deleteMember(int pid, String uid) {
		connect();
		String sql = "delete m1 from Member as m1 Inner Join Member as m2 on m1.mid = m2.mid where m2.pid=? and m2.uid='"+uid+"';";
		try {
			pstmt = conn.prepareStatement("SET SQL_SAFE_UPDATES=0");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}

	public boolean deleteAllCard(int pid) {
		connect();
		String sql = "delete c1 from Card as c1 Inner Join Card as c2 on c1.cid = c2.cid where c2.pid=?";
		try {
			pstmt = conn.prepareStatement("SET SQL_SAFE_UPDATES=0");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}

		return true;
	}
	
	public boolean updateFile(int cid, String file) {
		connect();
		String sql = "update Card set file=? where cid=?";
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, file);
			pstmt.setInt(2, cid);
			pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
}