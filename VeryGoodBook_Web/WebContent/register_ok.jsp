<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" >
		<meta http-equiv="refresh" content ="10;url=<%= request.getContextPath() %>" >
		<title>註冊成功</title>
		<link rel="stylesheet" type="text/css" href="//localhost:8080/vgb/style/vgb.css" >
	</head>
	<body>
		<header>
				<h1><a href='<% out.print(request.getContextPath()); %>'>非常好書</a> 
					<sub>註冊成功</sub>
				</h1>
				<hr>						
		</header>
		<article>
			<h3>
				<%  
					Customer c = (Customer)request.getAttribute("customer");					
				%>								
				<%=c!=null?c.getName():"" %>你好,恭喜已經完成註冊
				<p>
					10秒後將回到<a href='<% out.print(request.getContextPath()); %>'>首頁</a>
				</p>
			</h3>
			
		</article>
		<footer>
				<hr>
				<p>非常好書&copy;版權所有</p>
		</footer>
	</body>
</html>