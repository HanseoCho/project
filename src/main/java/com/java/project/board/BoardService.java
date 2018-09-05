package com.java.project.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.java.project.DAO.DaoInterface;
import com.java.project.Util.Criteria;
import com.java.project.Util.MapUtil;
import com.java.project.vo.BoardVO;
import com.java.project.vo.CommentVO;
import com.java.project.vo.UserVO;
@Service
public class BoardService implements BoardServiceInterface {
	@Inject
	DaoInterface di;
	@Override
	public ResponseEntity<String> insertBoard(BoardVO board) {
		try {
			System.out.println(board.toString());
			Map<String, Object> param = MapUtil.makeParam("insert", "board.insert");
			di.call(param, board);
			return new ResponseEntity<String>("글작성 완료", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("글작성 실패", HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
	@Override
	public ResponseEntity<String> updateBoard(BoardVO board) {
		try {
			System.out.println(board.toString());
			Map<String, Object> param = MapUtil.makeParam("update", "board.update");
			di.call(param, board);
			return new ResponseEntity<String>("글수정 완료", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("글수정 실패", HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
	@Override
	public ResponseEntity<String> deleteBoard(HttpServletRequest req,int no) {
		try {
			Map<String, Object> param = MapUtil.makeParam("update", "board.delete");
			param.put("boardNo", no);
			
			HttpSession session = req.getSession();
			di.call(param);
			return new ResponseEntity<String>("글삭제 완료", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("글삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}	
	@Override
	public ResponseEntity<HashMap<String, Object>> typeBoardSelect(BoardVO board, Criteria criteria) {
		HashMap<String, Object> result = new HashMap<String,Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Map<String, Object> param = MapUtil.makeParam("selectList", "board.selectTypeList");
		board.changeTypeString();
		param.put("startPage", (criteria.getPage()-1)*10);
		param.put("endPage", 10);
		param.put("type", board.getType());
		System.out.println(param);
		try {
			list = (List<HashMap<String, Object>>) di.call(param);
			SimpleDateFormat d = new SimpleDateFormat("yyyy.MM.dd");
			for(int i=0;i<list.size();i++) {
				HashMap<String, Object> parser = list.get(i);
				parser.put("date", d.format(list.get(i).get("date")));
				list.set(i, parser);
			}			
			System.out.println(list);
			result.put("result", list);
			param = MapUtil.makeParam("selectOne", "board.selectTypeCount");
			param.put("type", board.getType());
			criteria.setCriteria((int)di.call(param), 10);
			result.put("js",criteria.parserTypeJs(board.getType()));
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@Override
	public ResponseEntity<HashMap<String, Object>> searchBoardSelect(BoardVO board, Criteria criteria){
		HashMap<String, Object> result = new HashMap<String,Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Map<String, Object> param = new HashMap<>();
		if(board.getHead().equals("subcon")) {
			param = MapUtil.makeParam("selectList", "board.searchList2");
		}
		else {
			param = MapUtil.makeParam("selectList", "board.searchList");
		}
		board.changeTypeString();
		param.put("startPage", (criteria.getPage()-1)*10);
		param.put("endPage", 10);
		param.put("type", board.getType());
		param.put("head", board.getHead());
		param.put("body", board.getBody());
		try {
			list = (List<HashMap<String, Object>>) di.call(param);
			SimpleDateFormat d = new SimpleDateFormat("yyyy.MM.dd");
			for(int i=0;i<list.size();i++) {
				HashMap<String, Object> parser = list.get(i);
				parser.put("date", d.format(list.get(i).get("date")));
				list.set(i, parser);
			}			
			result.put("result", list);
			if(board.getHead().equals("subcon")) {
				param = MapUtil.makeParam("selectOne", "board.searchCount2");
			}
			else {
				param = MapUtil.makeParam("selectOne", "board.searchCount");
			}
			param.put("type", board.getType());
			param.put("head", board.getHead());
			param.put("body", board.getBody());
			criteria.setCriteria((int)di.call(param), 10);
			result.put("js",criteria.parserTypeJs(board.getType()));
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@Override
	public ResponseEntity<HashMap<String, Object>> boardDetail(BoardVO board) {
		try {
			HashMap<String, Object> result = new HashMap<String,Object>();
			Map<String, Object> param = MapUtil.makeParam("selectOne", "board.detailSelect");
			result = (HashMap<String, Object>) di.call(param,board);
			SimpleDateFormat d = new SimpleDateFormat("yyyy.MM.dd");
			result.put("date",d.format(result.get("date")));
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@Override
	public ResponseEntity<HashMap<String, Object>> getComment(CommentVO comment) {
		try {
			HashMap<String, Object> result = new HashMap<String,Object>();
			Map<String, Object> param = MapUtil.makeParam("selectList", "board.commentSelect");
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) di.call(param, comment);
			//result = (HashMap<String, Object>) di.call(param,board);
			
			SimpleDateFormat d = new SimpleDateFormat("yyyy.MM.dd");
			for(int i=0;i<list.size();i++) {
				HashMap<String, Object> parser = list.get(i);
				parser.put("date", d.format(list.get(i).get("date")));
				list.set(i, parser);
			}
			result.put("result", list);
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@Override
	public ResponseEntity<String> delComment(CommentVO comment) {
		try {
			HashMap<String, Object> result = new HashMap<String,Object>();
			Map<String, Object> param = MapUtil.makeParam("update", "board.delCom");
			di.call(param, comment);
			return new ResponseEntity<String> ("댓글삭제 성공",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String> ("댓글삭제 실패",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}	
	@Override
	public ResponseEntity<String> insertComment(CommentVO comment) {
		try {
			System.out.println(comment.toString());
			Map<String, Object> param = MapUtil.makeParam("insert", "board.commentInsert");
			di.call(param, comment);
			return new ResponseEntity<String>("댓글작성 완료", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("댓글작성 실패", HttpStatus.INTERNAL_SERVER_ERROR);			
		}
	}
	@Override
	public ResponseEntity<HashMap<String, Object>> getCommentCount() {
		try {
			HashMap<String, Object> result = new HashMap<String,Object>();
			Map<String, Object> param = MapUtil.makeParam("selectList", "board.commentCount");
			List<HashMap<String, Object>> list = new ArrayList<>();
			list = (List<HashMap<String, Object>>) di.call(param);
			result.put("result",list);
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
