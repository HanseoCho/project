package com.java.project.service;

import java.io.Console;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.java.project.DAO.DaoInterface;
import com.java.project.Interface.UserServiceInterface;
import com.java.project.Util.MapUtil;
import com.java.project.mail.MailHandler;
import com.java.project.mail.TempKey;
import com.java.project.vo.UserVO;

@Service
public class UserService implements UserServiceInterface {
	@Inject
	DaoInterface di;
	
	@Inject
	private JavaMailSender mailSender;
	
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);	
	@Override
	public String selectid(UserVO user) {
		try {
			Map<String, Object> param = MapUtil.makeParam("selectOne", "user.selectId");
			return di.call(param,user) == null?"비중복":"중복";
		}
		catch (Exception e) {
			logger.info("selectid메소드 문제발생");
			e.printStackTrace();
			return "error";
		}
	}
	
	@Override
	public ResponseEntity<HashMap<String, Object>> matchKey(UserVO user) throws Exception {
		Map<String, Object> param = MapUtil.makeParam("selectOne", "user.selectId");
		if(di.call(param, user) == null) {
			logger.info("matchKey - userId 없음");
			logger.info(user.toString());
			HashMap<String, Object> map = user.parseMap();
			return  new ResponseEntity<HashMap<String, Object>>(map, HttpStatus.ACCEPTED);
		}
		else {
			logger.info("matchKey - userId 존재");
			UserVO user2 = (UserVO) di.call(param, user);
			logger.info(user2.toString());
			param = MapUtil.makeParam("update", "user.yesKey");
			di.call(param, user);
			HashMap<String, Object> map = user2.parseMap();
			return  new ResponseEntity<HashMap<String, Object>>(map, HttpStatus.OK);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<String> insert(UserVO user) {
		user.insertDb(); //분활된 값들 합쳐주기, 이메일 폰 생일
		try {
			if(idPattern(user)==false) {
				return  new ResponseEntity<String>("아이디를 규칙에 맞게 다시 입력해주세요", HttpStatus.ACCEPTED);
			}
			if(!selectid(user).equals("비중복")) {
				return  new ResponseEntity<String>("중복된 아이디입니다.", HttpStatus.ACCEPTED);
			};
			if(user.checkPw()==false) {
				return  new ResponseEntity<String>("비밀번호를 확인해주세요", HttpStatus.ACCEPTED);
			}
			Map<String, Object> param = MapUtil.makeParam("insert", "user.insert");
			user.setKey();
			di.call(param, user);
			
			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("[HanS:hop 이메일 인증]");
			sendMail.setText(
					//new StringBuffer().append("<h1>메일인증</h1>").append("<a href='http://localhost/user/").append(user.getEmail()).append("&key=").append(user.getKey()).append("' target='_blenk'>이메일 인증 확인</a>").toString());
					new StringBuffer().append("<div style='border:1px solid black; text-align:center;'><h1>메일인증</h1><h3>안녕하세요\nHanS:hop에 계속 가입하실려면 아래 링크를 눌러주세요.</h3>").append("<a href='http://gudi.iptime.org:11100/email/"+user.getId()+"/key/"+user.getKey()).append("' target='_blenk'>이메일 인증 확인</a></div>").toString());
			sendMail.setFrom("trullo393@gmail.com", "HanS:hop");
			sendMail.setTo(user.getEmail());
			sendMail.send();			
			return  new ResponseEntity<String>("이메일발송", HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			return  new ResponseEntity<String>("가입실패", HttpStatus.ACCEPTED);
		}

	}
	@Override
	public ResponseEntity<String> update(HttpServletRequest req,UserVO user) {
		Map<String, Object> param = MapUtil.makeParam("update", "user.update");
		user.insertDb();
		if(user.checkPw()==false) {
			return  new ResponseEntity<String>("비밀번호를 확인해주세요", HttpStatus.ACCEPTED);
		}
		try{
			di.call(param, user);
			param = MapUtil.makeParam("selectOne", "user.login");
			HttpSession session = req.getSession();
			UserVO user2 = (UserVO) di.call(param, user);
			session.removeAttribute("sessionScope");
			session.setAttribute("sessionScope", user2.parseMap());
			session.setMaxInactiveInterval(60*30); //60초 * 30
			return new ResponseEntity<String>("회원정보 수정성공",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("회원정보 수정실패",HttpStatus.ACCEPTED);
		}
	}
	@Override
	public ResponseEntity<String> delete(HttpServletRequest req,UserVO user) {
		Map<String, Object> param = MapUtil.makeParam("update", "user.delete");
		HttpSession session = req.getSession();
		try{
			di.call(param, user);
			session.removeAttribute("sessionScope");
			return new ResponseEntity<String>("회원정보 삭제성공",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("회워정보 삭제실패",HttpStatus.ACCEPTED);
		} 
	}
	
	public boolean idPattern(UserVO user) {
    	if(user.getId().length()<4){
    		return false;
    	}
    	else if(user.getId().matches("(.*[!,@,#,$,%,^,&,*,?,_,~,-].*)")){
    		return false;
    	}else if(user.getId().matches("(.*[가-힣|ㄱ-ㅎ].*)")){
    		return false;
    	}
    	return true;
	}

	@Override
	public ResponseEntity<String> findId(UserVO user) {
		//왜 user.email로 하면 안되고 user.email1로하면 잘될까?? 잘못된부분이 있으니 그럼 넘어가는 값을 최종전인 dao에서 확인하자
		HashMap<String, Object> param = (HashMap<String, Object>) MapUtil.makeParam("selectOne", "user.findsId");
		user.replaceEmail();
		if(di.call(param,user) == null) {
			return new ResponseEntity<String>("잘못된 이메일입니다.",HttpStatus.ACCEPTED);
		}
		else {
			UserVO user2 = (UserVO) di.call(param,user);
			return new ResponseEntity<String>(user2.getId(),HttpStatus.OK);
		}
	}
	@Override
	public ResponseEntity<String> findPw(UserVO user) {
		Map<String, Object> param = MapUtil.makeParam("selectOne", "user.findsPw");
		user.replaceEmail();
		System.out.println(user.toString());
		if(di.call(param,user) == null) {
			return new ResponseEntity<String>("이메일과 아이디를 확인해주세요.",HttpStatus.ACCEPTED);
		}
		else {
			//비밀번호 만들어주기 패턴 Hanshop 숫자 6개 특수문자3개 
			Random random = new Random();
			String password ="hanshop"; 
			String[] sign = {"!","@","#","$","%","^","&","*","?","_","~","-"}; 
			for(int i=0;i<9;i++) {
				if(i<6) {
					System.out.println(1);
					password = password.concat(String.valueOf(random.nextInt(10)));
				}
				else {
					System.out.println(2);
					password = password.concat(sign[random.nextInt(12)]);
				}
			}
			user.setPw(password);
			param = MapUtil.makeParam("update", "user.changePw");
			di.call(param, user);
			try {			
			MailHandler sendMail = new MailHandler(mailSender);

			sendMail.setSubject("[HanS:hop 비밀번호찾기]");
			sendMail.setText(
					new StringBuffer().append("<div style='border:1px solid black; text-align:center;'><h1>[HanS:hop]</h1><h3>안녕하세요 HanS:hop입니다<br> 예비 비밀번호는"+password+"입니다</h3>").toString());
			sendMail.setFrom("trullo393@gmail.com", "HanS:hop");
			sendMail.setTo(user.getEmail1());
			sendMail.send();
			
			return new ResponseEntity<String>("해당 이메일로 예비 비밀번호가 전송되었습니다.",HttpStatus.OK);
			}
			catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<String>("이메일을 다시 확인해주세요.",HttpStatus.OK);
			}
		}
	}

	@Override
	public ResponseEntity<String> setSession(UserVO user, HttpServletRequest req) {
		//로그인이니 db확인 필수
		System.out.println(1);
		Map<String, Object> param = MapUtil.makeParam("selectOne", "user.login");
		HttpSession session = req.getSession();
		user.insertDb();
		if(di.call(param, user) == null) {
			return new ResponseEntity<String>("아이디와 패스워드를 다시 확인해주세요.",HttpStatus.ACCEPTED);
		}
		else {
			UserVO user2 = (UserVO) di.call(param, user);
			if(user2.getKickYn().equals("Y")){
				return new ResponseEntity<String>("운영자에 의해 차단되었습니다",HttpStatus.ACCEPTED);
			};
			try {
				session.removeAttribute("sessionScope");
				session.setAttribute("sessionScope", user2.parseMap());
				session.setMaxInactiveInterval(60*30); //60초 * 30
				System.out.println(1);
				return new ResponseEntity<String>("로그인 성공",HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<String>("로그인중 문제 발생",HttpStatus.ACCEPTED);
			}
		}
	}

	@Override
	public ResponseEntity<String> outSession(UserVO user, HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.removeAttribute("sessionScope");
		return new ResponseEntity<String>("로그아웃 성공",HttpStatus.OK);
	}
	@Override
	public ResponseEntity<HashMap<String, Object>> allList(){
		try {
			Map<String, Object> param = MapUtil.makeParam("selectList", "user.allList");
			HashMap<String, Object> result = new HashMap<String,Object>();
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
			List<HashMap<String, Object>> list =(List<HashMap<String, Object>>) di.call(param); 
			for(int i=0;i<list.size();i++) {
				HashMap<String, Object> map =list.get(i);
				map.put("joinDate",f.format(map.get("joinDate")));
				list.set(i, map);
			}
			result.put("result",list);				
			return new ResponseEntity<HashMap<String,Object>> (result,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<HashMap<String,Object>> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public ResponseEntity<String> kickUser(UserVO user) {
		HashMap<String, Object> param = (HashMap<String, Object>) MapUtil.makeParam("update", "user.kickUser");
		try {
			di.call(param,user);
			return new ResponseEntity<String>("차단 성공",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("차단 실패",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public ResponseEntity<String> rollUser(UserVO user) {
		HashMap<String, Object> param = (HashMap<String, Object>) MapUtil.makeParam("update", "user.rollUser");
		try {
			di.call(param,user);
			return new ResponseEntity<String>("차단해제 성공",HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("차단해제 실패",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
