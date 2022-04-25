<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CashBookOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<%
		int y = (Integer)request.getAttribute("y");
		int m = (Integer)request.getAttribute("m");
		List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
	%>
	<div class="text-center">
		<br>
		<h1>CashBookOne</h1>
		<br>
	</div>
	<div class="float-right">
		<a href="#">[<%=session.getAttribute("sessionMemberId")%>]</a>님 반갑습니다. &nbsp;
		<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">로그아웃</a>
	</div>
	
	<table class="table table-bordered">
		<% for(Map map :list){ %>
			<tr>
				<td class="text-center">NO</td>
				<td><%=map.get("cashbookNo")%></td>
			</tr>
			<tr>
				<td class="text-center">DAY</td>
				<td><%=map.get("cashDate")%></td>
			</tr>
			<tr>
				<td class="text-center">KIND</td>
				<td><%=map.get("kind")%></td>
			</tr>
			<tr>
				<td class="text-center">CASH</td>
				<td><%=map.get("cash") %></td>
			</tr>
			<tr>
				<td class="text-center">MEMO</td>
				<td><%=map.get("memo") %></td>
			</tr>
	</table>
	
	<div class="float-right">
      <a href="<%=request.getContextPath()%>/UpudateCashBookController?cashbookNo=<%=map.get("cashbookNo")%>" class="btn btn-dark">수정</a>
      <a href="<%=request.getContextPath()%>/DeleteCashBookController?cashbookNo=<%=map.get("cashbookNo")%>" class="btn btn-dark">삭제</a>
   	</div>
   	<% } %>
   	
   	<a href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m%>" class="btn btn-outline-secondary">뒤로가기</a>
	
</div>	
</body>
</html>