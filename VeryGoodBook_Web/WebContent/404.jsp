
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1" >
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">
	<title>404 Not Found</title>
	
<style>
	h4{
		font-size: 25px;
		text-align: center
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
</head>

<body>
	<jsp:include page="/subviews/header_sc.jsp">
		<jsp:param value="404" name="subtitle"/>
	</jsp:include>
		<article>
		<h4>PAGE NOT FOUND - <%= request.getAttribute("javax.servlet.error.request_uri") %></h4>
			<img style='display: block; width: 60%; margin: auto; border:1px solid red; border-width: 5px 5px;' 
			src='<%= request.getContextPath() %>/img/404v.png'>
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
			<br><br><br><br>
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