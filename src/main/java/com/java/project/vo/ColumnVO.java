package com.java.project.vo;

public class ColumnVO {
	int no;
	String type;
	String value;
	String category;
	String division;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
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
	@Override
	public String toString() {
		return "ColumnVO [no=" + no + ", type=" + type + ", value=" + value + ", category=" + category + ", division="
				+ division + "]";
	}
	
	
	
}
