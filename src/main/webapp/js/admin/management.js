//체크한 값을 담아두었다가 이걸로 Column삭제 이벤트처리
var delValue = {};
$(function(){
	// 공통부분
	$("#adminSidebar ul li").off().on("click",function(){
		$("#fText").hide();
		$(".adboxs").hide();
		$(".adboxs").eq($(this).index()).show();
	})
	
	$("input[name=viewImage]").on("change",function(){
		var imgList = $(this);
		$("#loadImgs").empty();
		if(imgList[0].files.length>3){
			alert("파일은 3개까지 가능합니다");
			imgList[0].value = "";
			return false;
		}
		for(var i=0;i<imgList[0].files.length;i++){
			$("#loadImgs").append('<img class="loadImg" style="width: 200px; height: 200px;">');
			LoadImg(i,imgList[0].files[i],$('.loadImg'));
		}
	})

	$("input[name=infoImage]").on("change",function(){
		var imgList = $(this);
		$("#infoImgs").empty();
		for(var i=0;i<imgList[0].files.length;i++){
			$("#infoImgs").append('<img class="infoImg" style="width: 200px; height: 200px;">');
			LoadImg(i,imgList[0].files[i],$('.infoImg'));
		}
	})
	
	$("#colorResult").on("click",function(){
		var txt = $("#coloresInput").val();
		$("#coloresInput").val("");
		$("#coloresSee").append('<a href="#" style="text-decoration: none;"><span class="colorCss">'+txt+'</span></a>')
		var colorBox = $("#coloresSee a");
		colorBox.eq(colorBox.length-1).on("click",function(){
			$(this).empty();
			return false;
		})
	})
	$("#sizeResult").on("click",function(){
		var txt = $("#sizeInput").val();
		$("#sizeInput").val("");
		$("#sizeSee").append('<a href="#" style="text-decoration: none;"><span class="sizeCss">'+txt+'</span></a>')
		var colorBox = $("#sizeSee a");
		colorBox.eq(colorBox.length-1).on("click",function(){
			$(this).empty();
			return false;
		})
	})
	
	$("#columnAddResult").on("click",function(){
		if($("#columnAddSelect").val()=="중분류" & $(".conditionAddSelect").eq(0).val()=="" ){
			alert("상세조건을 선택해주세요");
			return false;
		}
		if(($("#columnAddSelect").val()=="소분류" & $(".conditionAddSelect").eq(0).val()=="") | ($("#columnAddSelect").val()=="소분류" & $(".conditionAddSelect").eq(1).val()=="")){
			alert("상세조건을 선택해주세요");
			return false;
		}
		
		/* 
		if($("#columnAddSelect").val()=="중분류" | $("#columnAddSelect").val()=="소분류"){
			console.log("check");
			if($(".conditionAddSelect").eq(0).val()=="" | $(".conditionAddSelect").eq(1).val()==""){
				alert("상세조건을 선택해주세요")
				return false;
			}
		}
		 */
		console.log("check2");
		if($("#columnAddSelect").val() == "종류"){
			alert("종류를 선택해주세요");
			return false;
		}
		//$.ajax({method:"post",url:"/column",data:{"type":$("#columnAddSelect").val(),"value":$("#columnAddText").val()}})
		var queryString = $("form[name=addForm]").serialize();
		$.ajax({method:"post",url:"/column",data:queryString})
		.done(function(data,test,xhr){
			console.log(xhr.status);
			if(xhr.status == 200){
				$("#columnAddText").val("");
				alert(data);
			}
			else if(xhr.status == 202){
				alert(data);
			}
			seeColumn();
		})
	})
	
	$("#delColumn").on("click",function(){
		if(!delValue){
			alert("삭제할 값을 선택해주세요")
			return false;
		}
		console.log(delValue);
		$.ajax({method:"delete",url:"/column/"+delValue.type+"/"+delValue.value})
		.done(function(data,test,xhr){
			if(xhr.status==200){
				alert(data);
			}
			else if(xhr.status==202){
				alert(data);
			}
			seeColumn();
		})
	})
	
	$(".checkList").on("click",function(){
		index = $(this).parent().index()
		for(var i=0;i<$(".checkList").length;i++){
			if(i==index){continue;}
			else{
				$(".checkList").eq(i).val("");
			}
		}
		delValue.type=$(this).parent().children("input[type=hidden]").val();
		delValue.value=$(this).val();
	})
	
	$("input[name=productResult]").on("click",function(){
		if($(".addCheckList").eq(0).val() == "" | $(".addCheckList").eq(1).val() == "" | $(".addCheckList").eq(2).val() == ""){
			alert("분류를 선택해주세요");
			return false;
		}
		var formdata = new FormData($("form[name=productAppend]")[0]);
		console.log(formdata);
		var queryString = $("form[name=productAppend]").serialize();
		var color = "";
		var size = "";
		for(var i=0;i<$("#coloresSee .colorCss").length;i++){
			color += $("#coloresSee .colorCss").eq(i).text()+",";
		}
		for(var i=0;i<$("#sizeSee .sizeCss").length;i++){
			size += $("#sizeSee .sizeCss").eq(i).text()+",";
		}		
		color = color.substring(0,color.length-1);
		size = size.substring(0,size.length-1);
		formdata.set("color",color);
		queryString +="&color="+color;
		queryString +="&size="+size;
		console.log(queryString);
		$.ajax({method:"post",url:"/product",data:queryString,beforeSend:function(){
    		loading.show();
    	}
    	})
		.done(function(data,test,xhr){
			if(xhr.status==200){
				$.ajax({method:"post",url:"/file",data:formdata,cache: false,contentType: false,processData: false,
			    	complete:function(){
			    		loading.hide();
			    	},
			    	error:function(){
			    		loading.hide();
			    	}
			    	})
				.done(function(data,test,xhr){
					if(xhr.status==200){
						$("form[name=productAppend")[0].reset();
						alert("상품추가 성공");
						location.href="/admin";
					}
					else if(xhr.status==202){
						alert(data);
					}
				})
			}
			else if(xhr.status==202){
				alert(data);
			}
		})
	})
	
	//추가할 상품종류의 클릭에따른 상세조건 활성/비활성화
	$("#columnAddSelect").on("change",function(){
		console.log($(this).val());
		$(".conditionAddSelect").attr("disabled","disabled");
		if($(this).val() == "중분류"){
			$(".conditionAddSelect").eq(0).removeAttr("disabled");
		}
		else if($(this).val() == "소분류"){
			$(".conditionAddSelect").removeAttr("disabled");
		}
	})
	
	$("form[name=productAppend]").on("reset",function(){
		imgClear()
	})
	
	
	//상품추가 Type Change시 하나씩 추가되는 이벤트
	$(".addCheckList").on("change",function(){
		changeColumn($(".addCheckList"),$(this));
	})
	
    $("input[name=eventBoxImage]").on("change",function(){
		var imgList = $(this);
		$("#eventImgs").empty();
            for(var i=0;i<imgList[0].files.length;i++){
                $("#eventImgs").append('<img class="eventImg" style="width: 200px; height: 200px;">');
                LoadImg(i,imgList[0].files[i],$('.eventImg'));
            }
        })
        
     $("input[name=eventBoxSubmit]").on("click",function(event){
         var formdata = new FormData($("form[name=eventBoxForm]")[0]);   
         
         $.ajax({method:"post",url:"/eventbox",data:formdata,cache: false,contentType: false,processData: false})
         .done(function(data,test,xhr){
        	 if(xhr.status==200){
        		 alert(data);
        		 location.reload();
        	 }
        	 else{
        		 console.log(data);
        	 }
         })
         return false;
     })
	
     
    //유저관리 화면구성
     function userView(){	
	    $.ajax({method:"get",url:"/userall"})
	    .done(function(data,test,xhr){
			if(xhr.status == 200){
				for(var i=$(".userManage").children("div").length;i>0;i--){
					if(i<2){continue;}
					$(".userManage").children("div").eq(i).remove();
				}
				var html;
				for(var i=0;i<data.result.length;i++){
					var result = data.result[i];
					if(result.kickYn == "Y"){
						html = '<div class="fl fl_row" style="background-color:gray;">';
					}else{
						html = '<div class="fl fl_row">';
					}
					html +='<input type="hidden" value="'+result.no+'">';
	                html +='<div class="th">'+result.id+'</div>';
	                html += '<div class="th">'+result.name+'</div>';
	                html += '<div class="th">'+result.joinDate+'</div>'
	                if(result.kickYn == "Y"){
	                	html += '<div class="th"><span class="cur roll">차단해제</span></div>'
	                }
	                else{
	                	html += '<div class="th"><span class="cur kick">차단하기</span></div>'
	                }
	                html += '</div>'
	                $(".userManage").append(html);
				}
				$(".kick").on("click",function(){
					$.ajax({method:"delete",url:"/userall/"+$(this).parents().children("input[type=hidden]").val()})
					.done(function(data,test,xhr){
						if(xhr.status==200){
							alert(data);
							userView()
						}
						else{
							console.log("이상이 발생했습니다");
							console.log(data);
						}
					})
				})
				$(".roll").on("click",function(){
					$.ajax({method:"put",url:"/userall/"+$(this).parents().children("input[type=hidden]").val()})
					.done(function(data,test,xhr){
						if(xhr,status=200){
							alert(data);
							userView();
						}
						else{
							console.log("이상이 발생했습니다");
							console.log(data);
						}
					})				
				})
			}
			else{
				console.log("에러발생");
			}
		})
	}
	seeColumn();
	userView();
})

