package com.java.project.vo;

public class BoardVO {
	int no;
	int userNo;
	String type;
	String subject;
	String content;
	String date;
	String secret;
	String head;
	String body;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	
	public void changeTypeString() {
		if(type.equals("Q_A")) {
			this.type = type.replace("_", "&");
		}
	}
	
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	@Override
	public String toString() {
		return "BoardVO [no=" + no + ", userNo=" + userNo + ", type=" + type + ", subject=" + subject + ", content="
				+ content + ", date=" + date + ", secret=" + secret + ", head=" + head + ", body=" + body + "]";
	}
	
	
}
