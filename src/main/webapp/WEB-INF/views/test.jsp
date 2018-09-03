<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function(){
		/* 
		if($("#test").val()!=null){
			history.pushState(null,null,"/test4");
		}
		var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/img/viewLoading.gif" /></div>')
		.appendTo(document.body).hide();	
		loading.show();
		console.log()
		 */
	})
</script>
</head>
<body>
<c:if test="${!empty test}">
	<input type="hidden" id="test" value=${test}>
</c:if>
<div style="text-align: center;">
	<span>1</span>
	<span>2</span>
	<span>3</span>
</div>
<p>${test}</p>
<div>

</div>
</body>
</html>