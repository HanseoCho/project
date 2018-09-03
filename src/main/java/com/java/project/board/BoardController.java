package com.java.project.board;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.java.project.Util.Criteria;
import com.java.project.vo.BoardVO;
import com.java.project.vo.CommentVO;

@Controller
public class BoardController {
	@Inject
	BoardServiceInterface bsi;
	@RequestMapping(value="/board",method=RequestMethod.GET)	
	public ModelAndView moveboard(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/board");
		return mv;
	}
	@RequestMapping(value="/about",method=RequestMethod.GET)	
	public ModelAndView moveabout(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/about");
		return mv;
	}	
	@RequestMapping(value="/board/write",method=RequestMethod.GET)	
	public ModelAndView movewrite(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/write");
		return mv;
	}	
	
	@ResponseBody
	@RequestMapping(value="/board/write",method=RequestMethod.POST)	
	public ResponseEntity<String> insertBoard(BoardVO board){
		return bsi.insertBoard(board);
	}
	@ResponseBody
	@RequestMapping(value="/board/update",method=RequestMethod.POST)	
	public ResponseEntity<String> updateBoard(BoardVO board){
		System.out.println(board.toString());
		return bsi.updateBoard(board);
	}	
	@ResponseBody
	@RequestMapping(value="/board/{type}/{page}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> typeBoardSelect(BoardVO board,Criteria criteria){
		return bsi.typeBoardSelect(board,criteria);
	}
	
	@ResponseBody
	@RequestMapping(value="/board/{head}/{body}/{type}/{page}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> searchBoardSelect(BoardVO board,Criteria criteria){
		System.out.println(board.toString());
		return bsi.searchBoardSelect(board,criteria);
	}
	
	@RequestMapping(value="/board/{no}",method=RequestMethod.GET)	
	public ModelAndView typeBoardSelect(@PathVariable("no") int no){
		ModelAndView mav = new ModelAndView();
		mav.addObject("no",no);
		mav.setViewName("/board/notice");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/board/{no}",method=RequestMethod.DELETE)	
	public ResponseEntity<String> deleteBoardSelect(HttpServletRequest req,@PathVariable("no") int no){
		return bsi.deleteBoard(req,no);
	}	
	@ResponseBody
	@RequestMapping(value="/board/detail/{no}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> typeBoardSelect(BoardVO board){
		return bsi.boardDetail(board);
	}
	
	
	@ResponseBody
	@RequestMapping(value="/comment/{boardNo}",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> getComment(CommentVO comment){
		return bsi.getComment(comment);
	}
	@ResponseBody
	@RequestMapping(value="/comment",method=RequestMethod.POST)	
	public ResponseEntity<String> insertComment(CommentVO comment){
		return bsi.insertComment(comment);
	}
	@ResponseBody
	@RequestMapping(value="/comment/count",method=RequestMethod.GET)	
	public ResponseEntity<HashMap<String, Object>> getCommentCount(){
		return bsi.getCommentCount();
	}
	
}
