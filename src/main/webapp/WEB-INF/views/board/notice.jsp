<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/notice.css">
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js"></script>
<style>
.commentText{
	height: 100px;
	width: 100%;
}
    .noticeBody{
        margin: 0 15vw;
        width: 70%;
        position: absolute;
        top: 20vh;        
    }
    .headnotice{
        height: 40px;
        border-top: 1px solid black;
        position: relative;
        font-size: 0.9em;
    }
    .contentnotice{
        border-top: 1px solid black;
        border-bottom: 1px solid black;
        min-height: 200px;
        height: auto;
        position: relative;
    }
    .h_center{
        position: relative;
        top: 30%;
    }
    .head_l{
        width: 10%;
    }
    #contentText{
        position: absolute;
        
    }
    .regBtn{
    	cursor: pointer;
    }
    
<!-- 코멘트 목록 -->
.commentText{
    height: 100px;
    width: 100%;
}
.commentText::placeholder{
    font-size: 0.7em;
}
.commentText{
    font-size: 0.7em;
}
.commentSubmit{
    padding: 5px 10px;
    border: 1px solid #363636;
    background-color: #363636;
    color: white;
    position: absolute;
    right: 10%;
}

.commentPoint{
    position: relative;
    top: 25px;
    border: 1px solid #757575;
    height: 150px;
    width: 100%;

}
.commentOfStar{
    position: relative;
    top: 15px;
}

.commentList{
    position: relative;
    top: 50px;
}

.commentLine::before{
    content: "";
    display: block;
    border: 1px solid #c8c8c8;
    width: 100%;
    height: 1px;
    top: 0px;
    position: relative;
}
.commentLine::after{
    content: "";
    display: block;
    border: 1px solid #c8c8c8;
    width: 100%;
    height: 1px;
    top: 00px;
    position: relative;    
}

.commentViewLeft > span{
    display: inline-block;
}

    

.infoarea_f3 ._t{
    color: #888888;
}

.infoarea_f3 ._b{
    font-weight: 700;
}
.infoarea_f3 ._hr::after{
    content: "";
    display: block;
    border: 1px solid #c8c8c8;
    width: 100%;
    height: 1px;
    top: 0px;
    position: relative; 
}

