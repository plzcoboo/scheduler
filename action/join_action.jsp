<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // 요청 문자 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // POST 요청인지와 필수 파라미터가 모두 존재하는지 확인
    if ("POST".equalsIgnoreCase(request.getMethod()) &&
        request.getParameter("chk_author") != null &&
        request.getParameter("department") != null &&
        request.getParameter("name") != null &&
        request.getParameter("phone_number") != null && 
        request.getParameter("password") != null && 
        request.getParameter("id") != null ) {

        // 데이터베이스 연결 매개변수
        String dbURL = "jdbc:mysql://localhost:3306/scheduler";
        String dbUser = "hyun";
        String dbPassword = "12345";

        // 폼 데이터 가져오기
        String role = request.getParameter("chk_author");
        String department = request.getParameter("department");
        String account = request.getParameter("id");
        String name = request.getParameter("name");
        String pw = request.getParameter("password");
        String phoneNumber = request.getParameter("phone_number");

        int roleIdx = Integer.parseInt(role);
        int departmentIdx = Integer.parseInt(department);
        
        Connection conn = null;
        PreparedStatement inputQuery = null;
        HttpSession joinSession = request.getSession(); // 세션 객체 선언

        try {
            // 데이터베이스 연결 설정
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // SQL 쿼리 준비
            String sql = "INSERT INTO users (account, name, pw, phone_number, department_idx, role_idx) VALUES (?, ?, ?, ?, ?, ?)";
            inputQuery = conn.prepareStatement(sql);
            inputQuery.setString(1, account);
            inputQuery.setString(2, name);
            inputQuery.setString(3, pw);
            inputQuery.setString(4, phoneNumber);
            inputQuery.setInt(5, departmentIdx);
            inputQuery.setInt(6, roleIdx);

            // 쿼리 실행
            int result = inputQuery.executeUpdate();

            if (result > 0) {
                // 가입 성공
                joinSession.setAttribute("message", "success");
            } else {
                // 가입 실패
                joinSession.setAttribute("message", "error");
            }

            response.sendRedirect("../index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // 오류 처리
            joinSession.setAttribute("message", "error");
            response.sendRedirect("../index.jsp");
        } finally {
            try {
                if (inputQuery != null) inputQuery.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    } else {
        // 필수 폼 데이터가 없으면 index 페이지로 리다이렉트
        response.sendRedirect("../index.jsp");
    }
%>
