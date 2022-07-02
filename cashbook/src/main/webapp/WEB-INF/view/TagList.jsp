<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TagList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<style>
ul{
width:100%;
float:left;
}
 .id{
flex-grow:1;
position: relative;

 }
 .session{
 position:absolute;
right: 0;
 }
</style>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
<%
	Calendar now = Calendar.getInstance();	
	int y = now.get(Calendar.YEAR);
	int m = now.get(Calendar.MONTH)+1;
	List<Map<String, Object>> taglist = (List<Map<String, Object>>)request.getAttribute("taglist");
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
	String tag = (String)(request.getAttribute("tag"));
%>
<div class="container">
<br>
	<h1>📅 CASHBOOK</h1><br>
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link" href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m%>">Calender</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" href="<%=request.getContextPath()%>/TagController">#Hash_Tag</a>
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
	<div class="text-center">
	<font size="6em" style="font-weight:500">해시태그 TOP10</font>
	</div>
	<br>
	<div class="row">
		<div class="col-sm-5">
		- 해시태그를 눌러보세요!(10번 이상 사용된 해시태그 기준)
		<table class="table">
		<%
			for(Map<String, Object> map : taglist) {
		%>
			<tr>
			
				<td class="text-left" width="30%">
				<span class="badge badge-pill badge-info">
				<%=map.get("rank")%>등
				</span>&nbsp;
					<b>
					<a style="text-decoration:none; color:#222222;" href="<%=request.getContextPath()%>/TagController?tag=<%=map.get("tag")%>">#<%=map.get("tag")%></a>
					</b>
				</td>
				<td>
					<div class="zt-skill-bar">
						<div data-width="<%=map.get("cnt")%>" style="">
						<span><%=map.get("cnt")%>번</span>
						</div>
					</div>
				</td>
			</tr>
		<%			
			}
		%>
		</table>
		</div>
		<div class="col-sm-7">
		<% 
			if(list.size() != 0){
		%>
			<div class="text-center">
			<h5><b>#<%=tag%></b></h5>
			</div>
			<table class="table">
			<%
				for(Map<String, Object> map : list) {
			%>
			<tr>
				<td class="text-left">
				<%
				 String kind = null;
			     if(map.get("kind").equals("수입")){ %>
			    <span style="color:#487AB8">[수입] </span>
			   <% }else if(map.get("kind").equals("지출")){ %>
			    <span style="color:#B5483A">[지출] </span>
			   	<%	}%>
			   	&nbsp;
			   	</td>
				<td class="text-left"><%=map.get("cash")%>원</td>
				<td class="text-left"><%=map.get("memo")%> </td>
				<td class="text-right"><%=map.get("cashDate")%></td>
			</tr>
			<%} %>
			</table> 
		<% } %>
		</div>
	</div>
</div>
</body>
<script>
(function( $ ) {
    "use strict";
    $(function() {
        function animated_contents() {
            $(".zt-skill-bar > div ").each(function (i) {
                var $this  = $(this),
                    skills = $this.data('width');
                $this.css({'width' : skills*2 + '%'});
 
            });
        }
        if(jQuery().appear) {
            $('.zt-skill-bar').appear().on('appear', function() {
                animated_contents();
            });
        } else {
            animated_contents();
        }
    });
}(jQuery));
</script>
</html>