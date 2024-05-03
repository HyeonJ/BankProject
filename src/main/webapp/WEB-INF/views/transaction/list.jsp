<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>솔트뱅크 : 거래내역조회</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">

    // 페이지가 로드될 때 실행되는 함수
    window.onload = function() {
        var accountId = getAccountIdFromURL(); // accountId를 가져옵니다.
        var selectElement = document.getElementById('selectedAccount'); // select 요소를 가져옵니다.
        var options = selectElement.options; // select 요소의 옵션들을 가져옵니다.
        
        // 각 옵션을 순회하며 accountId와 value가 일치하는 옵션을 찾습니다.
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === accountId) {
                options[i].selected = true; // 해당 옵션을 선택합니다.
                break; // 선택을 찾았으므로 더 이상 순회할 필요가 없습니다.
            }
        }
        loadTransactions(accountId, 1);
    };
	
 	$(document).ready(function(){
	    // 선택이 변경될 때마다 실행되는 함수
 	    $('select[name="selectedAccount"]').change(function(){
  	    	var accountId = $(this).val(); // 선택된 계좌 ID 가져오기
  	   		// Context root 수정으로 인해 '/bank' 제거
	        var baseUrl = '/transaction/'; // 기본 URL 설정
	        var url = baseUrl + accountId; // 선택된 계좌 ID를 포함한 URL 생성
	        window.location.href = url; // URL로 이동
	        //loadTransactions(accountId, 1);
	    });

	    $('ul.pagination').on('click', 'a.page-link', function(e) {
	        e.preventDefault(); // 기본 이벤트를 방지합니다.
	        var page = $(this).data('page'); // 클릭된 링크의 페이지 번호를 가져옵니다.
	        var accountId = $('select[name="selectedAccount"]').val();
	        loadTransactions(accountId, page); // 페이지 번호와 함께 트랜잭션 로드
	        
	        setPageActive(page);
	    });
	}); 

	function loadTransactions(accountId, page) {
	    var userId = 1; // 사용자 ID, 필요한 경우 수정할 수 있음
	    // AJAX 요청 보내기
	    $.ajax({
	    	// Context root 수정으로 인해 '/bank' 제거
	        url: '/api/transaction/list/' + accountId, // 요청을 보낼 서버의 URL 주소
	        type: 'GET',
	        data: { page: page }, // 서버로 보낼 데이터
	        success: function(data) {
	        	//console.log(data);
	        	// 현인: 적요 -> 거래자명 수정 및 deposit, transfer를 한글로 변경(var transactionType)
	               var html = '<table id="transactionTable" class="table table-bordered  table-hover">';
	               html += '<thead class="table-light">'
	               html += '<tr>'+
	                           '<th>날짜</th>'+
	                           '<th>구분</th>'+
	                           '<th>거래자명</th>'+
	                           '<th class="text-end">출금액</th>'+
	                           '<th class="text-end">입금액</th>'+
	                           '<th class="text-end">잔액</th>'+
	                       '</tr></thead><tbody>';
	               $.each(data, function(index, item) { // data는 JSON 배열이라고 가정
	                   var transactionDate = new Date(item.TRANSACTIONDATE); // Unix 타임스탬프를 날짜 객체로 변환
	                   var formattedDate = transactionDate.toLocaleString(); // 로컬 시간 문자열로 변환
	                   var transactionType = item.TYPE;
	                   if(transactionType === null || transactionType === "") {
	                      transactionType = "-";
	                   } else if(transactionType === "deposit") {
	                     transactionType = "입금";
	                  } else if(transactionType === "transfer") {
	                     transactionType = "이체";
	                  }
	                   html += '<tr>';
	                   html += '<td>' + formattedDate + '</td>';
	                   html += '<td>' + transactionType + '</td>';
	                   html += '<td>' + (item.NAME ? item.NAME : '-') +  '</td>';
	                   html += '<td class="text-end">' + (item.AMOUNTTRANSFER != null ? item.AMOUNTTRANSFER.toLocaleString('ko-KR') : 0) + ' 원</td>';
	                   html += '<td class="text-end">' + (item.AMOUNTDEPOSIT != null ? item.AMOUNTDEPOSIT.toLocaleString('ko-KR') : 0) + ' 원</td>';
	                   html += '<td class="text-end">' + (item.AMOUNTACCOUNT != null ? item.AMOUNTACCOUNT.toLocaleString('ko-KR') : 0) + ' 원</td>';
	                   html += '</tr></tbody>';
	               });
	            html += '</table>';
	            // 서버로부터 받은 데이터를 처리하여 테이블에 추가
	            $('#transactionTableContainer').html(html);
	         	// 현인: 거래 내역이 없을 시 '조회 결과가 없습니다.' 문구 추가
	            checkNoResult();
	            setPageActive(page);//페이지 로드 시 버튼 선택
	        },
	        error: function(xhr, status, error) {
	            console.error(xhr.responseText);
	            // 에러 처리
	        }
	    });
	} 
	
	function getAccountIdFromURL() {
        // 현재 URL에서 accountId를 추출하는 로직을 구현해야 합니다.
        // 예를 들어, http://localhost:8080/transaction/123 의 경우 "123"을 추출해야 합니다.
        // 추출한 accountId를 반환합니다.
        // 이 예제에서는 단순히 URL에서 accountId 부분을 추출하지만, 실제로는 더 복잡할 수 있습니다.
        var url = window.location.href;
        var accountId = url.substr(url.lastIndexOf('/') + 1);
        return accountId;
    }

	
	function setPageActive(pageNumber) {
	    // 모든 페이지 버튼의 활성화 상태를 초기화합니다.
	    var pageButtons = document.querySelectorAll('.pagination .page-item');
	    pageButtons.forEach(function(button) {
	        button.classList.remove('active');
	    });

	    // 선택한 페이지 버튼을 비활성화하고, 선택한 페이지 버튼의 이전과 다음 버튼을 활성화합니다.
	    var selectedButton = document.querySelector('.pagination .page-item:nth-child(' + pageNumber + ')');
	    selectedButton.classList.add('active');

	    // 선택한 페이지 버튼을 disable로 변경합니다.
	    var allLinks = document.querySelectorAll('.pagination .page-link');
	    allLinks.forEach(function(link) {
	        link.removeAttribute('disabled');
	    });
	    var selectedLink = selectedButton.querySelector('.page-link');
	    selectedLink.setAttribute('disabled', 'true');
	}
	
	// URL에서 숫자를 추출하는 함수
	function extractNumberFromURL() {
	  var url = window.location.href;
	  var matches = url.match(/\/(\d+)$/); // URL에서 숫자를 추출하는 정규표현식
	  if (matches) {
	    return parseInt(matches[1]); // 추출한 숫자를 반환
	  }
	  return null; // 숫자를 찾지 못한 경우 null 반환
	}

    function downloadTransaction() {
        var accountId = $('#selectedAccount').val(); // 선택된 계정의 ID 가져오기
        // 서버로 요청 보내기
        // Context root 수정으로 인해 '/bank' 제거
        window.location.href = '/transaction/download/' + accountId;
    }
    
    // 현인: 거래내역이 없을 경우 '조회 결과가 없습니다' 문구 출력
    function checkNoResult() {
    	var numTd = $('#transactionTable td').length;

    	 if (numTd === 0) {
             if (!$('.noResult').length) {
                 $('<div class="noResult" style="text-align: center;">조회 결과가 없습니다.</div>').appendTo('#transactionTableContainer');
             }
         } else {
             $('.noResult').remove();
         }
    }

	</script>
