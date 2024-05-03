<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>솔트뱅크 : 로그인</title>
</head>
<body>
	<%@ include file="../fix/header.jsp"%>
	<div class="page-section" style="min-height: 65vh;">
	<div class="container d-flex justify-content-center " style="margin-top:150px;">	
					
				<div class="col-md-4">
					<h6>
						<b>로그인</b>
					</h6>
					<hr>
					<%
						if (session.getAttribute("loginFailed") != null && (boolean) session.getAttribute("loginFailed")) {
					%>
					<script type="text/javascript">
			
						//  alert("로그인에 실패하였습니다.\n로그인 정보를 확인해주세요.");            
						swal({
							title : "로그인에 실패했습니다.",
							text : "아이디 혹은 비밀번호가 일치하지 않습니다.",
							type : "warning",
							confirmButtonText : "예",
							closeOnConfirm : false,
							closeOnCancel : true
						});
					</script>
					<%
						session.removeAttribute("loginFailed");
					%>
					<%
						}
					%>
					<form action="./login" method="post">
						<div class="mb-3">
							<input type="email" id="email" name="email" class="form-control"
								placeholder="아이디(이메일)" required>
						</div>
						<div class="mb-3">
							<input type="password" id="password" name="password"
								class="form-control" placeholder="비밀번호" required>
						</div>
						<div class="mb-3 d-grid gap-2">
							<input type="submit" id="loginButton"
								class="btn btn-outline-primary" value="로그인">
						</div>
						<hr>
					</form>

					<div class="mb-3 d-flex justify-content-between">
						<span>아직 회원이 아니신가요?</span>
						<button id="signupButton" class="btn btn-outline-success"
							onclick="location.href='./signup'">회원가입</button>
					</div>
				</div>				
				
		</div>
	</div>
	<%@ include file="../fix/footer.jsp"%>
</body>
</html>
