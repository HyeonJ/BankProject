<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<title>솔트뱅크 : 계좌삭제</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@ include file="../../fix/header.jsp"%>
<form action="#" method="post" id="deleteForm">
	<div class="page-section" style="min-height: 500px">
		<div class="container">
			<h5>계좌삭제</h5>
			<hr>

			<div class="" style="margin: auto;">

				<div class="row">
					<div class="col-3">
						<div class="mb-3"></div>
					</div>
					<div class="col-6">
						<div class="mb-3">
							<label for="txtAccoutName" class="form-label" >계좌번호</label>
							<select id="sltAccountNumber" class="form-select" aria-label="Default select example" name="accountNumber" onchange="updateInput(this)">
								
					        	<c:forEach var="account" items="${accounts}">
					        		<c:if test="${account.isdel == 0}">
										<option value="${account.account}" data-value="(${account.accountName}) ${account.typeValue}"> ${account.account} </option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</div>

				</div>
				
				<div class="row">
					<div class="col-3">
						<div class="mb-3">
						</div>
					</div>
					

					<div class="col-6">
						<div class="mb-3">
							<input type="text" class="form-control" readonly id="txtAccoutName" >
						</div>
					</div>

				</div>
				

				<div class="row">
					<div class="col-3"></div>
					<div class="col-6">
						<div class="mb-3">
							<label for="txtAccoutPwd" class="form-label">계좌 비밀번호</label>
							<input type="password" class="form-control" id="txtAccoutPwd" name="accountPassword" placeholder="선택한 계좌의 비밀번호를 입력하세요" maxlength="4">
						</div>
   						<span id="errorMessage" style="color: red;"></span>
					</div>
				</div>
				<div class="row">
					<div class="col"></div>
					<div class="col-6">
						<button type="submit" id="btnDelete" class="btn btn-danger">삭제</button>
					</div>
				</div>
			</div>
		</div>


	</div>
</form>
	<%@ include file="../../fix/footer.jsp"%>
<script type="text/javascript">

 	//alert("테스트");
 	document.getElementById("btnDelete").addEventListener('click',confirmDelete);

	function confirmDelete(e){
		e.preventDefault();
	 // alert("선택한 계좌를 삭제하시겠습니까?");
			swal({
				title: "",
				text: "선택한 계좌를 삭제하시겠습니까?",
				type: "warning",
				showCancelButton: true,
				confirmButtonText: "예",
				cancelButtonText: "아니요",
				closeOnConfirm: false,
				closeOnCancel : true
			}, function (isConfirm) {
				if (!isConfirm) return;
				else document.getElementById("deleteForm").submit();
			});
	
	}

    // 페이지가 로드될 때 실행될 함수
    window.onload = function() {
        // select box에서 선택된 option 요소 가져오기
        var selectElement = document.getElementById("sltAccountNumber");
        var selectedOption = selectElement.options[selectElement.selectedIndex];
        // 선택된 option 요소의 data-value 가져오기
        var inputValue = selectedOption.getAttribute("data-value");
        // input box에 값 설정
        var inputElement = document.getElementById("txtAccoutName");
        inputElement.value = inputValue;
    };
	
 	function updateInput(selectElement) {
        var selectedOption = selectElement.options[selectElement.selectedIndex];
        var inputValue = selectedOption.getAttribute("data-value");
        var inputElement = document.getElementById("txtAccoutName");
        inputElement.value = inputValue;
    }
 	
    function validateForm() {
        var submitButton = document.getElementById("submitButton");
        var errorMessage = document.getElementById("errorMessage");
    
        if (errorMessage.innerText === "" && passwordInput.value !== "") {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }
 	
    document.getElementById("txtAccoutPwd").addEventListener("input", function() {
        var password = this.value;
        var errorMessage = document.getElementById("errorMessage");
        
        if (!/^\d{4}$/.test(password)) {
            errorMessage.innerText = "비밀번호는 숫자 4자리를 입력하세요";
            this.classList.add("error");
        } else {
            errorMessage.innerText = "";
            this.classList.remove("error");
        }
        validateForm();
    });
    
    
    function confirmDelete(e){
        e.preventDefault();
        var accountNumber = document.getElementById("sltAccountNumber").value;
        var accountPassword = document.getElementById("txtAccoutPwd").value;

        $.ajax({
        	// Context root 수정으로 인해 '/bank' 제거
             url: '/api/account/validate/account/delete',
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
                      text: "정상적으로 삭제되었습니다.",
                      type: "success",
                      confirmButtonText: "확인",
                      closeOnConfirm: false
                   }, function (isConfirm) {
                      if(isConfirm)
                         document.getElementById('deleteForm').submit();
                   });
                    
                 } else {
                    swal({
                     title: "",
                     text: data.message,
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
</body>

</html>