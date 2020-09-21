<%@page import="uuu.vgb.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="uuu.vgb.entity.Customer"%>
<html lang="en">
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/style/slider.css">
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Homepage | SHOECREED</title>
<style>

article {
  float: left;
  padding: 20px;
  width: 100vw;
  background-color: white;
  min-height: 100vh;
  height: 600px;
  max-width: 2000px;
  min-width: 900px;
}

#myImg{
	position: relative;
	top: 65px;
	left: -25px;
}

.info {
	background-color: #575757;
  	padding: 30px;
	text-align: left;
	display: flex;
	justify-content: space-evenly;
	font-size: 14px;
	font-weight: bold;
}

/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens */
@media (max-width: 600px) {
  nav, article {
    width: 100%;
    height: auto;
  }
}

#popular-brands {
	font-size: 22px;
	font-weight: normal;
	min-width: 100px;
	margin: 0px 50px 0px 100px;
}

#most-popular {
	font-size: 22px;
	font-weight: normal;
	min-width: 100px;
	margin: 0px 50px 0px 100px;
}

#see-all{
	color: #429850;
	float: right;
	font-weight: 500;
	font-size: 16px;
}

.popular-brands-img {
	width: 100%;
	padding-left: 7em;
}

.most-popular-img {
	display: flex;
	flex-wrap: wrap;
	column-gap: 20px;
	justify-content: center;
}

.image {
	margin-top: 0;
	margin-right: 15px;
}

.image:hover{
	animation: shake 1.5s;
	animation-iteration-count: infinite;
}

@keyframes shake {
  0% { transform: translate(1px, 1px) rotate(0deg); }
  10% { transform: translate(-1px, -2px) rotate(-1deg); }
  20% { transform: translate(-3px, 0px) rotate(1deg); }
  30% { transform: translate(3px, 2px) rotate(0deg); }
  40% { transform: translate(1px, -1px) rotate(1deg); }
  50% { transform: translate(-1px, 2px) rotate(-1deg); }
  60% { transform: translate(-3px, 1px) rotate(0deg); }
  70% { transform: translate(3px, 1px) rotate(-1deg); }
  80% { transform: translate(-1px, -1px) rotate(1deg); }
  90% { transform: translate(1px, 2px) rotate(0deg); }
  100% { transform: translate(1px, -2px) rotate(-1deg); }
}

.shoe {
	width: 220px;
	max-width: 120%;
	transition: transform 1.5s;
	margin-top: 15px;
}

.shoe:hover{
	-ms-transform: scale(1.1); /* IE 9 */
  	-webkit-transform: scale(1.1); /* Safari 3-8 */
  	transform: scale(1.1); 
}

.product-info {
	margin-top: auto;
	text-align: left;
	background: #FAFAFA;
	box-shadow: 1px 2px 3px 0px rgba(0,0,0,.10);
	border-radius: 6px;
	display: flex;
	flex-direction: column;
}

.product-info > span {
	font-size: 20x;
}

.product-card {
 	flex-grow: 1;
 	border: 1px solid transparent;
}

.product-info>span {
	font-weight: 300;
	font-size: 14px;
}

.img-container{
	background-image: url(img/adidas4d.png);
	background-size: cover;
	background-position: 50% 50%;
	background-repeat: no-repeat;
	height: 80%;
	position: relative;
 }
 
.inner-container{
 	text-align: center;
 	color: white;
 	height: 205px;
 }
 
 h2 {
 	font-family: sans-serif;
 	font-size: 5em;
 	text-align: center;
 	font-weight: normal;
 	margin-top: 15px;
 }
 
.topnav {
  overflow: hidden;
  margin: 1px auto;
}

.search-box:hover > .search-txt{
	width: 350px;
	padding: 0 6px;
}

.search-box:hover > .search-btn{
	background: white;
}

.search-box {
	position: absolute;
	top: 65%;
	left: 50%;
	transform: translate(-50%,-50%);
	background: #FFF;
	height: 40px;
	border-radius: 40px;
	padding: 10px; 
}

.search-btn {
	color: white;
	float: right;
	width: 20px;
	height: 21px;
	border-radius: 50%;
	background: white;
	display: flex;
	justify-content: center;
	align-items: center;
	transition: 0.4s;
}

