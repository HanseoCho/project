<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js?var=2"></script> 
<style>
#boardSidebar ul li:hover{
	cursor: pointer;
}
</style>
<script>
var list = []
$(function(){
	//글쓰기버튼 이벤트
	$(".underBox #write").on("click",function(e){
		event.preventDefault();
		location.href="/board/write"
	})
	//댓글숫자를 보여주기위해 ajax
	$.ajax({method:"get",url:"/comment/count"})
	.done(function(data,test,xhr){
		if(xhr.status==200){
			list = data;
		}
		else if(xhr.status==202){
			console.log("202Error발생");
		}
		else if(xhr.status==500){
			console.log("500Error발생");
		}
		else{
			console.log("예상못한 오류발생")	
		}
	})
	
	//화면을 가져오는 부분
	var qs = getQueryStringObject();
 	if(qs.page ==null){
		qs.page = 1;
	}

	if(qs.type ==null){
		qs.type = "notice";
	}
	console.log(page);
	for(var i=0;i<$("#boardSidebar ul li").length;i++){
		var type2 = qs.type=="Q_A"?"Q&A":qs.type;
		if($("#boardSidebar ul li").eq(i).text()==type2){
			$("#boardSidebar ul li").eq(i).css("font-weight","bold");
		}
	}	 
	if(qs.head){
		$("#boardSidebar ul li").eq(0).css("font-weight","bold");
		$.ajax({method:"get",url:"/board/"+qs.head+"/"+qs.body+"/"+qs.type+"/"+qs.page})
		.done(function(data,test,xhr){
			console.log(data,test,xhr);
			if(xhr.status ==200){
				dataViewProcessing(data);
			}
			else if(xhr.status ==202){
				console.log("202에러");
			}
			else if(xhr.status ==500){
				console.log("500에러");
			}
			else{
				console.log("이상한 에러")
			}
		});
	}
	else{
		
		$.ajax({method:"get",url:"/board/"+qs.type+"/"+qs.page})
		.done(function(data,test,xhr){
			console.log(data,test,xhr);
			if(xhr.status ==200){
				dataViewProcessing(data);
			}
			else if(xhr.status == 202){
				console.log("202Error 서버처리중 문제가 발생하였습니다.");
			}
			else if(xhr.status == 500){
				console.log("500Error 서버에서 문제가 발생하였습니다.");
			}else{
				console.log("이상한Error")
			}
		});
	}
	
	//왼쪽 버튼들에게 이동이벤트 부여
	$("#boardSearch").on("click",function(){
		var txt = qs.type
		if(txt == "Q&A"){
			txt = "Q_A";
		}
		location.href="?head="+$(".search_").eq(0).val()+"&body="+$(".search_").eq(1).val()+"&type="+txt+"&page=1"
	})
})
function dataViewProcessing(data){
	$(".border").empty();
	var html = '<div class="fl fl_row borderRow borderTc"><div class="rowNoH">NO</div><div class="rowSubjectH">SUBJECT</div><div class="rowNameH">NAME</div><div class="rowDateH">DATE</div></div>'
	$(".border").append(html);
	for(var i=0;i<data.result.length;i++){
		var result = data.result[i];
		var check = -1;
		for(j=0;j<list.result.length;j++){
			if(result.boardNo == list.result[j].boardNo){
				check=j;
			}
		}
		html = ""
		html += '<div class="fl fl_row borderRow">'
		html += '<div class="rowNoH borderTc">'+result.num+'</div>';
		if(check>=0){
			html += '<div class="rowSubjectH"><a href="/board/'+result.boardNo+'">'+result.subject+'   ('+list.result[check].count+')</a></div>';
		}else{
			html += '<div class="rowSubjectH"><a href="/board/'+result.boardNo+'">'+result.subject+'</a></div>';
		}
		html += '<div class="rowNameH borderTc">'+result.name+'</div>';
		html += '<div class="rowDateH borderTc">'+result.date+'</div>';
		html += '</div>';
		console.log(html);
		$(".border").append(html);
	}
	$(".border").append("</div>");
	for(var j=0;j<data.js.length;j++){
		$(".underBox #page").append(data.js[j]);
	}
}
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
    <div style="height:50vh;" class="wrap"> 
        <div id="boardSidebar" class="fl fl_col">
            <ul>
                <li>NOTICE</li>
                <li>Q&A</li>
                <li>REVIEW</li>
            </ul>
        </div>  
        <div class="boardBody" style="">
            <div class="fl fl_col border">
<!--                 <div class="fl fl_row borderRow borderTc">
                    <div class="rowNoH">NO</div>
                    <div class="rowSubjectH">SUBJECT</div>
                    <div class="rowNameH">NAME</div>
                    <div class="rowDateH">DATE</div>
                </div>
                <div class="fl fl_row borderRow">
                    <div class="rowNoH borderTc">1</div>
                    <div class="rowSubjectH">개인정보보호방침 변경에 따른 공지사항</div>
                    <div class="rowNameH borderTc">NAME</div>
                    <div class="rowDateH borderTc">2018.08.16</div>
                </div>  
                <div class="fl fl_row borderRow">
                    <div class="rowNoH borderTc">1</div>
                    <div class="rowSubjectH">개인정보보호방침 변경에 따른 공지사항</div>
                    <div class="rowNameH borderTc">NAME</div>
                    <div class="rowDateH borderTc">2018.08.16</div>
                </div>  
                <div class="fl fl_row borderRow">
                    <div class="rowNoH borderTc">1</div>
                    <div class="rowSubjectH">개인정보보호방침 변경에 따른 공지사항</div>
                    <div class="rowNameH borderTc">NAME</div>
                    <div class="rowDateH borderTc">2018.08.16</div>
                </div>  
                <div class="fl fl_row borderRow">
                    <div class="rowNoH borderTc">1</div>
                    <div class="rowSubjectH">개인정보보호방침 변경에 따른 공지사항</div>
                    <div class="rowNameH borderTc">NAME</div>
                    <div class="rowDateH borderTc">2018.08.16</div>
                </div>  
                <div class="fl fl_row borderRow">
                    <div class="rowNoH borderTc">1</div>
                    <div class="rowSubjectH">개인정보보호방침 변경에 따른 공지사항</div>
                    <div class="rowNameH borderTc">NAME</div>
                    <div class="rowDateH borderTc">2018.08.16</div>
                </div>   -->                
            </div>        
            <div class="underBox" style="position: relative;">
                <span id="page"></span><a style="position: absolute; right: 40px;cursor: pointer;" id="write"><span>글쓰기</span></a>
            </div>
            <div style="font-size: 0.8em;">
                <span style="font-size: 0.01em; position: relative;bottom: 2px;">▷</span>검색어
                <select class="search_">
                	<option value="subject">제목</option>
                	<option value="content">내용</option>
                	<option value="subcon">제목+내용</option>
                	<option value="name">작성자</option>
                </select> 
                <input class="search_" type="search">
                <input id="boardSearch" type="button" value="찾기">
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