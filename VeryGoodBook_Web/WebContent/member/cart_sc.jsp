<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.CartItem"%>
<%@page import="uuu.vgb.entity.*"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1" >
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">	
	<title>Cart | SHOECREED</title>
	<style>
		#cartTable {border-collapse:collapse; width:100%; margin:auto; margin-top: 20px;}
			#cartTable caption{background-color:white;color:black;font-size:16px;margin-bottom:10px}	
			#cartTable th{border: 1px solid #cecece; padding: 8px; font-weight:normal; font-size: 14px;}
			#cartTable td{border: 1px solid #cecece; padding: 8px;font-size: 13px;}	
			/*#cartTable tr:nth-child(even){background-color: #f2f2f2;}*/		

			#cartTable tfoot tr{text-align: right}
			#cartTable tfoot tr{background-color: white}
			#cartTable tfoot tr:hover{background-color: initial}
			
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
		function goShopping(){
			location.href='<%= request.getContextPath()%>/product_list_sc.jsp';
		}
		function checkOut(){
		location.href='checkout_sc.jsp';
		}
	</script>
</head>
<body>
		<jsp:include page="/subviews/header_sc.jsp" >
			<jsp:param name="subtitle" value="cart"/>
		</jsp:include>		
		<article>
		
		<%
			ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			/* ProductService serivce = new ProductService(); */
		%>
		<% if(cart!=null && cart.size()>0) {%>
		<form action='update_cart.do' method='GET'>
		<table id='cartTable'>
			<caption>Shopping Bag</caption>
			<thead>
				<tr>
					<th>Item</th>
					<th>Size</th> <th>Price</th> <th>Discount</th>
					<th>Sale</th> <th>Quantity</th>
					<th>Sub Total</th> 
					<th>Remove</th>
				</tr>
			</thead>
			<tbody>
			
			<%
			
				for(CartItem item:cart.getCartItemSet()) {
					Product p = item.getProduct();
					Size size = item.getSize();
					
					/* size.setProductSize(item.getSize()); */
			%>
				<tr>
					<td><!-- Name -->
						<img src='../<%= p.getPhotoUrl()%>' style='max-width:230px;max-height:95px;width:auto;height:auto'>
						<%= item.getProduct().getName() %>
					</td>
					<td><%=size!=null?size.getProductSize():"" %></td>
					<td>$<%=p instanceof Outlet?((Outlet)p).getListPrice():p.getUnitPrice() %> USD</td> <!-- Price -->
					<td><%=p instanceof Outlet?((Outlet)p).getDiscountString():"" %></td> <!-- Discount -->
					<td>$<%=p.getUnitPrice() %> USD</td> <!-- Sale -->
					<td><input style='width:6ex' type='number' name='quantity<%=item.hashCode()%>' required
						value='<%= cart.getQuantity(item) %>' min='1' max=<%=size!=null?size.getStock():p.getStock()%>></td> <!-- Quantity -->
					<td>$<%= p.getUnitPrice() * cart.getQuantity(item) %> USD</td> <!-- Sub Total -->
					<td><input type='checkbox' name='delete<%=item.hashCode()%>'></td> <!-- Remove -->
				</tr>
				<% } %>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">共<%=cart.size() %>項, <%= cart.getTotalQuantity() %>雙</td>
					<td colspan="4">Order Total: $<%= cart.getTotalAmount() %> USD</td>
				</tr>
				<tr class='buttonGroup'>
					<td colspan="3"><input type='button' value='Return to Product' onclick="goShopping()"
						style='font-size:13px;padding:4px 5px;border:none;background-color:#EEEEEE;color:black;cursor:pointer;'>
					</td>
					<td colspan="6">
						<input type='submit' value='Modify' name='submit'
							style='font-size:13px;padding:4px 5px;border:none;background-color:black;color:white;cursor:pointer;'>
						<input type='submit' value='Checkout' name='submit'
							style='font-size:13px;padding:4px 5px;border:none;background-color:black;color:white;cursor:pointer;'>
					</td>
				</tr>
			</tfoot>
		</table>
		</form>
		<% }else{ %>
		<p style='text-align:center;font-size:30px;margin-top:300px'>Your cart is empty</p>
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