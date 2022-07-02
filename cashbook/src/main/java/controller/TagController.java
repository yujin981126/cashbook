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

import dao.HashtagDao;

@WebServlet("/TagController")
public class TagController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 똑같은 새션을 가져와서 
		HttpSession session = request.getSession();
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
				
		// 로그인이 하지 않은 상태라면
		if(sessionMemberId == null) {
				response.sendRedirect(request.getContextPath()+"/LoginController");
				return;
		}
		
		//HashtagDao 메서드 호출 
		HashtagDao hashtagDao = new HashtagDao();
		List<Map<String,Object>> taglist = hashtagDao.selectTagRankList();

		// date 값 받아오기 
		String tag = request.getParameter("tag");
		System.out.println("tag ->"+ tag);
		
		//HashtagDao 메서드 호출 
		List<Map<String,Object>> list = hashtagDao.selectTagOneList(tag);
		
		//리스트값 넘겨주기
		request.setAttribute("taglist", taglist);
		request.setAttribute("list", list);
		request.setAttribute("tag", tag);
		
		request.getRequestDispatcher("/WEB-INF/view/TagList.jsp").forward(request, response);
	}

}
