package com.java.project.product;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.java.project.Util.Criteria;
import com.java.project.vo.ColumnVO;
import com.java.project.vo.ProductVO;
import com.java.project.vo.ReviewVO;
import com.java.project.vo.UserVO;

@Controller
public class ProductController {
	@Inject
	ProductSericeInterface psi;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)	
	public ModelAndView list(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/list/list");
		return mv;
	}
	@RequestMapping(value="/list/product/{no}",method=RequestMethod.GET)	
	public ModelAndView detailView(@PathVariable("no") int no){
		ModelAndView mv = new ModelAndView();
		mv.addObject("no",no);
		mv.setViewName("/list/detail");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="/detail/{no}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> detailView2(@PathVariable("no") int no){
		return psi.detailView(no);
	}
	
	@ResponseBody
	@RequestMapping(value="/list/{page}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> getProduct2(Criteria criteria){
		System.out.println("Get : product");
		System.out.println("page : "+criteria.getPage());
		return psi.getList(criteria);
	}
	
	@ResponseBody
	@RequestMapping(value="/list/{division}/{page}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> getdivisoin(@PathVariable("division") String division,Criteria criteria){
		return psi.getdivision(division,criteria);
		//return psi.getList(criteria);
	}	
	
	@ResponseBody
	@RequestMapping(value="/column",method=RequestMethod.GET)	
	public ResponseEntity<List<HashMap<String, Object>>> getColumn(){
		return psi.getColumn();
	}
	@ResponseBody
	@RequestMapping(value="/column/{type}/{getType}",method=RequestMethod.GET)	
	public ResponseEntity<List<HashMap<String, Object>>> getselectColumn(ColumnVO column,@PathVariable("getType") String getType){
		return psi.getselectColumn(column,getType);
	}
	@ResponseBody
	@RequestMapping(value="/column/division",method=RequestMethod.GET)	
	public ResponseEntity<List<HashMap<String, Object>>> getdivisionColumn(){
		return psi.getdivisoinColumn();
	}	
	@ResponseBody
	@RequestMapping(value="/column",method=RequestMethod.POST)	
	public ResponseEntity<String> addColumn(ColumnVO column){
		System.out.println(column.toString());
		return psi.addColumn(column);
	}
	@ResponseBody
	@RequestMapping(value="/column/{type}/{value}",method=RequestMethod.DELETE)	
	public ResponseEntity<String> delColumn(ColumnVO column){
		return psi.delColumn(column);
	}
	@ResponseBody
	@RequestMapping(value="/product",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> getProduct(){
		System.out.println("Get : product");
		Criteria criteria = new Criteria();
		criteria.setPage(1);
		return psi.getList(criteria);
	}
	@ResponseBody
	@RequestMapping(value="/product",method=RequestMethod.POST)	
	public ResponseEntity<String> addProduct(ProductVO product){
		return psi.addProduct(product);
	}
	@ResponseBody
	@RequestMapping(value="/product/{no}",method=RequestMethod.DELETE)	
	public ResponseEntity<String> delProduct(ProductVO product){
		return psi.delProduct(product);
	}

	//리뷰부분 --------------------
	@ResponseBody
	@RequestMapping(value="/review/{productNo}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> reviewListGet(ReviewVO review){
		return psi.reviewListGet(review);
	}	
	@ResponseBody
	@RequestMapping(value="/review",method=RequestMethod.POST)	
	public ResponseEntity<String> reviewInsert(ReviewVO review){
		return psi.reviewInsert(review);
	}
	@ResponseBody
	@RequestMapping(value="/review/{no}",method=RequestMethod.PUT)	
	public ResponseEntity<String> delReview(ReviewVO review){
		return psi.delReview(review);
	}
	
	//장바구니
	@RequestMapping(value="/cart",method=RequestMethod.GET)	
	public ModelAndView moveCart(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("list/cart");
		return mav;
	}
}