//이미지 미리보기  LoadImg(몇번재인지,imgList[0].files[i],$('.infoImg'));
function LoadImg(num,value,type) {
	var reader = new FileReader();
	reader.onload = function (e) {
		type.eq(num).attr('src', e.target.result);
	}
	reader.readAsDataURL(value);
}	
function imgClear(){
	$("#loadImgs").empty();
	$("#infoImgs").empty();
	$("#coloresSee").empty();
}
//상품종류관리 화면 갱신
function seeColumn(){
	var select;
	$.ajax({method:"get",url:"/column"})
	.done(function(data,test,xhr){
		if(xhr.status == 200){
			for(var j=0;j<$(".checkList").length;j++){
				$(".checkList").eq(j).empty();
			}
			$(".conditionAddSelect").eq(0).empty().append("<option value=''>상세조건1</option>")
			$(".conditionAddSelect").eq(1).empty().append("<option value=''>상세조건2</option>")
			$(".addCheckList").eq(0).empty().append("<option value=''>대분류</option>")
			$(".addCheckList").eq(1).empty().append("<option value=''>중분류</option>")
			$(".addCheckList").eq(2).empty().append("<option value=''>소분류</option>")
			for(var i=0;i<data.length;i++){
				$.each(data[i],function(key,value){
					if(key=="type"){
						if(value=="대분류"){
							select = $("#categorySelect")
							select.append("<option>"+data[i].value+"</option>")
							$(".addCheckList").eq(0).append("<option>"+data[i].value+"</option>")
							$(".conditionAddSelect").eq(0).append("<option>"+data[i].value+"</option>")
						}
						else if(value=="중분류"){
							select = $("#divisionSelect")
							select.append("<option>"+data[i].value+"</option>")
							$(".conditionAddSelect").eq(1).append("<option>"+data[i].value+"</option>")
						}
						else if(value=="소분류"){
							select = $("#sectionSelect")
							select.append("<option>"+data[i].value+"</option>")
						}
					}
				})
			}
		}
		else if(xhr.status == 202){
			alert("Column데이터를 가져오지못했습니다.");
		}
	})
}

