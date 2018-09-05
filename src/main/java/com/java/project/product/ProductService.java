package com.java.project.product;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.java.project.DAO.DaoInterface;
import com.java.project.Util.Criteria;
import com.java.project.Util.HttpUtil;
import com.java.project.Util.MapUtil;
import com.java.project.vo.ColumnVO;
import com.java.project.vo.ProductVO;
import com.java.project.vo.ReviewVO;
import com.sun.mail.imap.protocol.Status;

@Service
public class ProductService implements ProductSericeInterface {
	@Inject
	DaoInterface di;
	
	@Override
	public ResponseEntity<List<HashMap<String, Object>>> getColumn() {
		Map<String, Object> param = MapUtil.makeParam("selectList", "column.allget");
		try {
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) di.call(param);
			return new ResponseEntity<List<HashMap<String, Object>>> (list,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			//list.add(new HashMap<String,Object>().);
			return new ResponseEntity<List<HashMap<String, Object>>> (HttpStatus.ACCEPTED);
		}
	}
	
	@Override
	public ResponseEntity<List<HashMap<String, Object>>> getdivisoinColumn() {
		Map<String, Object> param = MapUtil.makeParam("selectList", "column.divisionAllget");
		try {
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) di.call(param);
			return new ResponseEntity<List<HashMap<String, Object>>> (list,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			//list.add(new HashMap<String,Object>().);
			return new ResponseEntity<List<HashMap<String, Object>>> (HttpStatus.ACCEPTED);
		}
	}
	
