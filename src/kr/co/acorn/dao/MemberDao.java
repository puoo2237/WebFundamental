package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.MemberDto;
import kr.co.acorn.util.ConnLocator;

public class MemberDao {
	private static MemberDao single;

	private MemberDao() {
	}

	public static MemberDao getInstance() {
		if (single == null) {
			single = new MemberDao();
		}
		return single;
	}
	
	public boolean isEmail(String email) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email ");
			sql.append("FROM member ");
			sql.append("WHERE m_email = ?");
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, email );
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				isSuccess = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}
		return isSuccess;
	}
	public boolean insert(MemberDto m) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		int index = 1;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO member(m_email,m_name,m_pwd,m_phone,m_regdate) ");
			sql.append(" VALUES (?,?,PASSWORD(?), ?,NOW())");
			
			pstmt = con.prepareStatement(sql.toString());
			//바인딩 변수 세팅
			pstmt.setString(index++, m.getEmail());
			pstmt.setString(index++, m.getName());
			pstmt.setString(index++, m.getPassword());
			pstmt.setString(index++, m.getPhone());
			
			pstmt.executeUpdate();
			isSuccess = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}		
		return isSuccess;
	}
	public boolean update(MemberDto m) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		int index = 1;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE member ");
			sql.append("m_name=?,  m_phone = ? ");
			sql.append("WHERE m_email = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			//바인딩 변수 세팅
			pstmt.setString(index++, m.getName());
			//pstmt.setString(index++, m.getPwd());
			pstmt.setString(index++, m.getPhone());
			pstmt.setString(index++, m.getEmail());
			
			pstmt.executeUpdate();
			isSuccess = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}		
		return isSuccess;
	}
	public boolean delete(String email) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		int index = 1;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM member WHERE m_email = ?");
			
			pstmt = con.prepareStatement(sql.toString());
			//바인딩 변수 세팅
			pstmt.setString(index++,email);
			
			pstmt.executeUpdate();
			isSuccess = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}		
		return isSuccess;
	}
	public MemberDto select(String email) {
		MemberDto obj = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int index = 1;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email,m_name, ");
			sql.append("m_phone, date_format(m_regdate,'%Y/%m/%d') ");
			sql.append("FROM member ");
			sql.append("WHERE m_email = ? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(index++, email);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 1;
				email = rs.getString(index++);
				String name = rs.getString(index++);
				String phone = rs.getString(index++);
				String regdate = rs.getString(index++);
				
				obj = new MemberDto(email,name,null,phone,regdate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}
		return obj;
	}
	public ArrayList<MemberDto> select(int start, int length){
		ArrayList<MemberDto> list = new ArrayList<MemberDto>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int index = 1;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email,m_name, ");
			sql.append("m_phone, date_format(m_regdate,'%Y/%m/%d') ");
			sql.append("FROM member ");
			sql.append("ORDER BY m_regdate DESC ");
			sql.append("LIMIT ?,?  ");
			pstmt = con.prepareStatement(sql.toString());
			//바인딩 변수 세팅
			pstmt.setInt(index++,start );
			pstmt.setInt(index++,length );
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				index = 1;
				String email = rs.getString(index++);
				String name = rs.getString(index++);
				String phone = rs.getString(index++);
				String regdate = rs.getString(index++);
				list.add(new MemberDto(email,name,null,phone,regdate));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}
		
		return list;
	}
	public int getTotalRows() {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int index = 1;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(m_email) FROM member");
			
			pstmt = con.prepareStatement(sql.toString());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 1;
				count = rs.getInt(index);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}
		return count;
	}
	
	public MemberDto getMember(MemberDto dto) {
		MemberDto memberDto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email,m_name,m_phone,date_format(m_regdate,'%Y/%m/%d') ");
			sql.append("FROM member ");
			sql.append("WHERE m_email =? AND m_pwd = PASSWORD(?) ");
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, dto.getEmail() );
			pstmt.setString(++index, dto.getPassword());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				index = 0;
				String email = rs.getString(++index);
				String name = rs.getString(++index);
				String phone = rs.getString(++index);
				String regdate = rs.getString(++index);
				memberDto = new MemberDto(email,name,null,phone,regdate);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e2) {
				// TODO: handle exception
			}
		}
		return memberDto;
		
	}
	
}