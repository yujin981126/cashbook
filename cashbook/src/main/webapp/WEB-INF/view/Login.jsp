<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body class="bg-dark">
<div class="container">
<div class="text-center text-light">
	<br>
	<h1>Login</h1>
</div>
	<br>
	<div class="row">
		<div class="col-sm-4">
		
		</div>
		<div class="col-sm-4">
			<div class="text-center">
				<form method="post" action="<%=request.getContextPath()%>/LoginController">
					<input type="text" name="memberId" placeholder="USER ID" class="form-control text-center">
					<br>
				<input type="password" name="memberPw" placeholder="PASSWORD" class="form-control text-center">
					<br>
				<button type="submit" class="btn btn-light text-info">Login</button>
				</form>
			</div>
		</div>
		<div class="col-sm-4">
		
		</div>
	</div>
</div>
</body>
</html>