<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js?var=9"></script>  
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
   .eventBox{
       width: calc(100%/3);
       padding: 10px;
   }
   .boxs:hover{
   		cursor: pointer;
   }
</style>
<script>
$(function(){
	$.ajax({method:"get",url:"/eventbox"})
	.done(function(data,test,xhr){
		if(xhr.status==200){
			console.log(data);
			for(var i=0;i<data.result.length;i++){
				var result= data.result[i]
				$(".eventBoxs div .eventBox").eq(result.no-1).children("a").children("img").attr("src",result.url);
				$(".eventBoxs div .eventBox").eq(result.no-1).children("a").attr("href",result.location);
			}
		}
		else if(xhr.status==500){
			console.log("이상발생")
		}
	})
	$.ajax({method:"get",url:"/list/인기상품/1"})
	.done(function(data,test,xhr){
		if(xhr.status==200){
			console.log(data);
			setProductData(data,10,3,$(".hitItem"))
		}
		else{
			console.log(data);
		}
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
                <!-- <li class="headerli" id="test">CHAT</li> -->
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
    <div style="height: ;" class="wrap"> 
        <div id="sidebar" class="fl fl_col">
            <ul>
            	<li>인기상품</li>
            	<!-- 
                <li>OUTER</li>
                <li>SUIT</li>
                <li>TOP</li>
                <li>SHIRT</li>
                <li>KNIT</li>
                <li>BOTTOM</li>	
                <li>SHOES</li> 
                -->
            </ul>
        </div>
        <div id="slide">
            <img src="img/s1.jpg">
            <img src="img/s2.jpg" class="none">
            <img src="img/s3.jpg" class="none">
            <img src="img/s4.jpg" class="none">
            <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="position: relative;bottom: 50px;">
                <span class="w3-badge demo w3-border w3-transparent w3-hover-white sBtn w3-white"></span>
                <span class="w3-badge demo   w3-border w3-transparent w3-hover-white sBtn"></span>
                <span class="w3-badge demo w3-border w3-transparent w3-hover-white sBtn"></span>
                <span class="w3-badge demo w3-border w3-transparent w3-hover-white sBtn"></span>
             </div>
        </div>
        <div class="sbody" style="top:-250px;">
        	<hr>
        	<div class="eventBoxs fl fl_col">
        		<div class="fl fl_row" style="height:300px;">
        			<div class="eventBox">
                        <a href="#">
                            <img style="width: 100%; height: 100%;"  src="test.JPG">
                        </a>
                    </div>
                    <div class="eventBox">
                        <a href="#">
                            <img style="width: 100%; height: 100%;" src="test.JPG">
                        </a>
                    </div>
                    <div class="eventBox">
                        <a href="#">
                            <img style="width: 100%; height: 100%;" src="test.JPG">
                        </a>                    
                    </div>
        		</div>
        		<div class="fl fl_row" style="height:300px;">
        			<div class="eventBox">
                        <a href="#">
                            <img style="width: 100%; height: 100%;" src="test.JPG">
                        </a>
                    </div>
                    <div class="eventBox">
                        <a href="#">
                            <img style="width: 100%; height: 100%;" src="test.JPG">
                        </a>
                    </div>
                    <div class="eventBox">
                        <a href="#">
                            <img style="width: 100%; height: 100%;" src="test.JPG">
                        </a>                    
                    </div>
        		</div>
        	</div>
        	<h3>이달의 인기상품</h3>	
        	<div class="hitItem">
        	
        	</div>
        </div>
    </div>
    <div style="display:none; position: fixed;top: 85%; left: 90%;" class="updownBar">
        <div class="fl fl_col">
           <div><img id="imgUp" src="/img/up.png" style="width: 30px;"></div>            
           <div><img id="imgDown" src="/img/down.png" style="width: 30px;"></div>            
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