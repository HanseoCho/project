package com.java.project.vo;

import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
	int no;
	String category;
	String division;
	String section;
	String subject;
	String price;
	String color;
	String details;
	String size;
	String JoinDate;
	MultipartFile[] viewImage;
	MultipartFile infoImage;
	
	public int getNo() {
		return no;
	}



	public void setNo(int no) {
		this.no = no;
	}



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
	}



	public String getDivision() {
		return division;
	}



	public void setDivision(String division) {
		this.division = division;
	}



	public String getSection() {
		return section;
	}



	public void setSection(String section) {
		this.section = section;
	}



	public String getSubject() {
		return subject;
	}



	public void setSubject(String subject) {
		this.subject = subject;
	}



	public String getPrice() {
		return price;
	}



	public void setPrice(String price) {
		this.price = price;
	}



	public String getColor() {
		return color;
	}



	public void setColor(String color) {
		this.color = color;
	}



	public String getDetails() {
		return details;
	}



	public void setDetails(String details) {
		this.details = details;
	}



	public String getSize() {
		return size;
	}



	public void setSize(String size) {
		this.size = size;
	}



	public String getJoinDate() {
		return JoinDate;
	}



	public void setJoinDate(String joinDate) {
		JoinDate = joinDate;
	}



	public MultipartFile[] getViewImage() {
		return viewImage;
	}



	public void setViewImage(MultipartFile[] viewImage) {
		this.viewImage = viewImage;
	}



	public MultipartFile getInfoImage() {
		return infoImage;
	}



	public void setInfoImage(MultipartFile infoImage) {
		this.infoImage = infoImage;
	}



	@Override
	public String toString() {
		return "ProductVO [no=" + no + ", category=" + category + ", division=" + division + ", section=" + section
				+ ", subject=" + subject + ", price=" + price + ", color=" + color + ", details=" + details + ", size="
				+ size + ", JoinDate=" + JoinDate + ", viewImage=" + Arrays.toString(viewImage) + ", infoImage="
				+ infoImage + "]";
	}

}
