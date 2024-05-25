<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 데이터베이스 연결 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스 작성 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- 데이터베이스 실행 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>
<%-- 테이블에서 가져온 값 저장 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    request.setCharacterEncoding("UTF-8"); 
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    boolean loggedIn = false;

    try {
     
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler", "hyun", "12345");

        String sql = "SELECT * FROM users WHERE account=? AND pw=?";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, account);
        query.setString(2, password);

        ResultSet result = query.executeQuery();

        if (result.next()) {
            loggedIn = true;
            session.setAttribute("userId", account);
        } 

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('데이터베이스 오류가 발생했습니다.');</script>");
        out.println("<script>location.href='login.jsp';</script>");
        return;
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다.');</script>");
        out.println("<script>location.href='login.jsp';</script>");
        return;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
<% if (loggedIn) { %>
    <script>
        location.href = "../JSP/main.jsp";
    </script>
<% } else { %>
    <script>
        alert("아이디와 비밀번호를 확인해주세요");
        location.href = "../index.html";
    </script>
<% } %>
</body>
