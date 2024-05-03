<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<style>
.image-container {
	width: 150px;
	height: 150px;
	overflow: hidden;
	        border-radius: 50%;
	
	display: inline-block;
}

.profile-img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 중요 부분을 보여주며 주변을 잘라냄 */
}
</style>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../resources/css/mypage.css">
<link rel="stylesheet" href="../resources/css/bootstrap.css">
<title>솔트뱅크 : 마이페이지</title>
</head>
<body>
	<%@ include file="../../fix/header.jsp"%>
	<form action="#" id="myForm" method="post"
		enctype="multipart/form-data" accept-charset="UTF-8">
		<div class="page-section" style="min-height: 500px">
			<div class="container">
				<div class="hdnArea1">
					<h6>
						<b>마이페이지</b>
					</h6>

				</div>
				<div class="hdnArea2" style="display: none">
					<h6>
						<b>회원정보 수정</b>
					</h6>

				</div>
				<hr>
				<div class="" style="margin: auto;">
					<div
						class="container d-flex justify-content-center align-items-center "
						style="margin-top: 5px;">
						<div class="row">
							<div class="col d-flex justify-content-center my-3 text-center">
								<!-- 현인 -->
								<!-- profileId가 -1이면 현재 user의 profile 사진이 없는 상태 -->
								<!-- profile == -1 이면 ../images/user.png -->
								<!-- profile != -1 이면 서버에서 이미지 받아와서 뿌려줌 -->
								<c:if test="${profileId eq -1}">
									<div class="image-container">

										<img src="../images/user.png" id="profileImage"
											class="profile-img " alt="images">
									</div>
								</c:if>
								<c:if test="${profileId ne -1}">
									<div class="image-container">
										<!-- Context root 수정으로 인해 '/bank' 제거 --> 
										<img src="/profile/file/${profileId}" id="profileImage"
											class="profile-img" alt="images">
									</div>
								</c:if>

							</div>
							<div class="mb-3">
								<div class="row">
									<div class="col-6">
										<input class="form-control form-control-sm fileSection"
											id="formFileSm" type="file" accept=".jpg, .jpeg, .png"
											name="file" disabled>
									</div>
									<div class="col">
										<!-- 현인 -->
										<!-- profileId가 -1이면 현재 user의 profile 사진이 없는 상태 -->
										<!-- profile == -1 이면 삭제버튼 disabled -->
										<!-- profile != -1 이면 삭제버튼 활성화-->
										<button
												class="btn btn-outline-danger btn-sm pr-3 fileSection"
												type="button" id="btnProfileDelete" disabled>삭제</button>
										<%-- <c:if test="${profileId eq -1}">
											<button
												class="btn btn-outline-danger btn-sm pr-3 fileSection"
												type="button" id="btnProfileDelete" disabled>삭제</button>
										</c:if>
										<c:if test="${profileId ne -1}">
											<button
												class="btn btn-outline-danger btn-sm pr-3 fileSection"
												type="button" id="btnProfileDelete">삭제</button>
										</c:if> --%>
										<!-- 	<a href=""><label>image upload</label></a>/<a
											href=""><label>삭제</label></a>  -->
									</div>
								</div>

							</div>
						</div>
					</div>

					<div class="row">
						<div class="mb-3">
							<label for="txtEmail" class="form-label">이메일 </label> <input
								type="email" class="form-control inputCtrl" id="txtEmail"
								name="email" placeholder="name@example.com"
								value="${user.email}" disabled>
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtName" class="form-label">이름 </label> <input
								type="text" class="form-control inputCtrl" id="txtName"
								value="${user.name}" name="name" disabled>
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtPhoneNum" class="form-label">핸드폰번호 </label><input
								type="text" class="form-control inputCtrl" id="txtPhoneNum"
								value="${user.phoneNumber}" name="phoneNumber" disabled>
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtAddr" class="form-label">주소 </label> <input
								type="text" class="form-control inputCtrl" id="txtAddr"
								value="${user.address}" name="address" disabled >
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtPassword" class="form-label">비밀번호 </label> <input
								type="password" 
								class="form-control inputCtrl" id="txtPassword" placeholder="비밀번호를 입력해주세요"
								name="password" disabled required >
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtPassword2" class="form-label">비밀번호확인 </label> <input
								type="password" 
								class="form-control inputCtrl" id="txtPassword2" placeholder="비밀번호 확인란을 입력해주세요"
								disabled required>
						</div>
					</div>
					
					<div
						class="container d-flex justify-content-center align-items-center"
						style="height: 100px; margin-top: 5px;">

						<div class="row">
							<div class="hdnArea1">
								<button id="btnModify" type="button" class="btn btn-outline-success">수정</button>
							</div>
							<div class="hdnArea2" style="display: none">
								<button id="btnSave" type="submit" class="btn btn-success">저장</button>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<input type="hidden" name="isProfileDeleted" id="isProfileDeleted"
			value="false">

		<%@ include file="../../fix/footer.jsp"%>
		<script type="text/javascript">
			/*
			-수정버튼 클릭 시 Event
			 */
			$("#btnModify").click(function() {
				//수정 버튼 및 메뉴명 라벨 숨기기
				$(".hdnArea1").hide();
				//저장버튼 및 메뉴명 라벨 show
				$(".hdnArea2").show();
				//나머지 input입력 disabled false로 change
				$('.inputCtrl').attr("disabled", false);
				$('.fileSection').attr("disabled", false);
				
				// 현인: 이메일은 아이디로 사용하기 때문에 수정 불가능합니다.
				$('#txtEmail').attr("disabled", true);
				$('#txtName').attr("disabled", true);
			});
			
			/*
			-저장버튼 클릭 시 Event
			 */
			$("#btnSave").click(function(e) {
				e.preventDefault();
				var sPassword = $("#txtPassword").val();
				var sPassword2 = $("#txtPassword2").val();
				var bChkPassword = sPassword == sPassword2 ? true : false;
				
				
				console.log("bChkPassword>> " + bChkPassword)
				console.log("sPassword>> " + sPassword)

				//비밀번호 & 비밀번호 확인란의 value 일치 여부 확인
				//->일치하지 않을 경우 alert & return 처리
				if (bChkPassword == false) {
					swal({
						html: true,
            			title: "<h5><b>저장 실패</b></h5>",
						text : "비밀번호와 비밀번호 확인란이 일치하지 않습니다.",
						type : "warning",
					});
					return;
					//일치할 경우
				} else {

					//전달할 데이터를 담을 객체 formData 생성 //걍 form으로 대체할듯
					//var formData = new FormData();
					//사용자 입력값과 DB 내 비밀번호 일치 여부 확인
					
					
					
					// 현인: ajax 이용해서 비밀번호 서버에서 체크 후 비밀번호가 틀리면 submit되지 않습니다.
					jQuery.ajax({
						type : "POST",
						// Context root 수정으로 인해 '/bank' 제거
						url : "/api/user/validate/password", 
						data : { password: sPassword },
						cache : false,
						dataType : "json",
						success : function(data) {
							//->일치하면 저장(백단에서 검사할지?)
							// if data.리턴값 == true ~~
							if(data.result === "success") {
								swal({
									html: true,
			            			title: "<h5><b>성공</b></h5>",
			            			text: "회원 정보 수정이 완료되었습니다.",
			            			type: "success",
			            			confirmButtonText: "확인"
			            		}, function (isConfirm) {
			            			if(isConfirm)
			            				$("#myForm").submit();
			            		});
							} else {
								swal("", "비밀번호를 확인해주세요", "warning");
							}
							

							//->일치하지 않을 경우 다시 return 
							// else if data.리턴값 == false ~~
						},
						error : function(e) {
							swal("", "문제가 발생했습니다.", "error");
						},
						timeout : 100000
					});

				}
			});
			
			/*
			// 현인: 프로필 삭제 버튼 이벤트를 추가했습니다.
			// swal을 이용해서 알림창을 띄우고
			// 서버에서 사용하는 isProfileDeleted라는 hidden input의 값을 수정합니다.
			// 그리고 사진이 삭제되고 난 후 버튼이 다시 disabled 됩니다.
			$("#btnProfileDelete").click(function(e){
				e.preventDefault();
				swal({
        			title: "프로필 사진 삭제",
        			text: "프로필 사진을 삭제하시겠습니까?",
        			type: "info",
        			showCancelButton: true,
        			confirmButtonText: "확인",
        			cancelButtonText: "취소",
        			closeOnConfirm: false,
        			closeOnCancel: true
        		}, function (isConfirm) {
        			if (isConfirm) {
						swal('', '프로필 사진이 삭제되었습니다.', "success");
						$("#isProfileDeleted").val("true");
						$('#btnProfileDelete').attr("disabled", true);
						// Context root 수정으로 인해 '/bank' 제거
						$('#profileImage').attr('src', '/images/user.png');
					} else{
						$("#isProfileDeleted").val("false");
					}
        		});
 			});
			*/
			
			
			$("#btnProfileDelete").click(function(e){
				e.preventDefault();
				swal({
        		title: "<h5><b>프로필 사진을 삭제하시겠습니까?</b></h5>",
        		html:  true,
        		type: "info",
        		text: '<b>비밀번호 입력 후 저장 버튼을 눌러주세요<b><br><br> ' ,
        			//   '<input id="pwd1" placeholder="1" type="password" class="swal2-input" autofocus> ' +
        			 // '<input id="pwd2" placeholder="1" type="password" class="swal2-input">',
       		        //text: "<b>회원정보 수정을 위한 비밀번호를 입력해주세요<b><br><br>비밀번호: <input id='pwd1' type='password'><br>비밀번호 확인: ",
       		       // type: "input",
        			//showCancelButton: true,
        			confirmButtonText: "확인",
        			//cancelButtonText: "취소",
        			//closeOnConfirm: true,
        			//closeOnCancel: true
        		}, function (isConfirm) {
        			if (isConfirm) {
						//swal('', '프로필 사진이 삭제되었습니다.', "success");
						$("#isProfileDeleted").val("true");
						$('#btnProfileDelete').attr("disabled", true);
						// Context root 수정으로 인해 '/bank' 제거
						$('#profileImage').attr('src', '/images/user.png');
						//$("#btnSave").click();
					} else{
						$("#isProfileDeleted").val("false");
					}
        		});
 			});
			
			// 현인: 프로필 사진을 업로드하면 isProfileDeleted를 false로 바꿉니다.
			$("#formFileSm").change(function() {
				$("#isProfileDeleted").val(false);
			});
			
			
			//[05.01] 현인님 작성 코드 추가
		     // 이미지 업로드와 관련된 스크립트
	        document.getElementById('formFileSm').addEventListener('change', function(event) {
	            if (event.target.files && event.target.files[0]) {
	                var reader = new FileReader();
	                
	                reader.onload = function(e) {
	                    document.getElementById('profileImage').src = e.target.result; // 이미지 미리보기
	                };

	                reader.readAsDataURL(event.target.files[0]); // 파일을 읽어 버퍼에 저장
	            }
	        });
		     
		     
	     // 파일 업로드시 미리보기
		      $("#formFileSm").change(function() {
		    	// Context root 수정으로 인해 '/bank' 제거
		         $("#formFileSm").attr("src", "/profile/file/${profileId}");
		      });
		     
		   // 핸드폰 번호 입력시 자동으로 하이픈 추가
		      $("#txtPhoneNum").on("propertychange change keyup paste input", function(e) {
		         var x = e.target.value;
		          e.target.value = phoneNumber(x);
		         });
		      
		      function phoneNumber(value) {
		           if (!value) {
		             return "";
		           }

		           value = value.replace(/[^0-9]/g, "");

		           let result = [];
		           let restNumber = "";

		           // 지역번호와 나머지 번호로 나누기
		           if (value.startsWith("02")) {
		             // 서울 02 지역번호
		             result.push(value.substr(0, 2));
		             restNumber = value.substring(2);
		           } else if (value.startsWith("1")) {
		             // 지역 번호가 없는 경우
		             // 1xxx-yyyy
		             restNumber = value;
		           } else {
		             // 나머지 3자리 지역번호
		             // 0xx-yyyy-zzzz
		             result.push(value.substr(0, 3));
		             restNumber = value.substring(3);
		           }

		           if (restNumber.length === 7) {
		             // 7자리만 남았을 때는 xxx-yyyy
		             result.push(restNumber.substring(0, 3));
		             result.push(restNumber.substring(3));
		           } else {
		             result.push(restNumber.substring(0, 4));
		             result.push(restNumber.substring(4));
		           }

		           return result.filter((val) => val).join("-");
		         }
		      
		 
			    
		</script>
	</form>
</body>

</html>