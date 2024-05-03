<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<title>솔트뱅크 : 계좌생성</title>

</head>
<body>
	<%@ include file="../../fix/header.jsp"%>
	<input type="hidden" id="agreeStt" value="0"></input>
<form action="#" method="post">
	<div class="page-section" style="min-height: 500px">
		<div class="container">
			<h6><b>계좌생성</b></h6>
			<hr>
			<div class="" style="margin: auto;">
				<div class="row">
					<div class="col-3">
						<div class="mb-3">
							<label for="sltAccountType" class="form-label">계좌종류</label>
							<select id="sltAccountType" class="form-select" aria-label="Default select example" name="accountTypeId" onchange="updateInput(this)">
					        	<c:forEach var="type" items="${types}">
									<option value="${type.id}" data-value="${type.value}"> ${type.name} </option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="col-6">
						<div class="mb-3">
							<label for="txtAccoutName" class="form-label" >계좌명</label> <input
								type="text" class="form-control" readonly id="txtAccoutName"
								value="솔트룩스 통장">
						</div>
					</div>
				</div>
				

				<div class="row">
					<div class="col-3"></div>
					<div class="col-6">
						<div class="mb-3">
							<label for="txtAccoutPwd" class="form-label">계좌 비밀번호</label>
							<input type="password" name="accountPassword" class="form-control" id="txtAccoutPwd" placeholder="****" maxlength="4">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-3"></div>
					<div class="col-6">
						<div class="mb-3">
							<label for="txtAccoutPwd" class="form-label">비밀번호 확인</label>
							<input type="password" class="form-control" id="confirmPassword" placeholder="****" maxlength="4">
							<br>
    						<span id="errorMessage" style="color: red;"></span>
						</div>
					</div>
				</div>


				<div class="row">
					<div class="col-3"></div>
					<div class="col-6">
						<div class="mb-3 form-check">
							<input type="checkbox" class="form-check-input" id="agreeCheckbox" onchange="validateForm()">
								<label class="form-check-label" for="exampleCheck1"> 계좌생성을 위한 <a id="aa" data-bs-toggle="modal" data-bs-target="#exampleModal" href="#">개인정보처리방침</a>에 동의합니다. </label>
						</div>
					</div>
				</div>
				<div class="row" style="margin:30px">
					<div class="col"></div>
					<div class="col-6">
						<button type="submit" class="btn btn-success" id="submitButton" disabled>계좌생성</button>
					</div>
				</div>
			</div>
		</div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">개인정보처리방침</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <p> 제 1 장 총칙 제 1 조 (목적) 본 약관은 솔트뱅크가 운영하는
								웹사이트 ‘솔트뱅크’(이하 “웹사이트”라 합니다)에서 제공하는
								온라인 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버몰과 이용자의 권리, 의무 및 책임사항을 규정함을
								목적으로 합니다. 제 2 조 (용어의 정의) 본 약관에서 사용하는 용어는 다음과 같이 정의한다. “웹사이트”란
								회사가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 또는 용역을 거래 할 수
								있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다. “이용자”란
								“웹사이트”에 접속하여 서비스를 이용하는 회원 및 비회원을 말합니다. “회원”이라 함은 “웹사이트”에 개인정보를
								제공하여 회원등록을 한 자로서, “웹사이트”의 정보를 지속적으로 제공받으며, “웹사이트”이 제공하는 서비스를
								계속적으로 이용할 수 있는 자를 말합니다. “비회원”이라 함은 회원에 가입하지 않고, “웹사이트”이 제공하는
								서비스를 이용하는 자를 말합니다. “ID”라 함은 이용자가 회원가입당시 등록한 사용자 “개인이용문자”를 말합니다.
								“멤버십”이라 함은 회원등록을 한 자로서, 별도의 온/오프라인 상에서 추가 서비스를 제공 받을 수 있는 회원을
								말합니다. 제 3 조 (약관의 공시 및 효력과 변경) 본 약관은 회원가입 화면에 게시하여 공시하며 회사는 사정변경
								및 영업상 중요한 사유가 있을 경우 약관을 변경할 수 있으며 변경된 약관은 공지사항을 통해 공시한다 본 약관 및
								차후 회사사정에 따라 변경된 약관은 이용자에게 공시함으로써 효력을 발생한다. 제 4 조 (약관 외 준칙) 본 약관에
								명시되지 않은 사항이 전기통신기본법, 전기통신사업법, 정보통신촉진법, ‘전자상거래등에서의 소비자 보호에 관한
								법률’, ‘약관의 규제에관한법률’, ‘전자거래기본법’, ‘전자서명법’, ‘정보통신망 이용촉진등에 관한 법률’,
								‘소비자보호법’ 등 기타 관계 법령에 규정되어 있을 경우에는 그 규정을 따르도록 한다. 제 2 장 이용계약 제 5
								조 (이용신청) 이용신청자가 회원가입 안내에서 본 약관과 개인정보보호정책에 동의하고 등록절차(회사의 소정 양식의
								가입 신청서 작성)를 거쳐 ‘확인’ 버튼을 누르면 이용신청을 할 수 있다. 이용신청자는 반드시 실명과 실제 정보를
								사용해야 하며 1개의 생년월일에 대하여 1건의 이용신청을 할 수 있다. 실명이나 실제 정보를 입력하지 않은 이용자는
								법적인 보호를 받을 수 없으며, 서비스 이용에 제한을 받을 수 있다. 제 6 조 (이용신청의 승낙) 회사는 제5조에
								따른 이용신청자에 대하여 제2항 및 제3항의 경우를 예외로 하여 서비스 이용을 승낙한다. 회사는 아래 사항에
								해당하는 경우에 그 제한사유가 해소될 때까지 승낙을 유보할 수 있다. 가. 서비스 관련 설비에 여유가 없는 경우
								나. 기술상 지장이 있는 경우 다. 기타 회사 사정상 필요하다고 인정되는 경우 회사는 아래 사항에 해당하는 경우에
								승낙을 하지 않을 수 있다. 가. 다른 사람의 명의를 사용하여 신청한 경우 나. 이용자 정보를 허위로 기재하여
								신청한 경우 다. 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우 라. 기타 회사가 정한 이용신청
								요건이 미비한 경우... </p>
      </div>
      <div class="modal-footer">
        <button id="btnClose" type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button id="btnAgree" type="button" class="btn btn-primary" onchange="validateForm()">동의하기</button>
      </div>
    </div>
  </div>
