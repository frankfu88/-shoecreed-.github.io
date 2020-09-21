<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="style/vgb.css">
<title>JSP註解</title>
	<style>
		/* p{} css 註解*/
	</style>
</head>
<body>
	<h1>JSP註解</h1>
	<hr>
	<p>HTML註解</p>
	<!--   
	<	p>Hello<% out.println("HTMLtest"); %> %></p>
	-->
	<p>JSP註解</p>
	<%--asdasdasd    
	<	p>Hello <% out.println("JSPtest"); %> </p>
	--%>
	<p>JAVA註解</p>
	<%
		//java註解
		//out.println("Java test");
	%>
</body>
</html>