package uuu.vgb.controller;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;

/**
 * Servlet Filter implementation class LoginCheckServlet
 */
@WebFilter("/member/*")
public class LoginCheckServlet implements Filter {

    /**
     * Default constructor. 
     */
    public LoginCheckServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = ((HttpServletRequest)request).getSession();
		
		Customer member = (Customer)session.getAttribute("member");
		if(member==null) {
			//TODO:如何將原來的網址(?)記錄在loginServlet找得到的地方並可在登入成功時轉交給這個網頁
			res.sendRedirect(req.getContextPath()+"/login_sc.jsp");
			return;
		}
		chain.doFilter(request, response);
	}


}
