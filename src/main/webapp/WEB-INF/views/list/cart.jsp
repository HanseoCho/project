<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HanS:hop</title>
<link rel="stylesheet" type="text/css" href="/css/style.css?var=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	
<script src="/js/main.js?var=6"></script>
<style>
    .gray{
        color: #969696;
    }    
    .proSub{
        width: calc(100%/2 + 20%);
    }
    .proNum{
        width: calc(calc(100%/2+20%)/3);
    }
    .proPri{
        width: calc(calc(100%/2+20%)/3);
    }
    .proAllPri{
        width: calc(calc(100%/2+20%)/3);
    }
    .tc{
        text-align: center;
        padding: 10px 0;
    }
    .vc{
        display: table;
        vertical-align: middle;
        width: 100%;
        height: 100%;
    }
    .vc_s{
        display: table-cell; text-align: center; vertical-align: middle; height: 100%; width: 100%;
    }
    
    .payRadio{
        margin: 0 3px;
    }
    .refundChose{
        width: 40%;
        height: 100px;
        border: 1px solid black;
        background-color: #ededed;
        color: #b4b4b4;
    }    
    .refundChose_{
        width: 40%;
        height: 100px;
        border: 1px solid black;
        background-color: white;
    }    
    .refundBox{
        position: relative;
        left: 3%;
        top: 10%;
        width: 95%;
    }
    .regBtn:hover{
    	cursor: pointer;
    }