</head>
<body>
<%@ include file="../../fix/header.jsp" %>
	<div class="page-section" style="min-height:500px">
	    <div class="container">
	        <h5>거래내역조회</h5>
	        <hr>
	        <div>솔트룩스통장</div>
	        	        
	        <div class="col-3">
				<div class="mb-3">
					<select name="selectedAccount" id="selectedAccount" class="form-select"  aria-label="Default select example">
					    <!-- foreach에 if 추가 -->
	                   <c:forEach var="account" items="${accountList}">
	                      <c:if test="${account.isDeleted == 0 }">
	                          <option id="${account.accountId}" value="${account.accountId}">${account.accountNumber}</option>
	                     </c:if>
	                   </c:forEach>
					</select>
				</div>
	        </div>
	        
	        <div id="transactionTableContainer">
	        	<!-- 이 곳에 거래 목록이 동적으로 추가될 것입니다. -->
	        </div>
			
			<ul class="pagination">
			    <% int totalPages = (Integer) request.getAttribute("totalPages");
			       int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
			       int pageBlock = 10;
			       int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
			       int endPage = startPage + pageBlock - 1;
			       endPage = endPage > totalPages ? totalPages : endPage;
			    %>
			    <% if (startPage > pageBlock) { %>
			        <li class="page-item"><a href="#" class="page-link" data-page="<%= startPage - 1 %>">&laquo;</a></li>
			    <% } %>
			    <% for (int i = startPage; i <= endPage; i++) { %>
			        <li class="page-item">
			        <!-- 버튼의 a 클래스에서 클릭 이벤트를 만들어서 선택한 버튼은 disable, 나머지는 enable로 -->
			            <a href="#" class="page-link" onclick="btnActive(<%= i %>)" data-page="<%= i %>"><%= i %></a>
			        </li>
			    <% } %>
			    <% if (endPage < totalPages) { %>
			        <li class="page-item"><a href="#" class="page-link" data-page="<%= endPage + 1 %>">&raquo;</a></li>
			    <% } %>
			</ul>
	
	        			
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
				<button class="btn btn-outline-primary btn-sm" type="button" onclick="downloadTransaction()">거래내역 다운로드</button>
			</div>
	
	    </div> 
    </div>


<%@ include file="../../fix/footer.jsp" %>
</body>
</html>
