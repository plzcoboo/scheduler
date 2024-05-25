<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 결과 메시지를 저장할 변수 선언
    String message = "";

    // 요청 방식이 POST인지 확인하고, 필수 폼 데이터가 있는지 확인
    if ("POST".equalsIgnoreCase(request.getMethod()) &&
        request.getParameter("chk_author") != null &&
        request.getParameter("department") != null &&
        request.getParameter("name") != null &&
        request.getParameter("phone_number") != null) {

        // 폼 데이터 받기
        String role = request.getParameter("chk_author");
        String department = request.getParameter("department");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone_number");

        // role과 department의 인덱스 값을 변환
        int roleIdx = Integer.parseInt(role);
        int departmentIdx = Integer.parseInt(department);

        // 데이터베이스 연결 정보
        String url = "jdbc:mysql://localhost:3306/scheduler";
        String user = "hyun"; // DB 사용자명 입력
        String password = "12345"; // DB 비밀번호 입력
        Connection conn = null;
        PreparedStatement inputQuery = null;
        ResultSet rs = null;

        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 데이터베이스 연결
            conn = DriverManager.getConnection(url, user, password);
            // SQL 쿼리 작성
            String findIdSql = "SELECT account FROM users WHERE role_idx = ? AND department_idx = ? AND name = ? AND phone_number = ?";
            inputQuery = conn.prepareStatement(findIdSql);
            inputQuery.setInt(1, roleIdx);
            inputQuery.setInt(2, departmentIdx);
            inputQuery.setString(3, name);
            inputQuery.setString(4, phoneNumber);
            // 쿼리 실행
            rs = inputQuery.executeQuery();
            if (rs.next()) {
                String userId = rs.getString("account");
                message = "귀하의 아이디는: " + userId + "입니다.";
            } else {
                message = "일치하는 사용자 아이디가 없습니다.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "오류가 발생했습니다. 나중에 다시 시도해주세요.";
        } finally {
            // 리소스 해제
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (inputQuery != null) try { inputQuery.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    } else {
        // 필수 폼 데이터가 없으면 index 페이지로 리다이렉트
        response.sendRedirect("../index.jsp");
        return; // 더 이상의 처리를 막기 위해 return
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 결과</title>
    <link rel="stylesheet" href="../css/find_user_id.css">
</head>
<body>
    <main>
        <h1 class="logo">
            <img src="../images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>Scheduler</span>
        </h1>
        <section>
            <div class="join_title">
                <h2>아이디 찾기 결과</h2>
            </div>
            <div>
                <p><%= message %></p>
            </div>
            <div class="submit_box">
                <a href="../index.jsp">로그인 페이지로 돌아가기</a>
            </div>
        </section>
    </main>
</body>
</html>
