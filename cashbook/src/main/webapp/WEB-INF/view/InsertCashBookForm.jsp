<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertCashBookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<%
	int year = (Integer)request.getAttribute("year");
	int month = (Integer)request.getAttribute("month");
%>
<div class="container">
	<div class="text-center">
	<br>
	<h1>insertCashBookForm</h1>
	</div>
	
	<div class="float-right">
		<a href="#">[<%=session.getAttribute("sessionMemberId")%>]</a>님 반갑습니다. &nbsp;
		<a href="<%=request.getContextPath()%>/LogoutController" class="btn btn-outline-info btn-sm">로그아웃</a>
	</div>
	<a href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=year%>&m=<%=month%>" class="btn btn-info float-left btn-sm">뒤로가기</a>
		<br><br>
	
	<form method="post" action="<%=request.getContextPath()%>/InsertCashBookController">
	 <table class="table table-bordered">
		<tr>
			<td class="text-center table-info">DAY</td>
			<td>
				<input type="text" name="cashDate" value="<%=(String)request.getAttribute("cashDate")%>" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td class="text-center table-info">KIND</td>
			<td>
				<input type="radio" name="kind" value="수입"> 수입
				<input type="radio" name="kind" value="지출"> 지출
			</td>
		</tr>
		<tr>
            <td class="text-center table-info">CASH</td>
            <td><input type="number" name="cash">원</td> 
         </tr>
		
		<tr>
			<td class="text-center table-info">MEMO</td>
			<td>
				<textarea rows="4" cols="50" name="memo"></textarea>
			</td>
		</tr>
	</table>
	<button type="submit" class="btn btn-info float-right">입력</button>
	</form>
</div>
</body>
</html>