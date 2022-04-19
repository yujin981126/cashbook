package controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.HTMLDocument.HTMLReader.CharacterAction;

import dao.CashbookDao;

@WebServlet("/CashBookListByMonthController")
public class CashBookListByMonthController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1) 월별 가계부 리스트 요청 분석
		Calendar now = Calendar.getInstance();
		int y = now.get(Calendar.YEAR);
		int m = now.get(Calendar.MONTH)+1;
		
		int today = now.get(Calendar.DATE);

		if(request.getParameter("y") != null) {
			y = Integer.parseInt(request.getParameter("y"));
		}
		if(request.getParameter("m") != null) {
			m = Integer.parseInt(request.getParameter("m"));
		}
		if(m==0) {
			m = 12;
			y = y-1;
		}
		if(m==13) {
			m = 1;
			y = y+1;
		}
		
		System.out.println(y+" <-- y");
		System.out.println(m+" <-- m");
		
		
		// 시작시 필요한 공백 <TD>
		// firstDay는 오늘 날짜를 먼저 구하여 날짜만 1일로 변경
		Calendar firstDay = Calendar.getInstance(); // 오늘 날짜
		firstDay.set(Calendar.YEAR,y); 
		firstDay.set(Calendar.MONTH,m-1);
		firstDay.set(Calendar.DATE,1); // 오늘 월의 1일 
		int dayOFWeek = firstDay.get(Calendar.DAY_OF_WEEK);
		int startBlank  = dayOFWeek -1;
				
		// 마지막 날짜는 자바 달력 api를 이용
		int endDay = firstDay.getActualMaximum(Calendar.DATE);// 마지막 날짜
		
		// startBlank와 endDay 합의 결과에 endBlank를 더해서 7의 배수로 만들기 
		int endBlank =0;
		if((startBlank + endDay)%7 != 0) {
			// 7에서 startBlank + endDay의 7로 나눈 나머지 값을 빼면
			endBlank = 7 - (startBlank + endDay)%7;
		}
		
		// 전체 개수
		int totalTd = startBlank + endDay + endBlank;
		
		
		// 2) 모델값(월별 가계부 리스트)을 반환하는 비지니스로직(모델) 호출
		CashbookDao cashbookDao = new CashbookDao();
		List<Map<String, Object>> list = cashbookDao.selectCashbookListByMonth(y, m);
		/*
		 달력 출력에 필요한 모델 값 + 데이터베이스에서 반환된 모델값
		 */
		request.setAttribute("startBlank", startBlank);
		request.setAttribute("endDay", endDay);
		request.setAttribute("endBlank", endBlank);
		request.setAttribute("totalTd", totalTd);
		
		request.setAttribute("list", list);
		request.setAttribute("y", y);
		request.setAttribute("m", m);
		// 3) 뷰 포워딩
		request.getRequestDispatcher("/WEB-INF/view/CashBookListByMonth.jsp").forward(request, response);
	}

}