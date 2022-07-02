<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CashBookOne</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
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
int y = (Integer) request.getAttribute("y");
int m = (Integer) request.getAttribute("m");
List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("list");
%>
<body>
	<div class="container">
		<br>
		<h1>📅 CASHBOOK</h1>
		<br>
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m%>">Calender</a>
			</li>
			<li class="nav-item"><a class="nav-link"
				href="<%=request.getContextPath()%>/TagController">#Hash_Tag</a></li>
			<li class="nav-item"><a class="nav-link"
				href="<%=request.getContextPath()%>/TagSearchController">Search</a>
			</li>
			  <li class="nav-item">
    <a class="nav-link" href="<%=request.getContextPath()%>/StatsController">Stats</a>
  </li>
			<li class="form-inline my-lg-0 id">
				<div class="session">
					<a href="<%=request.getContextPath()%>/SelectMemberOneController?id=<%=session.getAttribute("sessionMemberId")%>">[<%=session.getAttribute("sessionMemberId")%>]
					</a>님 반갑습니다. &nbsp; <a
						href="<%=request.getContextPath()%>/LogoutController"
						class="btn btn-outline-info btn-sm">로그아웃</a>
				</div>
			</li>
		</ul>
		<br> <br> <br>
		<table class="table">
			<%
			for (Map map : list) {
			%>
			<tr class="text-center table-info">
				<td colspan="2">상세보기</td>
			</tr>
			<tr>
				<td><b> 
				<%
					 String kind = null;
					 if (map.get("kind").equals("수입")) {
					 %> 
					 <span style="color: #487AB8">+ 수입<%=map.get("cash")%></span> <%
					 } else if (map.get("kind").equals("지출")) {
					 %> 
					 <span style="color: #B5483A">- 지출<%=map.get("cash")%></span> <%
					 }
					 %>원
				</b></td>
				<td class="text-right"><%=map.get("cashDate")%></td>
			<tr style="height: 400px">
				<td colspan="2"><%=map.get("memo")%></td>
			</tr>
			<tr>
				<td colspan="2">
				</td>
			<tr>
		</table>
		<div class="text-center">
			<a
				href="<%=request.getContextPath()%>/UpdateCashBookController?cashbookNo=<%=map.get("cashbookNo")%>"
				class="btn btn-dark btn-sm">수정</a> <a
				href="<%=request.getContextPath()%>/DeleteCashBookController?cashbookNo=<%=map.get("cashbookNo")%>"
				class="btn btn-dark btn-sm">삭제</a>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>