<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UpdateMemberPw</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div class="text-center">
		<br>
		<h1>UpdateMemberPw</h1>
		</div>
		
		<div class="float-right">
			<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>">[<%=session.getAttribute("sessionMemberId")%>]</a>님 반갑습니다. &nbsp;
			<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">로그아웃</a>
		</div>
		<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>" class="btn btn-outline-info float-left btn-sm">뒤로가기</a>
		<br><br>
		
		<form method="post" action="<%=request.getContextPath()%>/UpdateMemberPwController">
			<table class="table table-bordered">
				<tr>
					<td> 기존의 memberPw를 입력해주십시오. <input type="password" name="memberPw" class="form-control">
					</td>
				</tr>
				<tr>
					<td> 변경하실 memberPw를 입력해주십시오. <input type="password" name="memberPw2" class="form-control">
					</td>
				</tr>
			</table>
		<button type="submit" class="btn btn-info btn-sm float-right">수정하기</button>
		</form>
	</div>
</body>
</html>