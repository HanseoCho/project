<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js"></script>        
<style>
.buyBox div .cancel:hover, .reviewSubmit:hover{
	cursor: pointer;
}
.reviewContainer .reviewLine .cancel:hover .proDel:hover {
	cursor: pointer;
}
.proDel{
	cursor: pointer;
}
</style>
<script>
    $(function(){
    	//리뷰작성할때 넘겨줄 data
    	var reviewData = {}
        $(".star").on("click",function(){
            for(var i=0;i<=$(this).index();i++){
                $(".star").eq(i).text("★");
            }
            for(var i=($(this).index()+1);i<=$(".star").length;i++){
                $(".star").eq(i).text("☆");
            }            
            reviewData.rating=$(this).index()+1;
            switch ($(this).index()){
                    case 0 : $(".starInfo").text("매우별로에요!!"); break;
                    case 1 : $(".starInfo").text("깊게 생각해보세요!!"); break;
                    case 2 : $(".starInfo").text("쓸만한것 같아요?"); break;
                    case 3 : $(".starInfo").text("추천해도 될것같아요!!"); break;
                    case 4 : $(".starInfo").text("아주좋아요!!"); break;
            }
            
        }).on("mouseout",function(){
            
        })
		var number = $("input[name=hideenNo]").val();
        $.ajax({method:"get",url:"/detail/"+number})
        .done(function(data,test,xhr){
        	if(xhr.status==200){
        		console.log(data);
        		$(".subject").text(data.subject);
        		$(".price").text(data.price+"원");
        		$(".details").text(data.details);
        		$(".choseImages ul").empty();
        		var colors = data.color.split(",");
        		$(".colorbox").empty();
        		for(var j=0;j<colors.length;j++){
        			$(".colorbox").append('<a href="#" class="choseCollor" style="text-decoration: none;"><span class="colorCss">'+colors[j]+'</span></a>')
        		}
        		for(var i=0;i<data.image.length;i++){
        			if(data.image[i].productType == "viewImage"){
        				$(".choseImages ul").append('<li><img src="'+data.image[i].fileUrl+'" class="choseImage"></li>');
        			}
        			else if(data.image[i].productType == "infoImage"){
        				$(".infoImage").attr("src",data.image[i].fileUrl);
        			}        
        		}
        		if(data.userNo == $("input[name=userNo]").val() | $("input[name=userId]").val() == "admin"){
        			$(".subject").append('<span class="proDel" style="position: absolute; right: 0; padding:5px; border: 1px solid black;">취소</span>')
        			$(".proDel").on("click",function(){
        				$.ajax({method:"delete",url:"/product/"+number})
        				.done(function(data,test,xhr){
        					if(xhr.status == 200){
        						alert(data);
        						history.go(-1);
        					}
        					else{
        						console.log("삭제중 문제발생");
        					}	
        				})
        			})
        		}
        		
        		
        		// 이미지부분
        		$(".keyImage").attr("src",$(".choseImages ul li img").eq(0).attr("src"));
        		
                $(".choseImage").on("mouseover",function(){
                    $(".keyImage").attr("src",$(this).attr("src"));
                })
                $(".choseCollor").on("click",function(){
                	//클릭하면 살거
                	var html;
                	html ='<div class="buyBox"><span class="infoarea_f2 subject" style="font-weight: 600">'+data.subject+'</span><br>';
                	html +='<span class="infoarea_f1 setColor">▶'+$(this).text()+'</span>';
                	html +='<div><input type="number" class="infoarea_f1 setCount" value="1" style="width: 50px;"><select style="font-size: 0.8em;" class="size setSize"></select><a class="cancel"><span style="width: 20px;height: 20px;background-color: #c8c8c8;color: white; position: relative; left: 10px;">x</span></a><span class="price allPrice" style="position: relative;left: 50px;">'+data.price+'원</span></div></div>';
                	
                	$(".buyList").append(html);
					var sizes = data.size.split(",");
					console.log(sizes);
					for(var m=0;m<sizes.length;m++){
						$(".buyBox div .size").append('<option>'+sizes[m]+'</option>');
					}
					$(".buyBox div .cancel").off().on("click",function(){
						console.log($(this).parent().parent().index());
						var index = $(this).parent().parent().index()
						$(".buyList .buyBox").eq(index).remove();
					})
					$(".buyBox input[type=number]").on("change",function(){
						var index = $(this).parent().parent().index()
						//console.log(index);
						//$(".buyList .buyBox").eq(index).children("span.price").text(($(this).val()*data.price)+"원");
						//console.log($(".buyList .buyBox").eq(index).children("span.price"))
						$(".buyList .buyBox").eq(index).children("div").children("span.price").text(($(this).val()*data.price)+"원");
					})
					return false;                	
                })
        	}
        	else if(xhr.status ==202){
        		alert("202에러")
        	}
        	else if(xhr.stauts ==500){
        		alert("500에러")
        	}
        	
        	
        	$("#buyNow").on("click",function(){
        		var count = 0;
        		if($(".buyBox").length == 0){
        			alert('색상을 선택해주세요.');
        			return false;
        		}
        		for(var i=0;i<$(".buyBox").length;i++){
	        		while(true){
	        			if(localStorage.getItem("cart"+count) == null){
	        				console.log("in");
	        				var ob = {'no':$("input[name=hideenNo]").val(),'color':$(".setColor").eq(i).text(),'count':$(".setCount").eq(i).val(),'size':$(".setSize").eq(i).val(),'subject':$(".subject").eq(i).text(),'img':$('.keyImage').attr("src"),'allPrice':$('.allPrice').eq(i).text(),'price':$('#price').text()};
	        				// no setColor setCount setSize
	        				localStorage.setItem("cart"+count,JSON.stringify(ob));
	        				console.log(JSON.parse(localStorage.getItem("cart"+count)));
	        				break;
	        			}
	        			else{
	        				count=count+1;
	        				console.log("out");
	        			}
        			}
        		}
        		location.href="/cart";        		
        	})
        	$("#addBtn").on("click",function(){
        		var count = 0;
        		if($(".buyBox").length == 0){
        			alert('색상을 선택해주세요.');
        			return false;
        		}
        		for(var i=0;i<$(".buyBox").length;i++){
	        		while(true){
	        			if(localStorage.getItem("cart"+count) == null){
	        				console.log("in");
	        				var ob = {'no':$("input[name=hideenNo]").val(),'color':$(".setColor").eq(i).text(),'count':$(".setCount").eq(i).val(),'size':$(".setSize").eq(i).val(),'subject':$(".subject").eq(i).text(),'img':$('.keyImage').attr("src"),'allPrice':$('.allPrice').eq(i).text(),'price':$('#price').text()};
	        				// no setColor setCount setSize
	        				localStorage.setItem("cart"+count,JSON.stringify(ob));
	        				console.log(JSON.parse(localStorage.getItem("cart"+count)));
	        				break;
	        			}
	        			else{
	        				count=count+1;
	        				console.log("out");
	        			}
        			}
        		}
				alert("장바구니에 추가완료");
        	})
        })
        
        //------리뷰관련-------\\
        //리뷰뿌려주기
        $.ajax({method:"get",url:"/review/"+$("input[name=hideenNo]").val()})
        .done(function(data,test,xhr){
    		if(xhr.status==200){
    			console.log(data);
    			var ratings = 0;
    			var arrayRating = [0,0,0,0,0]
    			for(var i=0;i<data.result.length;i++){
    				var result = data.result[i];
    				ratings += result.rating; 
    				arrayRating[(result.rating-1)]++
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
    			}
   				console.log(arrayRating.length)
   				var point = (100 / data.result.length).toFixed(1)
   				for(var i=0;i<arrayRating.length;i++){
   					$("#ratingBar .reviewOfStar").eq(4-i).children("#count").text("("+arrayRating[i]+")")
   					$("#ratingBar .reviewOfStar").eq(4-i).children("div").children("#bar").css("width",arrayRating[i]*point+"%");
   				}
   				$(".starAvgNum").text((ratings / data.result.length).toFixed(1));
   				$(".starAvgText").text(data.result.length+"개 리뷰 평점");
   				//취소버튼 이벤트 부여
   				$(".reviewContainer .reviewLine .cancel").on("click",function(){
   					var check = confirm("정말 삭제하시겠습니까??");
   					if(check){
   					var no = $(this).parent().children("input[type=hidden]").val();
   					$.ajax({method:"put",url:"/review/"+no})
   					.done(function(data,test,xhr){
   						if(xhr.status==200){
   							alert(data);
   							location.reload();
   						}
   						else if(xhr.status=202){
   							alert("202에러")
   						}
   						else if(xhr.status=500){
   							alert("500에러")
   						}
   						
   					})
   					}   					
   				})
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
        
        //리뷰등록 버튼
        $(".reviewSubmit").on("click",function(){
        	reviewData.productNo=$("input[name=hideenNo]").val()
        	reviewData.userNo=$("input[name=userNo]").val()
        	reviewData.contents=$(".reviewText").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
        	if(!reviewData.rating){
        		alert("평점을 선택해주세요!!!");
        		return false;
        	}
        	if(reviewData.userNo == null){
        		alert("로그인후 이용해주세요");
        		location.href="/login";
        	}
        	
        	$.ajax({method:"post",url:"/review",data:reviewData})
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
    <div style="" class="wrap">
    <!--  
    		숨겨져있는 input hidden 넘어온 상품번호(no)값
    -->
    	<input type="hidden" name="hideenNo" value="${no}">
    <!-- sessionScope (유저세션) 이 있으면 hidden으로 필요한 정보담기 -->
    <c:if test="${!empty sessionScope}">
    	<input type="hidden" name="userNo" value="${sessionScope.sessionScope.no}">
    	<input type="hidden" name="userId" value="${sessionScope.sessionScope.id}">
    </c:if>
        <div id="sidebar" class="fl fl_col">
            <ul>
            	<li>인기상품</li>
            </ul>
        </div>  
        <div class="product_detail">
            <div class="contetns fl fl_col">
                <div class=" product_detail_ fl fl_row">
                    <div class="fl_gr1 fl_sh choseImages ">
                        <ul>
                            <li><img src="img/test1.jpg" class="choseImage"></li>
                            <li><img src="img/test2.jpg" class="choseImage"></li>                            
                        </ul>
                    </div>
                    <div class="fl_gr9 fl_sh">
                        <img src="img/test1.jpg" class="keyImage">
                    </div>
                </div>  
                <div style="padding-bottom: 50px;">
                    <hr>
                    <!--상품 설명 긴 사진 부분-->
                    <p style="text-align: center;font-size: 0.7em">MoreInfo</p>
                    <div style="text-align: center;">
                        <img src="img/test2.jpg" class="infoImage" style="margin: 20px;">
                    </div>
                </div>
                <div class="fl fl_col">
                    <div class="fl fl_row">
                        <p class="infoarea_f2">REVIEW |<span style="color: #525151"> 문의글 혹은 악의적인 비방글은 무통보 삭제됩니다 :)</span></p>
                    </div>
                    <textarea class="reviewText" class="infoarea_f2" placeholder="리뷰를 남겨주세요(로그인시 이용가능)"></textarea>
                    <div class="fl fl_row" style="position: relative; top: 10px;">
                        <span class="star">☆</span><span class="star">☆</span><span class="star">☆</span><span class="star">☆</span><span class="star">☆</span>
                        <span class="starInfo infoarea_f3" style="position: relative; top: 3px;left: 10px;">별점을 주세요!!</span><a><span class="reviewSubmit">리뷰 등록</span></a>
                    </div>
                    <div class="reviewPoint fl fl_row">
                        <div class="fl_gr1" style="width: 100px;">
                            <span class="starAvgNum">0.0</span><br>
                            <span class="starAvgText">개 리뷰 평점</span>
                        </div>
                        <div class="fl_gr9 fl fl_col" id="ratingBar">
                            <div class="reviewOfStar fl fl_row" >
                                <span>5 Stars</span> 
                                <div style="width: 80%; height: 15px;background-color: #c8c8c8;position: relative;left: 15px;top: 5px;"><div id="bar" style="background-color: #03bbff;width: 0%; height: 100%;"></div></div>
                                <span id="count" style="position: absolute;right: 5%;">(0)</span>
                            </div>
                            <div class="reviewOfStar fl fl_row">
                                <span>4 Stars</span> 
                                <div style="width: 80%; height: 15px;background-color: #c8c8c8;position: relative;left: 15px;top: 5px;"><div id="bar" style="background-color: #03bbff;width: 0%; height: 100%;"></div></div>
                                <span id="count" style="position: absolute;right: 5%;">(0)</span>
                            </div>
                            <div class="reviewOfStar fl fl_row">
                                <span>3 Stars</span> 
                                <div style="width: 80%; height: 15px;background-color: #c8c8c8;position: relative;left: 15px;top: 5px;"><div id="bar" style="background-color: #03bbff;width: 0%; height: 100%;"></div></div>
                                <span id="count" style="position: absolute;right: 5%;">(0)</span>
                            </div>
                            <div class="reviewOfStar fl fl_row">
                                <span>2 Stars</span> 
                                <div style="width: 80%; height: 15px;background-color: #c8c8c8;position: relative;left: 15px;top: 5px;"><div id="bar" style="background-color: #03bbff;width: 0%; height: 100%;"></div></div>
                                <span id="count" style="position: absolute;right: 5%;">(0)</span>
                            </div>
                            <div class="reviewOfStar fl fl_row">
                                <span>1 Stars</span> 
                                <div style="width: 80%; height: 15px;background-color: #c8c8c8;position: relative;left: 15px;top: 5px;"><div id="bar" style="background-color: #03bbff;width: 0%; height: 100%;"></div></div>
                                <span id="count" style="position: absolute;right: 5%;">(0)</span>
                            </div>
                        </div>
                    </div>
                    <div class="reviewList fl fl_col">
                        <div>리뷰목록</div>
                        <!--리뷰가 추가될때 형태-->
                        <div id="reviewLists">
<!--                             <div class="reviewContainer">
                                <div class="reviewLine">
                                    <div class="fl fl_row reviewView">
                                        <div class="fl fl_col fl_gr7 reviewViewLeft" style="width: 100px;">
                                            <div>
                                                <div class="reviewViewLeft_t">
                                                    <span class="infoarea_f3">★★★★★</span><span class="infoarea_f2"> - 아주좋아요!!</span>
                                                </div>
                                                <div class="infoarea_f4 reviewViewLeft_t" style="word-break:break-all;">
                                                    	<span>넘무좋아요</span>
                                                </div>                                                
                                            </div>
                                        </div>
                                        <div class="fl fl_col fl_gr3 infoarea_f3">
                                            <p class="_t _b">작성자</p>
                                            <p class="_b _hr">운영자</p>
                                            <p class="_t _b">작성일</p>
                                            <p class="_b _hr">2018.08.14</p>
                                            <p class="_t _b">작성자 등급</p>
                                            <p class="_b">회원</p>
                                        </div>
                                    </div>                            
                                </div>
                            </div>    -->                         
                        </div>
                        <div></div>
                    </div>
                </div>
            </div>  
            <div class="infoarea fl fl_col ">
                <div class="infoarea_f3 subject" ><!-- 스트라이프 폴라넥T (화이트, 블랙) -->
                </div>
                <div class="infoarea_f3 price" id="price"><!-- 11,000원 --></div>
                <div class="infoarea_f1 colorbox" style="margin: 10px 0;"><a href="#" style="text-decoration: none;"><span class="colorCss">RED</span></a><a href="#" style="text-decoration: none;"><span class="colorCss" >BLUE</span></a></div>
                <div class="infoarea_f1">[필수]색상을 선택해주세요</div>
                <div class="fl fl_col buyList">
                    <!-- <span class="infoarea_f2 subject" style="font-weight: 600">스트라이프 폴라넥T</span>
                    <span class="infoarea_f1">▶핑크</span>
                    <div>
                        <input type="number" class="infoarea_f1" value="1" style="width: 50px;"><a><span style="width: 20px;height: 20px;background-color: #c8c8c8;color: white; position: relative; left: 10px;">x</span></a><span style="position: relative;left: 50px;">9000원</span>
                    </div> -->
                </div>
                <div class="infoarea_f2">
                    <ul>
                        <li class="infoarea_f2 textBold">DETAILS</li>
                        <li class="infoareaDetail details"><!-- 경쾌하면서도 클래식한 매력을 지닌 자체 제작 스트라이프 폴라 넥 티셔츠입니다.<br>
                            부드러운 코튼 소재를 사용하여 민감성 피부이신 분들께서도 자극 없이 착용하실 수 있으며,<br>
                            총 2가지 컬러로 관리가 용이한 블랙 컬러와, 피부 톤을 화사하게 밝혀주는 <br>
                            화이트 모두 추천드리고 싶은 제품입니다<br> -->
                        </li>
                    </ul>
                </div>
                <div>
                    <a href="#" id="buyNow"><p class="btnCss infoarea_f2 buyBtn">BUY NOW</p></a>
                    <a href="#" id="addBtn"><p class="btnCss infoarea_f2 addBtn">ADD CART</p></a>
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