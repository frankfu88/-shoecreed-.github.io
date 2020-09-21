<%@page import="java.util.List"%>
<%@page import="uuu.vgb.entity.*"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1" >
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">	
	<title>Checkout | SHOECREED</title>
	<style>
		#cartTable {border-collapse:collapse;width:100%;margin:auto;margin-top: 20px;}		
			#cartTable caption{background-color:#fff;color:black;font-size:16px;margin-bottom:10px;}			
			#cartTable th{border: 1px solid #cecece; padding: 8px;font-weight:normal;font-size: 14px;}		
			#cartTable td{border: 1px solid #cecece; padding: 8px;font-size: 13px;}			
			/* #cartTable tr:nth-child{background-color: #f6f6f6;} */			

			#cartTable tfoot tr{text-align: right}	
			#cartTable tfoot tr{background-color: white}
			#cartTable tfoot tr:hover{background-color: initial}	
			/* #cartTable tbody tr:hover{background-color: #FDFDFD} */
			
			fieldset label{width: 3.25em;display:inline-block;font-size:13px}
			
			#memberField {
				width:35%;
				float:left;
				min-width:300px;
				max-width:320px;
				display: flex;
				float: right;
				} 
			#recipientField{
				width:30%;
				float:left;
				min-width:350px;
				max-width:500px;
				float: right;
				height: 235px;
				display: flex;
				}
			#memberField input{width:90%;} 
			#recipientField input{width: 90%;max-width:30em}
			
		.change{
			display: none;
		}
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
	<% if("POST".equalsIgnoreCase(request.getMethod())) {%>
	$(fieldRepopulate); //$() 等同於$(document).ready(...)
	
	function fieldRepopulate(){
		//alert('fieldRepopulate');			
		$("#paymentType").val('<%= request.getParameter("paymentType")%>');
		$("#shippingType").val('<%= request.getParameter("shippingType")%>');
		$("#recipientName").val('<%= request.getParameter("recipientName")%>');
		$("#recipientEmail").val('<%= request.getParameter("recipientEmail")%>');
		$("#recipientPhone").val('<%= request.getParameter("recipientPhone")%>');
		shippingChange();
		$("#shippingAddress").val('<%= request.getParameter("shippingAddress")%>');
		
	}
	<% } %>
	function goShopping(){
		location.href='<%= request.getContextPath()%>/product_list_sc.jsp';
	}
	
	function copyMemberData(target){			
		$("#recipientName").val($("#name").val());
		$("#recipientEmail").val($("#email").val());
		$("#recipientPhone").val($("#phone").val());
		if($("#shippingType").val()=="HOME"){
			$("#shippingAddress").val($("#address").val());
		}
	}
	
	function paymentTypeChange(){			
		calculateFee();	
	}
	
	function calculateFee() {
		var paymentFee=$("#paymentType option:selected").attr("data-fee");
		var shippingFee=$("#shippingType option:selected").attr("data-fee");			
		console.log(Number(paymentFee),Number(shippingFee),Number($("#totalAmount").text()));
		
		var totalAmountWithFee = Number($("#totalAmount").text());
		if(paymentFee) totalAmountWithFee+=Number(paymentFee);
		if(shippingFee) totalAmountWithFee+=Number(shippingFee);
		$("#totalAmountWithFee").text(totalAmountWithFee);
	}
	
	var chooseStoreBtn = 
		"<input type='button' id='chooseStoreBtn' value='選擇超商' onclick='goEZShip()'>";
	function shippingChange(){
		$("#shippingAddress").removeAttr("list");
		$("#shippingAddress").attr("autocomplete","on");
		$("#shippingAddress").prop("readonly",false);
		$("#shippingAddress").css("width", parseInt($("#recipientEmail").css("width")));
        $("#chooseStoreBtn").remove();
        
		switch($("#shippingType").val()){
		case 'SHOP':
			$("#shippingAddress").attr("list", "shopList");
			$("#shippingAddress").attr("autocomplete","off");
			break;
		case 'STORE':
			$("#shippingAddress").attr("autocomplete","off");
			$("#shippingAddress").prop("readonly",true);
			$("#shippingAddress").css("width", parseInt($("#recipientEmail").css("width"))-75);
			$(chooseStoreBtn).insertAfter($("#shippingAddress"));
			break;
		}
		calculateFee();			
	}
	
	/* 超商轉換 */
	$(function(){
		$(".option2").addClass("change")
		var pay = $("#paymentType");
		var shop = $(".option2:contains('店面取貨')");
		var home = $(".option2:contains('送貨到府')");
		var store = $(".option2:contains('超商取貨')");
		pay.change(function() {
			
			$(".option2").addClass("change")
			$("shippingType").val("");
			switch (pay.val()){
				case 'SHOP':
					shop.removeClass("change");
					break;
				case 'ATM':
					shop.removeClass("change");
					home.removeClass("change");
					store.removeClass("change");
					break;
				case 'HOME':
					home.removeClass("change");
					break;
				case 'STORE':
					store.removeClass("change");
					break;
				case 'CARD':
					shop.removeClass("change");
					home.removeClass("change");
					store.removeClass("change");
					break;
			}
		})
	});
