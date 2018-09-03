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
        sample2_execDaumPostcode();
    });
    $("#btnCloseLayer").on("click",function(){
        closeDaumPostcode();
    });
    
    $(".regSubmit").on("click",function(){	
    	if($("input[name=id]").val() == "" |$("input[name=pw]").val() == "" |$("input[name=pw2]").val() == "" |$("input[name=name]").val() == "" |$("input[name=address1]").val() == "" |
    			$("input[name=address2]").val() == "" |$("input[name=address3]").val() == "" |$("input[name=phone1]").val() == "" |$("input[name=phone2]").val() == "" |$("input[name=phone3]").val() == "" |
    			$("input[name=email1]").val() == "" |$("input[name=email2]").val() == ""){
    		alert("모두 입력했는지 확인해주세요")
    		return false;
    	}
    	
    	var queryString = $("form[name=joinForm]").serialize();
    	$.ajax({type:"post",url:"/user",data:queryString,beforeSend:function(){
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
    			location.href="/email"
    		}
    		else if(xhr.status == 202){
    			alert(data);
    		}
    	});
    	
    });
    


    $("input[name=id]").on("focusout",function(){
    	if(id_check()==true){
    	$.ajax({type:"get",url:"/user/"+$("input[name=id]").val()})	
	    	.done(function(data){
	    		console.log(data);
	    		if(data=="중복"){
	    			$("input[name=id]").parent().find("span").text(" 이미 사용중인 아이디 입니다.")
	    		}
	    		else if(data=="비중복"){
	    			$("input[name=id]").parent().find("span").text(" 사용 가능한 아이디 입니다.")
	    		}
	    		else if(data=="error"){
	    			$("input[name=id]").parent().find("span").text("(영문/숫자,4자이상)")
	    			alert("새로고침후 이용해주세요");	    			
	    		}
	    	})
    	}
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
    function id_check(){
    	var userId = $("input[name=id]");
    	console.log();
    	if(userId.val().length<4){
    		$("input[name=id]").parent().find("span").text("영어/숫자로 4자 이상을 입력해주세요");
    		return false;
    	}
    	else if(userId.val().match(/(.*[!,@,#,$,%,^,&,*,?,_,~,-].*)/)){
    		$("input[name=id]").parent().find("span").text("특수문자는 사용할수 없습니다.");
    		return false;
    	}else if(userId.val().match(/(.*[가-힣|ㄱ-ㅎ].*)/)){
    		$("input[name=id]").parent().find("span").text("한글은 사용할수 없습니다.");
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
