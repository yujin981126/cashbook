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

import dao.HashtagDao;

@WebServlet("/TagController")
public class TagController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//HashtagDao 메서드 호출 
		HashtagDao hashtagDao = new HashtagDao();
		List<Map<String,Object>> list = hashtagDao.selectTagRankList();
		
		
		// CASHBOOK으로 돌아가기 위한 위한 년도와 월 정보 전달
		Calendar now = Calendar.getInstance();
		int y = now.get(Calendar.YEAR);
		int m = now.get(Calendar.MONTH)+1;
				
		//리스트값 넘겨주기
		request.setAttribute("list", list);
		request.setAttribute("y", y);
		request.setAttribute("m", m);
		request.getRequestDispatcher("/WEB-INF/view/TagList.jsp").forward(request, response);
	}
}
