<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">
<title>Product | SHOECREED</title>
<style>

.header{
	background-color: #ccc;
	padding: 20px;
	margin: 0px;
	line-height: 40px;
	text-align: center;
	color: white;
	font-size: 20px;
	font-weight: normal;
}

.productList{
	display: inline-block;
	padding: 10px;
	
}

.productImage{
	display: flex;
	box-shadow: gray 1px 1px 3px;
	height: 187px; 
	margin: 1em 0;
	width: 285px;
}

.productInfo{
	margin-top: auto;
	text-align: left;
	background: #FAFAFA;
	box-shadow: 1px 2px 3px 0px rgba(0,0,0,.10);
	border-radius: 2px;
	display: flex;
	flex-direction: column;
	line-height: 35px;
}

.productItem{
	height: 1 20px;
	margin: 1em 0;
	margin-top: auto;
	background: #FCFCFC; /*#FCFCFC*/
	border-radius: 6px;
	display: flex;
	flex-direction: column;
}

@media (max-width: 920px) {
  .productList {
    flex: 1 21%;
  }
}

</style> 
</head>
<body>
	<jsp:include page="/subviews/header_sc.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	
	<header class="header">
		<div>On SHOECREED, every sneaker you want is always available and authentic.</div>
	</header>
	
	<article>
	
		<%
			String search = request.getParameter("search");
			ProductService service = new ProductService();
			List<Product> list = null; 	
			if(search!=null && search.length()>0){
				list = service.searchProductsByName(search);
			// }else if(category!=null && category.length()>0){
			}else{
				list = service.getAllProducts();
			}
		
		%>

	<%if(list!=null && list.size()>0) {%>
		<ul class='productList'>
			<% for(int i=0;i<list.size();i++){
				Product p = list.get(i);
				%>
			<li class='productItem' id='<%= p.getId() %>'>
				<a href="<%=request.getContextPath() %>/product_list_sc.jsp?productId=<%= p.getId() %>">				
					<img class='productImage' 
						src='<%= p.getPhotoUrl() %>'>	
				</a>
				<div class='productInfo'>
					<div class='productName'><%= p.getName() %></div>
					<div>Sale: <%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %> $<%= p.getUnitPrice() %> </div>
					<div class='productDescription'><%= p.getDescription()%></div>	
				</div>
			</li>
			<% } %>
		</ul>
		
			<% }else{ %>
				<p>Product not found</p>
			<% } %>

	</article>
	
<%@include file="/subviews/footer_sc.jsp" %>
</body>
</html>