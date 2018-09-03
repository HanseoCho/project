package com.java.project.file;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.java.project.vo.ProductVO;

@RestController
public class FileController {
	@Inject
	FileServiceInterface fsi;
	@RequestMapping(value="/file",method=RequestMethod.POST)	
	public ResponseEntity<String> addImgFile(HttpServletRequest req,ProductVO product){
		return fsi.fileUpload(req,product);
	}
	
	
	/* 인덱스의 이벤트박스 관련 메소드*/
	@RequestMapping(value="/eventbox",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> getIndexEventBox(HttpServletRequest req,ProductVO product){
		return fsi.getIndexEventBox();
	}
	/* 인덱스의 이벤트박스 관련 메소드*/
	@RequestMapping(value="/eventbox",method=RequestMethod.POST)	
	public ResponseEntity<String> putIndexEventBox(@RequestParam("eventBoxImage") MultipartFile file,HttpServletRequest req){
		String location = req.getParameter("location");
		return fsi.putIndexEventBox(file,req);
	}
}