</style>
<script>
    $(function(){
        $(".leftBox").on("click",function(){
            $(".leftBox").removeClass("refundChose");
            $(".rightBox").removeClass("refundChose_");
            $(".rightBox").addClass("refundChose");
            $(".leftBox").addClass("refundChose_");
            $("input[name=refundC]").removeAttr("checked");
            $("input[name=refundC]").eq(0).prop("checked",true);
        })
        $(".rightBox").on("click",function(){
            $(".rightBox").removeClass("refundChose");
            $(".leftBox").removeClass("refundChose_");
            $(".leftBox").addClass("refundChose");
            $(".rightBox").addClass("refundChose_");
            $("input[name=refundC]").removeAttr("checked");
            $("input[name=refundC]").eq(1).prop("checked",true);
        })
        $(".regBtn").on("click",function(){
        	alert("구입은 아직 구현하지못했습니다.")
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
            </ul>
        </div>        
        <div class="fl_gr2 headerRightBar fontBlock rightMt" >
            <a>LOGIN</a>
            <a>JOIN</a>
            <a>MYPAGE</a>
            <a>장바구니</a>
        </div>        
    </header>
    <div class="wrap" style=""> 
        <div id="sidebar" class="fl fl_col">
            <ul>
                <li>인기상품</li>
            </ul>
        </div>  
        <div class="sbody" >
            <div  style="top: 20px;">
                <h3 style="display: inline-block;">ORDER / PAYMENT</h3>  <span class="gray" style="">주문/결제</span>
                <hr>
                <h5 style="display: inline-block;">PRODUCT INFO</h5>   <span class="gray" style="font-size: 0.8em;">상품 정보</span>
                <div class="fl fl_row">
                    <div class="proSub tc">상품정보</div><div class="proNum tc">수량</div><div class="proPri tc">상품 금액</div><div class="proAllPri tc">주문금액</div>
                </div>
                <div class="fl fl_row" style="margin: 10px 0; height: 90px;">
                    <div class="proSub" style="">
                        <div class="" style="position: relative;left: 3%;">
                            <img src="img/test1.jpg" style="width: 100px; height: 80px;">
                            <span style="position: relative; left: 5px;">가나다라마바사<span style="position: absolute;left: 0;top: 17px; font-size: 0.8em;">옵션 M</span></span>
                        </div>
                    </div>
                    <div class="proNum">
                        <div class="vc">
                            <div class="vc_s">2개</div>
                        </div>
                    </div>
                    <div class="proPri">
                        <div class="vc">
                            <div class="vc_s" >10000원</div>
                        </div>
                    </div>
                    <div class="proAllPri">
                        <div class="vc">
                            <div class="vc_s">20000원</div>
                        </div>
                    </div>
                </div>
                <hr>
                <!--//배송지 https://store.musinsa.com/app/order/order_form -->
                
                <div class="fl fl_col" style="width: 100%; height: 300px; background-color: aliceblue">
                    <div class="fl fl_row">
                        <div style="width: 80%"><h5 style="display: inline-block;"><b>RECIPIENT INFO </b></h5>   <span class="gray" style="font-size: 0.8em;">수령자 정보</span></div>
                        <div style="width: 20%"><h5 style="display: inline-block;">BUYER INFO </h5>   <span class="gray" style="font-size: 0.8em;">구매자 정보</span></div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 10px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">배송지선택</div>
                                <div><input type="radio" name="adr" value="1">기본배송지(구매자 정보)<input type="radio" name="adr" value="0">새로입력</div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%"><input type="text" name="name" value="이름"></div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 10px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">수령인/배송지명</div>
                                <div><input type="text" style="width: 120px;"></div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%">
                            <input type="text" name="name" value="이메일ID" style="width: 40%;">@
                           <select id="test" style="width: 40%;">
                               <option value="0">- 이메일 선택 -</option>
                               <option value="naver.com">naver.com</option>
                               <option value="daum.net">daum.net</option>
                               <option value="gmail.com">gmail.com</option>
                               <option>직접입력</option>
                           </select>                            
                        </div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 10px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">휴대전화</div>
                               <div class="fl_gr1" style="">
                                   <select>
                                       <option>010</option>
                                       <option>070</option>
                                       <option>016</option>
                                       <option>017</option>
                                       <option>018</option>
                                       <option>019</option>
                                   </select>
                                   -
                                   <input type="text" style="width: 50px;" maxlength="4">
                                   -
                                   <input type="text" style="width: 50px;" maxlength="4">
                               </div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%"><input type="text" name="name" value="조한서"></div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 10px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">배송지주소</div>
                                <div style="width: 85%;">                       
                                        <input type="text" id="sample2_postcode" placeholder="우편번호">
                                        <input type="button" id="daum_search" value="우편번호" style="background-color: white; font-size: 0.9em;width: 90px; height: 25px;"><br>
                                        <input type="text" id="sample2_address" style="width: 30%; margin: 5px 0; "><span class="joinInfo"> 기본주소</span><br>
                                        <input type="text" id="closeAddress" style="width: 30%; margin: 0 0 5px 0;"><span class="joinInfo"> 나머지주소 
                                            <input type="checkbox">기본배송지 등록</span>
                                        <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
                                        <div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
                                        <img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1"  alt="닫기 버튼">
                                        </div>
                               </div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%"></div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 30px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">배송메모</div>
                                <div><textarea cols="90;" style="resize:vertical;"></textarea></div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%"></div>
                    </div>                    
                </div>
                
            <!--결제정보-->                
                <div class="fl fl_col" style="width: 100%; height: 400px; background-color: aliceblue">
                    <div class="fl fl_row">
                        <div style="width: 80%"><h5 style="display: inline-block;"><b>PAYMENT INFO / AGREEMENT </b></h5>   <span class="gray" style="font-size: 0.8em;">결제 정보 / 주문자 동의</span></div>
                        <div style="width: 20%"><h5 style="display: inline-block;"></h5>   <span class="gray" style="font-size: 0.8em;"></span></div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 10px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">결제수단</div>
                                <div><input type="radio" class="payRadio">신용카드 <input type="radio" class="payRadio">가상계좌 <input type="radio" class="payRadio">계좌이체 
                                    <input type="radio" class="payRadio">휴대전화<input type="radio" class="payRadio">해외카드<input type="radio">TOSS 
                                    <input type="radio">페이코 <input type="radio">카카오페이
                                </div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%"><b>&nbsp;&nbsp;</b></div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 10px 0 20px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">결제 안내</div>
                                <div style="width: 85%;">
                                    <select style="height: 25px;">
                                        <option>입금은행 선택</option>
                                        <option>기업은행</option>
                                        <option>국민은행</option>
                                        <option>우리은행</option>
                                        <option>수협</option>
                                        <option>농협</option>
                                        <option>부산은행</option>
                                        <option>SC제일은행</option>
                                        <option>신한은행</option>
                                        <option>KEB하나은행</option>
                                        <option>광주은행</option>
                                        <option>우체국</option>
                                        <option>대구은행</option>
                                        <option>경남은행<option>
                                    </select>
                                    <input type="text" readonly disabled value="이름" style="width: 20%; height: 25px;"><br>
                                    <p class="gray"><b>가상 계좌 안내</b>계좌 유효 기간 2018년 09월 04일 23시 59분 59초<br>
                                    무통장입금(가상 계좌)는 각 주문별로 새로운 계좌번호가 생성되는 방식으로 해당계좌로 주문금액을 입금하시면 자동으로 입금확인 처리됩니다.<br> 
                                    단, 자동으로 처리되기 때문에 주문금액과 정확히 동일한 금액을 입금하셔야만 입금이 가능합니다. 주문금액이 87,950원일 경우 88,000원이나 90,000원을 입금하시면 입금되지 않습니다. 인터넷뱅킹, 텔레뱅킹, ATM/CD 기계, 은행 창구 등에서 입금하실 수 있습니다.</p>
                                </div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%">
                                                       
                        </div>
                    </div>
                    <!--배송지-->
                    <div class="fl fl_row" style="margin: 10px 0px;">
                        <!--왼쪽-->
                        <div style="width: 80%">
                            <div style="position: relative;left: 1%;" class="fl fl_row">
                                <div style="width: 15%;">품절시 처리방법</div>
                               <div class="fl_gr1 fl fl_row" style="width: 85%;">
                                   <div class="refundChose_ leftBox" style="margin-right: 20px;">
                                      <div class="refundBox">
                                           <input type="radio" name="refundC"><span style="font-size: 1.2em; font-weight: 400;">&nbsp;REFUND환불</span><br>
                                           <span>
                                               환불을 선택하시면 별도의 연락 없이 선택하신<br> 결제 방법으로 환불해 드립니다.
                                           </span>
                                       </div>
                                   </div>
                                   <div class="refundChose rightBox">
                                      <div class="refundBox">
                                          <input type="radio" name="refundC"><span style="font-size: 1.2em; font-weight: 400;">&nbsp;EXCHANGE교환</span><br>
                                           <span>
                                               교환을 선택하시면 주문자 정보를 통해 연락드린 후 교환을 도와드리겠습니다.
                                           </span>
                                       </div>
                                   </div>
                               </div>
                            </div>
                        </div>
                        <!--오른쪽-->
                        <div style="width: 20%"></div>
                    </div>                   
                </div>
                <div style="text-align: center; width: 100%; padding: 20px 0;">
                    <span class="regBtn" style="background-color: black; color: white; font-size: 1.1em; padding: 20px 15px;">PAYMENT <span class="gray" style="font-size: 0.8em;">결제하기</span></span>
                </div>
                            
            </div>
        </div>
    </div>
</body>
</html>