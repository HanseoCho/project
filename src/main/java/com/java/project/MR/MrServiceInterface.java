package com.java.project.MR;

import java.util.HashMap;

import org.springframework.http.ResponseEntity;

public interface MrServiceInterface {
	public ResponseEntity<HashMap<String, Object>> saveData(String inDate,String inTime) throws Throwable;
	public ResponseEntity<HashMap<String, Object>> reader(String inDate,String inTime) throws Throwable;
}
