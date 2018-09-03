package com.java.project.vo;

public class CommentVO {
	int no;
	int userNo;
	int boardNo;
	String content;
	String date;
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
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
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
	@Override
	public String toString() {
		return "CommentVO [no=" + no + ", userNo=" + userNo + ", boardNo=" + boardNo + ", content=" + content
				+ ", date=" + date + "]";
	}
	
}
