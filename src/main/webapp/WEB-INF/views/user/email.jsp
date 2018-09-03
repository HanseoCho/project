<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/login.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js"></script>     
 <script>
 	$(function(){
 		var id = $("#cid").val();
 		var key = $("#ckey").val();
 		if(id != null & key != null ){
			$(".textdiv p").eq(0).text("");
			$(".textdiv p").eq(1).text("");
 			$.ajax({method:"put",url:"/email/"+id+"/key/"+key})
 			.done(function(data,test,xhr){
 				if(xhr.status == 200){
 					alert("인증성공");
 					$(".textdiv p").eq(0).text(data.id+"님 인증에 성공하셨습니다.");
 					$(".textdiv p").eq(1).text("다시 로그인을 해주세요.");			
 				}
 				else if(xhr.status == 202){
 					alert("잘못된 URI입니다. \n다시 시도해주세요")
 					location.href="/project"
 				}
 			})
 		}
 	})
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
    <div style="height: 20000px;" class="wrap"> 
        <div id="sidebar" class="fl fl_col">
            <ul>
            	<li>인기상품</li>
            </ul>
        </div>  
        <div class="login sbody">
        	<c:if test="${!empty user}">
        		<input type="hidden" id="cid" value="${user.id}">
        		<input type="hidden" id="ckey" value="${user.key}">
        	</c:if>
            <div class="fl fl_col textdiv" style="position: absolute; left: 35%; text-align: center;">
            	<%-- 
            	${sessionScope}1 : 전체확인
            	${sessionScope.sessionScope.no}2 : 값에 접근할때 
            	--%>
            	<p style="font-size: 0.9em;">이메일로 인증 이메일이 전송되었습니다.</p>
            	<p style="font-size: 0.9em;">확인후 이용해주세요</p>
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