<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.0.0.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@100&display=swap"
	rel="stylesheet">
	<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@100&display=swap"
	rel="stylesheet">

<title>Header</title>
</head>
<body>
	<div class="container">
		<header
			class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
			<a href="/"
				class="d-flex align-items-center col-md-3 mb-2 mb-md-0 text-dark text-decoration-none">
				<!--  	<img src="images/home_icon.png"> --> <img
				src="<c:url value='/images/home_icon.png' />"
				style="width: 100px; height: 100px" />
			</a>

			<ul
				class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
				<li><a href="/" class="nav-link px-2 link-secondary">Home</a></li>
				<li><a href="/account/list"
					class="nav-link px-2 link-dark">계좌조회</a></li>
				<li><a href="/account/transfer"
					class="nav-link px-2 link-dark">계좌이체</a></li>
			</ul>

			<!--  로그인 여부에 따른 상단 navBar 변경 -->
			<!--  로그인 유저: Login/Sign-up -->
			<c:if test="${empty sessionScope.email}">
				<div class="col-md-3 text-end">
					<a href="/login"><button type="button"
							class="btn btn-outline-dark me-2">Login</button></a> <a
						href="/signup"><button type="button" class="btn btn-dark">Sign-up</button></a>
				</div>
			</c:if>
			<!--  비로그인 유저: Logout/My Page -->
			<c:if test="${not empty sessionScope.email}">
				<div class="col-md-3 text-end">
					<a href="/logout"><button type="button"
							class="btn btn-outline-dark me-2">Logout</button></a> <a
						href="/user/mypage"><button type="button"
							class="btn btn-dark">My Page</button></a>
				</div>
			</c:if>
		</header>
	</div>


</body>
</html>