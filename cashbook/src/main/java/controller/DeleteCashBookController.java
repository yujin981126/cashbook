package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CashBookDao;

@WebServlet("/DeleteCashBookController")
public class DeleteCashBookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//cashbookNo 값 불러오기 
		int cashbookNo = Integer.parseInt(request.getParameter("cashbookNo"));
		System.out.println("cashbookNo : "+ cashbookNo);
		
		//dao에서 selectCashBookOne메서드 호출
		CashBookDao cashbookDao = new CashBookDao();
		cashbookDao.deleteCashBook(cashbookNo);
				
		response.sendRedirect(request.getContextPath()+"/CashBookListByMonthController");
		
	}

}
