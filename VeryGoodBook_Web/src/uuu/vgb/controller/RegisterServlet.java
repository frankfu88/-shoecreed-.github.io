package uuu.vgb.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.BloodType;
import uuu.vgb.entity.Customer;
import uuu.vgb.entity.DataInvalidException;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.CustomerService;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/register.do") //http://localhost:8080/vgb/register.do
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub        
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errors = new ArrayList<>();
		request.setCharacterEncoding("UTF-8");		
		//1.讀取request中的FormData資料,並檢查		
		String id= request.getParameter("id");
		String name= request.getParameter("name");
		String pwd1= request.getParameter("pwd1");
		String pwd2= request.getParameter("pwd2");
		String email= request.getParameter("email");
		String birthday= request.getParameter("birthday");
		String gender= request.getParameter("gender");
		String captcha= request.getParameter("captcha");
		
		String phone= request.getParameter("phone");
		String address= request.getParameter("address");
		String bloodType= request.getParameter("bloodType");
		String married= request.getParameter("married");
		
		//TODO: 檢查必要欄位: name, email, birthday, gender		
		if(id==null || !Customer.checkId(id)) {
			errors.add("必須輸入正確的id");
		}
		if(name==null || (name=name.trim()).length()==0) {
			errors.add("必須輸入姓名");
		}		
		if(pwd1==null || pwd1.length()==0 || !pwd1.equals(pwd2)) {
			errors.add("必須輸入一致的密碼與確認密碼");
		}
		if(email==null || (email=email.trim()).length()==0) {
			errors.add("必須輸入email");
		}		
		if(birthday==null || (birthday=birthday.trim()).length()==0) {
			errors.add("必須輸入生日");
		}
		if(gender==null || (gender=gender.trim()).length()==0) {
			errors.add("必須輸入性別");
		}
		
		HttpSession session = request.getSession();
		if(captcha==null || (captcha=captcha.trim()).length()==0) {
			errors.add("必須輸入驗證碼");
		}else {
			String oldCaptcha = (String)session.getAttribute("RegisterCaptchaServlet");
			if(!captcha.equalsIgnoreCase(oldCaptcha)) {
				errors.add("驗證碼不正確");
			}
		}
		session.removeAttribute("RegisterCaptchaServlet");
		
		//2.若無誤，呼叫商業邏輯
		if(errors.isEmpty()) {
			Customer c = new Customer();
			try {
				c.setId(id);
				c.setName(name);
				c.setPassword(pwd1);
				c.setEmail(email);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				c.setPhone(phone);
				c.setAddress(address);				
				
				c.setBloodType(bloodType!=null && bloodType.length()>0?
						BloodType.valueOf(bloodType):null);
				
				c.setMarried(married!=null);
				
				CustomerService service = new CustomerService();
				service.register(c);
				
				//3.1 forward(內部轉交)to註冊成功畫面
				request.setAttribute("customer", c);
				RequestDispatcher dispatcher = 
						request.getRequestDispatcher("register_sc_ok.jsp");
				
				dispatcher.forward(request, response);
				return;
			}catch(DataInvalidException e) {				
				errors.add(e.getMessage());
			}catch(VGBException e) {
				this.log(e.getMessage(), e);
				errors.add(e.getMessage());
			}catch(Exception e) {
				this.log("會員註冊發生非預期錯誤"+e.getMessage(), e);
				errors.add("會員註冊失敗:"+e.getMessage());
			}
		}
		
		System.out.println(errors);
		
		//3.2 forward(內部轉交)to註冊失敗畫面
		request.setAttribute("errors", errors);
		RequestDispatcher dispatcher = 
				request.getRequestDispatcher("register_sc.jsp");
		
		dispatcher.forward(request, response);
		
	}

}
