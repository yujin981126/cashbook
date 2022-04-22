<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberOne</title>
</head>
<body>
<%
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
%>
	<h1>MemberOne</h1>
	<table>
		<%
			for(Map<String, Object> map : list) {
		%>
		<tr>
			<td>memberId</td>
			<td><%=map.get("memberId") %></td>
		</tr>
		<tr>
			<td>memberPw</td>
			<td><%=map.get("memberPw") %></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td><%=map.get("createDate") %></td>
		</tr>
		<% } %>
	</table>
</body>
</html>