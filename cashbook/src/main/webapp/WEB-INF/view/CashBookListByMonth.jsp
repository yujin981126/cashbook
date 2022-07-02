<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import ="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CashBookListByMonth</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
   <%
   List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
      
   int y = (Integer)request.getAttribute("y");
   int m = (Integer)request.getAttribute("m");
   int startBlank = (Integer)request.getAttribute("startBlank");
   int endDay = (Integer)request.getAttribute("endDay");
   int endBlank = (Integer)request.getAttribute("endBlank");
   int totalTd = (Integer)request.getAttribute("totalTd");
   
   //  디버깅 
   System.out.println(list.size() + " list.size() CashBookListByMonth.jsp");
   System.out.println(y + " y CashBookListByMonth.jsp");
   System.out.println(m + " m CashBookListByMonth.jsp");
   System.out.println(startBlank + "startBlank CashBookListByMonth.jsp");
   System.out.println(endDay + "endDay CashBookListByMonth.jsp");
   System.out.println(endBlank + " endBlank CashBookListByMonth.jsp");
   System.out.println(totalTd + " totalTd CashBookListByMonth.jsp");
  
   for(Map map : list) {
   	System.out.println(map.get("cashbookNo"));
   	}
   
   // 월을 영여로 변환 
   String month =null;
   if(m == 1){
	   month = "January";
   }else if(m == 2){
	   month = "February";
   }else if(m == 3){
	   month = "March";
   }else if(m == 4){
	   month = "April";
   }else if(m == 5){
	   month = "May";
   }else if(m == 6){
	   month = "June";
   }else if(m == 7){
	   month = "July";
   }else if(m == 8){
	   month = "August";
   }else if(m == 9){
	   month = "September";
   }else if(m == 10){
	   month = "October";
   }else if(m == 11){
	   month = "November";
   }else if(m == 12){
	   month = "December";
   }

	Calendar now = Calendar.getInstance();
   %>
<body>

<div class="container">
<div>
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
 a{
	text-decoration: none;
	color:#000000;
}
</style>

<br>
<h1>📅 CASHBOOK</h1><br>
<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m%>">Calender</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<%=request.getContextPath()%>/TagController">#Hash_Tag</a>
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
</div>
<br><br>
<div class="text-center">
	<font size="6em" style="font-weight: 500"><a href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m-1%>" style="text-decoration:none; color:#222222;">◀</a>
	<%=month%> <%=y%>
	<a href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m+1%>" style="text-decoration:none; color:#222222;">▶</a>	
	</font>	
</div>
<!-- 
<a href="<%=request.getContextPath()%>/TagController" class="btn btn-info float-left btn-sm">#Tag</a>
 -->
<br>
     <table class="table table-bordered">
        <thead>
           <tr class="text-center table-info">
              <th class="text-danger">Monday</th>
              <th class="text-dark">Monday</th>
              <th class="text-dark">Tuesday</th>
              <th class="text-dark">Wednesday</th>
              <th class="text-dark">Thursday</th>
              <th class="text-dark">Friday</th>
              <th class="text-primary">Saturday</th>
           </tr>
        </thead>
        <tboay>
           <tr>
           <!-- 날짜 부분 출력 -->
           <% for(int i=1; i<=totalTd; i++){ %>
           
           <!-- 1일부터 마지막 날짜만 출력이 되야 한다.  -->
           
              <% if((i - startBlank)>0 && (i - startBlank)<=endDay){
            	 String c ="";
             	if (i%7==0) {
               	c="text-primary";
               }else if(i%7==1){
               	c="text-danger";
               } %>
           <td class="<%=c%>">
           	<%=i - startBlank%>
           	
           	<a href="<%=request.getContextPath()%>/InsertCashBookController?y=<%=y%>&m=<%=m%>&d=<%=i-startBlank%>" class="btn btn-outline-info float-right btn-sm">입력</a>
            <hr>
           	<!-- 해당 날짜의 cashbook 목록 출력 -->
            <div class="text-dark">
         	<% for (Map map:list){
              	if((Integer)map.get("day") == (i-startBlank)){ %>
            	<small>
	            	<a href ="<%=request.getContextPath()%>/CashBookOneController?cashbookNo=<%=map.get("cashbookNo")%>" class="text-dark">
					<%
					 String kind = null;
				     if(map.get("kind").equals("수입")){ %>
				    	<span style="color:#487AB8">+<%=map.get("cash")%>원</span>
				   <% }else if(map.get("kind").equals("지출")){ %>
				    <span style="color:#B5483A">-<%=map.get("cash")%>원</span>
				   	<%	}%> <%=map.get("memo")%>...
	                </a>
	                <br>
                </small>
                <%}%>
            <%}%>
         	</div>
           </td>
           	<% }else{ %>
	           <td>&nbsp;</td>
	       <%} %>
	         <%if(i<totalTd && i%7 == 0) {%>
	               </tr>
	            <tr>
	           	<% } %>
          	<% } %>
           </tr>
           </tboay>
     </table>
  </div>
</body>
</html>