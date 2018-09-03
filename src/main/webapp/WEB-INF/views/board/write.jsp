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
<style>
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
</style>
<script>
    $(function(){
    	var qs = getQueryStringObject();
        //미로그인 유저접속시
        if($("#userNo").val() == null){
        	alert("로그인을 하셔야합니다.")
        	location.href="/login";
        }; 
    	var data = {};
        CKEDITOR.replace( 'editor1',{
            width:"100%",
            height:500
        } );     
        /* CKEditor : http://zzznara2.tistory.com/443 이미지 업로드 참고 */ 
        
        $("#test").on("click",function(){
            /* CKEDITOR 내용가져오기*/
            console.log(CKEDITOR.instances.editor1.getData())
        })
        //수정일때
        if(qs.update){
    		$.ajax({method:"get",url:"/board/detail/"+qs.update})
    		.done(function(data,test,xhr){
    			if(xhr.status==200){
    				console.log(data);
    				$("#selectType").remove();
    				$("#inputSubject").val(data.subject);
    				$("#resultBtn").text("수정");
    				CKEDITOR.instances.editor1.setData(data.content)
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
    		//수정버튼
    		$("#resultBtn").on("click",function(){
	        	data.userNo = $("#userNo").val();
	        	data.no = qs.update;
	        	data.subject = $("#inputSubject").val();
	        	data.content = CKEDITOR.instances.editor1.getData();
	        	data.secret = $("input[type=checkbox]").prop("checked")==false ?"N":"Y"; 
	        	
	        	console.log(data)
	        	$.ajax({method:"post",url:"/board/update",data:data})
	        	.done(function(data,test,xhr){
	        		if(xhr.status==200){
	        			alert(data);
	        			history.go(-1);
	        		}
	        		else if(xhr.status==202){
	        			alert("202에러");
	        		}
	        		else if(xhr.status==500){
	        			alert("500에러");
	        		}
	        		else{
	        			alert("원인을 알수없는 에러");
	        		}
	        	}) 
	        })
        }else{
	        //작성버튼
	        $("#resultBtn").on("click",function(){
	        	data.userNo = $("#userNo").val();
	        	data.type = $("#selectType").val();
	        	data.subject = $("#inputSubject").val();
	        	data.content = CKEDITOR.instances.editor1.getData();
	        	data.secret = $("input[type=checkbox]").prop("checked")==false ?"N":"Y"; 
	        	
	        	console.log(data)
	        	$.ajax({method:"post",url:"/board/write",data:data})
	        	.done(function(data,test,xhr){
	        		if(xhr.status==200){
	        			alert(data);
	        			var txt = $("#selectType").val()
	        			if(txt == "Q&A"){
	        				txt = "Q_A"
	        			}
	        			location.href="/board?type="+txt+"&page=1";
	        		}
	        		else if(xhr.status==202){
	        			alert("202에러");
	        		}
	        		else if(xhr.status==500){
	        			alert("500에러");
	        		}
	        		else{
	        			alert("원인을 알수없는 에러");
	        		}
	        		
	        	}) 
	        })
        }
        $("#backBtn").on("click",function(){
        	history.go(-1);
        })
    })
</script>     
</head>
<body>
	<!-- 필요한 값들 숨겨두자!! -->
    <c:if test="${!empty sessionScope}">
    	<input type="hidden" id="userNo" value="${sessionScope.sessionScope.no}">
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
    <div style="height:100vh;" class="wrap"> 
        <div id="boardSidebar" class="fl fl_col">
            <ul>
                <li>NOTICE</li>
                <li>Q&A</li>
                <li>REVIEW</li>
            </ul>
        </div>  
        <div class="noticeBody">
        <form>
        	<select style="font-size: 0.8em;" id="selectType">
			    <c:if test="${sessionScope.sessionScope.id eq 'admin'}">
			    	<option>NOTICE</option>
			    </c:if>
        		<option>Q&A</option>
        	</select>
            <div class="fl fl_col" style="font-size: 0.8em;">
                <div class="fl fl_row" style="margin-bottom: 5px;">
                    <span style="width: 50px; margin: 2px 0 0 7px; font-weight: bold;">제목</span><input type="text" id="inputSubject" style="width: 100%;">
                </div>
                <div>
                    <span style="margin: 0 10px 0 6px; font-weight: bold;">비밀글</span> <input type="checkbox" style="position: relative; top: 2px;">
                </div>
                <div>
                    <textarea name="editor1" id="editor1" rows="10" cols="80">
                    </textarea>
                </div>
                <div class="fl fl_row" style="position: relative; margin: 10 0;">
                    <div class="regBtn" id="resultBtn" style="width:50%;">작성</div><div class="regBtn" id="backBtn" style="width:50%;">돌아가기</div>
                </div>
            </div>
        </form>
        </div>
    </div>
    <footer style="height: 250px;" class="sbody">
        <div style="text-align: center; height: 80px;">
            <span class="footBar">HOME</span><span class="footBar">SHOP</span><span class="footBar">ABOUTs</span><span class="footBar">BOARD</span>
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