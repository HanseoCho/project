package com.java.project.DAO;

import java.util.HashMap;
import java.util.Map;

import com.java.project.vo.BoardVO;
import com.java.project.vo.ColumnVO;
import com.java.project.vo.CommentVO;
import com.java.project.vo.ProductVO;
import com.java.project.vo.ReviewVO;
import com.java.project.vo.UserVO;

public interface DaoInterface {
	public Object call(Map<String, Object> param);
	public Object call(Map<String, Object> param,UserVO user);
	public Object call(Map<String, Object> param,ColumnVO column);
	public Object call(Map<String, Object> param, ProductVO product);
	public Object call(Map<String, Object> param, ReviewVO review);
	public Object call(Map<String, Object> param, BoardVO board);
	public Object call(Map<String, Object> param, CommentVO comment);
	public void createTempKey(UserVO user);
}
