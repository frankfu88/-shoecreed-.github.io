<%@page import="uuu.vgb.entity.Outlet"%>
<%@page import="uuu.vgb.entity.Size"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@page import="uuu.vgb.entity.Product"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>

<style>
	#productDetail{
 		max-width: 1100px; 
 		min-width: 500px;
 	}

	.imgDiv{float:left;width:40%;min-width:250px}
	.imgDiv img{width:80%;min-width:240px}
	.dataDiv{float:left;width:55%;min-width:350px}	
	.sizeOption [type=radio] { 
	  position: absolute;
	  opacity: 0;
	  width: 10;
	  height: 10;
	}
	
	.sizeChart > a:hover{text-decoration: underline;cursor: pointer;}
	.dataDivContainer{display: flex;justify-content: space-between;margin: 50px 160px 0px 20px;}
	.dataDiv1{font-size: 16px;}
	.dataDiv1 div{padding: 5px}
	.dataDiv2{margin-bottom: 20px;}
	.dataDiv2 div{padding: 4px;margin-top: -6px}
	
	/* The snackbar - position it at the bottom and in the middle of the screen */
#snackbar {
  visibility: hidden; /* Hidden by default. Visible on click */
  min-width: 250px; /* Set a default minimum width */
  margin-left: -125px; /* Divide value of min-width by 2 */
  background-color: #333; /* Black background color */
  color: #fff; /* White text color */
  text-align: center; /* Centered text */
  border-radius: 2px; /* Rounded borders */
  padding: 16px; /* Padding */
  position: fixed; /* Sit on top of the screen */
  z-index: 1; /* Add a z-index if needed */
  left: 50%; /* Center the snackbar */
  bottom: 50%;
}

/* Show the snackbar when clicking on a button (class added with JavaScript) */
#snackbar.show {
  visibility: visible;
  -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
  animation: fadein 0.5s, fadeout 0.5s 2.5s;
}

@-webkit-keyframes fadein {
  from {center: 0; opacity: 0;} 
  to {center: 30px; opacity: 1;}
}

@keyframes fadein {
  from {center: 0; opacity: 0;}
  to {center: 30px; opacity: 1;}
}

@-webkit-keyframes fadeout {
  from {center: 30px; opacity: 1;} 
  to {center: 0; opacity: 0;}
}

@keyframes fadeout {
  from {center: 30px; opacity: 1;}
  to {center: 0; opacity: 0;}
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
	
	function addCart(){
		//alert('addCart');
		//1.改用非同步請求...
		$.ajax({
			url: $("#productForm").attr("action"),
			method: $("#productForm").attr("method"),
			data: $("#productForm").serialize()
		}).done(addCart_DoneHandler);
		
		//2.阻擋form submit送出同步(POST)請求...
		return false;
	
	}
	
	function addCart_DoneHandler(data, status, xhr){
		/* alert("加入購物車成功"); */
		$(".cartSub").text(data);
		var x = document.getElementById("snackbar");
		x.className = "show";
		setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
	}
</script>
<script>
 	function getSizeChart(sizeChart){
 		//同步的get請求
 		<%--location.href="<%= request.getContextPath() %>/product_lightbox_sc.jsp?productId=" + productId;
 		--%>
 		
 		//非同步的get請求 //JSON
 		$.ajax({
 				url:"<%= request.getContextPath() %>/view_size_chart.jsp?sizeChart=" + sizeChart,
 				method:'GET'
 		}).done(getSizeChart_DoneHandler);
 		
 	}
 	
 	function getSizeChart_DoneHandler(data, textStatus, jqXHR) {
 		//alert(data);
 		console.log(data);
 	
 		$("#sizeChart").html(data);
 		
 		//用fancybox來顯示(燈箱效果)
 		$.fancybox.open({
 			src  : '#sizeChart',
 			type : 'inline',
 			opts : {
 				afterShow : function( instance, current ) {
 					console.info( 'done!' );
 				}
 			}
 		});
 	}
</script>
<script src='<%= request.getContextPath() %>/fancybox/jquery.fancybox.js'></script>
		<div>
			<% if(p!=null) {%>
			<div>
				<div class='imgDiv'>
				  <img id='productImg' src='<%= p.getPhotoUrl() %>'>
				</div>
				<div class='dataDiv'>
					<h2><%= p.getName() %></h2>
					
		<nav class="dataDivContainer">
			<div class="dataDiv1">
			<% if(p instanceof Outlet) {%>
				<div>Price: $<%= ((Outlet)p).getListPrice() %> USD</div>
				<% } %>
				<div>Sale: <%= p instanceof Outlet?((Outlet)p).getDiscountString():""%> $<%= p.getUnitPrice() %> USD</div>
				<div>Stock: <span id='stock'><%= p.getStock() %></span></div>
			</div>
				
			<div class="dataDiv2">
				<form action='add_cart.do' method='POST' id='productForm' onsubmit='return addCart();'>
					<input type='hidden' style='width:3em' name='productId' value='<%= p.getId() %>'>
					
				<div>
					<div id="sizeChart"></div>
						<a href="javascript:getSizeChart()">
						<span style='font-size: 13px'>View Size Chart</span></a>
				</div>

						<% if(p.getProductSize()!=null && p.getProductSize().size()>0) {%>
						<div id='sizeDiv' style='margin: 3px 0'>
							<label>Size:</label>
							<label class='sizeOption'>
								<select name='size'>
									<!-- <option value='' data-fee='0'>Select a Size</option> -->
									<% for(int i=0;i<p.getProductSize().size();i++)  {
									Size size = p.getProductSize().get(i);
									%>
									<option title='<%=size.getProductSize() %>'  onclick='changeSize(this)'
										data-stock='<%= size.getStock() %>'><%= size.getProductSize() %></option><% } %>
								</select>
							</label>
						</div>
						<% } %>

						<label>Quantity:</label>
						<input type='number' min='1' max='<%= p.getStock() %>'
								id='quantity' name='quantity' required>
					<br><input type='submit' value="ADD TO CART" onclick="myFunction()" <%= p.getStock()==0?"disabled":"" %> 
								style="border:none;background-color:black;color:white;padding:5px 9px">

						<div id="snackbar">Added to Cart</div>
					
					</form>
					</div>
				</nav>	
					</div>
				</div>
				<div style='clear:both;width:90%;max-width:50em;min-width:350px;margin:auto;padding-top:1ex'>
					<hr>
					<div style='margin:auto;'>
						<%= p.getDescription()!=null?p.getDescription().replace("\n", "<br>"):"" %>
					</div>
				</div>
			</div>
			<%}else{ %>
			<p>(#<%= productId %>) NOT FOUND</p>
			<% } %>