.commentView{
    padding: 30px 0;
}    
.commentSubmit{
    padding: 5px 10px;
    border: 1px solid #363636;
    background-color: #363636;
    color: white;
    position: absolute;
    right: 0%;
}
.commentSubmit:hover{
	cursor: pointer;
}
</style>  
<script>
$(function(){
	var type="";
	var reviewData={};
	if($("input[name=hideenNo]").val()){
		$.ajax({method:"get",url:"/board/detail/"+$("input[name=hideenNo]").val()})
		.done(function(data,test,xhr){
			if(xhr.status==200){
				type=data.type;
				if($("input[name=userNo]").val()== data.userNo | $("input[name=userId]").val() == "admin"){
					$(".setBtn").css("display","inline-block");	
				}
				$("#boxSubject").text(data.subject);
				$("#boxName").text(data.name);
				$("#boxDate").text(data.date);
				$(".contentnotice").html(data.content);
			}
			else if(xhr.status == 202){
				console.log("202에러");
			}
			else if(xhr.status == 500){
				console.log("500에러");
			}
			else{
				console.log("에러발생");
			}
		})
		$("#backList").on("click",function(){
			if(type=="Q&A"){
				type="Q_A";
			}
			location.href="/board?type="+type+"&page=1";		
		})
		
		$.ajax({method:"get",url:"/comment/"+$("input[name=hideenNo]").val()})
		.done(function(data,text,xhr){
			if(xhr.status==200){
				console.log(data);
				for(var i=0;i<data.result.length;i++){
					console.log(i);
					var result = data.result[i];
					var html = "";
					html += '<div class="commentContainer"><div class="commentLine"><div class="fl fl_row commentView">'
					html += '<div class="fl fl_col fl_gr9 commentViewLeft" style="width: 100px;">';
					html += '<div><div class="infoarea_f4 commentViewLeft_t" style="word-break:break-all; font-size: 0.9em;">';
					html += '<span>'+result.content+'<br></span>';
					html += '</div></div></div>';
					html += '<div class="fl fl_col fl_gr1 infoarea_f3">';
					html += '<p class="_t _b">작성자</p>';
					html += '<p class="_b _hr">'+result.name+'</p>';
					html += '<p class="_t _b">작성일</p>';
					html += '<p class="_b _hr">'+result.date+'</p>';
					html += '<p class="_t _b">작성자 등급</p>';
    	            if(result.id == "admin"){
    	            	html+='<p class="_b">관리자</p>';
    	            }
    	            else{
    	            	html+='<p class="_b">회원</p>';
    	            }
					html += '</div></div></div></div>';
					console.log(html);
					$("#commentLists").append(html);
				}
/*     			for(var i=0;i<data.result.length;i++){
    				var result = data.result[i];
    				var html = '<div class="reviewContainer"><div class="reviewLine" style="position: relative;">'
    				if($("input[name=userNo]").val() == result.userNo){
    					html+= '<a class="cancel" style="position: absolute;font-size: 0.8em;top: 2px; right: 10.5%;"><span>X</span></a>'
    				}
    				html+= '<input type="hidden" value="'+result.no+'">'
    				html+='<div class="fl fl_row reviewView"><div class="fl fl_col fl_gr7 reviewViewLeft" style="width: 100px;">';
    				html += '<div><div class="reviewViewLeft_t"><span class="infoarea_f3">'+(Array(result.rating+1).join("★"))+'<span class="infoarea_f2">';
    	            switch (result.rating){
	                    case 1 : html+= " - 매우별로에요!!"; break;
	                    case 2 : html+= " - 깊게 생각해보세요!!"; break;
	                    case 3 : html+= " - 쓸만한것 같아요?"; break;
	                    case 4 : html+= " - 추천해도 될것같아요!!"; break;
	                    case 5 : html+= " - 아주좋아요!!"; break;
            		}
    	            html+='</span></div>'
    	            html+='<div class="infoarea_f4 reviewViewLeft_t" style="word-break:break-all;">';
    	            html+='<span>'+result.contents+'</span>';
    	            html+='</div></div></div>';
    	            html+='<div class="fl fl_col fl_gr3 infoarea_f3">';
    	            html+='<p class="_t _b">작성자</p>';
    	            html+='<p class="_b _hr">'+result.name+'</p>';
    	            html+='<p class="_t _b">작성일</p>';
    	            html+='<p class="_b _hr">'+result.date+'</p>';
    	            html+='<p class="_t _b">작성자 등급</p>';
    	            if(result.id == "admin"){
    	            	html+='<p class="_b">관리자</p>';
    	            }
    	            else{
    	            	html+='<p class="_b">회원</p>';
    	            }
    	            html+='</div></div></div></div>';
    				$("#reviewLists").append(html);
    			} */
			}
			else if(xhr.status == 202){
				console.log("202에러");
			}
			else if(xhr.status == 500){
				console.log("500에러");
			}
			else{
				console.log("에러발생");
			}
		})
	}
	else{
		alert("비정상적인 접근입니다.")
		location.href="/"
	}
	

    //댓글등록 버튼
    $(".commentSubmit").on("click",function(){
    	reviewData.boardNo=$("input[name=hideenNo]").val()
    	reviewData.userNo=$("input[name=userNo]").val()
    	reviewData.content=$(".commentText").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
    	
    	if(reviewData.userNo == null){
    		alert("로그인후 이용해주세요");
    		location.href="/login";
    	}
    	else if(reviewData.contents==""){
    		alert('내용을 입력해주세요');
    		return false;
    	}
    	
    	$.ajax({method:"post",url:"/comment",data:reviewData})
    	.done(function(data,test,xhr){
    		if(xhr.status==200){
    			alert(data);
    			location.reload();
    		}
    		else if(xhr.status==202){
    			alert("202에러");
    		}
    		else if(xhr.status==500){
    			alert("500에러");
    		}
    		else{
    			alert("이상에러 새로고침을 한번 해주세요");
    		}
    	})
    })
    
    $("#setList").on("click",function(){
    	var no = $("input[name=hideenNo]").val()
    	location.href="/board/write?update="+no;
    })
    $("#delList").on("click",function(){
    	var no = $("input[name=hideenNo]").val()
    	$.ajax({method:"delete",url:"/board/"+no})
    	.done(function(data,test,xhr){
    		if(xhr.status==200){
    			alert(data);
    			history.go(-1);
    		}
    		else{
    			console.log(data)
    		}
    	})
    })
	
})
</script>
</head>
<body>
	    <!--  
	    		숨겨져있는 input hidden 넘어온 값 board no
	    -->
	    	<input type="hidden" name="hideenNo" value="${no}">
    <!-- sessionScope (유저세션) 이 있으면 hidden으로 필요한 정보담기 -->
    <c:if test="${!empty sessionScope}">
    	<input type="hidden" name="userNo" value="${sessionScope.sessionScope.no}">
    	<input type="hidden" name="userId" value="${sessionScope.sessionScope.id}">
    </c:if>	    	
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
        <div id="boardSidebar" class="fl fl_col">
            <ul>
                <li>NOTICE</li>
                <li>Q&A</li>
                <li>REVIEW</li>
            </ul>
        </div>  
        <div style="height:100%;" class="noticeBody">
            <div class="fl fl_col" style="padding-bottom: 10px;">
                <div class="headnotice fl fl_row">
                    <div class="head_l"><span class="h_center head_l">제목</span></div><div><span class="h_center" id="boxSubject">subject</span></div>
                </div>
                <div class="headnotice fl fl_row">
                    <div class="head_l"><span class="h_center">작성자</span></div><div><span class="h_center" id="boxName">name</span></div></div>
                <div class="headnotice fl fl_row">
                    <div class="head_l"><b class="h_center">작성일</b></div><div><span class="h_center" id="boxDate">date</span></div></div>
                <div class="contentnotice"></div>   
            </div>
            <div id="backList" class="regBtn" style="display:inline-block;relative; left: 5%;top: 10px;">목록으로</div>
	        <div id="setList" class="regBtn setBtn" style="display:none; left: 5%;top: 10px;">수정하기</div>
	        <div id="delList" class="regBtn setBtn" style="display:none;relative; left: 5%;top: 10px;">삭제하기</div>
            <div class="">
                    <div class="fl fl_row">
                        <p class="infoarea_f2">댓글 |<span style="color: #525151"> 악의적인 비방글은 무통보 삭제됩니다 :)</span></p>
                    </div>
                    <textarea class="commentText" class="infoarea_f2" placeholder="댓글을 남겨주세요(로그인시 이용가능)"></textarea>
                    <div class="fl fl_row" style="position: relative; top: 10px;">
                        <a><span class="commentSubmit">댓글 등록</span></a>
                    </div>            
            </div>
                    <div class="commentList fl fl_col">
                        <div>댓글목록</div>
                        <!--리뷰가 추가될때 형태-->
                        <div id="commentLists">
