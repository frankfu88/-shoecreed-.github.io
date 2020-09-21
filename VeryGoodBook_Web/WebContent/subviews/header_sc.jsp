<%@page import="uuu.vgb.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/style/header.css">
<style>

* {
  	box-sizing: border-box;
}

body {
	margin: 0;
	background-color: #FFFFFF;
	font-family: Arial, Helvetica, sans-serif;
}

a {
	text-decoration: underline;
	text-decoration: overline; 
	text-decoration: line-through; 
	text-decoration: none; 
}
	a:link{color: black;}
	a:visited{color: black;}
	a:hover{color: black;}
	a:active{color: black;}
	
#topleft {
	position: absolute;
	padding: 15px;
	top: 10px;
	left: 50px;
	font-size: 11px;
	word-spacing: 1px;
}

#topleft > a:hover{
	text-decoration: underline;
}

#topright {
	position: absolute;
	padding: 15px;
	top: 10px;
	right: 50px;
	font-size: 11px;
	word-spacing: 1px;
}

#topright > a:hover{
	text-decoration: underline;
}

#myLogo {
	position: fixed;
    width: 100%;
    height: 50px;
 	text-align: center;
    font-size: 24px;
    top: 16px;
}
#socialbar {
	display:-webkit-flex;
	position: relative;
	float: right;
	display:flex;
	bottom: -50px;
	margin-top: -45px;
}

#item1{
	-webkit-order: 1;
	order: 1;
}

#item2{
	-webkit-order: 2;
	order: 2;
}

#item3{
	-webkit-order: 3;
	order: 3;
}

#item4{
	-webkit-order: 4;
	order: 4;
}

.menu{
	position: -webkit-sticky;
	position: sticky;
	top: 0px;
	width: 100vw;
	height: 8vh;
	background: #FFFFFF;
	z-index: 1;
}

.searchTable{
	display: none;
	width: 260px;
	height: 66px;
	border: 1px solid black;
	background: white;
	padding: 5px;
	font-size: 11px;
	text-align: center;
}

.searchTable > div:active{
	text-decoration: underline;
}

.searchTable > div {
	display: inline-block;
	font-weight: bold;
	justify-content: center;
	margin-top: 7px;
}

.searchBar{
	border: 0;
	outline: none;
	float: left;
	font-size: 13px;
	width: 250px;
}

</style>

<script type="text/javascript">
$(document).ready(init);
function init(){
	 $(".searchDrop").click(clickHandler);
}
function clickHandler(){
	//$(".searchTable").slideDown(100);
	 $(".searchTable").toggle(100);
}

$(".searchDrop").click(function(){
	$(".searchBar").focus();
});
</script>

<!-- header_sc.jsp start -->

<%Customer member = (Customer)session.getAttribute("member");%>

<div class="menu">
	<div id="myLogo"><a href="/vgb/index.jsp">SHOECREED</a></div>
		<sub>
			
		</sub>
	<div id="topright">
	<% if(member==null) {%>
		<a href="<%= request.getContextPath() %>/register_sc.jsp">REGISTER</a>&emsp;
		<a href="<%= request.getContextPath() %>/login_sc.jsp">LOGIN</a>&emsp;
		<%} else{ %>
		
		<span class='welcomeSub' style='font-weight:bold;font-size: 12px'>[<%=member!=null?member.getName():"" %>]</span>&nbsp;
		<a href="<%= request.getContextPath() %>/logout.do">LOGOUT</a>&emsp;
		<a href="<%= request.getContextPath() %>/member/modify_sc.jsp">MODIFY</a>&emsp;
		<a href="<%= request.getContextPath() %>/member/order_history.jsp">ORDER HISTORY</a>&emsp;
		<%} %>
		<a href="<%= request.getContextPath() %>/member/cart_sc.jsp">CART</a>
		
		<span class='cartSub'>
			<jsp:include page="/small_cart_sc.jsp"/>&emsp;&emsp;
		</span>
		
	</div>
	
	<div id="topleft">
		<a href="<%= request.getContextPath() %>/product_list_sc.jsp">MEN</a>&emsp;
		<a href="<%= request.getContextPath() %>/product_list_sc.jsp">WOMEN</a>&emsp;
		<a href="<%= request.getContextPath() %>">SALE</a>&emsp;
		
		<a href="#" class="searchDrop">SEARCH</a>
		   <div class="searchTable">
			   <div><a href="#">MEN</a></div>
			   <div><a href="#">WOMEN</a></div>	  
			  	<hr>
			 <form action="<%= request.getContextPath()%>/product_list_sc.jsp" method="get">
			 	<input class="searchBar" type="text" name="search" placeholder="SEARCH...">
			 </form>
		   </div>
	</div>
</div>
<!-- header_sc.jsp end -->