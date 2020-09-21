<%@page import="uuu.vgb.entity.Order"%>
<%@page import="java.util.Map"%>
<%@page import="uuu.vgb.service.OrderService"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1" >
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">	
	<title>Order History | SHOECREED</title>
	<style>
		#orderTable {border-collapse:collapse;width:100%;margin:auto;min-width:400px}		
			#orderTable thead th{background-color:#C0C0C0;color:black;}		
			#orderTable thead tr{background-color: #f2f2f2;font-size:16px}	
			#orderTable th{border: 1px solid #cecece; padding: 8px;}		
			#orderTable thead, #orderTable td{border: 1px solid #cecece; padding: 8px;}			
			#orderTable tbody tr:nth-child(even){background-color: #f2f2f2;}			

			#orderTable tfoot tr{text-align: right}	
			#orderTable tfoot tr{background-color: white}
			#orderTable tfoot tr:hover{background-color: initial}
			#orderTable tbody tr:hover{background-color:#9999FF;}
			
	.myFooter {
	  padding: 25px;
	  margin: 0px;
	  display: flex;
	  min-height: 10px;
	  position: relative;
	  width: 100vw;
	  text-align: center;
	  background-color: #fff;
	  color: black;
	  justify-content: center;
	  margin-top: 30px;
	}

	.upper-footer{
		padding: 8px;
		font-size: 11px;
	}
	
	.lower-footer{
		padding: 6px;
		font-size: 11px;
		color: #A0A0A0;
	}
	
	#socialbar {
		display:-webkit-flex;
		position: relative;
		float: right;
		display:flex;
		bottom: -50px;
	}
	
	#item1 {
		-webkit-order: 1;
		order: 1;
		margin-right: 8px;
	}
	
	#item2 {
		-webkit-order: 2;
		order: 2;
		margin-right: 8px;
	}
	
	#item3 {
		-webkit-order: 3;
		order: 3;
		margin-right: 8px;
	}
	
	#item4 {
		-webkit-order: 4;
		order: 4;
		margin-right: 8px;
	}
	</style>
	<script src="https://code.jquery.com/jquery-3.5.1.js" 
			integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" 
			crossorigin="anonymous">
	</script>
	<script>
		function getOrderDetail(orderId){
			//同步請求
			location.href='order_sc.jsp?orderId='+orderId;
		}
	
	</script>
</head>
<body>
		<jsp:include page="/subviews/header_sc.jsp" >
			<jsp:param name="subtitle" value="歷史訂單"/>
		</jsp:include>		
		<article>
		<%
			Customer member = (Customer)session.getAttribute("member");
			OrderService service = new OrderService();
			Map<Order, Double> ordersMap = service.getOrderHistory(member);
			if(ordersMap!=null && ordersMap.size()>0){
		%>
			<table id="orderTable">
				<thead>
				<tr>
					<th>Order No.</th>
					<th>Order Date</th>
					<th>Payment Type</th>
					<th>Shipping Type</th>
					<th>Total Amount</th>
				</tr>
				</thead>
				<tbody>
				<% for(Order order:ordersMap.keySet()) {%>
				<tr onclick="getOrderDetail(<%=order.getId()%>)">
					<th style='text-decoration:underline;color:#0066CC'><%= order.getId() %></th>
					<th><%= order.getOrderDate() %> | <%= order.getOrderTime() %></th>
					<th><%= order.getPaymentType() %></th>
					<th><%= order.getShippingType() %></th>
					<th style='color:#990000'>$<%= ordersMap.get(order)+order.getPaymentFee()+order.getShippingFee() %> USD</th>
					
				</tr>
				<%} %>
				</tbody>				
			</table>
			<% } %>
		</article>				
		<div>
	<footer class="myFooter">
		<div class="upper-footer">
			ABOUT US&emsp;&emsp;&emsp;
			LOCATIONS&emsp;&emsp;&emsp;
			NEWSLETTER SIGNUP&emsp;&emsp;&emsp;
			CUSTOMER CARE&emsp;&emsp;&emsp;
			SUGGESTIONS&emsp;&emsp;&emsp;
			CAREERS&emsp;&emsp;&emsp;
			AFFILIATES&emsp;&emsp;&emsp;
			SITEMAP&emsp;&emsp;&emsp;
			<br><br>
			<div class="lower-footer">
				&copy;2020 shoecreed All Rights Reserved.&emsp;&emsp;
				Terms & Conditions&emsp;&emsp;
				Privacy Policy&emsp;&emsp;
				Accessibility&emsp;&emsp;
			</div>	
		</div>
		
	<div id="socialbar">
		<div id="item1"><a href=https://zh-tw.facebook.com><img src="../img/facebook.png" width="70%"></a></div>
		<div id="item2"><a href=https://twitter.com/?lang=zh-tw><img src="../img/twitter.png" width="70%"></a></div>
		<div id="item3"><a href=https://www.instagram.com/?hl=zh-tw><img src="../img/instagram.png" width="70%"></a></div>
		<div id="item4"><a href=https://www.youtube.com/?hl=zh-TW&gl=TW><img src="../img/youtube.png" width="70%"></a></div>
	</div>
	</footer>
</div>
</body>
</html>