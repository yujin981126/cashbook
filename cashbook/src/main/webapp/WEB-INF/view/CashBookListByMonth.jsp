<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CashBookListByMonth</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container">

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
   %>
   
   		

   	<div class="text-center">
   		<br>
   		<h1><%=y%>년 <%=m%>월</h1>
	</div>
	<a href="<%=request.getContextPath()%>/TagController" class="btn btn-info float-right btn-sm">#Tag</a>
	<br>
	<br>
      <table class="table table-bordered">
         <thead>
            <tr class="text-center table-info">
               <th class="text-danger">일</th>
               <th class="text-dark">월</th>
               <th class="text-dark">화</th>
               <th class="text-dark">수</th>
               <th class="text-dark">목</th>
               <th class="text-dark">금</th>
               <th class="text-primary">토</th>
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
                }%>
            <td class="<%=c%>">
            	<%=i - startBlank%>
            	
            	<a href="<%=request.getContextPath()%>/InsertCashBookController?y=<%=y%>&m=<%=m%>&d=<%=i-startBlank%>" class="btn btn-outline-info float-right btn-sm">입력</a>
                <hr>
            	<!-- 해당 날짜의 cashbook 목록 출력 -->
                <div class="text-dark">
		           <% for (Map map:list){
		                if((Integer)map.get("day") == (i-startBlank)){ %>
			            	<div>
				            	<small><a href ="<%=request.getContextPath()%>/CashBookOneController?cashbookNo=<%=map.get("cashbookNo")%>" class="text-dark">
				                [<%=map.get("kind")%>]<%=map.get("cash")%>원<%=map.get("memo")%>
				                </a></small>
			                </div>
		                  <%}%>
		              <%}%>
             	</div>
            </td>
            	<% }else{ %>
            	<td>&nbsp;</td>
            	<%} %>
            	<%if(i<totalTd && i%7 == 0) {%>
                </tr><tr>
            	<% } %>
           	<% } %>
            </tr>
            </tboay>
      </table>
      
	<div class="text-center">
      <a href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m-1%>" class="btn btn-dark ">이전</a>
      <a href="<%=request.getContextPath()%>/CashBookListByMonthController?y=<%=y%>&m=<%=m+1%>" class="btn btn-dark ">다음</a>
   	</div>
   </div>
</body>
</html>