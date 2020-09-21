<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<link rel="stylesheet" type="text/css" href="style/vgb.css"/>
		<title>99乘法表</title>
		
		<style>
			#mutiple {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 70%;margin:auto;
			}
			
			#mutiple caption, #mutiple td{
			  border: 1px solid #ddd;
			  padding: 8px;
			  text-align:center
			}
			
			#mutiple tr:nth-child(even){
			  background-color: #f2f2f2;
			}
			
			#mutiple tr:hover {background-color: #ddd;}				
		</style>
	</head>
	<body>	
		<table id='mutiple'>
			<caption>99乘法表</caption>
			<% 				
			for(int i=1;i<10;i++) {			
			%>
			<tr>
				<% for(int j=1;j<10;j++) {%>
				<td> <%= i %> * <%= j %> = <%= i*j %></td>
				<%} %>
			</tr>
			<% }%>				
		</table>
		
		
	</body>
</html>