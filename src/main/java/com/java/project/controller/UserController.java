package com.java.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.java.project.Interface.UserServiceInterface;
import com.java.project.vo.UserVO;


@RestController
public class UserController {
	@Inject
	UserServiceInterface usi;

	//중복확인
	@RequestMapping(value="/user/{id}",method=RequestMethod.GET)	
	public ResponseEntity<String> userSelectId(UserVO user){
		return new ResponseEntity<String>(usi.selectid(user), HttpStatus.OK);
	}
	
	//이메일 인증
	@RequestMapping(value="/email/{id}/key/{key}",method=RequestMethod.PUT)	
	public ResponseEntity<HashMap<String, Object>> keyMatch(UserVO user) throws Throwable{
		return usi.matchKey(user);
	}	
	
	@RequestMapping(value="/search/{email}",method=RequestMethod.GET)
	public ResponseEntity<String> findId(UserVO user,HttpServletRequest req){
		return usi.findId(user);
	}

	@RequestMapping(value="/search/{email}/{id}",method=RequestMethod.GET)
	public ResponseEntity<String> findPw(UserVO user) throws Throwable{
		return usi.findPw(user);
	}
	
	//회원가입
	@RequestMapping(value="/user",method=RequestMethod.POST)	
	public ResponseEntity<String> userinsert(UserVO user){
		System.out.println(user.toString());
		return usi.insert(user);
	}

	//회원수정 (수정은 패스워드와 이름 자기소개 부분만 아이디로 구분)
	@RequestMapping(value="/user",method=RequestMethod.PUT)	
	public ResponseEntity<String> userUpdate(HttpServletRequest req,UserVO user){
		System.out.println("user method.put");
		System.out.println(user.toString());
		return usi.update(req,user);
	}	
	//회원탈퇴(아이디로 delYn확인후 삭제)
	@RequestMapping(value="/user/{id}",method=RequestMethod.DELETE)	
	public ResponseEntity<String> userDelete(HttpServletRequest req,UserVO user){
		return usi.delete(req,user);
	}	
	//
	

	//로그인 (파라미터 ID와 PW)
	@RequestMapping(value="/session",method=RequestMethod.POST)
	public ResponseEntity<String> setSession(UserVO user,HttpServletRequest req) {
		return usi.setSession(user,req);
	}
	//로그아웃
	@RequestMapping(value="/session",method=RequestMethod.DELETE)
	public ResponseEntity<String> outSession(UserVO user,HttpServletRequest req) {
		return usi.outSession(user,req);
	}
	
	//회원관리 뷰를 위해 회원 가져오기
	@RequestMapping(value="/userall",method=RequestMethod.GET)
	public ResponseEntity<HashMap<String, Object>> allList() {
		return usi.allList();
	}
	//회원관리 뷰를 위해 회원 차단취소
	@RequestMapping(value="/userall/{no}",method=RequestMethod.PUT)
	public ResponseEntity<String> rollUser(UserVO user) {
		return usi.rollUser(user);
	}	
	//회원관리 뷰를 위해 회원 차단
	@RequestMapping(value="/userall/{no}",method=RequestMethod.DELETE)
	public ResponseEntity<String> kickUser(UserVO user) {
		return usi.kickUser(user);
	}	
}
