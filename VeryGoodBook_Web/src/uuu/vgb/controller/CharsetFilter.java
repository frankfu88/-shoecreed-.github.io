package uuu.vgb.controller;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 * Servlet Filter implementation class CharsetFilter
 */
@WebFilter(urlPatterns = { "*.jsp", "*.do"}, dispatcherTypes = {DispatcherType.REQUEST,DispatcherType.ERROR})
public class CharsetFilter implements Filter {

    /**
     * Default constructor. 
     */
    public CharsetFilter() {
        System.out.println("CharsetFilter created");
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//System.out.println(LocalDateTime.now());
		
		request.setCharacterEncoding("UTF-8");
		request.getParameterNames(); //鎖定request的CharacterEncoding
		
		response.setCharacterEncoding("UTF-8");
		response.getWriter(); //鎖定response的CharacterEncoding
		
		chain.doFilter(request, response); //交棒給原來的jsp或servlet
		//System.out.println(LocalDateTime.now());
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		
	}

}
