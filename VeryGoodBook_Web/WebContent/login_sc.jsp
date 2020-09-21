<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="style/vgb.css">
<title>Login | SHOECREED</title>
<style>

html, body {margin: 0; height: 100%; overflow: hidden}

#captchaImg {
	vertical-align: middle;
	cursor: pointer;
}

.logIn {
  height: 330px;
  width: 336px;
  margin: 80px auto;
  background: #FCFCFC;
  box-shadow: 1px 2px 3px 0px rgba(0,0,0,0.10);
  border-radius: 6px;
  display: flex;
  flex-direction: column;
  background-color: #FAFAFA;
  margin-top: 120px;
  opacity: 0.9;
  padding-left: 20px;
}

.title {
  height: 60px;
  border-bottom: 1px solid #E1E8EE;
  padding: 20px 30px;
  color: black;
  font-size: 20px;
  font-weight: 400;
  text-align: center;
  position: relative;
}

.signIn{
	margin-top: 50px;
	padding-left: 110px;
}

nav>p {
	font-size: 13px;
}

#myVideo {
  position: fixed;
  right: 0;
  bottom: 0;
  min-width: 100%;
  min-height: 100%;
  z-index: -1;
}

</style>

<script>
	function refreshCaptcha(){
		var captchaImg = document.getElementById("captchaImg");
		captchaImg.src = "images/captcha.jpg?refresh="+new Date();
	}
</script>
<script>
	function refreshCaptcha(){
		var captchaImg = document.getElementById("captchaImg");
		captchaImg.src = "images/captcha.jpg?refresh="+new Date();
	}
</script>

<script>
// Get the video
var video = document.getElementById("myVideo");
</script>
</head>
	
<body>

<jsp:include page="/subviews/header_sc.jsp">
		<jsp:param value="" name=""/>
	</jsp:include>
	
<!-- The video -->
<video autoplay muted loop id="myVideo">
  <source src="img/travisDior.mp4" type="video/mp4">
</video>

<%
	Customer member = (Customer)session.getAttribute("member");
	if(member!=null){
		response.sendRedirect(request.getContextPath());
		return;
	}
%>
	<div class="logIn">
		<div class="title">LOGIN</div>
		<article>
			<%
				//讀取cookies: id, keepId
				Cookie[] cookies = request.getCookies();
				String id = "";
				String keepId = "";
				if(cookies!=null){
					for(int i=0;i<cookies.length;i++){
						Cookie theCookie = cookies[i];
						if(theCookie.getName().equals("id")){
							id = theCookie.getValue();
						}else if(theCookie.getName().equals("keepId")){
							keepId = theCookie.getValue();
						}
					}
				}
			
				List<String> errors = (List<String>)request.getAttribute("errors");
			%>
			<%= errors!=null?errors:"" %>
			<form action="login.do" method="POST">
			
			<nav>
				<p>
					<label>Email</label><br>
					<input id='id' name='id' 
					value='<%="POST".equalsIgnoreCase(request.getMethod())?request.getParameter("id"):id %>'
					required placeholder="">
					<input type="checkbox" name="keepId" <%= keepId %>><label>Remember me</label>
				</p>
			</nav>
			<nav>
				<p>
					<label>Password</label><br>
					<input type='password' name="pwd" placeholder="" required>
				</p>
			</nav>
			<nav>
				<p>
					<label>Verification</label><br>
					<input type='text' name="captcha" placeholder="" required>
					<img id="captchaImg" src="images/captcha.jpg" onclick="refreshCaptcha()"
					alt="verification" title="click to refresh">
				</p>
			</nav>
			
				<div class="signIn"><input type="submit" value='SIGN IN'></div>
				
			</form>
		</article>
	</div>
</body>
</html>