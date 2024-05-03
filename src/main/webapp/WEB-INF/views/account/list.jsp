<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
   .noResult {
        padding-top: 80px;
    	padding-bottom: 70px;
    }
</style>

<title>솔트뱅크 : 계좌조회</title>

</head>
<body>
	<%@ include file="../../fix/header.jsp"%>

	<div class="page-section" style="min-height:500px">
		<div class="container">
			<h6><b>계좌조회</b></h6>
			<hr>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
				<!-- <a href="./create"> -->
				<!-- Context root 수정으로 인해 '/bank' 제거 -->
				<button class="btn btn-outline-primary btn-sm " type="button" onclick="location.href='/account/create'">계좌생성</button>
				<!-- <a href="./delete"> -->
				<!-- Context root 수정으로 인해 '/bank' 제거 -->
				<button class="btn btn-outline-danger btn-sm pr-3" type="button" onclick="location.href='/account/delete'">계좌삭제</button>
			</div>
			<!-- Nav tabs -->
			

			
<%-- 			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<c:forEach var="type" items="${accountTypeNames}">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="${type.account_type_name}" data-toggle="tab" data-target="#${type.account_type_name}" type="button" 
						role="tab" aria-controls="${type.account_type_name}" aria-selected="false">${type.account_type_name}</button>
					</li>
				</c:forEach>
			</ul> --%>


			
			
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="transfer-tab" data-toggle="tab" data-target="#transfer" type="button"
						role="tab" aria-controls="transfer" aria-selected="true">입출금</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="deposit-tab" data-toggle="tab" data-target="#deposit" type="button" 
					role="tab" aria-controls="deposit" aria-selected="false">예적금</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="cma-tab" data-toggle="tab" data-target="#cma" type="button" 
					role="tab" aria-controls="cma" aria-selected="false">CMA</button>
				</li>
			</ul>
		
			<!-- Tab panes -->
		
			<div class="tab-content">
				<div class="tab-pane active" id="transfer" role="tabpanel" aria-labelledby="transfer-tab">
                  <div class="row m-1">
                     <ol class="list-group ">
                        
                        <c:forEach var="info" items="${accountInfo}">

                        <c:if test="${info.typeid==1 && info.deleted==0}">
                           <li class="list-group-item d-flex justify-content-between align-items-start">
                              <div class="ms-2 me-auto">
                                 ${info.type}
                                 <div class="fw-bold">${info.account}</div>
                              </div>
                              <div class="ms-2 me-auto">
                                 잔액 : ${info.balance}
                              </div>
                              <div class="smallBtnGroup" style="padding: 5px">
                              	<!-- Context root 수정으로 인해 '/bank' 제거 -->
                                 <button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='/account/transfer/?accountNumber=${info.account}'">이체</button>
                                 <a href="/transaction/${info.accountId}"><button type="button" class="btn btn-outline-success btn-sm">거래내역</button></a>
                              </div>
                           </li>
                        </c:if>
                        </c:forEach>
                        
                     </ol>
                  </div>
               </div>
               
               <div class="tab-pane" id="deposit" role="tabpanel" aria-labelledby="transfer-tab">
                  <div class="row m-1">
                     <ol class="list-group ">
                        
                        <c:forEach var="info" items="${accountInfo}">

                        <c:if test="${info.typeid == 3 && info.deleted==0}">
                           <li class="list-group-item d-flex justify-content-between align-items-start">
                              <div class="ms-2 me-auto">
                                 ${info.type}
                                 <div class="fw-bold">${info.account}</div>
                              </div>
                              <div class="ms-2 me-auto">
                                 잔액 : ${info.balance}
                              </div>
                              <div class="smallBtnGroup" style="padding: 5px">
                              <!-- Context root 수정으로 인해 '/bank' 제거 -->
                                 <button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='/account/transfer/?accountNumber=${info.account}'">이체</button>
                                 <a href="/transaction/${info.accountId}"><button type="button" class="btn btn-outline-success btn-sm">거래내역</button></a>
                              </div>
                           </li>
                        </c:if>
                        </c:forEach>
                        
                     </ol>
                  </div>
               </div>

               <div class="tab-pane" id="cma" role="tabpanel" aria-labelledby="transfer-tab">
                  <div class="row m-1">
                     <ol class="list-group ">
                        
                        <c:forEach var="info" items="${accountInfo}">

                        <c:if test="${info.typeid == 9 && info.deleted==0}">
                           <li class="list-group-item d-flex justify-content-between align-items-start">
                              <div class="ms-2 me-auto">
                                 ${info.type}
                                 <div class="fw-bold">${info.account}</div>
                              </div>
                              <div class="ms-2 me-auto">
                                 잔액 : ${info.balance}
                              </div>
                              <div class="smallBtnGroup" style="padding: 5px">
                              	<!-- Context root 수정으로 인해 '/bank' 제거 -->
                                 <button type="button" class="btn btn-outline-dark btn-sm" onclick="location.href='/account/transfer/?accountNumber=${info.account}'">이체</button>
                                 <a href="/transaction/${info.accountId}"><button type="button" class="btn btn-outline-success btn-sm">거래내역</button></a>
                              </div>
                           </li>
                        </c:if>
                        </c:forEach>
                        
                     </ol>
                  </div>
               </div>
	               </div>
	               </div>
	
		</div>
		
		
		<script>
		/*
		// 현인: '조회 결과가 없습니다.' 문구 출력을 위해 버튼을 누를때마다 list를 검사하는 이벤트 추가
		window.onload = function() {
			checkNoResult();
		}
		
		var tab = document.getElementById('myTab');
		
		tab.addEventListener('click', checkNoResult);
		
		function checkNoResult() {
			var activeTab = document.querySelector('.tab-pane.active');
		    if (activeTab) {
		        var list = activeTab.querySelector('ol.list-group');
		        var items = list.querySelectorAll('li');
				var noResult = activeTab.querySelector('.noResult');
		        
		        if (items.length === 0) {
		        	removeNoResult();
		            list.style.display = 'none'; // 기존 리스트 숨기기
		            var noResultText = document.createElement('div'); // 새로운 div 생성
		            noResultText.textContent = '조회 결과가 없습니다.'; // 텍스트 설정
		            noResultText.style.textAlign = 'center'; // 텍스트 가운데 정렬
		            noResultText.classList.add('noResult');
		            activeTab.appendChild(noResultText); // 생성한 div를 탭에 추가
		        }
		    }
		}
		
		function removeNoResult() {
			var noResult = document.querySelector('.noResult');
			if(noResult !== null) {
				noResult.remove();
			}
		}
		*/
		window.onload = function() {
			checkNoResult();
		}
		
		var tab = document.getElementById('myTab');
	      const navLinks = document.querySelectorAll('.nav-link');

	      var tabName = "transfer";
	      navLinks.forEach(button => {
	          button.addEventListener('click', function() {
	              switch (this.id) {
	                  case 'transfer-tab':
	                      tabName = 'transfer';
	                      break;
	                  case 'deposit-tab':
	                      tabName = 'deposit';
	                      break;
	                  case 'cma-tab':
	                      tabName = 'cma';
	                      break;
	                  default:
	                      tabName = 'transfer';
	              }
	          });
	      });
	      
	      tab.addEventListener('click', checkNoResult);
	      
	      function checkNoResult() {
	         var activeTab = document.querySelector('#' + tabName);
	       //  console.log("checkNoResult")
      	   //      console.log("activeTab")

	          if (activeTab) {
	              var list = activeTab.querySelector('ol.list-group');
	              var items = list.querySelectorAll('li');
	            var noResult = activeTab.querySelector('.noResult');
	              
	              if (items.length === 0) {
	                 
	                 removeNoResult();
	                  list.style.display = 'none'; // 기존 리스트 숨기기
	                  var noResultText = document.createElement('div'); // 새로운 div 생성
	                  noResultText.textContent = '조회 결과가 없습니다.'; // 텍스트 설정
	                  noResultText.style.textAlign = 'center'; // 텍스트 가운데 정렬
	                  noResultText.classList.add('noResult');
	                  activeTab.appendChild(noResultText); // 생성한 div를 탭에 추가
	              }
	          }
	      }
	      
	      function removeNoResult() {
	         var noResult = document.querySelector('.noResult');
	         if(noResult !== null) {
	            noResult.remove();
	         }
	      }
		
		</script>
		<%@ include file="../../fix/footer.jsp"%>
</body>

</html>