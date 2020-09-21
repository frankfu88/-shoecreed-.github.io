<%@page import="allPay.payment.integration.domain.AioCheckOutALL"%>
<%@page import="allPay.payment.integration.domain.AioCheckOutOneTime"%>
<%@page import="allPay.payment.integration.*"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="uuu.vgb.entity.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Order order = (Order) request.getAttribute("order");
    session.setAttribute("credit_card_order_id", order.getId());
%>
<%
    List<String> enErrors = new ArrayList<>();
    try {
        String protocol = request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/"));
        String ipAddress = java.net.InetAddress.getLocalHost().getHostAddress();
        String url = protocol + "://" + ipAddress + ":" + request.getLocalPort() 
        	+ request.getContextPath() + "/credit_card_back.do";     
       
        AllInOne all = new AllInOne("");
        AioCheckOutALL obj = new AioCheckOutALL();
        obj.setChoosePayment("ALL");//必須是ALL       
        obj.setClientBackURL(url);
        obj.setCreditInstallment("");
        obj.setItemName("SHOECREED-"+order.getId()+" "+order.getTotalAmountWithFee());
        obj.setMerchantID("2000132");//必須是2000132
        obj.setMerchantTradeDate(LocalDate.now().toString().replace('-', '/') 
        			+ " " + LocalTime.now().toString().substring(0, 8));//格式必須是yyyy/MM/dd hh:mm:ss
		String orderIdStr = "VGB" 
	        	+ LocalDate.now().toString().replace("-", "")        	
	        	+ String.format("%09d", order.getId());
        
        obj.setMerchantTradeNo(orderIdStr);  //必須是20個英數字字元，且不得與之前的訂單重複
        obj.setReturnURL(url);
        obj.setTotalAmount(String.valueOf((int)order.getTotalAmountWithFee()));
        obj.setTradeDesc("建立信用卡測試");
        String form = all.aioCheckOut(obj, null);
        System.out.println("form = " + form);
%>
<!-- 這個畫面不會顯示 -->
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Credit</title>
    </head>
    <body><%=form%></body>
</html>
<%
    } catch (Exception e) {
        // 例外錯誤處理。
        e.printStackTrace();
        enErrors.add(e.getMessage());
    } finally {
        // 回覆錯誤訊息。
        if (enErrors.size() > 0) {
            if (!enErrors.contains(null)) out.println("0|" + enErrors + "<br/>");
             	else out.println("0|" + "交易失敗，請重新操作一次" + "<br/>");            
            out.println("<br/>");
        }
    }
%>