package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;


@WebServlet("/UpdateMemberPwController")
public class UpdateMemberPwController extends HttpServlet {
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
				
		request.getRequestDispatcher("/WEB-INF/view/UpdateMemberPw.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 똑같은 새션을 가져와서 
		HttpSession session = request.getSession();
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
										
		// 로그인이 하지 않은 상태라면
		if(sessionMemberId == null) {
				response.sendRedirect(request.getContextPath()+"/LoginController");
				return;
		}
		
		String memberId = sessionMemberId;
		String memberPw = request.getParameter("memberPw");//변경전 비밀번호 
		String memberPw2 = request.getParameter("memberPw2"); //변경후 비밀번호 
		
		System.out.println("memberPw : "+memberPw);
		System.out.println("memberPw2 : "+memberPw2);
		
		MemberDao memberDao = new MemberDao();
		memberDao.updateMemberPw(memberId, memberPw, memberPw2);
		
		response.sendRedirect(request.getContextPath()+"/LogoutController");
	}

}
