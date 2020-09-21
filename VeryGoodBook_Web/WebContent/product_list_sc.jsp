<%@page import="java.util.Random"%>
<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/fancybox/jquery.fancybox.css">
<title>Products | SHOECREED</title>
<style>

.header{
	padding: 30px;
	margin: 0px;
	line-height: 80px;
	text-align: center;
	color: black;
	font-size: 35px;
	font-weight: normal;
	background-color: #F4F4F4;
	/* background-image: url('img/owsail.png'); */
	/* background-position: 30% 68%; */ /* horizontal(小-右, 大-左); vertical(小-下, 大-上)*/
	/* object-fit: contain; */
}

.product-filter {
  display: flex;
}

.sort {
  display: flex;
  padding-left: 1300px;
  margin-top: 25px;
}

.collection-sort {
  display: flex;
  flex-direction: column;
}

.productItem{
	display: inline-block;
	box-shadow: 1px 2px 3px 0px rgba(0,0,0,0.10);
	width: 274px;
	height: 290px;
	margin: 1em 0;
	vertical-align: inherit;
	padding: 7px;
	margin-top: 30px;
	margin: 12px 9px;
}

.productImage:hover{
	-ms-transform: scale(1.1); /* IE 9 */
  	-webkit-transform: scale(1.1); /* Safari 3-8 */
  	transform: scale(1.1); 
}

.productItem a{
	text-decoration: none;
}

.productImage{
	float: left;
	width: 250px;
	padding-top: 1em;
	transition: transform 1.5s;
}

.productData{
	float: left;
	width: 80%;
}
.productName{
	font-size: inherit;
	font-weight: normal;
	padding-top: 1ex;
}

.productName:hover{
	text-decoration: underline;
}

.productPrice{
	font-weight: bold;
}

.productSale{
	font-weight: bold;
	color: black;
}

.productDescription{
	font-size: small;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	-webkit-line-clamp: 2;
	min-width: 250px;
}

.productNotFound{
	font-size: 60px;
	text-align: center;
	margin-top: 270px;
}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"
			integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" 
			crossorigin="anonymous"></script>
<script src='<%= request.getContextPath() %>/fancybox/jquery.fancybox.js'></script>
<script>

	$(function(){
		
		$("#descSelector").val('<%= request.getParameter("desc")!=null?request.getParameter("desc"):"false" %>');
	});
	
 	function getProductJSP(productId){
 		//同步的get請求
 		<%--location.href="<%= request.getContextPath() %>/product_lightbox_sc.jsp?productId=" + productId;
 		--%>
 		
 		//非同步的get請求 //JSON
 		$.ajax({
 				url:"<%= request.getContextPath() %>/product_ajax.jsp?productId=" + productId,
 				method:'GET'
 		}).done(getProductJSP_DoneHandler);
 		
 	}
 	
 	function getProductJSP_DoneHandler(data, textStatus, jqXHR) {
 		//alert(data);
 		console.log(data);
 	
 		$("#productDetail").html(data);
 		
 		//用fancybox來顯示(燈箱效果)
 		$.fancybox.open({
 			src  : '#productDetail',
 			type : 'inline',
 			opts : {
 				afterShow : function( instance, current ) {
 					console.info( 'done!' );
 				}
 			}
 		});
 	}
 	function changeOrderBy(theSelect){
 		location.href = "?desc="+$(theSelect).val();
 	}
</script>
</head>
<body>
	<jsp:include page="/subviews/header_sc.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	<div id='productDetail'></div>
	
	<header class="header">
		<div>Every Sneaker You Want is Always Authentic and Available</div>
	</header>
	
<nav class="product-filter">

  <div class="sort">
    <div class="collection-sort">
      <label>Sort by:</label>
      <select id='descSelector' name='desc' onchange='changeOrderBy(this)'>
        <option value="false">Price: Low to High</option>
        <option value="true">Price: High to Low</option>
      </select>
    </div>
  </div>
</nav>
	
<article>
	
	<%
		String search = request.getParameter("search");
		String desc = request.getParameter("desc");
		ProductService service = new ProductService();
		List<Product> list = null;
		//Thread.sleep(new Random(5000).nextInt());
		if(search!=null && search.length()>0){
		list = service.searchProductsByName(search);
		//}else if(category){if(category!=null && category.length()>0){
		}else if("true".equals(desc)){
			list = service.getAllProducts(true);
		}else{
			list = service.getAllProducts();
		}
	%>
	
	<%if(list!=null && list.size()>0) {%>
	
	<ul class='productList'>
		<% for(int i=0;i<list.size();i++){ 
			Product p = list.get(i);
			%>
			<li class='productItem' id='<%= p.getId()%>'>
				<a href="javascript:getProductJSP(<%= p.getId() %>)">
					<img class='productImage' src='<%= p.getPhotoUrl() %>'>
					
					<div class='productData'>
						<div class='productName'><%= p.getName() %></div>
						
						<div class='productDescription'><%= p.getDescription() %></div>
						
						<% if(p instanceof Outlet) {%>
						<div class="productPrice">Price: $<%= ((Outlet)p).getListPrice() %> USD</div>
						<% } %>
						<div class="productSale">Sale: <%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %>
						$<%= p.getUnitPrice() %> USD</div>
						
						<!-- <div>Stock: <span id='stock'><%= p.getStock() %></span></div> -->
					</div>
				</a>
			</li>
		<%} %>
	</ul>
		<% }else{ %>
			<div class="productNotFound">PRODUCT NOT FOUND</div>
		<%} %>
</article>
	<%@include file="/subviews/footer_sc.jsp" %>
</body>
</html>