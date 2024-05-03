<%@page import="javax.sound.midi.Receiver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.example.bank.service.AccountService"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<title>솔트뱅크 : 계좌이체</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../../fix/header.jsp"%>
	<form action="#" method="post" id="transferForm">
		<div class="page-section" style="min-height: 500px">
			<div class="container">
				<h6>
					<b>계좌이체</b>
				</h6>
				<hr>

				<div class="" style="margin: auto;">
					<div class="row">
						<div class="mb-3">

							<div class="card">
								<div class="card-header">출금정보</div>
								<div class="card-body">
									<label for="withdrawAccountNumber" class="form-label">출금
										계좌 선택</label> <select name="senderAccountNumber"
										id="withdrawAccountNumber" class="form-select"
										aria-label="Default select example">
										<c:forEach var="account" items="${accounts}">
											<c:choose>

												<c:when test="${account.account == senderAccountNumber}">
													<option value="${account.account}" data-balance="${account.balance}" selected>${account.account}</option>
												</c:when>

												<c:otherwise>
													<c:if test="${account.ISDEL == 0}">
														<option value="${account.account}" data-balance="${account.balance}">${account.account}</option>
													</c:if>
												</c:otherwise>

											</c:choose>
										</c:forEach>
									</select>

									<div class="mb-3">
										<label for="txtAccoutPwd" class="form-label">계좌 비밀번호</label> <input
											type="password" name="accountPassword" class="form-control"
											id="txtAccoutPwd" placeholder="****" maxlength="4">
									</div>
								</div>
							</div>

							<div class="card">
								<div class="card-header">입금정보</div>
								<div class="card-body">
									<div class="mb-3">
										<label for="txtAmount" class="form-label">입금 금액</label> <input
											type="text" name="amount" class="form-control" id="txtAmount"
											required>
											<div id="accountBalance" style="text-align: right; color: blue;">계좌 잔액: ${accountBalance}원</div>
									</div>
									<div class="row">
										<div class="col-3">
											<div class="mb-3">
												<label for="selectBank" class="form-label">은행 선택</label> <select
													name="selectBank" class="form-select" id="selectBank"
													aria-label="Default select example">
													<option>솔트 은행</option>
													<option>KOSA 은행</option>
												</select>

											</div>
										</div>

										<div class="col">
											<div class="mb-3">
												<label for="receiverAccountNumber" class="form-label">입금
													계좌 입력</label> <input type="text" class="form-control"
													id="accountNumber" name="receiverAccountNumber"
													oninput="checkNumberInput(this)" required maxlength="16">
											</div>
										</div>
										<br> <span id="errorMessage" style="color: red;"></span>
										<div class="error-message" id="accountNumberErrorMessage"></div>
									</div>
								</div>

							</div>
						</div>


					</div>

					<div class="row">
						<div class="col"></div>
						<div class="col-6">
							<button type="submit" class="btn btn-success" id="submitButton">이체하기</button>
						</div>
					</div>

				</div>

			</div>
		</div>
	</form>

	<script>
		function validateForm() {
			console.log("validateForm 실행됨");
			var submitButton = document.getElementById("submitButton");
			var errorMessage = document.getElementById("errorMessage");
			var passwordInput = document.getElementById("txtAccoutPwd");

			if (errorMessage.innerText === "" && passwordInput.value !== "") {
				submitButton.disabled = false;
			} else {
				submitButton.disabled = true;
			}
		}

		document.getElementById("txtAccoutPwd").addEventListener("input",
				function() {
					var password = this.value;
					var errorMessage = document.getElementById("errorMessage");

					if (!/^\d{4}$/.test(password)) {
						errorMessage.innerText = "비밀번호는 숫자 4자리를 입력";
						this.classList.add("error");
					} else {
						errorMessage.innerText = "";
						this.classList.remove("error");
					}
					validateForm();
				});

		// 숫자와 "-"만 추출하는 함수
		function extractValidCharacters(input) {
			return input.replace(/[^\d-]/g, '');
		}

		// 계좌번호 형식을 변환하는 함수
		function formatAccountNumber(input) {
			var formattedNumber = input.replace(/(\d{4})(\d{6})(\d{4})/,
					'$1-$2-$3');
			return formattedNumber;
		}

		function checkNumberInput(input) {
			var inputValue = input.value.trim(); // 입력값의 앞뒤 공백을 제거
			var errorMessage = "";
			if (inputValue === '') {
				errorMessage = ""; // 공백
			} else if (!(/^[\d-]+$/.test(inputValue))) {
				errorMessage = "숫자와 '-'만 입력 가능";
				input.classList.add("input-error");
			} else {
				input.classList.remove("input-error");
				// 숫자와 "-"만 남도록 값 수정
				var validCharacters = extractValidCharacters(inputValue);
				input.value = formatAccountNumber(validCharacters);
			}
			var errorMessageId = input.id + "ErrorMessage";
			document.getElementById(errorMessageId).innerText = errorMessage;
		}

		document.getElementById("submitButton").addEventListener('click',
				confirmDelete);

		function confirmDelete(e) {
			e.preventDefault();
			var accountNumber = document
					.getElementById("withdrawAccountNumber").value;
			var accountPassword = document.getElementById("txtAccoutPwd").value;
			var receiverAccountNumber = document
					.getElementById("accountNumber").value;
			var amount = document.getElementById("txtAmount").value;

			$.ajax({
				// Context root 수정으로 인해 '/bank' 제거
				url : '/api/account/validate/account/transfer',
				type : 'POST',
				data : {
					accountNumber : accountNumber,
					accountPassword : accountPassword,
					receiverAccountNumber : receiverAccountNumber,
					amount : amount
				},
				success : function(data) {
					console.log(data);
					if (data.result == "success") {
						swal({
							title : "",
							text : "이체에 성공하였습니다.",
							type : "success",
							confirmButtonText : "확인",
							closeOnConfirm : false
						}, function(isConfirm) {
							if (isConfirm)
								document.getElementById('transferForm')
										.submit();
						});

					} else {
						swal({
							title : "",
							text : data.message,
							type : "warning",
							confirmButtonText : "확인"
						});
					}
				},
				error : function(xhr, status, error) {
					//console.error(xhr.responseText);
				},
				complete : function() {
					//enableSubmitButton();
				}
			});
		}
		
		// 현인: 계좌 잔액 표시를 위한 JS 코드
	    var selectElement = document.getElementById('withdrawAccountNumber');
	    var balanceDisplay = document.getElementById('accountBalance');

	    selectElement.addEventListener('change', function() {
	        var selectedOption = this.options[this.selectedIndex];
	        var balance = selectedOption.getAttribute('data-balance');
	        balanceDisplay.textContent = "계좌 잔액: " + formatNumber(balance) + "원";
	    });

	    // 초기 선택된 항목의 잔액을 표시
	    var initialBalance = selectElement.options[selectElement.selectedIndex].getAttribute('data-balance');
	    
	    balanceDisplay.textContent = "계좌 잔액: " + formatNumber(initialBalance) + "원";
	    
	    function formatNumber(num) {
	        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	    
	</script>
	<%@ include file="../../fix/footer.jsp"%>
</body>

</html>