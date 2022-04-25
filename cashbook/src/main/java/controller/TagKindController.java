package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HashtagDao;

@WebServlet("/TagKindController")
public class TagKindController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 똑같은 새션을 가져와서 
		HttpSession session = request.getSession();
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
				
		// 로그인이 하지 않은 상태라면
		if(sessionMemberId == null) {
				response.sendRedirect(request.getContextPath()+"/LoginController");
				return;
		}
			// 인코딩 utf-8
			request.setCharacterEncoding("utf-8");
		
			// kind 값 받아오기 
			String kind = request.getParameter("kind");
			System.out.println("kind ->"+ kind);
			
			//HashtagDao 메서드 호출 
			HashtagDao hashtagDao = new HashtagDao();
			List<Map<String,Object>> list = hashtagDao.selectKindTagRankList(kind);
			
			//리스트값 넘겨주기
			request.setAttribute("list", list);
			request.setAttribute("kind", kind);
			request.getRequestDispatcher("/WEB-INF/view/TagKindList.jsp").forward(request, response);
	}

}