.search-txt {
	border: none;
	background: none;
	outline: none;
	float: left;
	padding: 0;
	color: black;
	font-size: 16px;
	transition: 0.4s;
	line-height: 24px;
	width: 0px;
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
<script type="text/javascript" src="jquery.js"></script>
</head>
<body>

<jsp:include page="/subviews/header_sc.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>

		<%
			String search = request.getParameter("search");
			ProductService service = new ProductService();
			List<Product> list = null; 	
			if(search!=null && search.length()>0){
				list = service.searchProductsByName(search);
			}else{
				list = service.getAllProducts();
			}
		%>

<nav class="slider_container">
	<div>
		<img src="img/slider/asics.png"/>
	</div>
	<div>
		<img src="img/slider/rbk.png"/>
	</div>
	<div>
		<img src="img/slider/adidas-girl.png"/>
	</div>
	<div>
		<img src="img/slider/sacai-nike.png"/>
	</div>
	<div>
		<img src="img/slider/tscollab.png"/>
	</div>
</nav>

<nav>
<div class="img-container">
	<div class="inner-container">
		<h2>Buy Authentic Sneakers</h2>
		
		<div class="topnav">
			<form action="<%= request.getContextPath()%>/product_list_sc.jsp" method="get">
				<div class="search-box">
				    <input class="search-txt" type="text" name="search" placeholder="Search...">
				    <a class="search-btn" href="#">
				    	<i class="fas fa-search"></i>
				    </a>
		  		</div>
		  	 </form>
		</div>
	</div>
</div>
</nav>

<div class="bg">
	<article>
		<br><span id="popular-brands">Popular Brands</span>
		<a href="<%= request.getContextPath() %>/product_list_sc.jsp">
		<span id="see-all" style="margin: 0px 130px;">See All</span></a>
		
		<div class="popular-brands-img">
		<br><img class="image" src="img/popular-brands/nike2.png">
			<img class="image" src="img/popular-brands/airjordan.png">
			<img class="image" src="img/popular-brands/adidas2.png">
			<img class="image" src="img/popular-brands/yzy.png">
		</div>
		
		<br><br><br><span id="most-popular">Most Popular</span>
		<a href="<%= request.getContextPath() %>/product_list_sc.jsp">
		<span id="see-all" style="margin: 0px 130px;">See All</span></a>
		
		<div class="product-card">
			<div class="most-popular-img">
			
				<div class="shoe"><a href=""><img src="img/most-popular/aj1chicago.png"></a>
					<div class="product-info">
			      		<span>Jordan 1 Retro High</span>
			      		<span>Off-White Chicago</span>
			      		<h3>$517 USD</h3>
	    			</div>
	    		</div>
			
				<div class="shoe"><a href=""><img src="img/most-popular/benjerry.png"></a>
					<div class="product-info">
			      		<span>Nike SB Dunk Low</span>
			      		<span>Ben & Jerry's Chunky Dunky</span>
			      		<h3>$905 USD</h3>
	    			</div>
	    		</div>
	    		
	    		<div class="shoe"><a href=""><img src="img/most-popular/aj1travis.png"></a>
					<div class="product-info">
			      		<span>Jordan 1 Retro High</span>
			      		<span>Travis Scott</span>
			      		<h3>$1094 USD</h3>
	    			</div>
	    		</div>
	    		
	    		<div class="shoe"><a href=""><img src="img/most-popular/travpurple.png"></a>
					<div class="product-info">
			      		<span>Jordan 4 Retro</span>
			      		<span>Travis Scott</span>
			      		<span>Purple (Friends and Family)</span>
			      		<h3>$1000 USD</h3>
	    			</div>
	    		</div>
	    	
	    		<div class="shoe"><a href=""><img src="img/most-popular/aj12gold.png"></a>
					<div class="product-info">
			      		<span>Jordan 12 Retro</span>
			      		<span>Black University Gold</span>
			      		<h3>$232 USD</h3>
	    			</div>
	    		</div>
			</div>
		</div>
	</article>
</div>

<script src="https://apps.elfsight.com/p/platform.js" defer></script>
<div class="elfsight-app-98620261-51ee-4ab2-bcc5-8bc34040152f"></div>

<div class="info">
	<div id="recent-updates">
		<span><a href="" style="color: #F9F9F9;">Recent Updates</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">The Drop List</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">New Balance By the Numbers</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">AM90 Highlight HUFquake</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 1 Zoom Racer: Details</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Classic BAPE T-Shirts</a></span><p>
	</div>

	<div id="popular-releases">
		<span><a href="" style="color: #F9F9F9;">Popular Releases</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 5 Grape</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 12 Black Gold</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 4 Off-White</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Yeezy 350 Zyon</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Nike SB Grateful Dead</a></span><p>
	</div>
	
	<div id="air-jordan">
		<span><a href="" style="color: #F9F9F9;">Air Jordan</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 1</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 11</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 3</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 4</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Jordan 5</a></span><p>
	</div>
	
	<div id="adidas">
		<span><a href="" style="color: #F9F9F9;">adidas</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">adidas Yeezy Boost 350</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">adidas Yeezy Boost 500</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">adidas Yeezy Boost 700</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">adidas Yeezy Boost 380</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">adidas Yeezy Boost NMD</a></span><p>
	</div>
	
	<div id="nike">
		<span><a href="" style="color: #F9F9F9;">Nike</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Nike Air Max</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Nike Air Force 1</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Nike Blazer</a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Nike React </a></span><p>
		<span><a href="" style="color: #8E8E8E;font-weight: normal;">Nike Zoom Fly</a></span><p>
	</div>
</div>

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
		<div id="item1"><a href=https://zh-tw.facebook.com><img src="img/facebook.png" width="70%"></a></div>
		<div id="item2"><a href=https://twitter.com/?lang=zh-tw><img src="img/twitter.png" width="70%"></a></div>
		<div id="item3"><a href=https://www.instagram.com/?hl=zh-tw><img src="img/instagram.png" width="70%"></a></div>
		<div id="item4"><a href=https://www.youtube.com/?hl=zh-TW&gl=TW><img src="img/youtube.png" width="70%"></a></div>
	</div>
	</footer>
</div>
</body>
</body>
</html>
