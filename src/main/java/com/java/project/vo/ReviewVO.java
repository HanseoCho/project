package com.java.project.vo;

public class ReviewVO {
	int no;
	int productNo;
	int userNo;
	String contents;
	int rating;
	String date;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "ReviewVO [no=" + no + ", productNo=" + productNo + ", userNo=" + userNo + ", contents=" + contents
				+ ", rating=" + rating + ", date=" + date + "]";
	}
	
	
}
