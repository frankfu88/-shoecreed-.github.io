<%@ page pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/style/footer.css">

<style>

.myFooter {
  padding: 10px;
  margin: 0px;
  display: flex;
  min-height: 3px;
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

<!-- footer_sc.jsp  start -->
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
<!-- footer_sc.jsp end -->