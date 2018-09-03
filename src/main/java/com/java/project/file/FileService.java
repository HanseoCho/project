package com.java.project.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.java.project.DAO.DaoInterface;
import com.java.project.Util.HttpUtil;
import com.java.project.Util.MapUtil;
import com.java.project.vo.ProductVO;


@Service
public class FileService implements FileServiceInterface {
	@Inject
	DaoInterface di;
	
	@Override
	public ResponseEntity<String> fileUpload(HttpServletRequest req,ProductVO product) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		for(int i = 0; i < product.getViewImage().length; i++) {
			try {
				list.add(saveImg(product.getViewImage()[i],product,"viewImage"));
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<String> ("viewImage를 처리중 문제가 발생하였습니다.",HttpStatus.ACCEPTED);
			}
		}
		try {
			map.put("infoImage",saveImg(product.getInfoImage(),product,"infoImage"));
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("infoImage를 처리중 문제가 발생하였습니다.",HttpStatus.ACCEPTED);
		}
		map.put("viewImage", list);
		return new ResponseEntity<String> ("상품이 등록되었습니다",HttpStatus.OK);
	}
	
	public HashMap<String, Object> saveImg(MultipartFile file,ProductVO prodcut,String str){
		Map<String, Object> param = MapUtil.makeParam("selectOne", "product.selectNo"); 
		String inDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String inTime   = new java.text.SimpleDateFormat("HHmmss").format(new java.util.Date());
		Map<String, Object> param2 = MapUtil.makeParam("insert", "product.fileInsert");
		param2.put("productType", str);
		HashMap<String, Object> fileMap = new HashMap<String, Object>();
		String fileNm = file.getOriginalFilename();
			try {
				byte[] bytes = file.getBytes();
				String path = "D:/GDJ10/IDE/eclipse/workspace/project/src/main/webapp/img/" + (inDate+inTime) + "/";
				//String path = "D:/workspace/src/main/webapp/img/" + (inDate+inTime) + "/";
				//String path = req.getSession().getServletContext().getRealPath("/") + "img/product/" + (inDate+inTime) + "/";
				String dns = "http://gudi.iptime.org:11100/";
				File dirF = new File(path);		
				if(!dirF.exists()) {
					dirF.mkdirs();
				}
				File f = new File(path + fileNm);
				OutputStream out = new FileOutputStream(f);
				out.write(bytes);
				out.close();
				fileMap.put("productNo", (int) di.call(param,prodcut));
				fileMap.put("fileName", fileNm);
				fileMap.put("filePath", path);
				fileMap.put("fileUrl", dns + "img/" + (inDate+inTime) + "/" + fileNm);
				System.out.println(fileMap.toString());
				param2.putAll(fileMap);
				System.out.println(param2.toString());
				di.call(param2);
				return fileMap; 
			} catch (Exception e) {
				fileMap.put("setatus", 0);
				e.printStackTrace();
				return fileMap;
			}
	}
	public String saveImg(MultipartFile file){
		String inDate   = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		String inTime   = new java.text.SimpleDateFormat("HHmmss").format(new java.util.Date());
		String fileNm = file.getOriginalFilename();
			try {
				byte[] bytes = file.getBytes();
				String path = "D:/GDJ10/IDE/eclipse/workspace/project/src/main/webapp/img/" + (inDate+inTime) + "/";
				//String path = "D:/workspace/src/main/webapp/img/" + (inDate+inTime) + "/";
				//String path = req.getSession().getServletContext().getRealPath("/") + "img/product/" + (inDate+inTime) + "/";
				String dns = "http://gudi.iptime.org:11100/";
				File dirF = new File(path);		
				if(!dirF.exists()) {
					dirF.mkdirs();
				}
				File f = new File(path + fileNm);
				OutputStream out = new FileOutputStream(f);
				out.write(bytes);
				out.close();
				return dns + "img/" + (inDate+inTime) + "/" + fileNm; 
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
	}
	
	/* 인덱스의 이벤트박스 관련 메소드*/
	@Override
	public ResponseEntity<HashMap<String, Object>> getIndexEventBox() {
		Map<String, Object> param = MapUtil.makeParam("selectList", "index.getEventBox");
		HashMap<String, Object> result = new HashMap<String, Object>();
		try {
			result.put("result",di.call(param));
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	/* 인덱스의 이벤트박스 관련 메소드*/
	@Override
	public ResponseEntity<String> putIndexEventBox(MultipartFile file,HttpServletRequest req) {
		Map<String, Object> param = MapUtil.makeParam("selectList", "index.setEventBox");
		//파일저장이 이루어져야함
		try {
			param.put("url",saveImg(file));
			param.put("location", req.getParameter("location"));
			param.put("no", req.getParameter("no"));
			di.call(param);
			//param.put("url", url);
			return new ResponseEntity<String> ("수정성공",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("수정실패",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
