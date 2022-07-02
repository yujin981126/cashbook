<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertCashBookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<%@ page import="java.util.*" %>
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
<body>
<%
	Calendar now = Calendar.getInstance();
	int y = now.get(Calendar.YEAR);
	int m = now.get(Calendar.MONTH) + 1;
	int year = (Integer)request.getAttribute("year");
	int month = (Integer)request.getAttribute("month");
%>
<div class="container">
	<br>
<h1>📅 CASHBOOK</h1><br>
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
		<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>">[<%=session.getAttribute("sessionMemberId")%>]</a>님 반갑습니다. &nbsp;
		<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">로그아웃</a>
	</div>
	</li>
</ul>
	<br><br>
	<br>
	<form method="post" action="<%=request.getContextPath()%>/InsertCashBookController">
	 <table class="table table-bordered">
	 <tr>
	 <td class="table-info text-center">
	 <b>입력하기</b>
	 </td>
	 </tr>
		<tr>
			<td>
				<input type="text" name="cashDate" value="<%=(String)request.getAttribute("cashDate")%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>
				<input type="radio" name="kind" value="수입"> 수입
				<input type="radio" name="kind" value="지출"> 지출
			</td>
		</tr>
		<tr>
            <td><input type="number" name="cash"  class="form-control" placeholder="1000원"></td> 
         </tr>
		
		<tr>
			<td>
				<textarea rows="4" cols="50" name="memo" class="form-control"></textarea>
			</td>
		</tr>
		<tr>
			<td>

			</td>
		</tr>
	</table>
	<button type="submit" class="btn btn-info float-right">입력</button>
	</form>
</div>
</body>
</html>