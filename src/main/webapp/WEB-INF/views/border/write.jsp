<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/notice.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//cdn.ckeditor.com/4.10.0/standard/ckeditor.js"></script>
<script src="/js/main.js"></script>
<script>
    $(function(){
        CKEDITOR.replace( 'editor1',{
            width:"100%",
            height:500
        } );     
        /* CKEditor : http://zzznara2.tistory.com/443 이미지 업로드 참고*/
        
        $("#test").on("click",function(){
            /* CKEDITOR 내용가져오기*/
            console.log(CKEDITOR.instances.editor1.getData())
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
    <div style="" class="wrap"> 
        <div id="boardSidebar" class="fl fl_col">
            <ul>
                <li>NOTICE</li>
                <li>Q&A</li>
                <li>REVIEW</li>
            </ul>
        </div>  
        <div class="noticeBody">
        <form>
            <div class="fl fl_col" style="font-size: 0.8em;">
                <div class="fl fl_row" style="margin-bottom: 5px;">
                    <span style="width: 50px; margin: 2px 0 0 7px; font-weight: bold;">제목</span><input type="text" style="width: 100%;">
                </div>
                <div>
                    <span style="margin: 0 10px 0 6px; font-weight: bold;">비밀글</span> <input type="checkbox" style="position: relative; top: 2px;">
                </div>
                <div>
                    <textarea name="editor1" id="editor1" rows="10" cols="80">
                        This is my textarea to be replaced with CKEditor.
                    </textarea>
                </div>
                <div class="fl fl_row">
                    <div class="regBtn">작성</div><div class="regBtn">돌아가기</div>
                </div>
            </div>
        </form>
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