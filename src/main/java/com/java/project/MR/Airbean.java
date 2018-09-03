package com.java.project.MR;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.hadoop.io.Text;

public class Airbean {
	int productNo = 0;
	String category = "";
	String division = "";
	String section = "";
	String subject = "";
	int price = 0;
	String colors;
	String date_Y= "";
	String date_M= "";
	public Airbean(Text value) {
		try {
			String[] text = value.toString().split(",");
			date_Y = text[0].split("/")[0];
			date_M = text[0].split("/")[1];
			productNo = Integer.parseInt(text[7]);
			category = text[6];
			division = text[1];
			section = text[5];
			subject = text[3];
			price = Integer.parseInt(text[4]);
			colors = text[2];
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getColors() {
		return colors;
	}
	public void setColors(String colors) {
		this.colors = colors;
	}
	
	public String getDate_Y() {
		return date_Y;
	}
	public void setDate_Y(String date_Y) {
		this.date_Y = date_Y;
	}
	public String getDate_M() {
		return date_M;
	}
	public void setDate_M(String date_M) {
		this.date_M = date_M;
	}
	@Override
	public String toString() {
		return "Airbean [productNo=" + productNo + ", category=" + category + ", division=" + division + ", section="
				+ section + ", subject=" + subject + ", price=" + price + ", colors=" + colors + "]";
	}
	
	
}
