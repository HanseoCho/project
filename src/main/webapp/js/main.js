    var num = 0; 
    var timer;
    //로딩
    $(function(){
        $("#mainBtn").on("click",function(){
            location.href="/";    
        });
        /*슬라이드*/
        //이전 스크롤 좌표
/*        var lastScrollTop = 0;
        $(window).scroll(function(){
        	var currentScroolTop = $(window).scrollTop();
        	console.log(currentScroolTop-lastScrollTop);
        	if(currentScroolTop-lastScrollTop>500){
        		
        		lastScrollTop = currentScrollTop; 
        		var htmlupdownBar = '<div style="position: fixed;top: 85%; left: 90%;" class="updownBar">';

                $("#imgUp").on("click",function(){
                    $("body").scrollTop(0);
                })
                $("#imgDown").on("click",function(){
                    $("body").scrollTop($(document).height());
                })
        	}else{
        		$(".updownBar").remove();
        		lastScrollTop = currentScroolTop;
        	}
        })*/

        //위아래이동버튼
    	$("#imgUp").on("click",function(){
    		$("html").scrollTop(0);
    	})
    	$("#imgDown").on("click",function(){
    		$("html").scrollTop($(document).height());
    	})
        $(window).on("scroll",function(){
            if($(this).scrollTop() > 130){
                $("header").addClass('header_show');
                $(".updownBar").show();
            }
            else{
                $("header").removeClass('header_show');
                $(".updownBar").hide();
            }
        })
        $(".sBtn").on("mouseover",function(){
            clearInterval(timer);
            num = $(this).index() == 0 ? 3:$(this).index() == 1?0:$(this).index()-1;
            slideImgChange(num);
            num = (num+1)>=4 ?0:num+1;
            timer = setInterval(slidemove,3000);
        })
        timer = setInterval(slidemove,3000);
        /* /슬라이드 */
        
        $(".choseImage").on("mouseover",function(){
            $(".keyImage").attr("src",$(this).attr("src"));
        })
        
        $(".buyBtn").on("mouseover",function(){
            $(".buyBtn").css("background-color", "black");
            $(".buyBtn").css("color", "white");
        });
        $(".buyBtn").on("mouseout",function(){
            $(".buyBtn").css("background-color", "white");
            $(".buyBtn").css("color", "black");
        });       
        $(".addBtn").on("mouseover",function(){
            $(".addBtn").css("background-color", "#c8c8c8");
            $(".addBtn").css("color", "white");
        });
        $(".addBtn").on("mouseout",function(){
            $(".addBtn").css("background-color", "white");
            $(".addBtn").css("color", "black");
        });            
        $(".addBtn").on("mouseover",function(){
           
        });     
        /* 상단 페이지이동*/
        $(".headerli").on("click",function(){
        	switch ($(this).text()) {
			case "ONLINE SHOP":
				location.href="/list";
				break;
			case "ABOUT":
				location.href="/about";
				break;
			case "Board":
				location.href="/board";
				break;
			case "CHAT":
				$.ajax({method:"get",url:"/mr/0/0"})
				.done(function(data){
					console.log(data);
				})
				break;
			case "ADMIN":
				location.href="/admin";
				break;				
			default:
				break;
			}
        })
        
        $(".rightMt a").on("click",function(){
        	switch ($(this).text()) {
			case "LOGIN":
				location.href="/login";
				break;
			case "LOGOUT":
				$.ajax({method:"delete",url:"/session"})
				.done(function(data,test,xhr){
					if(xhr.status == 200){
						alert(data);
					}
					else{
						console.log(data,xhr)
						alert("로그아웃중 이상발생");
					}
					location.href="/"
				})
				break;				
			case "JOIN":
				location.href="/join";
				break;
			case "MYPAGE":
				location.href="/mypage"
				break;
			case "장바구니":
				location.href="/cart"
				break;
			default:
				break;
			}
        	
        })
        /* -------- */
        //쿠키가없으면 ajax로 컬럼부분 가지고오고 있으면 쿠키에서 가지고와서 중분류를 다가지고와서 메뉴를 표시
        if(getCookie("sideBarUl") == null){
	        $.ajax({method:"get",url:"/column/division"})
	        .done(function(data){
	        	console.log(data);
	        	var str="";
	        	for(var i=0;i<data.length;i++){
	        		$("#sidebar ul").append("<li>"+data[i].value+"</li>");
	        		str+=data[i].value+",";
	        	}
	        	str = str.substring(0,str.length-1);
	        	setCookie("sideBarUl",str,1);
	        })
        }
        else{
        	var str = getCookie("sideBarUl");
        	var str = str.split(",")
        	for(var i=0;i<str.length;i++){
        		$("#sidebar ul").append("<li>"+str[i]+"</li>");
        	}
        	$("#sidebar ul li").on("click",function(){
        		location.href="/list?division="+$(this).text()+"&page=1";
        	})
        	
        }
        $(".regCancel").on("click",function(){
        	location.href="/";
        })
    	$("#boardSidebar ul li").on("click",function(){
    		var txt = $(this).text();
			if(txt == "Q&A"){
				txt = "Q_A";
			}
			location.href="/board?type="+txt+"&page=1";
    	})
    	
    	
    	//푸터 이벤트
        $(".footBar").on("click",function(){
            var text = $(this).text();
            if(text == "HOME"){
                location.href="/";
            }
            else if(text == "SHOP"){
                location.href="/list";
            }
            else if(text == "ABOUT"){
                location.href="/about";
            }
            else if(text == "BOARD"){
                location.href="/board";
            }
        })  

    	
    })
