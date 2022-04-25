<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TagDateList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<%
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
%>
<div class="container">
	<div class="text-center">
		<br>
		<h1>TagDateList</h1>
		</div>
		<div class="float-right">
		<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>">[<%=session.getAttribute("sessionMemberId")%>]</a>님 반갑습니다. &nbsp;
			<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">로그아웃</a>
			</div>
		<a href="<%=request.getContextPath()%>/TagController" class="btn btn-outline-info float-left">뒤로가기</a>
		<br>
		<br>
		<% if(list.size() == 0) {%>
			<div class="text-center">작성 기록이 존재하지 않습니다.</div>
		<%}else{ %>
			<table class="table table-bordered">
				<tr class="text-center table-info">
					<th>DAY</th>
					<th>rank</th>
					<th>tag</th>
					<th>count</th>
				</tr>
				<%
					for(Map<String, Object> map : list) {
				%>

							<tr class="text-center">
								<td><%=map.get("cashDate")%></td>
								<td><%=map.get("rank")%> 등</td>
								<td># <%=map.get("tag")%></td>
								<td><%=map.get("cnt")%> 번</td>
							</tr>
				<%} %>
		<%}%>
			</table> 
</div>
</body>
</html>