<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertMember</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div class="text-center">
		<br>
		<br>
		<h1>📅 CASHBOOK</h1>
			<br>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/InsertMemberController" >
			<table class="table table-bordered">
				<tr>
					<td class=" table-info text-center">회원가입</td>
				</tr>
				<tr>
					<td>memberId를 입력해주세요<br>
					<input type="text" name="memberId" class="form-control"></td>
				</tr>
				<tr>
					<td>memberPw를 입력해주세요<br>
					<input type="password" name="memberPw" class="form-control"></td>
				</tr>
				<tr>
					<td>memberPw를 한번 더 입력해주세요<br>
					<input type="password" name="memberPw2" class="form-control"></td>
				</tr>
			</table>
			<div class="float-right">
				<a href="<%=request.getContextPath()%>/LoginController" class="btn btn-outline-info">뒤로가기</a>
				<button type="submit" class="btn btn-info">회원가입</button>
			</div>
		</form>
	</div>
</body>
</html>