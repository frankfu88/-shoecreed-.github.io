<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1" >
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">	
	<title>付款通知</title>
</head>
<body>
		<jsp:include page="/subviews/header_sc.jsp" >
			<jsp:param name="subtitle" value="ATM付款通知"/>
		</jsp:include>		
		<article>
			<form>
				<p>
					<label>訂單編號:</label>
					<input readonly value="6">
				</p>
				<p>
					<label>應付金額:</label>
					<input readonly value="752">
				</p>
				<p>
					<label>轉帳銀行:</label>
					<input value="" required>
				</p>
				<p>
					<label>帳號後5碼:</label>
					<input value="" maxlength="5" minlength="5" required>
				</p>
				<p>
					<label>轉帳金額:</label>
					<input  value="752">
				</p>
				<input type='submit'>
			</form>
		</article>				
</body>
</html>