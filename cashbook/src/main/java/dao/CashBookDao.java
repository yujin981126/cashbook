package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.RowSetInternal;

import vo.CashBook;

public class CashBookDao {

	// cashbookNo에 따른 상세 정보
	public List<Map<String, Object>> selectCashBookOne (int cashbookNo) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT"
				+ "		 	cashbook_no cashbookNo"
				+ "		 	,cash_date cashDate"
				+ "		 	,kind"
				+ "		 	,cash"
				+ "			,memo"
				+ "		 FROM cashbook"
				+ "		 WHERE cashbook_no=?";
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashbookNo);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("cashbookNo", rs.getInt("cashbookNo"));
				map.put("cashDate", rs.getString("cashDate"));
				map.put("kind", rs.getString("kind"));
				map.put("cash", rs.getInt("cash"));
				map.put("memo", rs.getString("memo"));
				list.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 달마다 데이터를 입력하는 매서드  
	public void insertCashbook(CashBook cashbook, List<String> hashtag) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
			conn.setAutoCommit(false); // 자동커밋을 해제
			
			String sql = "INSERT INTO cashbook(cash_date,kind,cash,memo,update_date,create_date)"
					+ " VALUES(?,?,?,?,NOW(),NOW())";
			
			// insert + select 방금생성된 행의 키값 ex) select 방금입력한 cashbook_no from cashbook;
			stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS); 
			stmt.setString(1, cashbook.getCashDate());
			stmt.setString(2, cashbook.getKind());
			stmt.setInt(3, cashbook.getCash());
			stmt.setString(4, cashbook.getMemo());
			stmt.executeUpdate(); // insert
			rs = stmt.getGeneratedKeys(); // select 방금입력한 cashbook_no from cashbook
			int cashbookNo = 0;
			if(rs.next()) {
				cashbookNo = rs.getInt(1);
			}
			
			// hashtag를 저장하는 코드
			PreparedStatement stmt2 = null;
			for(String h : hashtag) {
				String sql2 = "INSERT INTO hashtag(cashbook_no, tag, create_date) VALUES(?, ?, NOW())";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, cashbookNo);
				stmt2.setString(2, h);
				stmt2.executeUpdate();
			}
			
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 달력의 데이터를 달마다 보여주는 메서드 
	public List<Map<String, Object>> selectCashbookListByMonth(int y, int m) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		/*
		 SELECT 
		 	cashbook_no cashbookNo
		 	,DAY(cash_date) day
		 	,kind
		 	,cash
		 	,LEFT(memo, 5) memo
		 FROM cashbook
		 WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ?
		 ORDER BY DAY(cash_date) ASC
		 */
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT"
				+ "		 	cashbook_no cashbookNo"
				+ "		 	,DAY(cash_date) day"
				+ "		 	,kind"
				+ "		 	,cash"
				+ "			,LEFT(memo, 5) memo"
				+ "		 FROM cashbook"
				+ "		 WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ?"
				+ "		 ORDER BY DAY(cash_date) ASC,kind ASC";
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, y);
			stmt.setInt(2, m);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("cashbookNo", rs.getInt("cashbookNo"));
				map.put("day", rs.getInt("day"));
				map.put("kind", rs.getString("kind"));
				map.put("cash", rs.getInt("cash"));
				map.put("memo", rs.getString("memo"));
				list.add(map);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				stmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// cashbookNo에 따라 데이터를 삭제한 메서드
	public void deleteCashBook(int cashbookNo) {
		Connection conn = null;
		PreparedStatement hashStmt = null;
		PreparedStatement CashStmt = null;
		String hashSql = "DELETE FROM hashtag WHERE cashbook_no = ?";
		String CashSql = "DELETE FROM cashbook WHERE cashbook_no = ?";
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
			conn.setAutoCommit(false); // 자동커밋을 해제
			
			// hashtag 먼저 삭제 
			hashStmt = conn.prepareStatement(hashSql);
			hashStmt.setInt(1, cashbookNo);
			hashStmt.executeUpdate();

			// cashbook 삭제 
			CashStmt = conn.prepareStatement(CashSql);
			CashStmt.setInt(1, cashbookNo);
			CashStmt.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				hashStmt.close();
				CashStmt.close();
				conn.close();
			}catch(SQLException e) {
			e.printStackTrace();
			}
		}
	}
}