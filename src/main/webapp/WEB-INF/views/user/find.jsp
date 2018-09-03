<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>HanS:hop</title>
<style>
.regSubmit{
    background: black;
    color: white;
    margin-left: 13%;    
}
.regCancel{
    position: relative;
    left: 20px;
}
.regBtn:hover {
	cursor: pointer;
}
</style>
<script>
$(function(){
	var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/img/viewLoading.gif" /></div>')
	.appendTo(document.body).hide();	
	if($("#key").val() == "id"){
		$("h1").text("아이디찾기")
		$("h5").text("이메일을 입력해주세요!!!")
	}else{
		$("h1").text("비밀번호찾기")
		$("h5").text("아이디와 이메일을 입력해주세요!!!")		
	}
	$(".regCancel").on("click",function(){
		window.close();
	})
	$(".regSubmit").on("click",function(){
		if($("#key").val() == "id"){
			$.ajax({"method":"get",url:"/search/"+$("input[name=email]").val().replace('.','_'),beforeSend:function(){
				loading.show();
	    	},
	    	complete:function(){
	    		loading.hide();
	    	},
	    	error:function(){
	    		loading.hide();
	    	}})
			.done(function(data,test,xhr){
				if(xhr.status == 200){
					$("h5").text("귀하의 아이디는 "+data+" 입니다")
				}
				else if(xhr.status == 202){
					$("h5").text("가입하신 이메일이 아닙니다.")
				}
			})
		}else{
			$.ajax({"method":"get",url:"/search/"+($("input[name=email]").val().replace('.','_'))+"/"+$("input[name=id]").val(),beforeSend:function(){
	    		loading.show();
	    	},
	    	complete:function(){
	    		loading.hide();
	    	},
	    	error:function(){
	    		loading.hide();
	    	}})
			.done(function(data,test,xhr){
				if(xhr.status == 200){
					$("h5").text(data);
				}
				else if(xhr.status == 202){
					$("h5").text(data);
				}
			})
		}
	})	
})
</script>
</head>
<body style="background-color: rgba(255,99,66,0.2);">
<input type="hidden" id="key" value="${key}">
<h1 style="text-align: center;">아이디찾기</h1>
<h5 style="text-align: center; margin-top: 20px;margin-bottom: 10px;"></h5>
<div>
	<div style="width:70px; display: inline-block; text-align: center;"><span>Email</span></div><input type="text" name="email" style="width: 60%; position: relative; left: 10%;"><br>
</div>
<c:if test="${key eq 'pw' }">
<div>
	<div style="width:70px;display: inline-block; text-align: center;"><span >Id</span></div><input type="text" name="id" style="width: 60%; position: relative; left: 10%;"><br>
</div>
</c:if>

<div class="regSubmit regBtn" style="display: inline-block;margin-top: 20px;">찾기</div><div class="regCancel regBtn" style="display: inline-block;margin-top: 20px;">취소</div>


		
</body>

</html>