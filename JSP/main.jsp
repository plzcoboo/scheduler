<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
Calendar cal = Calendar.getInstance();
int currentYear = cal.get(Calendar.YEAR);
int currentMonth = cal.get(Calendar.MONTH) + 1;

HttpSession userAccount = request.getSession();
String currentUser = (String) userAccount.getAttribute("userId");

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/scheduler","hyun","12345");

String findProfileSql = " SELECT departments.name AS department_name, users.name AS user_name, roles.name AS role_name " + 
                        " FROM users " +
                        " INNER JOIN departments ON users.department_idx = departments.idx " +
                        " INNER JOIN roles ON users.role_idx = roles.idx " +
                        " WHERE users.account = ? ";

PreparedStatement findProfileQuery = connect.prepareStatement(findProfileSql);
findProfileQuery.setString(1, currentUser);
ResultSet result = findProfileQuery.executeQuery();

String departmentName = null;
String userName = null;
String roleName = null;

if (result.next()) {
    departmentName = result.getString("department_name");
    userName = result.getString("user_name");
    roleName = result.getString("role_name");
}

String scheduleSql = "SELECT date, " +
                     "SUM(CASE WHEN users.role_idx = 1 THEN 1 ELSE 0 END) AS leader_count, " +
                     "SUM(CASE WHEN users.role_idx = 2 THEN 1 ELSE 0 END) AS member_count " +
                     "FROM schedule " +
                     "JOIN users ON schedule.writer = users.idx " +
                     "GROUP BY date";

PreparedStatement scheduleQuery = connect.prepareStatement(scheduleSql);
ResultSet scheduleResult = scheduleQuery.executeQuery();

StringBuilder scheduleJsonBuilder = new StringBuilder("[");
while (scheduleResult.next()) {
    if (scheduleJsonBuilder.length() > 1) {
        scheduleJsonBuilder.append(",");
    }
    scheduleJsonBuilder.append("{");
    scheduleJsonBuilder.append("\"date\":\"").append(scheduleResult.getString("date")).append("\",");
    scheduleJsonBuilder.append("\"leader_count\":").append(scheduleResult.getInt("leader_count")).append(",");
    scheduleJsonBuilder.append("\"member_count\":").append(scheduleResult.getInt("member_count"));
    scheduleJsonBuilder.append("}");
}
scheduleJsonBuilder.append("]");
String scheduleJson = scheduleJsonBuilder.toString();

connect.close();
%>

<% if (currentUser != null) { %> 
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler</title>
    <link rel="stylesheet" href="../css/main.css">
    <link rel="icon" href="../images/logo.jpg">
</head>
<body>
    <main>
        <h1 class="logo">  
            <img src="../images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>Scheduler</span>
        </h1>
        <nav>
            <div class="change_year">
                <button id="prevYearBtn"><</button>
                <span class="year"><%= currentYear %></span>
                <button id="nextYearBtn">></button>
            </div>
            <div class="show_schedul">
             <% if ("팀장".equals(roleName)) { %>
                   <button>팀원 일정보기</button>
             <% } %>
            </div>
            <select class="monthSelect" onchange="changeMonth()">
                <option value="1">1월</option>
                <option value="2">2월</option>
                <option value="3">3월</option>
                <option value="4">4월</option>
                <option value="5">5월</option>
                <option value="6">6월</option>
                <option value="7">7월</option>
                <option value="8">8월</option>
                <option value="9">9월</option>
                <option value="10">10월</option>
                <option value="11">11월</option>
                <option value="12">12월</option>
            </select>
            <div class="profile">
                <span>부서 : <%= departmentName %> </span>
                <span>직책 : <%= roleName %></span>
            </div>
            <div class="hello">
                <span><%= userName %>님 반갑습니다.</span>
            </div>
            <div class="write_schedul">
                <button onclick="clickWriteEvent(event)">일정쓰기</button>
            </div>
        </nav>
        <article class="board">
            <table>
                <thead>
                    <tr>
                        <th class="sun">일</th>
                        <th>월</th>
                        <th>화</th>
                        <th>수</th>
                        <th>목</th>
                        <th>금</th>
                        <th class="sat">토</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </article>
        <form action="../action/logout_action.jsp" class="logout_form">
        <button class="logout">로그아웃</button>
        </form>
    </main>
    <script src="../js/main.js"></script>
    <script>
    console.log(<%= scheduleJson %>)
    let currentYear = <%= currentYear %>;
    let currentMonth = <%= currentMonth %>;
    let scheduleList = <%= scheduleJson %>;
    
    updateCalendar(currentYear, currentMonth, scheduleList);
    
    </script>
</body>
<% } else { %> 
<script>
alert('로그인 해주시기 바랍니다.')
location.href = "../index.jsp";
</script>
<% } %>
