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
	request.setCharacterEncoding("UTF-8");
	String id = (String)request.getParameter("id");
	String pw = (String)request.getParameter("password");
	String sql = "SELECT * FROM user WHERE id=? and password=?";
	String[] error = {"회원이 아닙니다", "비밀번호가 일치하지 않습니다", " 님 환영합니다."}; 	
 	String[] jsp = {"./index.jsp", "./id_error.jsp", "./pass_error.jsp"};
 	String resultMsg = "";
 	String resultUrl = "";
	
	Connection conn = null;
	try{
		String url = "jdbc:mysql://localhost:3306/jspbookdb?characterEncoding=UTF-8&serverTimezone=UTC";
		String user = "root";
		String password = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");	
		conn = DriverManager.getConnection(url, user, password);
		System.out.println("데이터베이스 연결 성공");
	}catch(SQLException ex) {		
		System.out.println("데이터베이스 연결 실패");
	}
	
	try{
		PreparedStatement pstat = null;
		pstat = conn.prepareStatement(sql);
		pstat.setString(1,id);
		pstat.setString(2,pw);
		ResultSet rs = pstat.executeQuery();
	 	if(rs.next()){
	 		String name = rs.getString("name");
	 		resultUrl = jsp[0];
	 		resultMsg = name + error[2];
	 		System.out.println("데이터 조회 성공\n" + resultMsg);
	 	}else{
	 		sql = "SELECT COUNT(*) count FROM user WHERE id=?";
	 		pstat = conn.prepareStatement(sql);
	 		pstat.setString(1, id);
		 	rs = pstat.executeQuery();
		 	System.out.println("데이터 조회중" + resultMsg);
		 	if(rs.next()){
		 		int count = rs.getInt("count");
		 		if(count > 0){
		 			resultUrl = jsp[2];
		 			resultMsg = error[1];
		 		}else{
		 			resultUrl = jsp[1];
		 			resultMsg = error[0];
		 		}
		 	}
	 	}
	}catch(SQLException ex) {
		System.out.println("데이터 조회 실패");
	}
%>
<jsp:forward page="<%= resultUrl %>">
	<jsp:param value="<%= resultMsg %>" name="message"/>
</jsp:forward>
</body>
</html>