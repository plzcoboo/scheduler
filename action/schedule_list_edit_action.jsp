<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String scheduleId = request.getParameter("id");
    String dateInput = request.getParameter("date");
    String hour = request.getParameter("hour");
    String minute = request.getParameter("minute");
    String content = request.getParameter("content");
    String event_time = (hour.length() == 1 ? "0" + hour : hour) + ":" + (minute.length() == 1 ? "0" + minute : minute) + ":00";

    Connection conn = null;
    PreparedStatement editQuery = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "hyun", "12345");

        String sql = "UPDATE schedule SET date = ?, event_time = ?, content = ? WHERE idx = ?";
        editQuery = conn.prepareStatement(sql);
        editQuery.setString(1, dateInput);
        editQuery.setString(2, event_time);
        editQuery.setString(3, content);
        editQuery.setString(4, scheduleId);
        int updated = editQuery.executeUpdate();

        if (updated > 0) {
            out.println("<script>alert('일정이 성공적으로 수정되었습니다.'); location.href='../JSP/main.jsp';</script>");
        } else {
            out.println("<script>alert('일정 수정에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        String errorMessage = e.getMessage().replace("\\", "\\\\").replace("\"", "\\\"").replace("\'", "\\\'").replace("\n", "\\n").replace("\r", "\\r");
        out.println("<script>alert('데이터베이스 오류가 발생했습니다. " + errorMessage + "'); history.back();</script>");
    } finally {
        if (editQuery != null) try { editQuery.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
