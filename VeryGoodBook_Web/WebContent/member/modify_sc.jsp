<%@page import="uuu.vgb.entity.VIP"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page import="uuu.vgb.entity.Customer"%>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" >
<link rel="stylesheet" type="text/css" href="../style/vgb.css">
<title>Modify | SHOECREED</title>
<style>

html, body {margin: 0; height: 100%; overflow: hidden}

#captchaImg {
	vertical-align: middle;
	cursor: pointer;
}

.modify {
  height: 550px;
  width: 390px;
  margin: 80px auto;
  background: #FCFCFC;
  box-shadow: 1px 2px 3px 0px rgba(0,0,0,0.10);
  border-radius: 6px;
  display: flex;
  flex-direction: column;
  opacity: 0.9;
  padding-left: 20px;
  position: absolute;
  top:0;
  bottom: 0;
  left: 0;
  right: 0;
  margin-top: 100px;
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

.create {
	position: relative;
	text-align: center;
}

nav>p {
	font-size: 14px;
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
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
	<script>
		function refreshCaptcha(){
			var captchaImg = document.getElementById("captchaImg");
			captchaImg.src = "../images/register_captcha.jpeg?refresh="+new Date();
		}
		
		<%  Customer member = (Customer)session.getAttribute("member");
				
				if("POST".equalsIgnoreCase(request.getMethod())) { %>
				$(fieldRepopulate); //$() 等同於$(document).ready(...)
				function fieldRepopulate(){					
					//alert('fieldRepopulate');
					$("#id").val('<%= request.getParameter("id")%>');
					$("#name").val('<%= request.getParameter("name")%>');
					$("#email").val('<%= request.getParameter("email")%>');
					$("#birthday").val('<%= request.getParameter("birthday")%>');
					$("#phone").val('<%= request.getParameter("phone")%>');
					$("#address").text('<%= request.getParameter("address")%>');  //textarea
					
					<%-- $("#<%= request.getParameter("gender")%>").prop("checked", true);  //radio --%>
					
					<%-- $("#bloodType").val('<%= request.getParameter("bloodType")%>');--%>
					<%-- $("#married").prop("checked", <%= request.getParameter("married")!=null%>); //checkbox --%>
					$("#changePwd").prop("checked", <%= request.getParameter("changePwd")!=null%>);
				}
			<%}else if("GET".equalsIgnoreCase(request.getMethod()) && member!=null){%>
				$(fieldRepopulate); //$() 等同於$(document).ready(...)
				function fieldRepopulate(){					
					//alert('fieldRepopulate');
					$("#id").val('<%= member.getId() %>');
					$("#name").val('<%= member.getName()%>');
					$("#email").val('<%= member.getEmail()%>');
					<%-- $("#birthday").val('<%= member.getBirthday()%>'); --%>
					$("#phone").val('<%= member.getPhone()%>');
					$("#address").text('<%= member.getAddress()%>');  //textarea
					
					<%-- $("#<%= member.getGender()%>").prop("checked", true);  //radio --%>
					
					<%-- $("#bloodType").val('<%= member.getBloodType()!=null?member.getBloodType().name():"" %>');	
					$("#married").prop("checked", <%= member.isMarried() %>); //checkbox --%>
				}
			<%}%>
			
			function enableChangePwd(){
				//alert("enableChangePwd()");
				$("#pwdDiv input[type='password']").prop('disabled', !$("#changePwd").prop("checked"));
				if($("#changePwd").prop("checked")){
					$("#pwdDiv").removeClass("disabled");
					$("#pwd1").focus();
				}else{
					$("#pwdDiv").addClass("disabled");					
				}
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
  <source src="../img/travisDior.mp4" type="video/mp4">
</video>

<div class="modify">
	<div>
		<%List<String> errors = (List<String>)request.getAttribute("errors");%>
		<% if(errors!=null && errors.size()>0){ %>
		<ul class='errors'>
			<% for(int i=0;i<errors.size();i++) {%>	
			<li><% out.print(errors.get(i)); %></li>
			<%} %>
		</ul>
		<% } %>
	</div>
<div class="title">MODIFY</div>
		<form action="update.do" method="POST">	
		
			<p>
				<label>Account</label><br>
				<input id='id' name='id' pattern="[A-Z][12][0-9][8]" maxlength="10"
				placeholder="" required readonly>
				<%if(member instanceof VIP) {%>
				<input type='checkbox' checked disabled><label>VIP, 享有<%= ((VIP)member).getDiscountString() %></label>
				<%} %>
			</p>
		
			<p>
				<label>Email address</label><br>
				<input type='email' id='email' name='email' placeholder="" required>
			</p>
		
			<p>
				<label>Name</label><br>
				<input id='name' name='name' placeholder="" required>
			</p>
	
			<p>
				<label>Password</label><br>
				<input type='password' name="password" placeholder="" required
					minlength="<%= Customer.PWD_MIN_LENGTH %>"
					maxlength="<%= Customer.PWD_MAX_LENGTH %>">
			</p>
	
		
			<fieldset style='width:15em'>
				<legend><input type='checkbox' id='changePwd'
					name='changePwd' onchange='enableChangePwd()'>New Password</legend>
				<div id='pwdDiv' class='disabled'>
					<label class='inputLabel'></label>
					<input type='password' id='pwd1' name="pwd1" placeholder="New Password" disabled
						minlength="<%= Customer.PWD_MIN_LENGTH %>" 
						maxlength="<%= Customer.PWD_MAX_LENGTH %>">
					<br>
					<label class='inputLabel'></label>
					<input type='password' name="pwd2" placeholder="Confirm" disabled
						minlength="<%= Customer.PWD_MIN_LENGTH %>" 
						maxlength="<%= Customer.PWD_MAX_LENGTH %>">
				</div>
			</fieldset>
			
			<p>
				<label>Birthday</label><br>
				<input type='date' id='birthday' name="birthday" required
					max='<%= LocalDate.now().plusYears(-20) %>'>
			</p> 
			
			<%-- <p>
				<label>性別:</label>
				<input type='radio' id="<%=Customer.MALE%>"  name="gender" value='<%=Customer.MALE%>' required><label>男</label>
				<input type='radio' id="<%=Customer.FEMALE%>" name="gender" value='<%=Customer.FEMALE%>' required><label>女</label>
			</p> --%>
			
			<p>
				<label>Address</label><br>
				<input id='address' name='address' required placeholder="">
			</p> 

			<!-- <p>
				<label></label>
				<input type='text' name='captcha' placeholder="Verification" required>
				<img id="captchaImg" src="../images/register_captcha.jpeg" onclick="refreshCaptcha()"
					alt="verification" title="click to refresh">
			</p> -->
	
			
			<div class="create"><input type="submit" value='MODIFY'></div>
		</form>
</div>
</body>
</html>