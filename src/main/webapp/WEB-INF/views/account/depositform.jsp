<%@page import="javax.sound.midi.Receiver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.bank.service.AccountService" %>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>솔트뱅크 : 계좌입금</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../../fix/header.jsp"%>
<form action="#" method="post" id="depositForm">
	<div class="page-section" style="min-height: 500px">
		<div class="container">
			<h5>계좌입금</h5>
			<hr>
			<div class="" style="margin: auto;">
				<div class="row">
					<div class="col-3"></div>
	
					<div class="col-6">
					
						<div class="mb-3">
							<h6>입금정보</h6>
							<hr>
								<label for="accountNumber" class="form-label" >입금 계좌 선택</label>
								<select name="accountNumber" id="accountNumber" class="form-select" aria-label="Default select example">
								    <c:forEach var="account" items="${accounts}">
								    	<c:if test="${account.ISDEL == 0}">
								    		<option value="${account.account}">${account.account}</option>
								    	</c:if>
								    </c:forEach> 
								</select>
						</div>
						
						<div class="mb-3">
							<label for="txtAccoutPwd" class="form-label">계좌 비밀번호</label>
							<input type="password" name="accountPassword" class="form-control" id="txtAccoutPwd" placeholder="****" maxlength="4">
						</div>
						
						<div class="mb-3">
							<h6>입금정보</h6>
							<hr>
								<label for="txtAmount class="form-label">입금 금액</label>
								<input type="text" name="amount" class="form-control" id="txtAmount" oninput="validateNumber(this)" required>
						</div>
						<span id="errorMessage" style="color: red;"></span>
					</div>
				</div>
				
				
				<div class="row">
					<div class="col"></div>
					<div class="col-6">
						<button type="submit" class="btn btn-success" id="submitButton" disabled>이체하기</button>
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
        var amountInput = document.getElementById("txtAmount");
        
        if (errorMessage.innerText === "" && passwordInput.value !== ""
        		&& (amountInput.value !== "" && amountInput.value >= 1000)) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }
    
    document.getElementById("txtAccoutPwd").addEventListener("keyup", function() {
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
    
    function validateNumber(input) {
    	var errorMessage = document.getElementById("errorMessage");
    	
        input.value = input.value.replace(/[^0-9]/g, '');
        
        if(input.value !== "") {
    		if(input.value < 1000) {
    			errorMessage.innerText = "최소 입금 금액 1000원";
    			input.classList.add("error");
    		} else {
                errorMessage.innerText = "";
                input.classList.remove("error");
            }
    	}
        validateForm();
      }
    
    document.getElementById("submitButton").addEventListener('click', confirmDelete);
    
    function confirmDelete(e){
    	e.preventDefault();
    	var accountNumber = document.getElementById("accountNumber").value;
    	var accountPassword = document.getElementById("txtAccoutPwd").value;
    	
    	$.ajax({
            url: '/bank/api/account/validate/account/password',
            type: 'POST',
            data: {
            	accountNumber: accountNumber,
            	accountPassword: accountPassword
            },
            success: function(data) {
                console.log(data);
                if(data.result == "success") {
                	swal({
            			title: "",
            			text: "이체에 성공하였습니다.",
            			type: "success",
            			confirmButtonText: "확인"
            		}, function (isConfirm) {
            			if(isConfirm)
            				document.getElementById('depositForm').submit();
            		});
                	
                } else {
                	swal({
        				title: "",
        				text: "계좌번호와 비밀번호가 일치하지 않습니다.",
        				type: "warning",
        				confirmButtonText: "확인"
        			});
                }
            },
            error: function(xhr, status, error) {
                //console.error(xhr.responseText);
            },
            complete: function() {
                //enableSubmitButton();
            }
        });
    }	

</script>
<%@ include file="../../fix/footer.jsp"%>
</body>

</html>