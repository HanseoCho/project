package com.java.project.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java.project.Interface.UserServiceInterface;
import com.java.project.Util.Criteria;
import com.java.project.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Inject
	UserServiceInterface usi;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	//테스트용 폐이지 이동
	@RequestMapping(value = "/move/{page}", method = RequestMethod.GET)
	public String home2(@PathVariable("page") String page) {
		System.out.println(page);
		return page;
	}	
	
	//회원가입 이동
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String moveRegist() {
		return "user/join";
	}
	//로그인 이동
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String movelogin() {
		return "user/login";
	}	

	//회원가입인증
	@RequestMapping(value="/email",method=RequestMethod.GET)	
	public ModelAndView joinCertification(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/user/email");
		return mv;
	}				
	
	//회원가입인증
	@RequestMapping(value="/email/{id}/key/{key}",method=RequestMethod.GET)	
	public ModelAndView joinCertification2(UserVO user) throws Throwable{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/user/email");
		mv.addObject("user",user.parseMap());
		return mv;
	}	
	
	@RequestMapping(value="/find/{key}",method=RequestMethod.GET)	
	public ModelAndView findBoard(@PathVariable("key") String key) throws Throwable{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/user/find");
		mv.addObject("key",key);
		return mv;
	}	
	@RequestMapping(value="/mypage",method=RequestMethod.GET)	
	public ModelAndView mypage(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/user/mypage");
		return mv;
	}
	@RequestMapping(value="/admin",method=RequestMethod.GET)	
	public ModelAndView admin(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/admin/management");
		return mv;
	}			

	@RequestMapping("/test3")
	public String test3(RedirectAttributes redirectAttributes) {
		Criteria cri = new Criteria();
		cri.setPage(11);
		cri.setCriteria(380,30);
		System.out.println(cri.parserJs());
		return null;
	}
	@RequestMapping("/test4")
	public ModelAndView test4(@RequestParam(value="test", defaultValue="null") String test) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("test");
		if(!test.equals("null")) {
			mv.addObject("test",test);			
		}
		return mv;
	}	
	@RequestMapping("/chat")
	public String moveChat() {
		return "/chat/chat";
	}
}