</script>

<script>
    var geo = undefined;
    
    $(document).ready(init);
    function init(){
        //判斷是否支援Geo Location
        if(geo = getGeoLocation()){
            $("#title").text("");
            /*write code here*/
            //geo.getCurrentPosition(showCoords);
            //geo.watchPosition(showCoords,errorHandler);
       }else{
            $("#title").text("Geolocation is not supported.");
        }
        $("#myInput").change(mapHandler);
    }
    function mapHandler(){
        var mapAddress =  $("#myInput").val();
		$("#myMap").attr("src","http://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q="+mapAddress+"&z=16&output=embed");
		//$("#myMap").attr("src","http://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q="+lat+","+lon+"&z=16&output=embed");
		//window.location.href="http://maps.google.com/maps?q="+lat+","+lon;
    }
    
    function getGeoLocation()
    {
        if(navigator.geolocation){
            return navigator.geolocation;
        }else{
            return undefined;
        }
    }
 
    function errorHandler(error){
    	alert("Error!");
    }
    </script>
</head>
<body>
		<jsp:include page="/subviews/header_sc.jsp" >
			<jsp:param name="subtitle" value="結帳"/>
		</jsp:include>		
		<article>
		
		<% 
			Customer member = (Customer)session.getAttribute("member");
			ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
			//List<String> errors = (List<String>)request.getAttribute("errors");
		%>
		${requestScope.errors}
		<% if(cart!=null && cart.size()>0) {%>
		<form action='check_out.do' method='POST' id='cartForm'>
			<table id='cartTable'>
				<caption>Order Details</caption>
				<thead>
					<tr>
						<th>Item</th> 
						<th>Size</th> <th>Price</th>
						<th>Discount</th> <th>Sale</th>
						<th>Quantity</th> <th>Sub Total</th>
						<!-- <th>Remove</th> --> 						
					</tr>
				</thead>
				<tbody>
					<%  for(CartItem item:cart.getCartItemSet()) {
						Product p = item.getProduct();
						Size size = item.getSize();	
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
						value='<%= cart.getQuantity(item) %>' min='1' max=<%=p.getStock() %>></td> <!-- Quantity -->
					<td>$<%= p.getUnitPrice() * cart.getQuantity(item) %> USD</td> <!-- Sub Total -->
					<%-- <td><input type='checkbox' name='delete<%=item.hashCode()%>'></td> <!-- Remove --> --%>
				</tr>
				<% } %>											
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5">共<%=cart.size() %>項, <%= cart.getTotalQuantity() %>雙</td>
						<td colspan="3">Order Total: $<span id="totalAmount"><%= cart.getTotalAmount() %></span> USD</td>
					</tr>
					<tr>
						<td  colspan="5">
							<div style='width:60%;float:right'>
								<label> Shipping Method:</label>
								<select id='shippingType' name='shippingType' required onchange='shippingChange()'>
									<option value='' data-fee='0'>Please select</option>
									<% for(ShippingType shType:ShippingType.values()) { %>
									<option class='option2' value='<%= shType.name()%>' data-fee='<%= shType.getFee()%>'>
										<%= shType%>
									</option>
									<% } %>
								</select>
							</div>
							<div style='width:35%;float:right'>
								<label>Payment Method:</label>
								<select id='paymentType' name='paymentType' required onchange='changeShippingOption()'> 
									<option value='' data-fee='0'>Please select</option>
									<% for(PaymentType pType:PaymentType.values()) { %>
									<option value='<%= pType.name()%>' data-fee='<%= pType.getFee()%>'
										data-shippingArray='<%= pType.getShippingTypeArray()%>'>
									<%= pType%>
									</option>
									<% } %>
								</select>
							</div>
						</td>
						<td  colspan="3" style='font-size:14px;font-weight:bold'>
							Order Total(Shipping:Included): $<span id='totalAmountWithFee'><%= cart.getTotalAmount() %></span> USD
						</td>
					</tr>
				<tr>
					<td colspan="8" style='text-align:left;background-color:#F9F9F9'>

   					<input type="text" placeholder="請輸入地址" id="myInput" style='width:32%'>
   					<br><br>
   					
					<iframe id="myMap" width='400' height='400' frameborder='0' 
						scrolling='no' marginheight='0' marginwidth='0' 
						src='http://maps.google.com.tw/maps?f=q&hl=zh-TW&geocode=&q=恆逸教育訓練中心&z=16&output=embed'>
					</iframe>
					
						<fieldset id='recipientField'>
							<legend style='text-align: center;font-size:14px;font-weight:bold'>
								Recipient (<a href='javascript:copyMemberData()'>Same as Purchaser</a>)</legend>
							<label>Name</label><input id="recipientName" name="recipientName" required><br>
							<label>Phone</label><input id="recipientPhone" name="recipientPhone" required><br>
							<label>Email</label><input id="recipientEmail" name="recipientEmail" required><br>
							<label>Address</label><input id="shippingAddress" name="shippingAddress" required><br>
								<datalist id="shopList">
	                               	<option>復北門市-台北市復興北路99號1樓</option>
	                                   <option>信義門市-台北市信義區忠孝東路五段68號</option>
                               </datalist>
						</fieldset>
						<fieldset id='memberField'>
							<legend style='text-align: center;font-size:14px;font-weight:bold'>Purchaser</legend>
							<label>Name</label><input id="name" value='<%= member.getName() %>' readonly><br>
							<label>Phone</label><input id="phone" value='<%= member.getPhone() %>' readonly><br>
							<label>Email</label><input id="email" value='<%= member.getEmail() %>' readonly><br>
							<label>Address</label><input id="address" value='<%= member.getAddress() %>' readonly><br>
						</fieldset>
					
					</td>
				</tr>
				<tr class='buttonGroup'>
				<td colspan="3"><input type='button' value='Return to Product' onclick="goShopping()"
					style='font-size:13px;padding:4px 5px;border:none;
						background-color:#EEEEEE;color:black;cursor:pointer;'>
				</td>
				<td colspan="5">
					<input type='submit' value='Modify'
						style='font-size:13px;padding:4px 5px;border:none;
							background-color:black;color:white;cursor:pointer;'>
					<input type='submit' value='Checkout'
						style='font-size:13px;padding:4px 5px;border:none;
							background-color:black;color:white;cursor:pointer;'>
				</td>
				</tr>
			</tfoot>
		</table>
	</form>
		<script>                        	
            function goEZShip() {//前往EZShip選擇門市
                  $("#recipientName").val($("#recipientName").val().trim());
                  $("#recipientEmail").val($("#recipientEmail").val().trim());
                  $("#recipientPhone").val($("#recipientPhone").val().trim());
                  $("#shippingAddress").val($("#shippingAddress").val().trim());
                  var protocol = "<%=request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/"))%>";
                  var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";
                  var url = protocol + "://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ez_ship_callback.jsp";                   
                  $("#rtURL").val(url);
                  $("#webPara").val($("#cartForm").serialize());
               console.log(url);
               console.log($("#webPara").val());                 
               $("#ezForm").submit();
                }
       </script>
            <form method="post" name="simulation_from" action="http://map.ezship.com.tw/ezship_map_web.jsp" id="ezForm">
                <input type="hidden" name="suID"  value="test@vgb.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->
                <input type="hidden" name="processID" value="VGB201804230000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->
                <input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->
                <input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->
                <input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->
                <input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->
            </form> 
		<% }else{ %>
		<p>Your cart is empty</p>
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