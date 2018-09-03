package com.java.project.file;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.java.project.vo.ProductVO;

public interface FileServiceInterface {

	ResponseEntity<String> fileUpload(HttpServletRequest req,ProductVO proudct);
	ResponseEntity<HashMap<String, Object>> getIndexEventBox();
	ResponseEntity<String> putIndexEventBox(MultipartFile file,HttpServletRequest req);
	
}
