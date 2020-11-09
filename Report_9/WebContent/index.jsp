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
		request.setCharacterEncoding("UTF-8");
		String msg = (String)request.getParameter("message"); 
	%>
	<% if(msg == null){ %>
	<form action="process.jsp" method="get">
		ID : <input type="text" name="id"><br/>
		비밀번호 : <input type="text" name="password"><br/>
		<input type="submit" value="로그인">
		<input type="reset" value="다시쓰기"><br/>
		<a href="#">회원가입</a>
	<% }else{ %>
		<p><%= msg %></p>
		<a href="./index.jsp">로그아웃</a>
	<% } %>
	</form>
</body>
</html>