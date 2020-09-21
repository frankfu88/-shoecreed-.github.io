<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" >
		<meta http-equiv="refresh" content ="5;url=<%= request.getContextPath() %>" >
		<title>註冊成功</title>
		<link rel="stylesheet" type="text/css" href="/style/vgb.css" >
	</head>
	<body>
		<header>
				<h1><a href='<% out.print(request.getContextPath()); %>'></a> 
				</h1>
				<hr>						
		</header>
		<article>
			<h3>
				<% 
					Customer c = (Customer)request.getAttribute("customer");
					out.print(c!=null?c.getName():"c is null");
				%>
				你好,恭喜已經完成註冊
			</h3>
			<p>
				5秒後將回到<a href='<% out.print(request.getContextPath()); %>'>首頁</a>
			</p>
		</article>
	</body>
</html>