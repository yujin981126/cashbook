package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


public class HashtagDao {
	
	// 태그 사용 순위 메서드
	public List<Map<String,Object>> selectTagRankList() {
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			/*
			 	SELECT t.tag, t.cnt, RANK() over(ORDER BY t.cnt DESC) ranking
				FROM 
				(SELECT tag, COUNT(*) cnt
				FROM hashtag
				GROUP BY tag) t
			 */
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
			String sql = "SELECT t.tag, t.cnt, RANK() over(ORDER BY t.cnt DESC) rank"
					+ "				FROM"
					+ "				(SELECT tag, COUNT(*) cnt"
					+ "				FROM hashtag"
					+ "				GROUP BY tag) t";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("tag", rs.getString("tag"));
				map.put("cnt", rs.getInt("t.cnt"));
				map.put("rank", rs.getInt("rank"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// kind별 태그 사용 순위 메서드
	public List<Map<String,Object>> selectKindTagRankList(String kind) {
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			/*
			 	SELECT t.kind, t.tag, t.cnt, RANK() over(ORDER BY t.cnt DESC) ranking
				FROM 
				(SELECT c.kind, h.tag, COUNT(*) cnt
				FROM hashtag h
				INNER JOIN cashbook c
				ON h.cashbook_no = c.cashbook_no
				WHERE c.kind = ?
				GROUP BY tag)t
			 */
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
			String sql = "SELECT t.kind, t.tag, t.cnt, RANK() over(ORDER BY t.cnt DESC) rank"
					+ "				FROM "
					+ "				(SELECT c.kind, h.tag, COUNT(*) cnt"
					+ "				FROM hashtag h"
					+ "				INNER JOIN cashbook c"
					+ "				ON h.cashbook_no = c.cashbook_no"
					+ "				WHERE c.kind = ? "
					+ "				GROUP BY tag)t";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, kind);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("kind", rs.getString("kind"));
				map.put("tag", rs.getString("tag"));
				map.put("cnt", rs.getInt("t.cnt"));
				map.put("rank", rs.getInt("rank"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 날짜별 태그 사용 순위 메서드
	public List<Map<String,Object>> selectDateTagRankList(String cashDate) {
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			/*
			 	SELECT t.cash_date, t.tag, t.cnt, RANK() over(ORDER BY t.cnt DESC) ranking
				FROM 
				(SELECT c.cash_date, h.tag, COUNT(*) cnt
				FROM hashtag h
				INNER JOIN cashbook c
				ON h.cashbook_no = c.cashbook_no
				WHERE c.cash_date = ?
				GROUP BY tag)t
			 */
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
			String sql = "SELECT t.cash_date cashDate, t.tag, t.cnt, RANK() over(ORDER BY t.cnt DESC) rank"
					+ "				FROM"
					+ "				(SELECT c.cash_date, h.tag, COUNT(*) cnt"
					+ "				FROM hashtag h"
					+ "				INNER JOIN cashbook c"
					+ "				ON h.cashbook_no = c.cashbook_no"
					+ "				WHERE c.cash_date = ?"
					+ "				GROUP BY tag)t";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cashDate);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("cashDate", rs.getString("cashDate"));
				map.put("tag", rs.getString("tag"));
				map.put("cnt", rs.getInt("t.cnt"));
				map.put("rank", rs.getInt("rank"));
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// 태그 상세보기 메서드 
		public List<Map<String,Object>> selectTagOneList(String tag) {
			List<Map<String,Object>> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				/*
				 	SELECT h.tag,c.cash_date cashDate,c.kind, c.cash,c.memo
				FROM hashtag h
				INNER JOIN cashbook c
				ON h.cashbook_no = c.cashbook_no
				WHERE h.tag = ?
				ORDER BY c.cash_date desc
				 */
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
				String sql = "SELECT h.tag tag,c.cash_date cashDate,c.kind kind, c.cash cash ,c.memo memo"
						+ "				FROM hashtag h"
						+ "				INNER JOIN cashbook c"
						+ "				ON h.cashbook_no = c.cashbook_no"
						+ "				WHERE h.tag = ?"
						+ "				ORDER BY c.cash_date desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, tag);
				rs = stmt.executeQuery();
				while(rs.next()) {
					Map<String, Object> map = new HashMap<>();
					map.put("tag", rs.getString("tag"));
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
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return list;
		}
}