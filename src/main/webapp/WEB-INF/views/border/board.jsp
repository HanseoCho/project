<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js"></script>        
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
        <div id="boardSidebar" class="fl fl_col">
            <ul>
                <li>NOTICE</li>
                <li>Q&A</li>
                <li>REVIEW</li>
            </ul>
        </div>  
        <div class="boardBody">
            <div class="fl fl_col border">
                <div class="fl fl_row borderRow borderTc">
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
                </div>                  
            </div>        
            <div>페이징</div>
            <div style="font-size: 0.8em;">
                <span style="font-size: 0.01em; position: relative;bottom: 2px;">▷</span>검색어 
                <select>
                    <option>일주일</option>
                    <option>한달</option>
                    <option>세달</option>
                    <option>전체</option>
                </select>
                <select>
                    <option>제목</option>
                    <option>내용</option>
                    <option>글쓴이</option>
                </select> 
                <input type="text">
                <input type="button" value="찾기">
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