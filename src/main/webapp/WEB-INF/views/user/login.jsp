<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/login.css?ver=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="/js/main.js"></script>     
<script>
$(function(){
	$("#findId").on("click",function(){
		window.open("/find/id", "아이디찾기", "width=500, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes");  
	})
	$("#findPw").on("click",function(){
		window.open("/find/pw", "아이디찾기", "width=500, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
	})	
	$(".loginSubmit").on("click",function(){
		$.ajax({method:"post",url:"/session",data:{"id":$("#lid").val(),"pw":$("#lpw").val()}})
		.done(function(data,test,xhr){
			if(xhr.status == 200){
				alert(data)
				location.href="/"
			}
			else if(xhr.status == 202){
				alert(data)
				location.reload();
			}
			else{
				console.log(data);
			}
		})
	});
	
    $(".loginReg").on("click",function(){
    	location.href="/join"
    })
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
                <!-- <li class="headerli">CHAT</li> -->
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
    <div style="height: 90vh;" class="wrap"> 
        <div id="sidebar" class="fl fl_col">
            <ul>
            	<li>인기상품</li>
            </ul>
        </div>  
        <div class="login sbody">
            <div class="fl fl_col" style="position: absolute; left: 35%;">
                <div class="infoarea_f2">Login or Create</div>
                <div><input id="lid" type="text" class="inputText" placeholder="ID"></div>
                <div><input id="lpw" type="password" class="inputText" placeholder="PASSWORD"></div>
                <div class="fl fl_row minibar" style="font-size: 0.6em;">
                	<div style="text-align: right; width:100%;"><span style="margin-right: 10px;border: 1px 3px;" id="findId">아이디찾기</span><span style="border: 1px 3px;" id="findPw">비밀번호찾기</span></div>
                </div>
                <div class="loginSubmit"><span>LOGIN</span></div>
                <div class="loginReg"><span>JOIN US</span></div>
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