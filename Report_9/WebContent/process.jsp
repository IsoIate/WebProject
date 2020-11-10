<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		Connection conn = null;
		String url="jdbc:mysql://localhost:3306/jspbookdb?characterEncoding=UTF-8&serverTimezone=UTC";
		String user = "root";
		String pass = "root";
		String nextPage = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, pass);
		} catch(SQLException e) {
			out.println("데이터베이스 연결 실패");
		}
	%>
	<%
		String sql = "SELECT * FROM user WHERE id=?";
		PreparedStatement pstat = conn.prepareStatement(sql);
		
		pstat.setString(1, request.getParameter("id"));
		ResultSet rs = pstat.executeQuery();
		if(rs.next() != false) { // boolean값, id가 일치
			if(rs.getString(2).equals(request.getParameter("passwd"))){	// pw 비교
				request.setAttribute("name", rs.getString(3));
				nextPage = "index.jsp";
			}
			else {
				nextPage = "pass_error.jsp";
			}
			/* 
			out.println(rs.getString(1));	// id
			out.println(rs.getString(2));	// pw
			out.println(rs.getString(3));	// name 
			*/
		}
		else {	// id가 불일치
			nextPage = "id_error.jsp";
		}
	%>
	<!-- 페이지 이동처리 -->
	<jsp:forward page="<%= nextPage %>"></jsp:forward>	
</body>
</html>