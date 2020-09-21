<%@page import="uuu.vgb.entity.Customer"%>
<%@page import="com.sun.xml.internal.ws.api.pipe.NextAction"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%! 
	static{
	System.out.println("hello.jsp class loaded...");
	}

	//(宣告在_jspService外)
	private int i;//屬性
	private String welcome="你好";//屬性
	public void jspInit(){			
		String welcome = this.getInitParameter("welcome"); //web.xml
		if(welcome!=null){
			this.welcome = welcome;
		}
		
		System.out.println("hello.jsp init...");
	}
%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">
<title>JSP測試</title>
	<style>
		
	.welcomeSub{float:right;color:navy;padding-top:1ex;}		
	
	#reqHeaders {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 70%;margin:auto;
			}
			
			#reqHeaders caption, #reqHeaders td{
			  border: 1px solid #ddd;
			  padding: 8px;
			  text-align:center
			}
			
			#reqHeaders tr:nth-child(even){
			  background-color: #f2f2f2;
			}
			
			#reqHeaders tr:hover {background-color: #ddd;}		
		</style>
	</head>
<body>
		<header>
			<h1><a href='<%= request.getContextPath()%>'>非常好書</a> <sub>歡迎</sub></h1>
		</header>
		<% Customer member = (Customer)session.getAttribute("member");%>
		<nav>
			<hr>
			<% if(member==null) {%>
				<a href="<%= request.getContextPath()%>/login.jsp">登入</a> | 
				<a href="register.jsp">註冊</a> |
			<%}else{  %>
				<a href="<%= request.getContextPath()%>/logout.do">登出</a> | 
				<a href="<%= request.getContextPath()%>/member/update.jsp">修改會員</a> |
			<% } %>
			<sub class='welcomeSub'><%=member!=null?member.getName():"" %> 你好</sub>
			<hr>
		</nav>
	<%
		int i=10;//區域變數(宣告在_jspService中)		
	%>	
	
	<p>Welcome: <%= welcome %></p>
	<p>屬性i: <%= this.i %></p>
	<p>區域變數i: <%= i %></p>
	<% 
		
			//1.載入Driver
			//Class.forName("com.mysql.j.jdbc.Driver");
		
			//2.建立連線
			//Connection connection = DriverManager.getConnection(".....", "root", "1234");
	%>
	<hr>
	<h2>隱含變數 request(***)</h2>
	<p>request url protocol: <%= request.getProtocol() %></p>
	<p>request url server Name: <%= request.getLocalName() %></p>
	<p>request url server ip: <%= request.getLocalAddr() %></p>
	<p>request url server port: <%= request.getLocalPort() %></p>
	<p>request client Name: <%= request.getRemoteHost() %></p>
	<p>request client ip: <%= request.getRemoteAddr() %></p>
	<p>request client port: <%= request.getRemotePort() %></p>
	<p>request url contextPath: <%= request.getContextPath() %></p>
	<p>request url: <%= request.getRequestURL() %></p>
	<p>request uri: <%= request.getRequestURI() %></p>
	<p>request query string: <%= request.getQueryString() %></p>
	<% request.setCharacterEncoding("UTF-8"); %>
	<p>request parameter [id]: <%= request.getParameter("id") %></p>
	<p>request parameter [gender]: <%= request.getParameter("gender") %></p>
	<p>request parameter [name]: <%= request.getParameter("name") %></p><!-- http://instructor:8080/vgb/mod12/hello.jsp?id=A123456789&name=%E5%BC%B5%E4%B8%89%E8%B1%90&gender=M -->
	<p>request method: <%= request.getMethod() %></p>
	<div>
		<form method='POST'>
			<input name='id' placeholder='請輸入id'><br>
			<input name='name' placeholder='請輸入name'><br>
			<input name='pwd' placeholder='請輸入pwd'><br>
			<input type='submit' value='送出資料'>
		</form>
	</div>
	<div>
		<table id='reqHeaders' style='width:75%'>
			<caption>request中的Headers</caption>
			<%
				Enumeration<String> headerNames = request.getHeaderNames();
				while(headerNames.hasMoreElements()){
					String name = headerNames.nextElement();
					String value = request.getHeader(name);
			%>			
			<tr>
				<td><%= name %></td>
				<td><%= request.getHeader(name) %></td>
			</tr>
			<% } %>
		</table>		
	</div>
	<hr>
	<h2>隱含變數 session(**)</h2>
	<p>sessioni.id: <%= session.getId() %></p>
	<p>session.isNew(): <%= session.isNew() %></p>
	<p>session.getCreationTime(): <%= new Date(session.getCreationTime()) %></p>
	<p>session.getLastAccessedTime(): <%= new Date(session.getLastAccessedTime()) %></p>
	<p>session time out(sec.): <%= session.getMaxInactiveInterval() %>秒</p>
	<hr>
	<h2>隱含變數 application(*, 等同於this.getServletContext())</h2>
	<p>application realPath: <%= application.getRealPath("/") %></p>
	<p>application context Path: <%= application.getContextPath() %></p>	
	<%
		Integer visitorCounter = (Integer)application.getAttribute("app.visitors.counter");
		if(visitorCounter==null) visitorCounter = 5000_0000;	
		application.setAttribute("app.visitors.counter", ++visitorCounter);
	%>
	<p>application 拜訪人次: <%= application.getAttribute("app.visitors.counter") %></p>
	<hr>
	<h2>隱含變數 config(常用this取代)</h2>
	<p>config.getServletName(): <%= config.getServletName() %></p>
	<p>config.getInitParameter("fork"): <%= config.getInitParameter("fork") %></p>
	<p>this.getServletName(): <%= this.getServletName() %></p>
	<p>this.getInitParameter("fork"): <%= this.getInitParameter("fork") %></p>
	<hr>
	<h2>隱含變數 pageContext(很少用)</h2>
	<p>request url contextPath:<%= ((HttpServletRequest)pageContext.getRequest()).getContextPath() %></p>
	<hr>
	<h2>隱含變數 page(必須用this取代)</h2>
	<p>page==this: <%= page==this %></p>
	<p>page.getClass().getName() <%= page.getClass().getName() %></p>
	
</body>
</html>