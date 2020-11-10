<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if(request.getAttribute("name") == null) {	// %>
			<form action="process.jsp" method="post">
				ID : <input type="text" name="id"></br>
				비밀번호 : <input type="password" name="passwd"></br>
				<input type="submit" value="로그인">
				<input type="reset" value="다시쓰기"></br>
				<a href="register.jsp">회원가입</a>
			</form>
	<% } else { 
		out.println(request.getAttribute("name") + " 님 환영합니다.");
	%>
	</br>
	<a href="index.jsp">로그아웃</a>
	<%} %>
</body>
</html>