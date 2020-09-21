<%@ page pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="../style/vgb.css">
<title>系統錯誤</title>
</head>
<body>
	<header>
		<h1>非常好書 <sub>系統錯誤</sub></h1>
		<hr>
	</header>	
	<article>
	<% if(exception!=null) {%>
		<h2>系統發生錯誤:<%= request.getRequestURI() %></h2>
		<% this.log("系統發生錯誤", exception);%>		
		<details>
			<summary>錯誤訊息:<%= exception %></summary>
			<font style='font-size: small;color:darkred'>
				<% exception.printStackTrace(new java.io.PrintWriter(out));%>
			</font>
	    </details>
		
	<% } %>
	</article>
</body>
</html>