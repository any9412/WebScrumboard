package webproject;

import java.sql.Date;

public class ProjectClass {
	private int pid;
	private String title;
	private Date pstartdate;
	private Date penddate;
	private String uid;
	
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getPstartdate() {
		return pstartdate;
	}
	public void setPstartdate(Date pstartdate) {
		this.pstartdate = pstartdate;
	}
	public Date getPenddate() {
		return penddate;
	}
	public void setPenddate(Date penddate) {
		this.penddate = penddate;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
}
