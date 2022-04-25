package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CashBookDao;
import vo.CashBook;


@WebServlet("/InsertCashBookController")
public class InsertCashBookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 똑같은 새션을 가져와서 
		HttpSession session = request.getSession();
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
						
		// 로그인이 하지 않은 상태라면
		if(sessionMemberId == null) {
				response.sendRedirect(request.getContextPath()+"/LoginController");
				return;
		}
		
		// y,m,d 세가지 값을 받아와야 함
		String y = request.getParameter("y");
		String m = request.getParameter("m");
		String d = request.getParameter("d");
		String cashDate = y + "-" + m + "-" + d; // MariaDB에서 0을 자동으로 붙여준다 
		
		// 뒤로가기를 위한 년도와 월 정보 전달
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH)+1;
		
		// 지역변수 cashDate 는 다른곳에서 사용 못하므로
		request.setAttribute("cashDate", cashDate);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.getRequestDispatcher("/WEB-INF/view/InsertCashBookForm.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
		if(sessionMemberId == null) {
			// 로그인 되지 않은 상태라면
			response.sendRedirect(request.getContextPath()+"/LoginController");
			return;
		}
		
		request.setCharacterEncoding("utf-8");
		
		// 넘어온값 변수에 저장하기 
		String cashDate = request.getParameter("cashDate");
		String kind = request.getParameter("kind");
		int cash = Integer.parseInt(request.getParameter("cash"));
		String memo = request.getParameter("memo");
		
		// 디버깅
		System.out.println("cashDate InsertCashBookController do post : "+ cashDate);
		System.out.println("kind InsertCashBookController dopost() : "+ kind);
		System.out.println("cash InsertCashBookController dopost() : "+ cash);
		System.out.println("memo InsertCashBookController dopost() : "+ memo);
		System.out.println("MemberId InsertCashBookController dopost() : "+ sessionMemberId);
		
		CashBook cashbook = new CashBook();
		cashbook.setCashDate(cashDate);
		cashbook.setKind(kind);
		cashbook.setCash(cash);
		cashbook.setMemo(memo);
		cashbook.setMemberId(sessionMemberId);
		
		
		// memo 해시태그 
		List<String> hashtag = new ArrayList<>();
		// 1) #앞에 띄어쓰기 작업
		String memo2 = memo.replace("#"," #");
		// 2) 공백기준으로 문자열 쪼개기
		String[] arr = memo2.split(" ");
		for(String s  :arr) {
			// 3) #을 시작점으로 
			if(s.startsWith("#")) {
				// 4) #을 제거 
				String temp = s.replace("#", "");
				// 5) 공백이 아닌 문자를 저장
				if(temp.length()>0) {
					hashtag.add(temp);
				}
			}
		}
		
		System.out.println("hashtag.size InsertCashBookController dopost(): "+ hashtag.size());
		for(String h : hashtag) {
			//System.out.println(h);
		}
		
		CashBookDao cashbookDao = new CashBookDao();
		cashbookDao.insertCashbook(cashbook, hashtag, sessionMemberId);
		
		response.sendRedirect(request.getContextPath()+"/CashBookListByMonthController");
	}

}
