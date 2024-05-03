<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${empty sessionScope.email}">
<h2>세션 없음</h2>
</c:if>
<c:if test="${not empty sessionScope.email}">
<h2>세션 있음</h2>
</c:if>
</body>
</html>