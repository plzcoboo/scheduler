<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    HttpSession userAccount = request.getSession();
    String currentUser = (String) userAccount.getAttribute("userId");

    if (currentUser == null) {
        out.println("<script>alert('로그인 해주시기 바랍니다.'); location.href='../index.html';</script>");
        return;
    }

    String scheduleId = request.getParameter("id");

    Connection conn = null;
    PreparedStatement delQuery = null;
    ResultSet rs = null;
    int currentUserId = -1;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "hyun", "12345");

        // 현재 사용자의 idx를 가져옴
        String userSql = "SELECT idx FROM users WHERE account = ?";
        delQuery = conn.prepareStatement(userSql);
        delQuery.setString(1, currentUser);
        rs = delQuery.executeQuery();

        if (rs.next()) {
            currentUserId = rs.getInt("idx");
        } else {
            out.println("<script>alert('사용자를 찾을 수 없습니다.'); location.href='../index.html';</script>");
            return;
        }

        // 일정 작성자를 확인
        String checkSql = "SELECT writer FROM schedule WHERE idx = ?";
        delQuery = conn.prepareStatement(checkSql);
        delQuery.setString(1, scheduleId);
        rs = delQuery.executeQuery();

        if (rs.next()) {
            int writerId = rs.getInt("writer");

            if (currentUserId != writerId) {
                out.println("<script>alert('삭제 권한이 없습니다.'); location.href='../JSP/main.jsp';</script>");
                return;
            }
        } else {
            out.println("<script>alert('일정을 찾을 수 없습니다.'); location.href='../JSP/main.jsp';</script>");
            return;
        }

        // 리소스 해제 후 삭제 처리
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (delQuery != null) try { delQuery.close(); } catch (SQLException e) {}

        String deleteSql = "DELETE FROM schedule WHERE idx = ?";
        delQuery = conn.prepareStatement(deleteSql);
        delQuery.setString(1, scheduleId);
        int deleted = delQuery.executeUpdate();

        if (deleted > 0) {
            out.println("<script>alert('일정이 성공적으로 삭제되었습니다.'); location.href='../JSP/main.jsp';</script>");
        } else {
            out.println("<script>alert('일정 삭제에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        String errorMessage = e.getMessage().replace("\\", "\\\\").replace("\"", "\\\"").replace("\'", "\\\'").replace("\n", "\\n").replace("\r", "\\r");
        out.println("<script>alert('데이터베이스 오류가 발생했습니다. " + errorMessage + "'); history.back();</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (delQuery != null) try { delQuery.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
