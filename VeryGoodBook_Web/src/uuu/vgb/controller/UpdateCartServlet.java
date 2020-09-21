package uuu.vgb.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.CartItem;
import uuu.vgb.entity.ShoppingCart;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/member/update_cart.do")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
		if(cart!=null) {
			Set<CartItem> trashCan = new HashSet<>();
			//1.取得request的Form Data
				for(CartItem item:cart.getCartItemSet()) {
					String quantity=request.getParameter("quantity"+item.hashCode());
					String delete=request.getParameter("delete"+item.hashCode());
					if(delete==null) {//2.1修改購物明細
						if(quantity!=null && quantity.matches("\\d+")) {
							int q = Integer.parseInt(quantity);
							if(q>0) {
								cart.update(item, Integer.parseInt(quantity));
							}else {
								trashCan.add(item);
							}
						}
					}else {//2.2將待刪除購物明細加入trashCan
						//cart.remove(item); //可能發生ConcurrentModificationException
						trashCan.add(item);
					}
					
				} 
				for(CartItem item:trashCan) {
					cart.remove(item);
				}
				
				trashCan.clear();
		}
		
		String submit = request.getParameter("submit");
		//System.out.println(submit);
		//3.redirect to cart_sc.jsp
		if("Checkout".equals(submit)) {
			response.sendRedirect("checkout_sc.jsp");
		}else {
			response.sendRedirect("cart_sc.jsp");
		}
		
	}

}
