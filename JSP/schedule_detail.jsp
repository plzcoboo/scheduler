<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    HttpSession userAccount = request.getSession();
    String currentUser = (String) userAccount.getAttribute("userId");

    String dateParam = request.getParameter("date");
    String roleParam = request.getParameter("role");

    StringBuilder scheduleJsonBuilder = new StringBuilder("[");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

    if (currentUser != null && dateParam != null && roleParam != null) {
        Connection conn = null;
        PreparedStatement detailQuery = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "hyun", "12345");

            String sql = "SELECT schedule.idx, departments.name AS department_name, users.name AS user_name, schedule.content, schedule.date, schedule.event_time " +
                         "FROM schedule " +
                         "JOIN users ON schedule.writer = users.idx " +
                         "JOIN departments ON users.department_idx = departments.idx " +
                         "WHERE schedule.date = ? AND users.role_idx = ?";

            detailQuery = conn.prepareStatement(sql);
            detailQuery.setString(1, dateParam);
            detailQuery.setInt(2, Integer.parseInt(roleParam));

            rs = detailQuery.executeQuery();

            while (rs.next()) {
                if (scheduleJsonBuilder.length() > 1) {
                    scheduleJsonBuilder.append(",");
                }
                scheduleJsonBuilder.append("{");
                scheduleJsonBuilder.append("\"idx\":").append(rs.getInt("idx")).append(",");
                scheduleJsonBuilder.append("\"department_name\":\"").append(rs.getString("department_name")).append("\",");
                scheduleJsonBuilder.append("\"user_name\":\"").append(rs.getString("user_name")).append("\",");
                scheduleJsonBuilder.append("\"content\":\"").append(rs.getString("content")).append("\",");
                scheduleJsonBuilder.append("\"date\":\"").append(dateFormat.format(rs.getDate("date"))).append("\",");
                scheduleJsonBuilder.append("\"event_time\":\"").append(timeFormat.format(rs.getTime("event_time"))).append("\"");
                scheduleJsonBuilder.append("}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류가 발생했습니다. 관리자에게 문의하세요.'); history.back();</script>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (detailQuery != null) try { detailQuery.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    } else {
        out.println("<script>alert('유효하지 않은 접근입니다.'); location.href = '../index.jsp';</script>");
    }

    scheduleJsonBuilder.append("]");
    String scheduleJson = scheduleJsonBuilder.toString();
%>

<% if (currentUser != null && dateParam != null && roleParam != null) { %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <title>스케줄러</title>
    <link rel="stylesheet" href="../css/schedule_detail.css">
    <link rel="icon" href="../images/logo.jpg">
    <style>
        .hide {
            display: none;
        }
    </style>
</head>
<body>
    <main>
        <h1 class="logo">
            <img src="../images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>스케줄러</span>
        </h1>
        <div class="detail_form">
            <div class="detail_title">
                <h2><%= dateParam %> 일정 목록</h2>
            </div>
            <div class="first_section">
                <div class="title_box">
                    <h3>일정 목록</h3>
                    <span id="scheduleCount">0</span>
                </div>
            </div>
            <div class="second_section">
                <ul id="scheduleList">
                </ul>
                <div class="submit_box">
                    <a href="../JSP/main.jsp">목록으로 돌아가기</a>
                </div>
            </div>
        </div>
    </main>
    <script>
        const scheduleData = <%= scheduleJson %>;
    </script>
    <script src="../js/schedule_detail.js"> </script>
</body>
</html>
<% } %>
