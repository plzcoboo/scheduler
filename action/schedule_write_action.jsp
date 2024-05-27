<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    // 세션에서 현재 사용자를 가져옵니다.
    HttpSession userAccount = request.getSession();
    String currentUser = (String) userAccount.getAttribute("userId");

    // 폼 데이터에서 값을 가져옵니다.
    String hour = request.getParameter("hour");
    String minute = request.getParameter("minute");
    String content = request.getParameter("content");
    String dateInput = request.getParameter("date");

    // 날짜와 시간 형식 설정
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate eventDate = LocalDate.parse(dateInput, dateFormatter);
    LocalDate currentDate = LocalDate.now();

    // 현재 날짜와 이벤트 날짜 비교
    if (eventDate.isBefore(currentDate)) {
        out.println("<script>alert('과거 날짜의 일정은 추가할 수 없습니다.'); history.back();</script>");
    } else {
        String event_time = (hour.length() == 1 ? "0" + hour : hour) + ":" + (minute.length() == 1 ? "0" + minute : minute) + ":00";

        Connection conn = null;
        PreparedStatement writeQuery = null;
        ResultSet rs = null;
        int userIdx = -1;

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "hyun", "12345");

            // currentUser를 사용하여 users 테이블에서 idx를 가져옵니다.
            String getUserIdxSql = "SELECT idx FROM users WHERE account = ?";
            writeQuery = conn.prepareStatement(getUserIdxSql);
            writeQuery.setString(1, currentUser);
            rs = writeQuery.executeQuery();

            if (rs.next()) {
                userIdx = rs.getInt("idx");
            } else {
                throw new Exception("사용자를 찾을 수 없습니다.");
            }

            // 기존 PreparedStatement와 ResultSet을 닫습니다.
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (writeQuery != null) try { writeQuery.close(); } catch (SQLException e) {}

            // SQL 쿼리를 준비하고 실행합니다.
            String sql = "INSERT INTO schedule (writer, content, date, event_time) VALUES (?, ?, ?, ?)";
            writeQuery = conn.prepareStatement(sql);
            writeQuery.setInt(1, userIdx);
            writeQuery.setString(2, content);
            writeQuery.setString(3, dateInput);
            writeQuery.setString(4, event_time);
            writeQuery.executeUpdate();

            // 성공 메시지를 출력하고 메인 페이지로 이동합니다.
            out.println("<script>alert('일정이 성공적으로 추가되었습니다.'); location.href='../JSP/main.jsp';</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('일정 추가에 실패했습니다. 다시 시도해 주세요.'); history.back();</script>");
        } finally {
            // 리소스를 해제합니다.
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (writeQuery != null) try { writeQuery.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }
%>
