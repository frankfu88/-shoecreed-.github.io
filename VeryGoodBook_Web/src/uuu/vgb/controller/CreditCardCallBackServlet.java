package uuu.vgb.controller;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import uuu.vgb.entity.Customer;
import uuu.vgb.entity.VGBException;
import uuu.vgb.service.OrderService;

/**
 * Servlet implementation class CreditCardCallBackServlet
 */
@WebServlet("/credit_card_back.do")
public class CreditCardCallBackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Customer member = (Customer) request.getSession().getAttribute("member");
		// 1. 取得request中的parameter

		String amount = request.getParameter("amount");
		String auth_code = request.getParameter("auth_code");
		String card4no = request.getParameter("card4no");
		String card6no = request.getParameter("card6no");
		String merchantTradeNo = request.getParameter("MerchantTradeNo");
		String process_date = request.getParameter("process_date");
		String paymentTypeChargeFee = request.getParameter("PaymentTypeChargeFee");
		int orderId = 0;
		Integer oid = (Integer) request.getSession().getAttribute("credit_card_order_id");
		if (oid != null) {// 取出session中的訂單編號
			orderId = oid;
			request.getSession().removeAttribute("credit_card_order_id");
		}

		// 2. 呼叫商業邏輯
		OrderService service = new OrderService();
		try {
			service.updateStatusToPAID(orderId, member.getId(), card6no, card4no, auth_code, process_date, amount);
		} catch (VGBException ex) {
			this.log("信用卡授權發生錯誤", ex);
		}

		// 3. redirect to /member/orders_history.jsp (或"/member/order.jsp?orderId=" +
		// orderId)
		response.sendRedirect(request.getContextPath()+"/member/order_history.jsp");
		return;
	}

}
