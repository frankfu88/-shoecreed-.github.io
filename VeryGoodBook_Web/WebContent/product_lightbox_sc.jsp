
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Size"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">
<title>Product Info | SHOECREED</title>
<style>
	.imgDiv{float:left;width:40%;min-width:250px}
	.imgDiv img{width:80%;min-width:240px}
	.dataDiv{float:left;width:55%;min-width:350px}	
	.sizeOption [type=radio] { 
	  position: absolute;
	  opacity: 0;
	  width: 10;
	  height: 10;
	}
	
	/* IMAGE STYLES */
	.sizeOption [type=radio] + img {
	  cursor: pointer;vertical-align: middle;
	}
	
	/* CHECKED STYLES */
	.sizeOption [type=radio]:checked + img {
		border: 1px solid darkred;
		border-radius: 5px;
	}
</style>
		<%
			String productId = request.getParameter("productId");
			Product p = null;
			if(productId!=null){
				ProductService service = new ProductService();
				p = service.getProduct(productId);
			}
		%>	
<script>
	<%if(p!=null){%>
	var totalStock = <%=p.getStock()%>;
	<%}%>
	/* function changeImg(colorImg){
		console.log(colorImg.src, colorImg.dataset.stock);
		var productImg = document.getElementById('productImg');
		productImg.src = colorImg.src;
		document.getElementById('stock').innerHTML = colorImg.dataset.stock + '(共' + totalStock + '個)';
		document.getElementById('quantity').setAttribute('max',colorImg.dataset.stock);
	} */
</script>
</head>
<body>	
	<jsp:include page="/subviews/header_sc.jsp">
		<jsp:param value="Product Description" name="subtitle"/>
	</jsp:include>	

		<article>
			<% if(p!=null) {%>
			<div>
				<div class='imgDiv'>
				  <img id='productImg' src='<%= p.getPhotoUrl() %>'>
				</div>
				<div class='dataDiv'>
					<h2><%= p.getName() %></h2>
					<% if(p instanceof Outlet) {%>
					<div>Price：$<%= ((Outlet)p).getListPrice() %></div>
					<% } %>
					<div>Sale: <%= p instanceof Outlet?((Outlet)p).getDiscountString():""%> $<%= p.getUnitPrice() %></div>
					<div>Stock: <span id='stock'><%= p.getStock() %></span></div>
					<div>
						<form action='add_cart.do' method='POST'>
							<input type='text' style='width:3em' name='productId' value='<%= p.getId() %>'>
							<% if(p.getProductSize()!=null && p.getProductSize().size()>0) {%>
							<div id='sizeDiv' style='margin: 3px 0'>
								<label>Size:</label>
								<% for(int i=0;i<p.getProductSize().size();i++)  {
									Size size = p.getProductSize().get(i);
								%>
								<label class='sizeOption'>								
									<input type='radio' name='size' value='<%=size.getProductSize() %>' >
									<span style='width:48px' title='<%=size.getProductSize() %>'  onclick='changeSize(this)'
										 data-stock='<%= size.getStock() %>'><%= size.getProductSize() %></span>
								</label>
								<% } %>
							</div>
							<% } %>
							<label>Quantity:</label>
							<input type='number' min='1' max='<%= p.getStock() %>' 
									id='quantity' name='quantity' required>
							<input type='submit' value="add to cart" <%= p.getStock()==0?"disabled":"" %>>
						</form>
					</div>
				</div>
				<div style='clear:both;width:90%;min-width:350px;margin:auto; padding-top:1ex'>
					<hr>
					<div style='margin:auto;'><%= p.getDescription() %></div>
				</div>
			</div>
			<%}else{ %>
			<p>(#<%= productId %>) NOT FOUND</p>
			<% } %>
		</article>
	<%@include file="/subviews/footer_sc.jsp" %>
</body>
</html>