	@Override
	public ResponseEntity<List<HashMap<String, Object>>> getselectColumn(ColumnVO column,String getType) {
		Map<String, Object> param = new HashMap<String,Object>();
		if(column.getType().equals("중분류")) {
			column.setCategory(getType);
			param = MapUtil.makeParam("selectList", "column.divisionget");
		}
		else if(column.getType().equals("소분류")) {
			column.setDivision(getType);
			param = MapUtil.makeParam("selectList", "column.sectionget");
		}
		try {
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) di.call(param,column);
			return new ResponseEntity<List<HashMap<String, Object>>> (list,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<HashMap<String, Object>>> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public ResponseEntity<String> addColumn(ColumnVO column) {
		Map<String, Object> param = MapUtil.makeParam("insert", "column.insert");
		try {
			di.call(param, column);
			return new ResponseEntity<String>("Column추가완료",HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("Column추가실패",HttpStatus.ACCEPTED);
		}
	}

	@Override
	public ResponseEntity<String> delColumn(ColumnVO column) {
		Map<String, Object> param = MapUtil.makeParam("delete", "column.delete");
		try {
			di.call(param, column);
			return new ResponseEntity<String>("Column삭제완료",HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("Column삭제실패",HttpStatus.ACCEPTED);
		}
	}

	@Override
	public ResponseEntity<List<HashMap<String, Object>>> getProduct() {
		return null;
	}

	@Override
	public ResponseEntity<String> addProduct(ProductVO product) {
		Map<String, Object> param = MapUtil.makeParam("insert", "product.insert");
		System.out.println(product.toString());
		try {
			di.call(param,product);
			return new ResponseEntity<String>("상품추가완료",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("상품추가실패",HttpStatus.ACCEPTED);
		}
	}

	@Override
	public ResponseEntity<String> delProduct(ProductVO product) {
		Map<String, Object> param = MapUtil.makeParam("update", "product.deletePro");
		try {
			di.call(param,product);
			param = MapUtil.makeParam("update", "product.deleteFile");
			di.call(param,product);
			return new ResponseEntity<String> ("상품삭제 완료",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("상품삭제 실패",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public ResponseEntity<HashMap<String, Object>> getList(Criteria criteria) {
		HashMap<String, Object> result = new HashMap<String,Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> list2 = new ArrayList<HashMap<String, Object>>();
		Map<String, Object> param = MapUtil.makeParam("selectList", "product.listGet");
		param.put("startPage", (criteria.getPage()-1)*30);
		param.put("endPage", criteria.getPage()*30);
		System.out.println(param);
		try {
			list = (List<HashMap<String, Object>>) di.call(param);
			//현재 페이지에 따른 총갯수 더해주기 페이징을 위해서
			param = MapUtil.makeParam("selectList", "product.fileGet");
			list2 = (List<HashMap<String, Object>>) di.call(param);
			System.out.println("list2 : "+list2);
			
			for(int i=0;i<list.size();i++) {
				List<HashMap<String, Object>> list3 = new ArrayList<HashMap<String, Object>>();
				for(int j=0;j<list2.size();j++) {
					if(list.get(i).get("no") == list2.get(j).get("productNo")) {
						list3.add(list2.get(j));
					}
				}
				list.get(i).put("image", list3);
			}
			result.put("result", list);
			param = MapUtil.makeParam("selectOne", "product.countGet");
			criteria.setCriteria((int)di.call(param), 30);
			result.put("js",criteria.parserJs());
			System.out.println(result);
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@Override
	public ResponseEntity<HashMap<String, Object>> getdivision(String division,Criteria criteria) {
		HashMap<String, Object> result = new HashMap<String,Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> list2 = new ArrayList<HashMap<String, Object>>();
		Map<String, Object> param = new HashMap<>();
		if(division.equals("인기상품")) {
			param = MapUtil.makeParam("selectList", "productviews.popularProuctList");
		}
		else {
			param = MapUtil.makeParam("selectList", "product.divisionListGet");
		}
		param.put("startPage", (criteria.getPage()-1)*30);
		param.put("endPage", criteria.getPage()*30);
		param.put("division", division);
		System.out.println(param);
		try {
			list = (List<HashMap<String, Object>>) di.call(param);
			//현재 페이지에 따른 총갯수 더해주기 페이징을 위해서
			param = MapUtil.makeParam("selectList", "product.fileGet");
			list2 = (List<HashMap<String, Object>>) di.call(param);
			
			for(int i=0;i<list.size();i++) {
				List<HashMap<String, Object>> list3 = new ArrayList<HashMap<String, Object>>();
				for(int j=0;j<list2.size();j++) {
					if(list.get(i).get("no") == list2.get(j).get("productNo")) {
						list3.add(list2.get(j));
					}
				}
				list.get(i).put("image", list3);
			}
			result.put("result", list);
			param = MapUtil.makeParam("selectOne", "product.divisionCountGet");
			param.put("division", division);
			criteria.setCriteria((int)di.call(param), 30);
			result.put("js",criteria.parserdivisionJs(division));
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@Override
	public ModelAndView divisionList() {
		
		return null;
	}

	@Override
	public ModelAndView sectionList() {
		
		return null;
	}
	@Override
	public ResponseEntity<HashMap<String, Object>> detailView(int no){
		try {
		Map<String, Object> param = MapUtil.makeParam("selectOne", "product.detailNo");
		param.put("no", no);
		HashMap<String, Object> result = new HashMap<String,Object>();
		HashMap<String, Object> map = new HashMap<String,Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		map = (HashMap<String, Object>) di.call(param);
		
		param = MapUtil.makeParam("selectList", "product.ImageNo");
		param.put("no", no);
		
		list = (List<HashMap<String, Object>>) di.call(param);
		map.put("image", list);
		return new ResponseEntity<HashMap<String, Object>>(map,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String, Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public ResponseEntity<String> reviewInsert(ReviewVO review) {
		try {
			System.out.println(review.toString());
			Map<String, Object> param = MapUtil.makeParam("insert", "review.insert");
			di.call(param, review);
			return new ResponseEntity<String>("리뷰작성 완료", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("리뷰작성 실패", HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}

	@Override
	public ResponseEntity<HashMap<String, Object>> reviewListGet(ReviewVO review) {
		try {
			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			HashMap<String, Object> result = new HashMap<String,Object>();
			Map<String, Object> param = MapUtil.makeParam("selectList", "review.selectList");
			list = (List<HashMap<String, Object>>) di.call(param, review);
			SimpleDateFormat d = new SimpleDateFormat("yyyy.MM.dd");
			for(int i=0;i<list.size();i++) {
				HashMap<String, Object> parser = list.get(i);
				parser.put("date", d.format(list.get(i).get("date")));
				list.set(i, parser);
			}
			result.put("result", list);
			System.out.println(result);
			return new ResponseEntity<HashMap<String, Object>>(result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String, Object>>(HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
	
	@Override
	public ResponseEntity<String> delReview(ReviewVO review) {
		try {
			System.out.println(review.toString());
			Map<String, Object> param = MapUtil.makeParam("update", "review.delete");
			di.call(param, review);
			return new ResponseEntity<String>("삭제 완료", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
}
