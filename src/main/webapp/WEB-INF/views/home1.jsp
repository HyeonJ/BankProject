<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Home</title>

</head>
<body>
	<%@ include file="../fix/header.jsp"%>

	<div class="page-section" style="min-height: 500px">
		<div class="container d-flex justify-content-center "
			style="height: calc(100vh - 300px); margin-top:90px; overflow:hidden;">
			<div class="row" style="text-align: center">
					<div class="card" style="width: 35rem; height:450px; padding: 10px">
						<div style="text-align: center; justify-content: center">
							<img src="images/savings.png" style="width: 200px; margin: 0;">
						</div>
						<div class="card-body">
							<h5 class="card-title">계좌조회</h5>
							<br>
							<p class="card-text">본인이 소유한 계좌 목록을 조회합니다.</p>
							<br> <a href="account/list" class="btn btn-success">메뉴로
								이동</a>
						</div>
					</div>

					<div class="card" style="width: 35rem; height:450px; padding: 14px">
						<div style="text-align: center">
							<img src="images/transfer.png" style="width: 200px;">
						</div>
						<div class="card-body">
							<h5 class="card-title">계좌이체</h5>
							<br>
							<p class="card-text">본인 소유의 다른 계좌 혹은 타인 명의의 계좌로 이체를 진행합니다.</p>
							<br> <a href="account/transfer" class="btn btn-success">메뉴로
								이동</a><br>
						</div>
					</div>
			</div>
		</div>
	</div>
	<%@ include file="../fix/footer.jsp"%>
</body>

</html>