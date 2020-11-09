package demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database {
	Connection conn = null;
	
	public Database() {
		String url = "jdbc:mysql://localhost:3306/jspbookdb?characterEncoding=UTF-8&serverTimezone=UTC";
		String user = "root";
		String password = "root";
		String nextPage = null;
		
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");	
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("데이터베이스 연결 성공");
		}catch(SQLException | ClassNotFoundException ex) {		
			System.out.println("데이터베이스 연결 실패");
		}
	}
	public DTOUser findId(String id) {
		PreparedStatement pstat;
		DTOUser dto = new DTOUser();
		try {
			pstat = conn.prepareStatement("SELECT * FROM user WHERE id=?");
			pstat.setString(1, id);
			ResultSet rs = pstat.executeQuery();
			dto.setId(rs.getString(1));
			dto.setPasswd(rs.getString(2));
			dto.setName(rs.getString(3));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dto;
	}
		
}

