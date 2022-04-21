<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TagOneList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<%
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
%>
<div class="container">
	<div class="text-center">
		<br>
		<h1>TagOneList</h1>
		</div>
		<a href="<%=request.getContextPath()%>/TagController" class="btn btn-outline-info float-right">뒤로가기</a>
		<br>
		<br>
			<table class="table table-bordered">
				<tr class="text-center table-info">
					<th>Tag</th>
					<th>Date</th>
					<th>kind</th>
					<th>cash</th>
					<th>memo</th>
				</tr>
				<%
					for(Map<String, Object> map : list) {
				%>

							<tr class="text-center">
								<td># <%=map.get("tag")%></td>
								<td><%=map.get("cashDate")%></td>
								<td>[<%=map.get("kind")%>]</td>
								<td><%=map.get("cash")%> 원</td>
								<td><%=map.get("memo")%> </td>
							</tr>
				<%} %>
			</table> 
</div>
</body>
</html>