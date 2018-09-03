<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/join.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="/js/main.js?ver=1"></script>        
<script>
$(function(){
	$(function(){
	    //로딩
		var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/img/viewLoading.gif" /></div>')
		.appendTo(document.body).hide();	
	    // 우편번호 찾기 화면을 넣을 element
	    var element_layer = document.getElementById('layer');

	    function closeDaumPostcode() {
	        // iframe을 넣은 element를 안보이게 한다.
	        element_layer.style.display = 'none';
	    }

	    function sample2_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = data.address; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수

	                // 기본 주소가 도로명 타입일때 조합한다.
	                if(data.addressType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample2_postcode').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('sample2_address').value = fullAddr;

	                // iframe을 넣은 element를 안보이게 한다.
	                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	                element_layer.style.display = 'none';
	            },
	            width : '100%',
	            height : '100%',
	            maxSuggestItems : 5
	        }).embed(element_layer);

	        // iframe을 넣은 element를 보이게 한다.
	        element_layer.style.display = 'block';

	        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	        initLayerPosition();
	    }

	    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	    function initLayerPosition(){
	        var width = 300; //우편번호서비스가 들어갈 element의 width
	        var height = 400; //우편번호서비스가 들어갈 element의 height
	        var borderWidth = 5; //샘플에서 사용하는 border의 두께

	        // 위에서 선언한 값들을 실제 element에 넣는다.
	        element_layer.style.width = width + 'px';
	        element_layer.style.height = height + 'px';
	        element_layer.style.border = borderWidth + 'px solid';
	        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
	        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
	        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
	    };
	    
	    $("#daum_search").on("click",function(){
	    	//$("#closeAddress").val("");
	        sample2_execDaumPostcode();
	    });
	    
	    $("#btnCloseLayer").on("click",function(){
	        closeDaumPostcode();
	    });
	    
	    $(".regSubmit").on("click",function(){	
	    	var queryString = $("form[name=joinForm]").serialize();
	    	$.ajax({type:"put",url:"/user?"+queryString,beforeSend:function(){
	    		loading.show();
	    	},
	    	complete:function(){
	    		loading.hide();
	    	},
	    	error:function(){
	    		loading.hide();
	    	}
	    	})
	    	.done(function(data,textStatus, xhr){
	    		if(xhr.status ==200){
	    			alert(data)
	    			location.href="/"
	    		}
	    		else if(xhr.status == 202){
	    			alert(data);
	    		}
	    	});
	    });
	    
	    $(".regCancel").on("click",function(){
	    	$.ajax({type:"delete",url:"/user/"+$("input[name=id]").val(),beforeSend:function(){
	    		loading.show();
	    	},
	    	complete:function(){
	    		loading.hide();
	    	},
	    	error:function(){
	    		loading.hide();
	    	}
	    	})
	    	.done(function(data,textStatus, xhr){
	    		console.log(data,textStatus, xhr.status);
	    		if(xhr.status ==200){
	    			alert(data)
	    			location.href="/project"
	    		}
	    		else if(xhr.status == 202){
	    			alert(data);
	    		}
	    	});	    	
	    })
	    
	    $("input[name=pw]").on("focusout",function(){
	    	if(pw_check()==false){
	    		$("input[name=pw]").parent().find("span").text(" (영문/숫자/특수문자혼용, 8자이상)")
	    	}
	    	else if(pw_check()==true){
	    		$("input[name=pw]").parent().find("span").text("사용 가능한 패턴입니다.")
	    	}
	    })
	    
	    $("input[name=pw2]").on("focusout",function(){
	    	if(pw_check2()==false){
	    		$("input[name=pw2]").parent().find("span").text(" 비밀번호가 일치하지 않습니다.")
	    	}
	    	else if(pw_check2()==true){
	    		$("input[name=pw2]").parent().find("span").text(" 비밀번호가 일치합니다.")
	    	}
	    })
	    
		function pw_check(){ 
	  	   if(!$("input[name=pw]").val().match(/([a-zA-Z].*[0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~,-].*[0-9])|([0-9].*[a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z].*[0-9])|([!,@,#,$,%,^,&,*,?,_,~,-].*[0-9].*[a-zA-Z])/)) {
	  		   return false;
	  	   }
	  	  return true;
	  	}       
		function pw_check2(){ 
		  if($("input[name=pw]").val() != $("input[name=pw2]").val()) {
			  return false;
		  }
		  return true;
		} 
		
	    $("#emailSelect").on("change",function(){
	    	var checkString = $("#emailSelect").val();
	    	$("input[name=email2]").attr("readonly",true)
			if(checkString == ""){
				$("input[name=email2]").val("");
			}
			else if(checkString == "naver.com"){
				$("input[name=email2]").val("naver.com");
			}
			else if(checkString == "daum.net"){
				$("input[name=email2]").val("daum.net");
			}
			else if(checkString == "gmail.com"){
				$("input[name=email2]").val("gmail.com");
			}
			else if(checkString == "직접입력"){
				$("input[name=email2]").attr("readonly",false);
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
    <div class="wrap"> 
        <div id="sidebar" class="fl fl_col">
            <ul>
            	<li>인기상품</li>
            </ul>
        </div>  
        <div class="join">
            <div class="fl fl_col">
                <div>MYPAGE</div>
                <hr><br><br>
                <form name="joinForm">
                <div class="joinContainer fl fl_row"> 
                   <div class="fl fl_col fl_gr2" style="height: 40vh;">
                       <div class="joinId"><span class="joinId infoarea_f4 _tb">아이디</span></div>
                       <div class="joinPw"><span class="joinPw infoarea_f4 _tb">비밀번호</span></div>
                       <div class="joinPw2"><span class="joinPw2 infoarea_f4 _tb">비밀번호 확인</span></div>
                       <div class="joinName"><span class="joinName infoarea_f4 _tb">이름</span></div>
                       <div class="joinAdd"><span class="joinAdd infoarea_f4 _tb">주소</span></div>
                       <div class="joinTel" style="position: relative; top: 40px;"><span class="joinTel infoarea_f4 _tb">휴대전화</span></div>
                       <div class="joinEmail" style="position: relative; top: 40px;"><span class="joinEmail infoarea_f4 _tb">이메일</span></div>
                       <div class="joinBirthDay" style="position: relative; top: 40px;"><span class="joinBirthDay infoarea_f4 _tb">생년월일</span></div>
                   </div>

                   <div class="fl fl_col fl_gr8 joinRight">
                       <div class="joinId" ><input type="text" class="joinId" name="id" disabled  value="${sessionScope.sessionScope.id}">
                       		<input type="hidden" class="joinId" name="id" value="${sessionScope.sessionScope.id}">
                       </div>
                       <div class="joinPw" style="position: relative; bottom: 5px;"><input type="password" name="pw"><span class="joinInfo"> (영문/숫자/특수문자혼용,8자이상)</span></div>
                       <div class="joinPw2" style="position: relative; bottom: 5px;" ><input type="password" name="pw2"><span class="joinInfo"></span></div>
                       <div class="joinName" style="position: relative; bottom: 5px;"><input type="text" name="name" disabled  value="${sessionScope.sessionScope.name}">
                       		<input type="hidden" name="name" value="${sessionScope.sessionScope.name}">
                       </div>
                       <div class="joinAdd" style="position: relative; bottom: 10px;">
                            <input type="text" id="sample2_postcode" name="address1" placeholder="우편번호" value="${sessionScope.sessionScope.address1}">
                            <input type="button" id="daum_search" value="우편번호" style="background-color: white; font-size: 0.9em;width: 90px; height: 25px;"><br>
                            <input type="text" id="sample2_address" name="address2" style="width: 50%; margin: 2px 0;" value="${sessionScope.sessionScope.address2}"><span class="joinInfo"> 기본주소</span><br>
                            <input type="text" id="closeAddress" name="address3" style="width: 50%; margin: 2px 0;" value="${sessionScope.sessionScope.address3}"><span class="joinInfo"> 나머지주소</span>
                            <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
                            <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
                            <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1"  alt="닫기 버튼">
                            </div>
                       </div>
                       <br><br>
                       <div class="joinTel" style="position: relative; bottom: 10px;">
                           <select name="phone1">
                               <option>010</option>
                               <option>070</option>
                               <option>016</option>
                               <option>017</option>
                               <option>018</option>
                               <option>019</option>
                           </select>
                           -
                           <input type="text" name="phone2" style="width: 40px;" value="${fn:split(sessionScope.sessionScope.phone,'-')[1]}">
                           -
                           <input type="text" name="phone3" style="width: 40px;" value="${fn:split(sessionScope.sessionScope.phone,'-')[2]}">
                       </div>
                       <div class="joinEmail" style="position: relative; bottom: 10px;"><input type="text" name="email1" style="width: 120px;" value="${fn:split(sessionScope.sessionScope.email,'@')[0]}" disabled> @ <input type="text _tb" name="email2" style="width: 120px;" readonly="readonly" value="${fn:split(sessionScope.sessionScope.email,'@')[1]} " disabled>
                       <input type="hidden" name="email1" style="width: 120px;" value="${fn:split(sessionScope.sessionScope.email,'@')[0]}"><input type="hidden" name="email2" style="width: 120px;" readonly="readonly" value="${fn:split(sessionScope.sessionScope.email,'@')[1]}"> 
                       </div>
                       <div class="joinBirthDay" style="position: relative; bottom: 10px;">
                           <input type="text" style="width: 50px;" name="birthDay1" value="${fn:split(sessionScope.sessionScope.birthDay,'/')[0]}" disabled>년<input type="text" name="birthDay2" style="width: 30px;" value="${fn:split(sessionScope.sessionScope.birthDay,'/')[1]}" disabled>월<input type="text" name="birthDay3" style="width: 30px;" value="${fn:split(sessionScope.sessionScope.birthDay,'/')[2]}" disabled>일
                           <input type="hidden" style="width: 50px;" name="birthDay1" value="${fn:split(sessionScope.sessionScope.birthDay,'/')[0]}"><input type="hidden" name="birthDay2" style="width: 30px;" value="${fn:split(sessionScope.sessionScope.birthDay,'/')[1]}"><input type="hidden" name="birthDay3" style="width: 30px;" value="${fn:split(sessionScope.sessionScope.birthDay,'/')[2]}">
                        </div>  
                   </div>
                </div>
                <div class="fl fl_row divBtnTool" style="position: relative; bottom: 10px;">
                    <div class="regSubmit regBtn">수정하기</div><div class="regCancel regBtn">탈퇴하기</div>
                </div>
                </form>
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