<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TagList</title>
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
		<h1>Tag(#) RANKING</h1>
		<br>
	</div>
	<div class="row">
		<div class="col-sm-5">
			<table class="table table-bordered">
				<tr class="text-center table-info">
					<th>rank</th>
					<th>tag</th>
					<th>count</th>
				</tr>
				<%
					for(Map<String, Object> map : list) {
				%>
						<tr class="text-center">
							<td><%=map.get("rank")%> 등</td>
							<td><a href="<%=request.getContextPath()%>/TagOneController?tag=<%=map.get("tag")%>"># <%=map.get("tag")%></a></td>
							<td><%=map.get("cnt")%> 번</td>
						</tr>
				<%			
					}
				%>
			</table>
		</div>
		
		<div class="col-sm-7">
			<table class="table table-bordered">
				<tr class="table-info">
					<td class="text-center">
						수입/지출별 검색
					</td>
				</tr>
				<tr>
					<td>
						<form method="get" action="<%=request.getContextPath()%>/TagKindController">
							<div class="text-center">
							<input type="radio" name="kind" value="수입"> 수입 
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="kind" value="지출"> 지출
							</div>
							<button type="submit" class="btn btn-outline-info float-right">검색</button>
						</form>
					</td>
				</tr>
			</table>

			<table class="table table-bordered">
				<tr class="table-info">
					<td class="text-center">
						날짜별 검색
					</td>
				</tr>
				<tr>
					<td>
						<form method="get" action="<%=request.getContextPath()%>/TagDateController">
							<input type="date" name="date" class="form-control"><br>
							<button type="submit" class="btn btn-outline-info float-right">검색</button>
						</form>
					</td>
				</tr>
			</table>
			<div>
				<a href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m%>" class="btn btn-info float-right btn-sm">cashbook 이동하기</a>
			</div>
		</div>
	</div>	 
</div>
</body>
</html>