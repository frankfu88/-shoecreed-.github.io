package uuu.vgb.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uuu.vgb.entity.Customer;
import uuu.vgb.entity.DataInvalidException;
import uuu.vgb.entity.Order;
import uuu.vgb.entity.PaymentType;
import uuu.vgb.entity.ShippingType;
import uuu.vgb.entity.ShoppingCart;
import uuu.vgb.entity.StockShortageException;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.MailService;
import uuu.vgb.service.OrderService;

/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet("/member/check_out.do")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutServlet() {
        super();
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
		List<String> errors = new ArrayList<>();
		HttpSession session = request.getSession();
		Customer member = (Customer)session.getAttribute("member");
		ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
		if(cart==null && cart.size()==0) {
			response.sendRedirect("cart_sc.jsp");
			return;
		}
		
		//1.讀取request的form data
		String paymentTypeStr=request.getParameter("paymentType");
		String shippingTypeStr=request.getParameter("shippingType");
		String recipientName=request.getParameter("recipientName");
		String recipientPhone=request.getParameter("recipientPhone");
		String recipientEmail=request.getParameter("recipientEmail");
		String shippingAddress=request.getParameter("shippingAddress");
		
		PaymentType paymentType = null;
		ShippingType shippingType = null;
		
		if(paymentTypeStr==null ||
				!PaymentType.contains(paymentTypeStr)) { //必須在PaymentType加上contains
			errors.add(paymentTypeStr +"不是正確的付款方式");
		}else paymentType = PaymentType.valueOf(paymentTypeStr);
		
		if(shippingTypeStr==null ||
				!ShippingType.contains(shippingTypeStr)) { //必須在ShippingType加上contains
			errors.add(shippingTypeStr+"不是正確的貨運方式");
		}else shippingType = ShippingType.valueOf(shippingTypeStr);		
		
		if(recipientName==null ||
				(recipientName=recipientName.trim()).length()==0) {
			errors.add("必須輸入收件人姓名");
		}
		
		if(recipientPhone==null || 
				(recipientPhone=recipientPhone.trim()).length()==0) {
			errors.add("必須輸入收件人電話");
		}
		if(recipientEmail==null ||
				(recipientEmail=recipientEmail.trim()).length()==0) {
			errors.add("必須輸入收件人Email");
		}
		if(shippingAddress==null || 
				(shippingAddress=shippingAddress.trim()).length()==0) {
			errors.add("必須輸入收件地址");
		}
		
		//2. 若無誤則呼叫商業邏輯
		if(errors.isEmpty()) {
			Order order = new Order();
			order.setMember(member);
			order.add(cart);
			
			order.setPaymentType(paymentType);
			order.setPaymentFee(paymentType.getFee());
			order.setShippingType(shippingType);
			order.setShippingFee(shippingType.getFee());
			
			order.setRecipientName(recipientName);
			order.setRecipientPhone(recipientPhone);
			order.setRecipientEmail(recipientEmail);
			order.setShippingAddress(shippingAddress);
			
			MailService.sendHelloMailWithLogo(recipientEmail);
			
			OrderService orderService = new OrderService();
			try {
				orderService.checkOut(order);
				session.removeAttribute("cart");//務必清除購物車
				
				//加入信用卡串接程式(以下紅色粗體字部分)
		         request.setAttribute("order", order);

		         //若paymentType=PaymentType.CARD則轉交/WEB-INF/credit_card.jsp來送出對於第三方支付的請求
		         if(order.getPaymentType()==PaymentType.CARD){                   
		           request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);                  
		             return;
		         }

				//3.1 redirect to order_history.jsp								
				response.sendRedirect("order_history.jsp");
				return;
			}catch(DataInvalidException e) {				
				errors.add(e.getMessage());
			}catch(StockShortageException e) {
				//session.setAttribute("stock.shortage", e);
				response.sendRedirect("cart_sc.jsp");
				return;
			}catch(VGBException e) {
				this.log(e.getMessage(), e);
				errors.add(e.getMessage());
			}catch(Exception e) {
				this.log("結帳發生非預期錯誤"+e.getMessage(), e);
				errors.add("結帳失敗:"+e.getMessage());
			}
		}
		System.out.println(errors);
		//3.2
		request.setAttribute("errors", errors);
		request.getRequestDispatcher("checkout_sc.jsp").forward(request, response);
	}

}