<!--                             <div class="commentContainer">
                                <div class="commentLine">
                                    <div class="fl fl_row commentView">
                                        <div class="fl fl_col fl_gr9 commentViewLeft" style="width: 100px;">
                                            <div>
                                                <div class="infoarea_f4 commentViewLeft_t" style="word-break:break-all; font-size: 0.9em;">
                                                    	<span>넘무좋아요<br></span>
                                                </div>                                                
                                            </div>
                                        </div>
                                        <div class="fl fl_col fl_gr1 infoarea_f3">
                                            <p class="_t _b">작성자</p>
                                            <p class="_b _hr">운영자</p>
                                            <p class="_t _b">작성일</p>
                                            <p class="_b _hr">2018.08.14</p>
                                            <p class="_t _b">작성자 등급</p>
                                            <p class="_b">회원</p>
                                        </div>
                                    </div>                            
                                </div>
                            </div>  --> 
                        </div>
                    </div>            
        </div>
    </div>
    <div style="display:none; position: fixed;top: 85%; left: 90%;" class="updownBar">
        <div class="fl fl_col">
           <div><img id="imgUp" src="/img/up.png" style="width: 30px;"></div>            
           <div><img id="imgDown" src="/img/down.png" style="width: 30px;"></div>            
        </div>
    </div>    
<!--     <footer style="height: 250px;" class="sbody">
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
    </footer> -->
    
</body>
</html>