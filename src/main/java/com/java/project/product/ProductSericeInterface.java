package com.java.project.product;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.ModelAndView;

import com.java.project.Util.Criteria;
import com.java.project.vo.ColumnVO;
import com.java.project.vo.ProductVO;
import com.java.project.vo.ReviewVO;

public interface ProductSericeInterface {
	public ResponseEntity<List<HashMap<String, Object>>> getColumn();
	public ResponseEntity<List<HashMap<String, Object>>> getdivisoinColumn();
	public ResponseEntity<List<HashMap<String, Object>>> getselectColumn(ColumnVO column,String getType);
	public ResponseEntity<String> addColumn(ColumnVO column);
	public ResponseEntity<String> delColumn(ColumnVO column);
	public ResponseEntity<List<HashMap<String, Object>>> getProduct();
	public ResponseEntity<String> addProduct(ProductVO product);
	public ResponseEntity<String> delProduct(ProductVO product);
	public ResponseEntity<HashMap<String, Object>> getList(Criteria criteria);
	public ResponseEntity<HashMap<String, Object>> getdivision(String division,Criteria criteria);
	public ModelAndView divisionList();
	public ModelAndView sectionList();
	public ResponseEntity<HashMap<String, Object>> detailView(int no);
	//리뷰
	public ResponseEntity<String> reviewInsert(ReviewVO review);
	public ResponseEntity<HashMap<String, Object>> reviewListGet(ReviewVO review);
	public ResponseEntity<String> delReview(ReviewVO review);
	
}
