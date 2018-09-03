package com.java.project.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;

import com.java.project.vo.UserVO;


public interface UserServiceInterface {
	public String selectid(UserVO user);
	public ResponseEntity<HashMap<String, Object>> matchKey(UserVO user) throws Exception;
	public ResponseEntity<String> insert(UserVO user);
	public ResponseEntity<String> update(HttpServletRequest req, UserVO user);
	public ResponseEntity<String> delete(HttpServletRequest req, UserVO user);
	public ResponseEntity<String> findId(UserVO user);
	public ResponseEntity<String> findPw(UserVO user);
	public ResponseEntity<String> setSession(UserVO user,HttpServletRequest req);
	public ResponseEntity<String> outSession(UserVO user,HttpServletRequest req);
	public ResponseEntity<HashMap<String, Object>> allList();
	public ResponseEntity<String> kickUser(UserVO user);
	public ResponseEntity<String> rollUser(UserVO user);
}
