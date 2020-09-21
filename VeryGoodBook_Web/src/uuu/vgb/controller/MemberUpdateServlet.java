package uuu.vgb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;
import uuu.vgb.entity.VIP;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name="MemberUpdateServlet",  //"/LOGIN.DO", "/Login.Do", "/Login.do"
		urlPatterns= {"/member/update.do", }) // http://localhost:8080/vgb/login.do
public class MemberUpdateServlet extends HttpServlet {	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException{
	
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		Customer member = (Customer)session.getAttribute("member");
		request.setCharacterEncoding("utf-8");
		
		//1. 取得request中的Form Data,並檢查之
		String id=member.getId();
		String password=request.getParameter("password");
		String name=request.getParameter("name");

		String changePwd = request.getParameter("changePwd");
		String pwd1=request.getParameter("pwd1");
		String pwd2=request.getParameter("pwd2");
		String gender=request.getParameter("gender");
		String birthday=request.getParameter("birthday");
		String email=request.getParameter("email");		
		String captcha=request.getParameter("captcha");
		
		String address=request.getParameter("address");
		String phone=request.getParameter("phone");
		String bloodType=request.getParameter("bloodType");
		String married=request.getParameter("married");
		System.out.println(id);
		
		if(id==null || id.length()==0) {
			errors.add("必須輸入帳號");
		}		
		
		if(name==null || name.length()==0) {
			errors.add("必須輸入姓名");
		}
		if(password==null || password.length()==0
				|| !password.equals(member.getPassword())) {
			errors.add("必須輸入正確的原密碼");
		}
		
		if(changePwd!=null) {
			if(pwd1==null || pwd1.length()==0 || pwd2==null || pwd2.length()==0) {
				errors.add("必須輸入密碼");
			}else if(!pwd1.equals(pwd2)){
				errors.add("密碼與確認密碼不一致");
			}
		}

//		if(gender==null || gender.length()!=1) {
//			errors.add("必須輸入性別");
//		}
//		if(birthday==null || birthday.length()==0) {
//			errors.add("必須輸入生日");
//		}
		if(email==null || email.length()==0) {
			errors.add("必須輸入Email");
		}
		
//		if(captcha==null || captcha.length()==0) {
//			errors.add("必須輸入驗證碼");
//		}else {
//			String oldCaptcha = (String)session.getAttribute("RegisterCaptchaServlet");
//			if(!captcha.equalsIgnoreCase(oldCaptcha)) {
//				errors.add("驗證碼不正確");
//			}
//		}
//		session.removeAttribute("RegisterCaptchaServlet");		

		//2. 若檢查無誤，則呼叫商業邏輯
		if(errors.isEmpty()) {									
			CustomerService service = new CustomerService();
			
			try {
				Customer c = member.getClass().newInstance();
				c.setId(member.getId());
				c.setPassword(changePwd!=null?pwd1:member.getPassword());
				c.setName(name);
//				c.setGender(gender.charAt(0));
				c.setBirthday(birthday);
				c.setEmail(email);
				
				c.setAddress(address);
				c.setPhone(phone);
//				c.setMarried(married!=null);
//				c.setBloodType(bloodType);
				if(c instanceof VIP) {
					((VIP)c).setDiscount(((VIP)member).getDiscount());
				}				
				System.out.println(member);				
				System.out.println(c);
				
				service.update(c);
				
				//3.1 redirect to 首頁
				session.setAttribute("member", c);
				response.sendRedirect(request.getContextPath());
					
				return;
			} catch (VGBException ex) {			
				this.log("會員修改失敗!",ex);		
				errors.add("會員修改失敗: " + ex.getMessage());				
			} catch (Exception ex) {
				this.log("會員修改發生非預期錯誤!",ex);
				errors.add("會員修改發生非預期錯誤: " + ex);
			}
		}
		
		//response.setContentType("text/html;charset=UTF-8");
		//3.2 產生錯誤回應
		//response.getWriter().println("controller write: "+errors);
		//response.getWriter().flush();
		
		//3.2 內部轉交給login.jsp，產生錯誤回應		
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("/member/modify_sc.jsp");
		
		dispatcher.forward(request, response);
		
	}

}
