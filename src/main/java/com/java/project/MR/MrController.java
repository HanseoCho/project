package com.java.project.MR;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.hadoop.conf.Configuration;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MrController {
	@Inject
	MrServiceInterface msi;
	
	static String year;
	static String month;

	
	@ResponseBody
	@RequestMapping(value="/mr/{year}/{month}")	
	public ResponseEntity<HashMap<String, Object>> MR(@PathVariable("year") String year,@PathVariable("month") String month) throws Throwable{
		System.out.println(1);
		this.year = year;
		this.month = month;
		String inDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String inTime   = new java.text.SimpleDateFormat("HHmmss").format(new java.util.Date());
		msi.saveData(inDate,inTime);
		
		return msi.reader(inDate, inTime);
	}
}
