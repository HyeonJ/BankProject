<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CREATE ACCOUNT</title>
    <script>
	    function updateInput(selectElement) {
	        var selectedOption = selectElement.options[selectElement.selectedIndex];
	        var inputValue = selectedOption.getAttribute("data-value");
	        var inputElement = document.getElementById("typeInput");
	        inputElement.value = inputValue;
	    }
    
        function validateForm() {
            var agreeCheckbox = document.getElementById("agreeCheckbox");
            var submitButton = document.getElementById("submitButton");
            
            if (agreeCheckbox.checked) {
                submitButton.disabled = false;
            } else {
                submitButton.disabled = true;
            }
        }
    </script>
    
    <style>
    body {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		margin: 0;
        }

        .table-wrapper {
            text-align: center;
        }
        table {
            border-collapse: collapse;
            border-color: white;
        }
    </style>
</head>
<body>
<%@ include file="../../fix/header.jsp" %>

<div class="table-wrapper">
	<h2>계좌 생성</h2>

	<form action="#" method="post">
		<table>
			<tr>
				<th>
			        <select name="accountTypeId" onchange="updateInput(this)">
			        	<c:forEach var="type" items="${types}">
							<option value="${type.id}" data-value="${type.value}"> ${type.name} </option>
						</c:forEach>
			        </select>
				</th>
				
				<td>
					<input type="text" id="typeInput" value="솔트룩스 통장" readonly>
				</td>
				
			</tr>
			
			<tr>
				<td> </td>
				<td>
					<input type="password" name="accountPassword" placeholder="비밀번호 4자리">
				</td>
			</tr>
			
			<tr>
				<td> </td>
				<td>
			        <input type="checkbox" id="agreeCheckbox" name="agreeCheckbox" onchange="validateForm()">
			        (필수) 개인정보 취급방침 동의 (보기)
				</td>
			</tr>
			
			<tr>
				<td> </td>
				<td>
			        <input type="submit" id="submitButton" value="제출" disabled>
				</td>
			</tr>
			
		</table>
	</form>
</div>

<%@ include file="../../fix/footer.jsp" %>	
</body>
</html>