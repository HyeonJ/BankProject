<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../resources/css/mypage.css">
<link rel="stylesheet" href="../resources/css/bootstrap.css">
<title>솔트뱅크 : 마이페이지</title>
</head>
<body>
	<%@ include file="../../fix/header.jsp"%>
	<form action="#" id="myForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
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
							<div class="text-center">
							<!-- 현인 -->
							<!-- profileId가 -1이면 현재 user의 profile 사진이 없는 상태 -->
							<!-- profile == -1 이면 ../images/user.png -->
							<!-- profile != -1 이면 서버에서 이미지 받아와서 뿌려줌 -->
								<c:if test="${profileId eq -1}">
									<img src="../images/user.png" class="rounded" alt="images"
										style="width: 50px; height: 50px">
								</c:if>
								<c:if test="${profileId ne -1}">
									<img src="/bank/profile/file/${profileId}" class="rounded" alt="images"
										style="width: 50px; height: 50px">
								</c:if>
								<a href=""><img
									src="../images/arrow.png" class="rounded" alt="images"
									style="width: 20px; height: 20px"></a>
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
										<c:if test="${profileId eq -1}">
											<button class="btn btn-outline-danger btn-sm pr-3 fileSection"
											type="button" id="btnProfileDelete" disabled>삭제</button>
										</c:if>
										<c:if test="${profileId ne -1}">
											<button class="btn btn-outline-danger btn-sm pr-3 fileSection"
											type="button" id="btnProfileDelete">삭제</button>
										</c:if>
										<a href=""><label>image upload</label></a>/<a
											href=""><label>삭제</label></a>
									</div>
								</div>

							</div>
						</div>
					</div>

					<div class="row">
						<div class="mb-3">
							<label for="txtEmail" class="form-label">이메일 </label> <input
								type="email" class="form-control inputCtrl" id="txtEmail" name="email"
								placeholder="name@example.com" value="${user.email}" disabled>
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtPhoneNum" class="form-label">핸드폰번호 </label> <input
								type="text" class="form-control inputCtrl" id="txtPhoneNum"
								value="${user.phoneNumber}" name="phoneNumber" disabled>
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtPassword" class="form-label">비밀번호 </label> <input
								type="text" class="form-control inputCtrl" id="txtPassword"
								value="" name="password" disabled>
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtPassword2" class="form-label">비밀번호확인 </label> <input
								type="text" class="form-control inputCtrl" id="txtPassword2"
								value="" disabled>
						</div>
					</div>
					<div class="row">
						<div class="mb-3">
							<label for="txtAddr" class="form-label">주소 </label> <input
								type="text" class="form-control inputCtrl" id="txtAddr" value="${user.address}"
								name="address" disabled>
						</div>
					</div>
					<div
						class="container d-flex justify-content-center align-items-center"
						style="height: 100px; margin-top: 5px;">

						<div class="row">
							<div class="hdnArea1">
								<button id="btnModify" type="button" class="btn btn-success">수정</button>
							</div>
							<div class="hdnArea2" style="display: none">
								<button id="btnSave" type="submit" class="btn btn-success">저장</button>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<input type="hidden" name="isProfileDeleted" id="isProfileDeleted" value="false">
		
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
						title : "저장 실패",
						text : "비밀번호와 비밀번호 확인란이 일치하지 않습니다.",
						type : "warning",
					});
					return;
					//일치할 경우
				} else {

					//전달할 데이터를 담을 객체 formData 생성 //걍 form으로 대체할듯
					var formData = new FormData();
					//사용자 입력값과 DB 내 비밀번호 일치 여부 확인
					
					
					
					// 현인: ajax 이용해서 비밀번호 서버에서 체크 후 비밀번호가 틀리면 submit되지 않습니다.
					jQuery.ajax({
						type : "POST",
						url : "/bank/api/user/validate/password", 
						data : { password: sPassword },
						cache : false,
						dataType : "json",
						success : function(data) {
							//->일치하면 저장(백단에서 검사할지?)
							// if data.리턴값 == true ~~
							if(data.result === "success") {
								swal({
			            			title: "성공",
			            			text: "회원 정보 수정이 완료되었습니다.",
			            			type: "success",
			            			confirmButtonText: "확인"
			            		}, function (isConfirm) {
			            			if(isConfirm)
			            				$("#myForm").submit();
			            		});
							} else {
								swal("", "옳지 않은 비밀번호를 입력하셨습니다.", "warning");
							}
							

							//->일치하지 않을 경우 다시 return 
							// else if data.리턴값 == false ~~
						},
						error : function(e) {
							swal("실패", "문제가 발생했습니다.", "error");
						},
						timeout : 100000
					});

				}
			});
			
			
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
						$("#isProfileDeleted").value = "true";
						$('#btnProfileDelete').attr("disabled", true);
					} else{
						$("#isProfileDeleted").value = "false";
					}
        		});
 			});
			
			// 현인: 프로필 사진을 업로드하면 isProfileDeleted를 false로 바꿉니다.
			$("#formFileSm").change(function() {
				$("#isProfileDeleted").value = "false";
			});
		</script>
	</form>
</body>

</html>