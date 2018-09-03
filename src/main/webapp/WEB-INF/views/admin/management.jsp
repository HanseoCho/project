<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/detail.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/js/main.js?var=5"></script>
<script src="/js/admin/management.js?var=2"></script>
<style>
.pleft{
	font-size: 1.3em;
	display: inline-block; 
	width: 200px;
}

.pright{
	font-size: 0.9em;
	width:calc(100% - 200px);
}
.divtb{
	padding: 0 0 10px 0;
}

.proHead{
	width:200px;
	
}
.th{
    width: 100%;
    text-align: center;
    border: 1px solid black;
    font-weight: 800;
    font-size: 0.9em;
}
.td{
    width: 100%;
    text-align: center;
    border: 1px solid black;
    font-size: 0.8em;
}
.hide{
	display: none;
}
#adminSidebar ul li{
	margin: 5px 0;
}
#adminSidebar ul li:hover {
	cursor: pointer;
}
.cur:hover{
	cursor: pointer;
}
.analChose{
    width: 40%;
    height: 100px;
    border: 1px solid black;
    background-color: #ededed;
    color: #b4b4b4;
}    
.analChose_{
    width: 40%;
    height: 100px;
    border: 1px solid black;
    background-color: white;
}    
.analBox{
    position: relative;
    left: 3%;
    top: 10%;
    width: 95%;
}
.analViewBox{
    width: 50%;
    height: 250px;
}
</style>
<script>
//로딩

