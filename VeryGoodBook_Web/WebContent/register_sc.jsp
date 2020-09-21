<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="style/vgb.css">
<title>Register | SHOECREED</title>
<style>


#captchaImg {
	vertical-align: middle;
	cursor: pointer;
}

.signUp {
  height: 620px;
  width: 390px;
  margin: 80px auto;
  background: #FCFCFC;
  box-shadow: 1px 2px 3px 0px rgba(0,0,0,0.10);
  border-radius: 6px;
  display: flex;
  flex-direction: column;
  margin-top: 10px;
  margin-bottom: 20px;
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

nav>p {
	font-size: 13px;
}

</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
	<script>
		function refreshCaptcha(){
			var captchaImg = document.getElementById("captchaImg");
			captchaImg.src = "images/register_captcha.jpeg?refresh="+new Date();
		}
		
		<% if("POST".equals(request.getMethod())) {%>
			$(fieldRepopulate);
		 
			
		function fieldRepopulate(){
			alert('fieldRepopulate');
			$("#account").val('<%= request.getParameter("id")%>');
			$("#name").val('<%= request.getParameter("name")%>');
			$("#email").val('<%= request.getParameter("email")%>');
			$("#birthday").val('<%= request.getParameter("birthday")%>');
			$("#phone").val('<%= request.getParameter("phone")%>');
			$("#address").val('<%= request.getParameter("address")%>'); //textarea
			
			$("#<%= request.getParameter("gender")%>").prop("checked", true); //radio
		}
		<%} %>
	</script>
</head>

<body>
<jsp:include page="/subviews/header_sc.jsp">
		<jsp:param value="Register" name="subtitle"/>
	</jsp:include>
<%
	Customer member = (Customer)session.getAttribute("member");
%>

<div class="signUp">
	<div>
	<%
		List<String> errors = (List<String>)request.getAttribute("errors");
	%>
	<% if(errors!=null && errors.size()>0){ %>
	<ul class='errors'>
		<% for(int i=0;i<errors.size();i++) {%>	
		<li><% out.print(errors.get(i)); %></li>
		<% } %>
	</ul>
	<% } %>
</div>

	<div class="title">CREATE ACCOUNT</div>
			<form action="register.do" method="POST">
			
		<nav>
			<p><label>Account</label><br>
				<input id='id' name='id' maxlength="10"
				placeholder="" required>
			</p>
		</nav>
		<nav>
			<p>
				<label>Email</label><br>
				<input type='email' id='email' name='email' placeholder="" required>
			</p>
		</nav>
		<nav>
			<p>
				<label>Name</label><br>
				<input id='name' name='name' placeholder="" required>
			</p>
		</nav>
		<nav>
			<p>
				<label>Password</label><br>
				<input type='password' name="pwd1" placeholder="" required
					minlength="<%= Customer.PWD_MIN_LENGTH %>"
					maxlength="<%= Customer.PWD_MAX_LENGTH %>">
			</p>
		</nav>
		<nav>
			<p>
				<label>Confirm</label><br>
				<input type='password' name="pwd2" required placeholder="">
			</p>
		</nav>
		<nav>
			<p>
				<label>Birthday</label><br>
				<input type="date" id='birthday' name="birthday" max='2040-12-31' required
					max='<%=LocalDate.now().plusYears(-20) %>'>
			</p>
		</nav>	
		<nav>
			<p>
				<label>Phone</label><br>
				<input id='phone' name='phone' required placeholder="">
			</p>
		</nav>
		<nav>	
			<p>
				<label>Address</label><br>
				<input id='address' name='address' required placeholder="">
			</p>
		</nav>
		<nav>
			<p>
				<label>Gender</label><br>
				<input type='radio' id="<%=Customer.MALE %>" name="gender" value='<%=Customer.MALE %>' required><label>Men's</label>
				<input type='radio' id="<%=Customer.FEMALE %>" name="gender" value='<%=Customer.FEMALE %>' required><label>Women's</label>
				<input type='radio' name="gender" value='NT' required><label>No Thanks</label>
			</p>
		</nav>
		<nav>
			<p>
				<label>Verification</label><br>
				<input type='text' name='captcha' placeholder="" required>
				<img id="captchaImg" src="images/register_captcha.jpeg" onclick="refreshCaptcha()"
					alt="verification" title="click to refresh">
			</p>
		</nav>	
			<div class="create" style='text-align:center'><input type="submit" value='Create'></div>
		</form>
	</div>
		
	<%@include file="/subviews/footer_sc.jsp" %>
	</body>
</html>