<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Error</title>
	
</head>
<body>

	<div class="page-section" style="min-height: 500px">
	 	<div class="container d-flex justify-content-center " style="height: calc(100vh - 100px); margin-top: 20px;"> 
	
		<div class="row">
			<div class="col">
				<div class="imgSection">
					<!-- Context root 수정으로 인해 '/bank' 제거  -->
					<img src="/images/error_500.jpg" style="height: 80vh; width: 1000px"
						class="rounded mx-auto d-block" alt="...">
				</div>
			</div>
			<div class="col">
				<h3>잘못된 요청입니다.</h3><br>
				<div>${message}</div><br>
				<a href="#" class="btn btn-light" onClick="javascript:history.back()" style="margin-right:20px;">뒤로가기</a>
				<!-- Context root 수정으로 인해 '/bank' 제거  -->
				<a href="/" class="btn btn-success">홈으로 이동</a>
			</div>
		</div>

		</div>
	</div>
	

			<%@ include file="../../fix/footer.jsp"%>
	
</body>

</html>