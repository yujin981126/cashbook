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
			conn = DriverManager.getConnection("jdbc:mariadb://3.39.153.13:3306/cashbook","root","mariadb1234");
			String sql = "SELECT t.tag, t.cnt, RANK() over(ORDER BY t.cnt DESC) rank "
					+ "									FROM "
					+ "					 			(SELECT tag, COUNT(*) cnt "
					+ "									FROM hashtag "
					+ "									GROUP BY tag "
					+ "									LIMIT 0,10 ) t "
					+ "									WHERE cnt > 10 ";
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
	public List<Map<String,Object>> selectTagRankList(String kind,String beginDate,String endDate) {
		List<Map<String,Object>> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {

			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://3.39.153.13:3306/cashbook","root","mariadb1234");
			String sql = "SELECT t.kind, t.tag,t.cash, t.cnt, RANK() over(ORDER BY t.cnt DESC) rank,t.cash_date cashDate"
					+ "								FROM "
					+ "								(SELECT c.kind,c.cash, h.tag, COUNT(*) cnt,c.cash_date"
					+ "								FROM hashtag h "
					+ "							INNER JOIN cashbook c "
					+ "								ON h.cashbook_no = c.cashbook_no"
					+ "								WHERE c.kind like ?  AND c.cash_date BETWEEN STR_TO_DATE(?,'%Y-%m-%d')  AND STR_TO_DATE(?,'%Y-%m-%d') "
					+ "								GROUP BY tag)t";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, kind);
			stmt.setString(2, beginDate);
			stmt.setString(3, endDate);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("kind", rs.getString("kind"));
				map.put("tag", rs.getString("tag"));
				map.put("cnt", rs.getInt("t.cnt"));
				map.put("cash", rs.getInt("cash"));
				map.put("rank", rs.getInt("rank"));
				map.put("cashDate", rs.getString("cashDate"));
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
				conn = DriverManager.getConnection("jdbc:mariadb://3.39.153.13:3306/cashbook","root","mariadb1234");
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