/* 슬라이드 */
var slideImgChange = function(check){
    //check는 슬라이드버튼중 뭘체크했는지 표시 0~3
    var nextcheck = (check+1)==4?0:check+1;
    
    $("#slide img").eq(check).animate({opacity:0},300);
    setTimeout(function(){
        for(var j=0;j<$("#slide img").length;j++){
            $("#slide img").eq(j).hide();                
        }
        $("#slide img").eq(nextcheck).css("display","block");
        $("#slide img").eq(nextcheck).css("opacity",0);
        $("#slide img").eq(nextcheck).animate({opacity:1},500);
    },300)
    for(var i=0;i<$(".sBtn").length ;i++){
        $(".sBtn").eq(i).removeClass("w3-white")
    }
    $(".sBtn").eq(nextcheck).addClass("w3-white");
}
    
function slidemove(){
    slideImgChange(num);
    num = (num+1)>=4 ?0:num+1;
}

//쿠키 관련설정들
function setCookie(cookie_name, value, days) {
	  var exdate = new Date();
	  exdate.setDate(exdate.getDate() + days);
	  // 설정 일수만큼 현재시간에 만료값으로 지정

	  var cookie_value = escape(value) + ((days == null) ? '' : ';    expires=' + exdate.toUTCString());
	  document.cookie = cookie_name + '=' + cookie_value;
}
function addCookie(cookie_name, value, days) {
	  var exdate = new Date();
	  exdate.setDate(exdate.getDate() + days);
	  // 설정 일수만큼 현재시간에 만료값으로 지정

	  var cookie_value = cookie_value + escape(value) + ((days == null) ? '' : ';    expires=' + exdate.toUTCString());
	  document.cookie = document.cookie + cookie_name + '=' + cookie_value;
}
function getCookie(cookie_name) {
	  var x, y;
	  var val = document.cookie.split(';');
	  for (var i = 0; i < val.length; i++) {
	    x = val[i].substr(0, val[i].indexOf('='));
	    y = val[i].substr(val[i].indexOf('=') + 1);
	    x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
	    if (x == cookie_name) {
	      return unescape(y); // unescape로 디코딩 후 값 리턴
	    }
	  }
}

//쿼리스트링 얻기
function getQueryStringObject() {
    var a = window.location.search.substr(1).split('&');
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i) {
        var p = a[i].split('=', 2);
        if (p.length == 1)
            b[p[0]] = "";
        else
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
}

