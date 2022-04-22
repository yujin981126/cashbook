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

import dao.MemberDao;
import vo.Member;

@WebServlet("/SelectMemberOneController")
public class SelectMemberOneController extends HttpServlet {
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
		String id = request.getParameter("id");
		MemberDao memberDao = new MemberDao();
		List<Map<String,Object>> list = memberDao.selectMemberOne(id);
		
		for(Map m:list) {
			System.out.println("정보->"+ m);
		}
		//리스트값 넘겨주기
		request.setAttribute("list", list);
		request.getRequestDispatcher("/WEB-INF/view/MemberOne.jsp").forward(request, response);
		
	}


}