var aData = {};
var columns = [{"string":"중분류","number":"건수"},{"string":"소분류","number":"건수"},{"string":"금액","number":"건수"},{"string":"색상","number":"건수"}];
var viewList = [
	{ option: {
         chartType: 'PieChart',
         options: {'title': '중분류별 분석',pieHole: 0.4},
         containerId: 'chart_1'
        }},
	{option: {
         chartType: 'PieChart',
         options: {'title': '소분류별 분석',pieHole: 0.4},
         containerId: 'chart_2'
       }},
       {option: {
        chartType: 'BarChart',
        options: {'title': '가격대별 분석'},
        containerId: 'chart_3'
      }},
      {option: {
          chartType: 'ColumnChart',
          options: {'title': '인기색상 분석'},
          containerId: 'chart_4'
        }}       
];
$(function(){
	var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="/img/viewLoading.gif" /></div>').appendTo(document.body).hide();
    $(".leftBox").on("click",function(){
        $(".leftBox").removeClass("analChose");
        $(".rightBox").removeClass("analChose_");
        $(".rightBox").addClass("analChose");
        $(".leftBox").addClass("analChose_");
        $("input[name=analC]").removeAttr("checked");
        $("input[name=analC]").eq(0).prop("checked",true);
        $.ajax({method:"get",url:"/mr/0/0",beforeSend:function(){
        	loading.show();
    	},
    	complete:function(){
    		loading.hide();
    	},
    	error:function(){
    		loading.hide();
    	}
    	})
        .done(function(data){
            console.log(data);
            aData=data;
	        google.charts.load('current');
	    	google.charts.setOnLoadCallback(drawVisualization);
        })
    }).on("mouseover",function(){
        $(".leftBox").removeClass("analChose");
        $(".rightBox").removeClass("analChose_");
        $(".rightBox").addClass("analChose");
        $(".leftBox").addClass("analChose_");
        $("input[type=month]").attr("disabled","disabled");
        $("#monthBtn").attr("disabled","disabled");
    })
    
    $(".rightBox").on("click",function(){
        $(".rightBox").removeClass("analChose");
        $(".leftBox").removeClass("analChose_");
        $(".leftBox").addClass("analChose");
        $(".rightBox").addClass("analChose_");
        $("input[name=analC]").removeAttr("checked");
        $("input[name=analC]").eq(1).prop("checked",true);
        $("input[type=month]").removeAttr("disabled");
        $("#monthBtn").removeAttr("disabled");
        $("#monthBtn").off().on("click",function(){
            if($("input[type=month]").val()==""){
                alert("입력하신 날짜를 확인해주세요");
                return false;
            }
            var month = [];
            month = $("input[type=month]").val().split("-")
            $.ajax({method:"get",url:"/mr/"+month[0]+"/"+month[1],beforeSend:function(){
        		loading.show();
        	},
        	complete:function(){
        		loading.hide();
        	},
        	error:function(){
        		loading.hide();
        	}
        	})
            .done(function(data){
                console.log(data);
                aData=data;
          	  	google.charts.load('current');
        	  	google.charts.setOnLoadCallback(drawVisualization);
            })
        });
    }).on("mouseover",function(){
        $(".rightBox").removeClass("analChose");
        $(".leftBox").removeClass("analChose_");
        $(".leftBox").addClass("analChose");
        $(".rightBox").addClass("analChose_");
    })	
    
})
function drawVisualization() {
	var i=0;
	$.each(aData,function(index,value){
		getData(i);
		i=i+1;
	})
}
wrapper = {};
function getData(num){
			console.log("num");
			console.log(num);
			// json 데이터 변수 담기
			// 컬럼 정보 확인 (예외처리)
			if(aData.length == 0){
				alert("잘못된 호출 입니다.");
				return false;
			}
			console.log(1)
			// 구글 차트에 사용 할 데이터 만들기
			var chartData = new google.visualization.DataTable();
			console.log(2)
			// 컬럼 데이터 설정

			$.each(columns[num], function(key,value) {
				console.log("key : "+key);
				console.log("value : "+value);
				chartData.addColumn(key, value);
			});
			console.log(3)
			// 차트 데이터 설정
			$.each(aData["result"+num], function(index, value) {
				var row = [];
				console.log(value);
				row[0] = value[0];
				row[1] = Number(value[1]);
/* 				for(var i = 0; i < columns.length; i++){
					row[i] = value[columns[i].column];
				} */
				chartData.addRows([ row ]);
			});
			viewList[num].option.dataTable = chartData;
			wrapper[num] = new google.visualization.ChartWrapper(viewList[num].option);
      		wrapper[num].draw();      			
};
</script>  
</head>
<body>
    <header class="header fl fl_row" style="top: 0;">
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
    <div style="" class="wrap"> 
        <div id="adminSidebar" class="fl fl_col">
            <ul>
            	<li>상품종류관리</li>
                <li>상품추가</li>
                <li>이벤트박스 관리</li>
                <li>유저관리</li>
                <li>통계분석</li>
            </ul>
        </div>
        <div class="sbody" style="top: 20px; height:100vh;">
        	<div id="fText"  style="text-align: center; ">
        		<h3>관리자 전용 페이지 입니다.</h3>
        	</div>
        	<!-- 상품종류관리 -->
        	<div class="adboxs hide" id="adcolAdd" style="height: 60vh;">
        		<div style="text-align: center;"><h2>상품종류관리</h2></div>
        		<div style="text-align: center; margin-left: 25%;">
	        		<div class="fl fl_row">
	        			<div class="fl fl_col proHead" style="margin-right: 10px;">
	        				대분류
	        				<input type="hidden" value="대분류">
	        				<select size="10" id="categorySelect" class="checkList">
	        				</select>
	        			</div>
	        			<div class="fl fl_col proHead" style="margin-right: 10px;">
	        				중분류
	        				<input type="hidden" value="중분류">
	        				<select size="10" id="divisionSelect" class="checkList">
	        				</select>        				
	        			</div>
	        			<div class="fl fl_col proHead">
	        				소분류
	        				<input type="hidden" value="소분류">
	        				<select size="10" id="sectionSelect" class="checkList"> 
	        				</select>        				
	        			</div>
	        		</div>
	        	</div>
	        	<div style="text-align: center;">
	        		<input type="button" id="delColumn" value="삭제" style="position: relative; top: 10px; right:20px;">
	        	</div>
	        	<hr>
	        	<h3 style="text-align: center;">추가할 상품종류</h3>
	        	<div style="margin-left: 25%; font-size: 0.8em;">
	        		<form name="addForm" >
		        		<select id="columnAddSelect" name="type">
		        			<option>종류</option>
		        			<option>대분류</option>
		        			<option>중분류</option>
		        			<option>소분류</option>
		        		</select>
		        		<select name="category" class="conditionAddSelect" disabled="disabled">
		        		</select>
			        	<select name="division" class="conditionAddSelect" disabled="disabled">
		        		</select>
		        		<input type="text" style="width:300px;" id="columnAddText" name="value">
		        		<input type="button" id="columnAddResult" value="추가">
	        		</form>
	        	</div>
        	</div>
        	<!-- 상품작성 -->
        	<div class="adboxs hide" id="adpdAdd" style="height: ;">
        		<form name="productAppend">
        		<div class="fl fl_col">
        			<h3 style="text-align: center;">상품추가</h3>
        			<div class="divtb">
        				<select class="addCheckList" name="category">
        					<option>대분류</option>
        				</select>
        				<select class="addCheckList" name="division">
        					<option>중분류</option>
        				</select>
        				<select class="addCheckList" name="section">
        					<option>소분류</option>
        				</select>
        			</div>
        			<div class="divtb">
        				<div class="pleft">상품명</div><input class="pright" type="text" name="subject">
        			</div>
        			<div class="divtb">
        				<div class="pleft">가격</div><input class="pright" type="number" name="price">
        			</div>
        			<div class="fl fl_row divtb">
        				<div class="pleft">색깔</div>
        				<div>
        					<div class="fl fl_row">
	        					<input type="text" id="coloresInput" style="display: inline-block;"><input class="pright" id="colorResult" type="button" value="추가">
	        				</div>
							<div id="coloresSee" class="infoarea_f1" style="margin: 10px 0;">
							</div>
        				</div>
        			</div>
        			<div class="fl fl_row divtb">
        				<div class="pleft">사이즈</div>
        				<div>
        					<div class="fl fl_row">
	        					<input type="text" id="sizeInput" style="display: inline-block;"><input class="pright" id="sizeResult" type="button" value="추가">
	        				</div>
							<div id="sizeSee" class="infoarea_f1" style="margin: 10px 0;">
							</div>
        				</div>
        			</div>        			
        			<div class="fl fl_row divtb">
        				<div class="pleft">details</div>
        				<textarea class="pright" rows="5" cols="50" name="details"></textarea>
        			</div>
           			<div class="fl fl_row divtb">
        				<div class="pleft">viewImage</div>
        				<div>
        					<div class="fl fl_row">
	        					<input type="file" name="viewImage" style="display: inline-block;" multiple="multiple">
	        				</div>
	        				<div id="loadImgs" style="height:200px; overflow-x: auto;">
	        					<span style="text-align: center; position: relative; top: 30px;">ViewImage는 3개까지 가능합니다</span>
	        				</div>
        				</div>
        			</div>

           			<div class="fl fl_row divtb">
        				<div class="pleft">moreInfo</div>
        				<div>
        					<div class="fl fl_row">
	        					<input type="file" name="infoImage" style="display: inline-block;">
	        				</div>
	        				<div id="infoImgs" style="height:200px;">
	        					<span style="text-align: center; position: relative; top: 30px;">morInfo이미지는 1개만 가능합니다</span>
	        				</div>
        				</div>
        			</div>
        			<input type="button" name="productResult" value="상품등록" style="font-size: 1.2em;">
        			<input type="reset" value="리셋" style="font-size: 1.2em;">
        		</div>
        		</form>
        	</div>
        	<!-- 이벤트박스 관리  -->
    	    <div class="adboxs hide" id="adindexEvent">
                <div style="text-align: center;"><h2>인덱스화면 관리</h2></div>
                <div style="text-align: center; position: relative; height: 150px;">
                    <span style="font-size: 0.9em;">이벤트박스 예시</span>
                    <div class="fl fl_col" style="font-size: 0.9em; position: absolute;left: 46%;" >
                        <div class="fl fl_row" style="width: 100px;">
                            <div style="width: calc(100%/3);">1</div>
                            <div style="width: calc(100%/3);">2</div>
                            <div style="width: calc(100%/3);">3</div>
                        </div>
                        <div class="fl fl_row" style="width: 100px;">
                            <div style="width: calc(100%/3);">4</div>
                            <div style="width: calc(100%/3);">5</div>
                            <div style="width: calc(100%/3);">6</div>
                        </div>
                    </div>
                </div>
                <div>
                    <div style="position: relative; text-align: left;">
                        <form name="eventBoxForm">
                            <div class="fl fl_col" style="position: absolute; left: 35%; height: 400px;">
                                <div class="fl fl_row" style="width: 600px;">
                                    <select name="no">
                                    <option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option>
                                    </select>번째
                                </div>
                                <div class="fl fl_row" style="width: 600px;">
                                    <div style="width: 130px;">이동할 URL주소</div>
                                    <div style="width: ;"><input name="location" type="text"></div>
                                </div>
                                <div class="fl fl_row" style="width: 600px;">
                                    <div style="width: 130px;">변경할 이미지  </div>
                                    <div style="width: ;"><input name="eventBoxImage" type="file"><input name="eventBoxSubmit" type="button" value="수정"></div>
                                </div>
                                <div id="eventImgs" style="height:200px;">
                                    <span style="text-align: center; position: relative; top: 30px;">미리보기</span>
                                </div>
                            </div>                        
                        </form>
                    </div>
                </div><br><br><br><br><br><br><br><br>
            </div>
        	<!-- 유저관리 -->
            <div id="adUser" class="userManage hide adboxs" style="padding: 0 10px;">
                <div style="text-align: center;">
                    <h3>유저관리</h3>
                </div>
                <div class="fl fl_row">
                    <div class="th">아이디</div>
                    <div class="th">이름</div>
                    <div class="th">가입일</div>
                    <div class="th">차단여부</div>
                </div>
            </div>
        <!-- 분석화면 -->
            <div id="analysis" class="hide adboxs" style="height:80vh; padding: 0 10px;">
                <div style="text-align: center;">
                    <h3>통계분석</h3>
                </div>
                <br>
                <div class="fl fl_row">
                    <div style="width: 100%;">
                        <div style="text-align: center;">
                               <div class="fl_gr1 fl fl_row" style="width: 100%;">
                                   <div class="analChose leftBox" style="margin: 0 80px 0 80px;">
                                      <div class="analBox">
                                           <input type="radio" name="analC"><span style="font-size: 1.2em; font-weight: 400;">&nbsp;전체분석</span><br>
                                           <span>
                                               쇼핑몰에 상품조회로 인한 데이터를 전부 분석합니다.<br>
                                               <span style="color: #c9c9c9;">분석할 데이터가 많아 오래걸릴수 있습니다.</span>
                                               
                                           </span>
                                       </div>
                                   </div>
                                   <div class="analChose rightBox">
                                      <div class="analBox">
                                          <input type="radio" name="analC"><span style="font-size: 1.2em; font-weight: 400;">&nbsp;세부분석</span><br>
                                           <span>
                                               연도와 월을 지정해 상품조회로 인한 데이터를 분석합니다.<br>
                                               <input type="month" style="width: 150px; margin-right: 10px;" disabled><input id="monthBtn" type="button" value="검색" disabled>
                                           </span>
                                       </div>
                                   </div>
                               </div>                            
                        </div>
                    </div>
                </div>
                <hr>
                <div class="fl fl_row">
                    <div class="analViewBox" id="chart_1"></div>
                    <div class="analViewBox" id="chart_2"></div>
                </div>
                <div class="fl fl_row">
                    <div class="analViewBox" id="chart_3"></div>
                    <div class="analViewBox" id="chart_4"></div>
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