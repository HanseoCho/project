<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css?var=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="/js/main.js?var=6"></script>
<style>
div.box{
}
div.box:hover{
	cursor: pointer;
}
.itemVal:hover{
	cursor: pointer;
	background-color: black;
	color: white;
}

</style>
<script>
var saveData = {}
$(function(){
	var qs = getQueryStringObject();
	var page;
	var division;
	
	if(qs.page ==null){
		page = 1;
	}
	else{
		page = qs.page;
	}
	if(qs.division ==null){
		division = null;
	}
	else{
		division = qs.division;
	}
	for(var i=0;i<$("#sidebar ul li").length;i++){
		if($("#sidebar ul li").eq(i).text()==division){
			$("#sidebar ul li").eq(i).css("font-weight","bold");
		}
	}	
	console.log(page);
	if(!division){
		$.ajax({method:"get",url:"/list/"+page})
		.done(function(data,test,xhr){
			console.log(data,test,xhr);
			if(xhr.status ==200){
				saveData=data
				console.log(data.result);
				setProductData(data,10,4,$(".sbody"));
				setProductPagin(data,$(".sbody"));
			}
			else if(xhr.status == 202){
				console.log("202Error 서버처리중 문제가 발생하였습니다.");
			}
			else if(xhr.status == 500){
				console.log("500Error 서버에서 문제가 발생하였습니다.");
			}
		});
	}
	else{
		$.ajax({method:"get",url:"/list/"+division+"/"+page})
		.done(function(data,test,xhr){
			console.log(data,test,xhr);
			if(xhr.status ==200){
				saveData = data
				console.log(data.result);
				setProductData(data,10,4,$(".sbody"));
				setProductPagin(data,$(".sbody"));
			}
			else if(xhr.status == 202){
				console.log("202Error 서버처리중 문제가 발생하였습니다.");
			}
			else if(xhr.status == 500){
				console.log("500Error 서버에서 문제가 발생하였습니다.");
			}
		});
	}
	function boxClick(){
		$("div.box").on("click",function(){
			location.href="/list/product/"+$(this).children("input[type=hidden]").val()
		})
	}
	
	$(".itemVal").on("click",function(){
		setProductData(saveData,10,$(this).text(),$(".sbody"));
		setProductPagin(saveData,$(".sbody"));
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
    <div style=";" class="wrap"> 
        <div id="sidebar" class="fl fl_col">
            <ul>
            	<li>인기상품</li>
            </ul>
        </div>  
        <div class="itemSort fl fl_row" style="position:absolute;right: 16%;top: 15%;">
        	<div class="itemVal" style="border: 1px solid black;padding: 5px 5px;">2</div>
        	<div class="itemVal" style="border: 1px solid black;padding: 5px 5px;">3</div>
        	<div class="itemVal" style="border: 1px solid black;padding: 5px 5px;">4</div>
            <div class="itemVal" style="border: 1px solid black;padding: 5px 5px;">5</div>
            <div class="itemVal" style="border: 1px solid black;padding: 5px 5px;">6</div>
        </div>
        <div class="sbody">
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