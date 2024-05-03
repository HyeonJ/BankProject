<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계좌 목록 조회</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        #header {
            background-color: #f0f0f0;
            padding: 10px;
            display: flex;
            justify-content: flex-end;
        }
        #header a {
            margin-left: 10px;
            text-decoration: none;
            color: #333;
        }
        #content {
            margin: 20px auto;
            text-align: center;
            width: 60%;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
        }
        th {
            background-color: #f0f0f0;
        }
        .button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<%@ include file="../../fix/header.jsp" %>
${message}
    <div id="header">
        <a href="/mypage">마이페이지</a>
        <a href="/logout">로그아웃</a>
    </div>
    <div id="content">
        <h2>계좌 목록 조회</h2>
        <table>
            <tr>
                <th></th>
                <th></th>
                <th></th>
                <th><button class="button" onclick="location.href='/bank/account/create/?userId=${userId}'">+</button></th>
            </tr>
		<c:forEach var="info" items="${accountInfo}">
			<tr>
				<td> ${info.type} <br> ${info.account} </td>
				<td> ${info.balance} </td>
                <td><button onclick="location.href='/bank/account/transfer/?userId=${info.ID}&accountNumber=${info.account}'">이체</button></td>
                <td><button>조회</button></td>
			</tr>
		</c:forEach>


        </table>
    </div>
    
<%@ include file="../../fix/footer.jsp" %>
</body>
</html>