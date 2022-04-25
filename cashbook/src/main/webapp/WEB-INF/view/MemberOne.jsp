<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<%
	int y = (Integer)request.getAttribute("y");
	int m = (Integer)request.getAttribute("m");
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
%>
<div class="container">
	<div class="text-center">
	<br>
	<h1>MemberOne</h1>
	</div>
	<div class="float-right">
		<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>">[<%=session.getAttribute("sessionMemberId")%>]</a>님 반갑습니다. &nbsp;
		<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">로그아웃</a>
	</div>
	<a href="<%=request.getContextPath()%>/CashBookListByMonthController" class="btn btn-outline-info float-left btn-sm">뒤로가기</a>
	<br>	<br>
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
		<a href="<%=request.getContextPath()%>/UpdateMemberPwController" class="btn btn-info btn-sm">패스워드수정</a>
		<a href="<%=request.getContextPath()%>/DeleteMemberController" class="btn btn-info btn-sm">회원탈퇴</a>
	</div>
	</div>
</body>
</html>