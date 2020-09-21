<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<% 
	Customer member = (Customer)session.getAttribute("member");
	if(member!=null) {
		response.sendRedirect(request.getContextPath());
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset='UTF-8'>
		<meta name="viewport" content="width=device-width, initial-scale=1" >
		<link rel="stylesheet" type="text/css" href="style/vgb.css">
		<title>會員登入</title>	
		<style>
			#captchaImg{vertical-align: middle;cursor: pointer}
		</style>	
		<script>
			function refreshCaptcha(){
				//alert("refreshCaptcha");
				var captchaImg = document.getElementById("captchaImg");
				captchaImg.src = "images/captcha.jpg?refresh="+new Date();
				
			}
		</script>
	</head>
	<body>
		<header>
			<h1><a href='/vgb'>非常好書</a> <sub>會員登入</sub></h1>
		</header>
		<hr>
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
				<p>
					<label>帳號:</label>
					<input id='id' name='id' 
						value='<%="POST".equalsIgnoreCase(request.getMethod())?request.getParameter("id"):id %>' 
						required placeholder="請輸入身分證號/Email">
					<input type="checkbox" name="keepId"  <%=keepId%>><label>記住我的帳號</label>
				</p>
				<p>
					<label>密碼:</label>
					<input type='password' name="pwd" placeholder="請輸入密碼" required>
				</p>
				<p>
					<label>驗證碼:</label>
					<input type='text' name="captcha" placeholder="請依據右圖輸入驗證碼" required>
					<img id="captchaImg" src="images/captcha.jpg" onclick="refreshCaptcha()"
						alt="驗證碼" title="點選即可更新驗證碼">
				</p>
				<input type="submit" value='登入'>		
			</form>			
		</article>
	</body>
</html>