</div>

	<!-- 	// 현인: deprecated
		<!-- modal 
		<div class="modal" id="mandatoryTerm" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Modal title</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>Modal body text goes here.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save
							changes</button>
					</div>
				</div>
			</div>
		</div>-->
		 

	</div>
</form>
	<%@ include file="../../fix/footer.jsp"%>


<script>
    function updateInput(selectElement) {
    //console.log("updateInput 실행됨");
        var selectedOption = selectElement.options[selectElement.selectedIndex];
        var inputValue = selectedOption.getAttribute("data-value");
        var inputElement = document.getElementById("txtAccoutName");
        inputElement.value = inputValue;
    }
    
    function validateForm() {
    	console.log("validateForm 실행됨");
        var agreeCheckbox = document.getElementById("agreeCheckbox");
        var submitButton = document.getElementById("submitButton");
        var errorMessage = document.getElementById("errorMessage");
        var passwordInput = document.getElementById("confirmPassword");
        
        console.log("checkbox상태>> " + agreeCheckbox.checked)
        if (($("#agreeStt").val() == '1' || agreeCheckbox.checked) && errorMessage.innerText === "" && passwordInput.value !== "") {
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
    
    document.getElementById("confirmPassword").addEventListener("input", function() {
        var password = document.getElementById("txtAccoutPwd").value;
        var confirmPassword = this.value;
        var errorMessage = document.getElementById("errorMessage");
        
        if (password !== confirmPassword) {
            errorMessage.innerText = "비밀번호가 일치하지 않습니다";
            this.classList.add("error");
        } else {
            errorMessage.innerText = "";
            this.classList.remove("error");
        }
        validateForm();
    });
    
    $("#btnAgree").on("click",function(e){
		   $('#exampleModal').modal('toggle');
		$("#agreeCheckbox").prop('checked',true);
		//추가확인 필요
		$("#agreeStt").val('1');
	});
</script>
</body>

</html>