<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String phoneNumber = request.getParameter("phoneNumber");
    boolean isDuplicate = false;
    String result = "";

    Connection conn = null;
    PreparedStatement inputQuery = null;
    ResultSet rs = null;

    String dbDriver = "com.mysql.cj.jdbc.Driver";
    String dbUrl = "jdbc:mysql://localhost:3306/scheduler";
    String dbUsername = "hyun";
    String dbPassword = "12345";

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        String sql = "SELECT COUNT(*) FROM users WHERE phone_number = ?";
        inputQuery = conn.prepareStatement(sql);
        inputQuery.setString(1, phoneNumber);
        rs = inputQuery.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            isDuplicate = true;
        }

        result = isDuplicate ? "중복된 전화번호입니다." : "사용가능한 전화번호입니다.";
    } catch (Exception e) {
        e.printStackTrace();
        result = "오류가 발생했습니다.";
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (inputQuery != null) try { inputQuery.close(); } catch (SQLException e) { e.printStackTrace(); }
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
            var result = "<%= result %>";
            var isAvailable = <%= isAvailable %>;
            window.opener.setResultPhoneNum(result, isAvailable);
            window.close();
        };
    </script>
</head>
<body>
    <h1>중복 체크 중...</h1>
</body>
</html>