//상품 만들어주기 
//data : data{result{no,subject,price,images[]}} 필수유형
//x : 몇줄
//y : 몇개씩
//target : 뿌려줄태그  $(".hitTag")
function setProductData(data,x,y,target){
	var html = "";
	for(var i=0;i<x;i++){
		if((i*y)<data.result.length){
			if(y==1){
				html+='<div style="height: 900px; padding: 10px 0;" class="fl fl_row">';
			}
			else if(y==2){
				html+='<div style="height: 900px; padding: 10px 0;" class="fl fl_row">';
			}
			else if(y==3){
				html+='<div style="height: 800px; padding: 10px 0;" class="fl fl_row">';
			}
			else if(y==4){
				html+='<div style="height: 700px; padding: 10px 0;" class="fl fl_row">';
			}
			else if(y==5){
				html+='<div style="height: 600px; padding: 10px 0;" class="fl fl_row">';
			}
			else if(y==6){
				html+='<div style="height: 500px; padding: 10px 0;" class="fl fl_row">';
			}
			else{
				html+='<div style="height: 700px; padding: 10px 0;" class="fl fl_row">';
			}			
		}
		for(var j=0;j<y;j++){
			var result = data.result[((i*y)+(j))];
			if(result){
				console.log(result);
				html+='<div style="width: calc(100%/'+y+');height: 100%;" class="boxs">';
				html+='<div class="fl fl_col fl_gr1 box wmil">';
				html+='<input type="hidden" id="no" value="'+result.no+'">';
				for(var s=0;s<result.image.length;s++){
					if(result.image[s].productType=="viewImage"){
						html+='<input type="hidden" class="hiddenImage" value="'+result.image[s].fileUrl+'">';
					}
				}
				if(result.image[0].productType==null){}
				else{
					if(result.image[0].productType=="viewImage"){
						html+='<div class="fl_gr8 boxImg" style="background-image: url('+result.image[0].fileUrl+');"></div>';
					}else{
						html+='<div class="fl_gr8 boxImg" style="background-image: url('+result.image[1].fileUrl+');"></div>';
					}		
				}
				html+='<div>'+result.subject+'</div>';
				html+='<hr style="margin: 5px 0;">';
				html+='<div style="text-align: right;">'+result.price+'원</div>';
				html+='</div>';
				html+='</div>';							
			}
			else{
				console.log('x')
			}
		}
		html+='</div>' 	
	}
	target.empty().append(html);
	$("div.boxs").on("click",function(){
		location.href="/list/product/"+$(this).children("div").children("input[id=no]").val()
	}).on("mouseover",function(){
		//console.log($(this).children("input[class=hiddenImage]"))
		//console.log($(this).children(".boxImg"))
		var hiddenImgs = $(this).children("div").children("input[class=hiddenImage]")
		var boxImg = $(this).children("div").children(".boxImg")
		if(hiddenImgs.length > 1){
			for(var q=0;q<hiddenImgs.length;q++){
				var backimg = boxImg.css("background-image")
				backimg = backimg.replace("url","").replace("(","").replace(")","").replace('"',"").replace('"',"");
				if(hiddenImgs.eq(q).val() != backimg){
					console.log(hiddenImgs.eq(q).val());
					console.log(backimg);
					boxImg.css("background-image",'url('+hiddenImgs.eq(q).val()+')');
					break;
				} 
			}
		}
	}).on ("mouseout",function(){
		var hiddenImgs = $(this).children("div").children("input[class=hiddenImage]")
		var boxImg = $(this).children("div").children(".boxImg")
		if(hiddenImgs.length > 1){
			for(var q=0;q<hiddenImgs.length;q++){
				var backimg = boxImg.css("background-image")
				backimg = backimg.replace("url","").replace("(","").replace(")","").replace('"',"").replace('"',"");
				if(hiddenImgs.eq(q).val() != backimg){
					console.log(hiddenImgs.eq(q).val());
					console.log(backimg);
					boxImg.css("background-image",'url('+hiddenImgs.eq(q).val()+')');
					break;
				} 
			}
		}
	})
}	
//data   : data{js[페이징정보]} 
//target : 추가할 타겟 $(".sbody")
function setProductPagin(data,target){
	var paging ="<div style='text-algin:center;position:relative;margin:50px 0;'>";
	for(var k=0;k<data.js.length;k++){
		paging+=data.js[k];
	}
	paging = paging.replace("undefined","");
	paging+='</div>'
	target.append(paging);			
}

