package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import vo.Member;


@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	//로그인 폼으로 이동함
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 똑같은 새션을 가져와서 
		HttpSession session = request.getSession();
		String sessionMemberId = (String)session.getAttribute("sessionMemberId");
		
		// 로그인이 되어 있는 상태
		if(sessionMemberId != null) {
			response.sendRedirect(request.getContextPath()+"/CashBookListByMonthController");
			return;
			
		}
		// 로그인 되어 있는 멤버면 리다이렉트
		request.getRequestDispatcher("/WEB-INF/view/Login.jsp").forward(request, response);
		
	}
	// 로그인 액션으로 이동함
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberId = request.getParameter("memberId");	
		String memberPw = request.getParameter("memberPw");
		
		System.out.println(memberId + memberPw);
		
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		
		//모델 호출
		
		MemberDao memberDao = new MemberDao();
		String returnMemberId = memberDao.selectMemberByIdPw(member);
		if(returnMemberId == null) {
			//로그인 실패 
			response.sendRedirect(request.getContextPath()+"/LoginController");//로그인 실패시 로그인 폼을 재요청 
			return;
		}
		// 로그인 성공
		HttpSession session = request.getSession(); // 현재 연결한 클라이언트 (브라우저) 새션값을 받아온다
		session.setAttribute("sessionMemberId", returnMemberId);
		
		response.sendRedirect(request.getContextPath()+"/CashBookListByMonthController");
	}

}