//종류 상세가 표기 넘어올것은 select태그 기본이 종류 (대분류,중분류,소분류) 그냥 .addCheckList하나랑 이벤트대상(바뀐애가 누군지 찾아서 다음에 적용할려고)
function changeColumn(addCheckList,thisEvent){
	//arguments.length; 넘어오는 아규먼트의 수 체크
	var index = addCheckList.index(thisEvent)
	//console.log(index); 
	if(index==0 | index ==1){}
	else{
		return false;
	}
	var search = index == 0 ? "중분류" : "소분류";
	search += ("/"+addCheckList.eq(index).val());
	console.log(search)
	$.ajax({method:"get",url:"/column/"+search})
	.done(function(data,test,xhr){
		if(xhr.status==200){
			if(index==0){
				addCheckList.eq(1).empty().append("<option value=''>중분류</option>")
			}
			else if(index==1){
				addCheckList.eq(2).empty().append("<option value=''>소분류</option>")
			}
			for(var i=0;i<data.length;i++){
				if(index==0){
					addCheckList.eq(1).append("<option>"+data[i].value+"</option>")
				}
				else if(index==1){
					addCheckList.eq(2).append("<option>"+data[i].value+"</option>")
				}
			}
		}
		else if (xhr.status==202){
			alert("changeColumn_처리중 문제발생");
		}
		else if (xhr.status==500){
			alert("changeColumn_서버문제발생");
		}
	})
}