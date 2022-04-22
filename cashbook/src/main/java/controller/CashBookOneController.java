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
import javax.servlet.http.HttpSession;

import dao.CashBookDao;


@WebServlet("/CashBookOneController")
public class CashBookOneController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 똑같은 새션을 가져와서 
		HttpSession session = request.getSession();
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
				
		// 로그인이 되어 있는 상태
		if(sessionMemberId == null) {
				response.sendRedirect(request.getContextPath()+"/LoginController");
				return;
		}
		//cashbookNo 값 불러오기 
		int cashbookNo = Integer.parseInt(request.getParameter("cashbookNo"));
		System.out.println("cashbookNo : "+cashbookNo);
		
		//dao에서 selectCashBookOne메서드 호출
		CashBookDao cashbookDao = new CashBookDao();
		List<Map<String, Object>> list = cashbookDao.selectCashBookOne(cashbookNo);
		
		// 뒤로가기를 위한 년도와 월 정보 전달
		Calendar now = Calendar.getInstance();
		int y = now.get(Calendar.YEAR);
		int m = now.get(Calendar.MONTH)+1;
		
		request.setAttribute("list", list);
		request.setAttribute("y", y);
		request.setAttribute("m", m);
		
		request.getRequestDispatcher("/WEB-INF/view/CashBookOne.jsp").forward(request, response);
		
	}

}
