package uuu.vgb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login.do"})//http://localhost:8080/vgb/login.do 
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException{
//    	doPost(request, response);
//    }
	/**
	 * @param captcha 
	 * @param captcha 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
//		ServletContext context = this.getServletContext();
//		System.out.println(context.getRealPath("/"));
		
		List<String> errors = new ArrayList<>(); 
		//1.取得request中的FormData(第10章), 並檢查之
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String captcha = request.getParameter("captcha");
		
		if(id==null || id.length()==0) {
			errors.add("必須輸入帳號");
		}
		
		if(pwd==null || pwd.length()==0) {
			errors.add("必須輸入密碼");
		}
		
		HttpSession session = request.getSession();
		if(captcha==null || (captcha=captcha.trim()).length()==0) {
			errors.add("必須輸入驗證碼");
		}else {
			String oldCaptcha = (String)session.getAttribute("CaptchaServlet");
			if(!captcha.equalsIgnoreCase(oldCaptcha)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("CaptchaServlet");

		//2.若無誤，則呼叫商業邏輯
		if(errors.isEmpty()) {
			CustomerService service = new CustomerService();
			try {
				Customer c = service.login(id, pwd);
				
				//3.1 登入成功forward到首頁
				//使用cookie機制將id,keepId記錄在cookie中
				String keepId = request.getParameter("keepId");
				
				Cookie idCookie = new Cookie("id", id);
				Cookie keepIdCookie = new Cookie("keepId", "checked");
				int maxAge=0;
				if(keepId!=null) {
					maxAge = 7*24*60*60; //有效期為7天,秒為單位
				}
				idCookie.setMaxAge(maxAge);
				keepIdCookie.setMaxAge(maxAge);
				
				response.addCookie(idCookie);
				response.addCookie(keepIdCookie);
				
				//HttpSession session = request.getSession();
				session.setAttribute("member", c);
				
				//作法1. 內部轉交forward（此處不適當）
				//RequestDispatcher dispatcher = request.getRequestDispatcher("/");
				//dispatcher.forward(request, response);
				
				//作法2. 外部轉址redirect（建議使用）
				response.sendRedirect(request.getContextPath());
				return;
			} catch (VGBException e) {
				this.log("會員登入發生錯誤", e); //for admin, developers
				errors.add(e.getMessage()); //for users		
			} catch (Exception e) {
				this.log("會員登入發生非預期錯誤", e); //for admin, developers
				errors.add("會員無法登入: "+e.toString()); //for users				
			}
		}
		
		//3.2 登入失敗forward到login畫面
		request.setAttribute("errors", errors);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("login_sc.jsp");
		dispatcher.forward(request, response);
		return;

	}
	

}
