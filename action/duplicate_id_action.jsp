<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String userId = request.getParameter("userId");
    boolean isDuplicate = false;
    String result = "";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String dbDriver = "com.mysql.cj.jdbc.Driver";
    String dbUrl = "jdbc:mysql://localhost:3306/scheduler";
    String dbUsername = "hyun";
    String dbPassword = "12345";

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        String sql = "SELECT COUNT(*) FROM users WHERE account = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            isDuplicate = true;
        }

        result = isDuplicate ? "존재하는 아이디입니다." : "사용가능한 아이디입니다.";
    } catch (Exception e) {
        e.printStackTrace();
        result = "오류가 발생했습니다.";
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    boolean isAvailable = !isDuplicate;
%>
<!DOCTYPE html>
<html>
<head>
    <title>중복 체크 결과</title>
    <script>
        window.onload = function() {
            let result = "<%= result %>";
            let isAvailable = <%= isAvailable %>;
            window.opener.setResultId(result, isAvailable);
            window.close();
        };
    </script>
</head>
<body>
    <h1>중복 체크 중...</h1>
</body>
</html>
