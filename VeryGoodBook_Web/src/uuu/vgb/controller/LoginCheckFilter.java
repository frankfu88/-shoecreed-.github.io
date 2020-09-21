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
 * Servlet implementation class LoginCheckFIlter
 */
@WebFilter("/member/*")
public class LoginCheckFilter implements Filter {
	
    /**
     Default Constructor
     */
    public LoginCheckFilter() {
        // TODO Auto-generated constructor stub
    }

	/** Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = ((HttpServletRequest)request).getSession();
		
		Customer member = (Customer)session.getAttribute("member");
		if(member==null) {
			//TODO:如何將原來的網址(?)記錄在loginServlet找得到的地方並可在登入成功時轉交給這個網頁
			session.setAttribute("prev.uri", req.getRequestURI());
			session.setAttribute("prev.uri.querystring", req.getQueryString());
			
			res.sendRedirect(req.getContextPath()+"/login_sc.jsp");
			return;
		}
		chain.doFilter(request, response);
	}
}

