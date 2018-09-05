package com.java.project.board;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;

import com.java.project.Util.Criteria;
import com.java.project.vo.BoardVO;
import com.java.project.vo.CommentVO;

public interface BoardServiceInterface {
	ResponseEntity<String> insertBoard(BoardVO board);
	ResponseEntity<String> updateBoard(BoardVO board);
	ResponseEntity<String> deleteBoard(HttpServletRequest req,int no);
	ResponseEntity<HashMap<String, Object>> typeBoardSelect(BoardVO board,Criteria criteria);
	ResponseEntity<HashMap<String, Object>> searchBoardSelect(BoardVO board, Criteria criteria);
	ResponseEntity<HashMap<String, Object>> boardDetail(BoardVO board);
	ResponseEntity<HashMap<String, Object>> getComment(CommentVO comment);
	ResponseEntity<String> insertComment(CommentVO comment);
	ResponseEntity<HashMap<String, Object>> getCommentCount();
	ResponseEntity<String> delComment(CommentVO comment);
}
