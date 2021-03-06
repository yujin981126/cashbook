<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberOne</title>
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
<body>
<%
	Calendar now = Calendar.getInstance();
	int y = now.get(Calendar.YEAR);
	int m = now.get(Calendar.MONTH) + 1;
	
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
%>
<div class="container">
<br>
<h1>π CASHBOOK</h1><br>
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
    <li class="form-inline my-lg-0 id">
    <div class="session">
		<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>">[<%=session.getAttribute("sessionMemberId")%>]</a>λ λ°κ°μ΅λλ€. &nbsp;
		<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">λ‘κ·Έμμ</a>
	</div>
	</li>
</ul>
	<br><br>
	<div class="text-center">
			<font size="6em" style="font-weight: 500">λμμ λ³΄</font>
		</div>
		<br>
	<table class="table table-bordered">
		<%
			for(Map<String, Object> map : list) {
		%>
		<tr>
			<td class="table-info">memberID</td>
			<td><%=map.get("memberId") %></td>
		</tr>
		<tr>
			<td class="table-info">createDate</td>
			<td><%=map.get("createDate") %></td>
		</tr>
		<% } %>
	</table>
	<div class="float-right">
		<a href="<%=request.getContextPath()%>/UpdateMemberPwController" class="btn btn-info btn-sm">PWμμ </a>
		<a href="<%=request.getContextPath()%>/DeleteMemberController" class="btn btn-info btn-sm">νμνν΄</a>
	</div>
	</div>
</body>
</html>