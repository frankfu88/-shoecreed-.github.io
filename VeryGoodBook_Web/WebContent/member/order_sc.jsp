<%@page import="uuu.vgb.entity.Size"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.OrderItem"%>
<%@page import="uuu.vgb.entity.PaymentType"%>
<%@page import="uuu.vgb.service.OrderService"%>
<%@page import="uuu.vgb.entity.Order"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1" >
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">	
	<title>Order Details | SHOECREED</title>
	<style>
		.orderData{min-height:30vh;width:80%;min-width:380px;margin:auto;margin-top:100px}
		.leftDiv{float:left;width:45%;min-width:350px;padding-top:1ex;font-size:17px}
		.rightDiv{float:left;width:50%;min-width:350px;}
		.orderData h3{clear:both}
		#orderItems {font-size:smaller;width:80%;min-width:380px;margin:auto}
		#orderItems,#orderItems caption{border: gray 1px solid;box-shadow: gray 1px 1px 3px;padding:1ex 0;text-align:center}		
		thead th,tbody td{border-bottom:lightgray 1px solid}
	
	</style>
	<script src="https://code.jquery.com/jquery-3.5.1.js" 
			integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" 
			crossorigin="anonymous">
	</script>
</head>
<body>
		<jsp:include page="/subviews/header_sc.jsp" >
			<jsp:param name="subtitle" value="訂單明細"/>
		</jsp:include>
		<%
			Customer member = (Customer)session.getAttribute("member");
			String orderId = request.getParameter("orderId");
			Order order = null;
			if(orderId!=null && orderId.length()>0){
				OrderService service = new OrderService();
				order = service.getOrder(member, orderId);
			}
		%>		
		<article>
		<%--=order --%>
		<% if(order!=null) {%>
		<div class='orderData'>
			<div class='leftDiv'>
				Order No: <%= order.getId()%><br>
				Status: New Order<br>  
				Order Date/Time: <%= order.getOrderDate()%> <%= order.getOrderTime()%><br>
				Payment Type: <%= order.getPaymentType() %>
					<% if(order.getPaymentType()==PaymentType.ATM && order.getStatus()==0){%>
					<button onclick='location.href="paid.jsp?orderId="+<%= order.getId()%>;'>
						通知付款</button>
					<% } %> <br>
				Shipping Type: <%=order.getShippingType() %>			
			</div>
			
			<fieldset class='rightDiv'>
				<legend>Recipient Details:</legend>
				Name: <%=order.getRecipientName() %>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;
				Phone: <%=order.getRecipientPhone() %><br>
				Email: <%=order.getRecipientEmail() %>&emsp;&emsp;&emsp;
				Shipping Address: <%=order.getShippingAddress() %>
			</fieldset>
			<h3>
			Total Order<span style='font-size: smaller'>(Shipping:Included)</span>: $<%= order.getTotalAmountWithFee() %> USD			
			</h3>
		</div>		
		<% if(order.getOrderItemSet()!=null && order.getOrderItemSet().size()>0) {%>
		<table id='orderItems' >
				<caption>Order Details</caption>
				<thead>
					<tr>
						<th>Item</th> 
						<th>Size</th> <th>Sale</th>
						<th>Quantity</th> <th>Sub Total</th>
					</tr>
				</thead>
				<tbody>
					<%for(OrderItem item : order.getOrderItemSet()){ 
						Product p = item.getProduct();
						Size size = item.getSize();
					%>
					<tr>
						<td style='text-align: left'><!-- 名稱 -->
							<%-- <img src='<%=color!=null?color.getPhotoUrl():p.getPhotoUrl() %>' style='width:50px;vertical-align: middle'> --%>
							<%= p.getName() %>
						</td>
						<td><%=item.getSize().getProductSize() %> </td> <!-- size -->
						<td>$<%= item.getPrice() %> USD</td> <!-- 售價 -->						
						<td><%=item.getQuantity() %></td> <!-- 數量 -->
						<td>$<%= item.getPrice() %> USD</td> <!-- 小計 -->						
					</tr>
					<%} %>
					
												
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4">共<%=order.size() %>項, <%=order.getTotalQuantity() %>件</td>
						<td colspan="3">未含運費: $<%=order.getTotalAmount() %> USD</td>
					</tr>
				</tfoot>
			</table>			
		<% 	}	
		   }else{ %>
			<p>查無此訂單</p>
		<% } %>
		</article>				
		
</body>
</html>