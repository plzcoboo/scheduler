<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    HttpSession userAccount = request.getSession();
    String currentUser = (String) userAccount.getAttribute("userId");

    if (currentUser == null) {
        out.println("<script>alert('로그인 해주시기 바랍니다.'); location.href='../index.html';</script>");
        return;
    }

    String scheduleId = request.getParameter("id");

    if (scheduleId == null) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='../JSP/main.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement editQuery = null;
    ResultSet rs = null;
    String dateInput = "";
    String hour = "";
    String minute = "";
    String content = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "hyun", "12345");

        String sql = "SELECT date, event_time, content FROM schedule WHERE idx = ?";
        editQuery = conn.prepareStatement(sql);
        editQuery.setString(1, scheduleId);
        rs = editQuery.executeQuery();

        if (rs.next()) {
            dateInput = rs.getString("date");
            String[] timeParts = rs.getString("event_time").split(":");
            hour = timeParts[0];
            minute = timeParts[1];
            content = rs.getString("content");
        } else {
            out.println("<script>alert('일정을 찾을 수 없습니다.'); location.href='../JSP/main.jsp';</script>");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        String errorMessage = e.getMessage().replace("\\", "\\\\").replace("\"", "\\\"").replace("\'", "\\\'").replace("\n", "\\n").replace("\r", "\\r");
        out.println("<script>alert('데이터 로드에 실패했습니다. " + errorMessage + "'); history.back();</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (editQuery != null) try { editQuery.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler</title>
    <link rel="stylesheet" href="../css/schedule_list_edit.css">
    <link rel="icon" href="../images/logo.jpg">
</head>
<body>
    <main>
        <h1 class="logo">
            <img src="../images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>Scheduler</span>
        </h1>
        <form action="../action/schedule_list_edit_action.jsp" method="post" class="schedul_list_edit_form">
            <input type="hidden" name="id" value="<%= scheduleId %>">
            <div class="join_title">
                <h2>일정을 수정하시겠습니까?</h2>
                <em>주어진 양식에 입력해주세요.</em>
            </div>
            <div class="second_section">
                <section class="schedul_date_box">
                    <div class="title_box">
                        <h3>일정 날짜</h3>
                        <span>(일정 날짜를 입력해주세요.)</span>
                    </div>
                    <input type="date" id="date" name="date" value="<%= dateInput %>" pattern="^\d{4}-\d{2}-\d{2}$">
                </section>
                <section class="schedul_time_box">
                    <div class="title_box">
                        <h3>일정 시간</h3>
                        <span>(일정 시간을 입력해주세요.)</span>
                    </div>
                    <div class="schedul_time">
                        <input type="text" name="hour" id="hour" value="<%= hour %>" pattern="^(0?[0-9]|1[0-9]|2[0-3])$" required>시
                        <input type="text" name="minute" id="minute" value="<%= minute %>" pattern="^[0-5]?[0-9]$" required>분
                    </div>
                </section>
                <section class="schedul_text_box">
                    <div class="title_box">
                        <h3>일정 내용</h3>
                        <span>(내용을 입력하세요.)</span>
                    </div>
                    <div class="schedul_text">
                        <textarea name="content" id="content" required><%= content %></textarea>
                    </div>
                </section>
                <div class="submit_box">
                    <button type="submit" class="submit_button"> 제출</button>
                    <a href="../JSP/main.jsp">목록으로 돌아가기</a>
                </div>
            </div>
        </form>
    </main>
    <script src="../js/schedul_list_edit.js"></script>
</body>
</html>
