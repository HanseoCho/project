package com.java.project.DAO;

import java.io.Console;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.java.project.vo.BoardVO;
import com.java.project.vo.ColumnVO;
import com.java.project.vo.CommentVO;
import com.java.project.vo.ProductVO;
import com.java.project.vo.ReviewVO;
import com.java.project.vo.UserVO;

@Repository
public class Dao implements DaoInterface {
	@Resource(name="sqlSession")
	SqlSession session;	
	private static final Logger logger = LoggerFactory.getLogger(Dao.class);
		@Override
		public Object call(Map<String, Object> param) {
			String sql = param.get("sql").toString();
			String sqltype = param.get("sqlType").toString();
			
			if("selectOne".equals(sql)) {
				return session.selectOne(sqltype,param);
			}
			else if("insert".equals(sql)) {
				return session.insert(sqltype,param);
			}
			else if("update".equals(sql)) {
				return session.update(sqltype,param);
			}
			else if("selectList".equals(sql)) {
				return session.selectList(sqltype,param);
			}
			else if("delete".equals(sql)) {
				return session.delete(sqltype,param);
			}
			else {			
				logger.info("sql문 확인 : " + sql);
			}
			
			return null;
		}
		@Override
		public Object call(Map<String, Object> param, UserVO user) {
			String sql = param.get("sql").toString();
			String sqltype = param.get("sqlType").toString();
			user.insertDb();
			if("selectOne".equals(sql)) {
				return session.selectOne(sqltype,user);
			}
			else if("insert".equals(sql)) {
				return session.insert(sqltype,user);
			}
			else if("update".equals(sql)) {
				return session.update(sqltype,user);
			}
			else if("selectList".equals(sql)) {
				return session.selectList(sqltype,user);
			}
			else if("delete".equals(sql)) {
				return session.delete(sqltype,user);
			}
			else {			
				logger.info("sql문 확인 : " + sql);
			}
			return null;
		}
		
		@Override
		public Object call(Map<String, Object> param, ColumnVO column) {
			String sql = param.get("sql").toString();
			String sqltype = param.get("sqlType").toString();
			if("selectOne".equals(sql)) {
				return session.selectOne(sqltype,column);
			}
			else if("insert".equals(sql)) {
				return session.insert(sqltype,column);
			}
			else if("update".equals(sql)) {
				return session.update(sqltype,column);
			}
			else if("selectList".equals(sql)) {
				return session.selectList(sqltype,column);
			}
			else if("delete".equals(sql)) {
				return session.delete(sqltype,column);
			}
			else {			
				logger.info("sql문 확인 : " + sql);
			}
			return null;
		}
		
		@Override
		public Object call(Map<String, Object> param, ProductVO product) {
			String sql = param.get("sql").toString();
			String sqltype = param.get("sqlType").toString();
			if("selectOne".equals(sql)) {
				return session.selectOne(sqltype,product);
			}
			else if("insert".equals(sql)) {
				return session.insert(sqltype,product);
			}
			else if("update".equals(sql)) {
				return session.update(sqltype,product);
			}
			else if("selectList".equals(sql)) {
				return session.selectList(sqltype,product);
			}
			else if("delete".equals(sql)) {
				return session.delete(sqltype,product);
			}
			else {			
				logger.info("sql문 확인 : " + sql);
			}
			return null;
		}		
		
		@Override
		public void createTempKey(UserVO user) {
			session.selectList("user.createmail",user);
		}
		@Override
		public Object call(Map<String, Object> param, ReviewVO review) {
			String sql = param.get("sql").toString();
			String sqltype = param.get("sqlType").toString();
			if("selectOne".equals(sql)) {
				return session.selectOne(sqltype,review);
			}
			else if("insert".equals(sql)) {
				return session.insert(sqltype,review);
			}
			else if("update".equals(sql)) {
				return session.update(sqltype,review);
			}
			else if("selectList".equals(sql)) {
				return session.selectList(sqltype,review);
			}
			else if("delete".equals(sql)) {
				return session.delete(sqltype,review);
			}
			else {			
				logger.info("sql문 확인 : " + sql);
			}
			return null;
		}
		@Override
		public Object call(Map<String, Object> param, BoardVO board) {
			String sql = param.get("sql").toString();
			String sqltype = param.get("sqlType").toString();
			if("selectOne".equals(sql)) {
				return session.selectOne(sqltype,board);
			}
			else if("insert".equals(sql)) {
				return session.insert(sqltype,board);
			}
			else if("update".equals(sql)) {
				return session.update(sqltype,board);
			}
			else if("selectList".equals(sql)) {
				return session.selectList(sqltype,board);
			}
			else if("delete".equals(sql)) {
				return session.delete(sqltype,board);
			}
			else {			
				logger.info("sql문 확인 : " + sql);
			}
			return null;
		}
		@Override
		public Object call(Map<String, Object> param, CommentVO comment) {
			String sql = param.get("sql").toString();
			String sqltype = param.get("sqlType").toString();
			if("selectOne".equals(sql)) {
				return session.selectOne(sqltype,comment);
			}
			else if("insert".equals(sql)) {
				return session.insert(sqltype,comment);
			}
			else if("update".equals(sql)) {
				return session.update(sqltype,comment);
			}
			else if("selectList".equals(sql)) {
				return session.selectList(sqltype,comment);
			}
			else if("delete".equals(sql)) {
				return session.delete(sqltype,comment);
			}
			else {			
				logger.info("sql문 확인 : " + sql);
			}
			return null;
		}	


}
