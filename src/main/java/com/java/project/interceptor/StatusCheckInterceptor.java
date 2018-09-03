package com.java.project.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.java.project.HomeController;
import com.java.project.DAO.DaoInterface;
import com.java.project.Util.MapUtil;
import com.java.project.vo.UserVO;

public class StatusCheckInterceptor extends HandlerInterceptorAdapter {
	@Inject
	DaoInterface di;
	private static final Logger logger = LoggerFactory.getLogger(StatusCheckInterceptor.class);
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		/*
		if(test == null) {
			System.out.println("null");
		}
		else {
			System.out.println("있따..");
		}*/
		
		Map<String, Object> map = (Map<String, Object>) session.getAttribute("sessionScope");
		String urlString = request.getRequestURI().toString(); 
		logger.info("요청url : "+urlString);
		
		if(urlString.contains("/email")) {
			session.removeAttribute("sessionScope");
			return true;
		}
		//상품을 클릭할때 클릭데이터 쌓기
		else if(urlString.contains("/list/product/")) {
			Map<String, Object> param = MapUtil.makeParam("insert", "productviews.insert");
//			String[] urlSplit = urlString.split("/")[3];
			param.put("productNo",urlString.split("/")[3]);//4번째가 상품번호
			//비회원일시
			if(map == null) {
				param.put("userType", "비회원");
				param.put("userNo", null);
			}
			//회원일시
			else {
				param.put("userType", "회원");
				param.put("userNo", map.get("no"));
			}
			di.call(param);
		}		
		
		
		else if(urlString.contains("/mypage")) {
			if(map == null) {
				response.sendRedirect("/project");
				return false;
			}
		}
		else {
			if(map != null) {
				UserVO user = new UserVO();
				user = user.parseUesr(map);
				if(user.getStatus().equals("N")) {
					response.sendRedirect("/email");
					return false;
				}	
			}
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	
}
