<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DeleteMember</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
ul {
	width: 100%;
	float: left;
}

.id {
	flex-grow: 1;
	position: relative;
}

.session {
	position: absolute;
	right: 0;
}

a {
	text-decoration: none;
	color: #000000;
}
</style>
</head>
<%
Calendar now = Calendar.getInstance();
int y = now.get(Calendar.YEAR);
int m = now.get(Calendar.MONTH) + 1;
%>
<body>
	<div class="container">
<br>
<h1>๐ CASHBOOK</h1><br>
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m%>">Calender</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<%=request.getContextPath()%>/TagController">#Hash_Tag</a>
  </li>
    <li class="nav-item">
    <a class="nav-link" href="<%=request.getContextPath()%>/TagSearchController">Search</a>
  </li>
    <li class="nav-item">
    <a class="nav-link" href="<%=request.getContextPath()%>/StatsController">Stats</a>
  </li>
    <li class="form-inline my-lg-0 id">
    <div class="session">
		<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>">[<%=session.getAttribute("sessionMemberId")%>]</a>๋ ๋ฐ๊ฐ์ต๋๋ค. &nbsp;
		<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">๋ก๊ทธ์์</a>
	</div>
	</li>
</ul>
<br><br>
	<div class="text-center">
		<font size="6em" style="font-weight: 500">DeleteMember</font>
	</div>
	<br>
	<form method="post" action="<%=request.getContextPath()%>/DeleteMemberController">
		<table class="table table-bordered">
			<tr>
				<td class="text-center table-info">CASHBOOK ํํดํ์๊ฒ ์ต๋๊น?</td>
			</tr>
			<tr>
				<td> โป ํ์์ ํํดํ๋ ค๋ฉด memberPw๋ฅผ ๋ค์ ์๋ ฅํด์ฃผ์ญ์์ค. <input type="password" name="memberPw" class="form-control">
				</td>
			</tr>
		</table>
	<button type="submit" class="btn btn-info btn-sm float-right">ํํดํ๊ธฐ</button>
	</form>
	</div>
</body>
</html>