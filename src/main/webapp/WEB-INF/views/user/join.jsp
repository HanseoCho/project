<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/join.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js?ver=1"></script>        
<script src="/js/user/join.js"></script>
<style>
.regBtn:hover{
	cursor: pointer;
}
</style>
<script>

</script> 
</head>
<body>
    <header class="header fl fl_row">
        <div class="fl_gr2"><p id="mainBtn" class="fontBlock leftMt">HanS:hop</p></div>        
        <div class="fl_gr5">
            <ul class="fontBlock centerMt">
                <li class="headerli">ONLINE SHOP</li>
                <li class="headerli">ABOUT</li>
                <li class="headerli">Board</li>
                <li class="headerli">CHAT</li>
                <c:if test="${sessionScope.sessionScope.id eq 'admin'}">
                	<li class="headerli">ADMIN</li>
                </c:if>                
            </ul>
        </div>        
        <div class="fl_gr2 headerRightBar fontBlock rightMt" >
        	<c:choose>
	        	<c:when test="${empty sessionScope}">
		            <a>LOGIN</a>
		            <a>JOIN</a>
	            </c:when>
	            <c:otherwise>
	            	<a>LOGOUT</a>
		            <a>MYPAGE</a>	            	
	            </c:otherwise>
           	</c:choose>             
	            <a>장바구니</a>
        </div>         
    </header>
    <div class="wrap"> 
        <div id="sidebar" class="fl fl_col">
            <ul>
            	<li>인기상품</li>
            </ul>
        </div>  
        <div class="join">
            <div class="fl fl_col">
                <div>회원가입</div>
                <hr><br><br>
                <form name="joinForm">
                <div class="joinContainer fl fl_row"> 
                   <div class="fl fl_col fl_gr2" style="height: 40vh;">
                       <div class="joinId"><span class="joinId infoarea_f4 _tb">아이디</span></div>
                       <div class="joinPw"><span class="joinPw infoarea_f4 _tb">비밀번호</span></div>
                       <div class="joinPw2"><span class="joinPw2 infoarea_f4 _tb">비밀번호 확인</span></div>
                       <div class="joinName"><span class="joinName infoarea_f4 _tb">이름</span></div>
                       <div class="joinAdd"><span class="joinAdd infoarea_f4 _tb">주소</span></div>
                       <div class="joinTel" style="position: relative; top: 40px;"><span class="joinTel infoarea_f4 _tb">휴대전화</span></div>
                       <div class="joinEmail" style="position: relative; top: 40px;"><span class="joinEmail infoarea_f4 _tb">이메일</span></div>
                       <div class="joinBirthDay" style="position: relative; top: 40px;"><span class="joinBirthDay infoarea_f4 _tb">생년월일</span></div>
                   </div>
                   <div class="fl fl_col fl_gr8 joinRight">
                       <div class="joinId" ><input type="text" class="joinId" name="id"><span class="joinId joinInfo"> (영문/숫자,4자이상)</span></div>
                       <div class="joinPw" style="position: relative; bottom: 5px;"><input type="password" name="pw"><span class="joinInfo"> (영문/숫자/특수문자혼용,8자이상)</span></div>
                       <div class="joinPw2" style="position: relative; bottom: 5px;" ><input type="password" name="pw2"><span class="joinInfo"></span></div>
                       <div class="joinName" style="position: relative; bottom: 5px;"><input type="text" name="name"></div>
                       <div class="joinAdd" style="position: relative; bottom: 10px;">
                            <input type="text" id="sample2_postcode" name="address1" placeholder="우편번호">
                            <input type="button" id="daum_search" value="우편번호" style="background-color: white; font-size: 0.9em;width: 90px; height: 25px;"><br>
                            <input type="text" id="sample2_address" name="address2" style="width: 50%; margin: 2px 0; "><span class="joinInfo"> 기본주소</span><br>
                            <input type="text" id="closeAddress" name="address3" style="width: 50%; margin: 2px 0;"><span class="joinInfo"> 나머지주소</span>
                            <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
                            <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
                            <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1"  alt="닫기 버튼">
                            </div>
                       </div>
                       <br><br>
                       <div class="joinTel" style="position: relative; bottom: 10px;">
                           <select name="phone1">
                               <option>010</option>
                               <option>070</option>
                               <option>016</option>
                               <option>017</option>
                               <option>018</option>
                               <option>019</option>
                           </select>
                           -
                           <input type="text" name="phone2" style="width: 40px;"maxlength="4">
                           -
                           <input type="text" name="phone3" style="width: 40px;"maxlength="4">
                       </div>
                       <div class="joinEmail" style="position: relative; bottom: 10px;"><input type="text" name="email1" style="width: 120px;"> @ <input type="text _tb" name="email2" style="width: 120px;" readonly="readonly"> 
                       <select id="emailSelect">
                           <option value="" >이메일 선택 -</option>
                           <option value="naver.com">naver.com</option>
                           <option value="daum.net">daum.net</option>
                           <option value="gmail.com">gmail.com</option>
                           <option>직접입력</option>
                       </select>
                       </div>
                       <div class="joinBirthDay" style="position: relative; bottom: 10px;">
                           <input type="text" style="width: 50px;" name="birthDay1" maxlength="4">년<input type="text" name="birthDay2" style="width: 30px;" maxlength="2">월<input type="text" name="birthDay3" style="width: 30px;" maxlength="2">일
                        </div>  
                   </div>
                </div>
                <div class="fl fl_row divBtnTool" style="position: relative; bottom: 10px;">
                    <div class="regSubmit regBtn">회원가입</div><div class="regCancel regBtn">회원가입 취소</div>
                </div>
                </form>
            </div>
        </div>
    </div>
    <footer style="height: 250px;" class="sbody">
        <div style="text-align: center; height: 80px;">
            <span class="footBar">HOME</span><span class="footBar">SHOP</span><span class="footBar">ABOUT</span><span class="footBar">BOARD</span>
        </div>
        <div style="text-align: center; height: 100px;">
            <span style="font-size: 0.9em;font-weight: 600;">010-7726-7244</span><br>
            <span style="font-size: 0.8em;">OPEN. AM 10:00 ~ PM 06:00 (mon-friday)</span><br>
            <span style="font-size: 0.8em;">LUNCH. PM 12:00 ~ PM 01:00</span><br>
            <span style="font-size: 0.8em;">BANKING. 기업은행 555-037102-01-000 (주)HanS:hop</span><br>     
        </div>
        <div style="text-align: center;">
            <a href="https://facebook.com"><img src="/img/facebook.png" style="width: 50px;"></a>
            <a href="https://www.instagram.com"><img src="/img/in.png" style="width: 50px;"></a>
            <a href="https://twitter.com/"><img src="/img/tw.png" style="width: 50px;"></a>
            <a href="https://www.kakaocorp.com/"><img src="/img/kakao.png" style="width: 50px;"></a>
        </div>
    </footer>    
</body>
</html>