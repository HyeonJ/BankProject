<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지?</title>
    <link rel="stylesheet" href="../resources/css/mypage.css">
    <link rel="stylesheet" href="../resources/css/bootstrap.css">
</head>
<body>
    <div class="header">
        <span class="logoText">SaltBank</span>
        <span class="logoutText"><a href="">로그아웃</a></span>
    </div>

    <br>
    <div class="modifyContainer">
        <span class="mypageText">마이페이지?</span>
        <hr>
        <div class="profileContainer">
            <span class="photoPlace">
                 <img src="${profileImageData}" alt="profilePhoto">
            </span>
            <span class="uploadContainer">
            	<form action="./file/upload" method="post" enctype="multipart/form-data">
 					<input type="file" name="file" accept=".jpg, .jpeg, .png" class="uploadButton">
        			<button type="submit">Upload</button>(.gif/.png/.jpg)
            	</form>           
		 </span>
        </div>
        <br>
        

        <form action="#" value="post">
            <table class="infoTable">
                <tr><td>이메일</td></tr>
                <tr><td><input type="email" class="form-control" name="email" required></td></tr>
                <tr><td>핸드폰 번호</td></tr>
                <tr><td><input type="text" class="form-control" name="phoneNumber" required></td></tr>
                <tr><td>비밀번호</td></tr>
                <tr><td><input type="password" class="form-control" name="password" required></td></tr>
                <tr><td>비밀번호 확인</td></tr>
                <tr><td><input type="password" class="form-control" name="passwordCheck" required></td></tr>
                <tr><td>주소</td></tr>
                <tr><td><input type="text" class="form-control" name="address" required></td></tr>
                <tr><td><br><input type="submit" class="btn btn-primary" id="submitButton" name="submitButton" value="저장"></td></tr>
            </table>
        </form>
    </div>
</body>
</html>