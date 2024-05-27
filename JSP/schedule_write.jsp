<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%  
HttpSession userAccount = request.getSession();
String currentUser = (String) userAccount.getAttribute("userId"); 
%>

<% if (currentUser != null ) { %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler</title>
    <link rel="stylesheet" href="../css/schedule_write.css">
    <link rel="icon" href="../images/logo.jpg">
</head>
<body>
    <main>
        <h1 class="logo">  
            <img src="../images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>Scheduler</span>
        </h1>
            <form id="scheduleForm" class="schedule_write_form" action="../action/schedule_write_action.jsp" method="post">
            <div class="join_title">
                <h2>일정을 쓰시겠습니까?</h2>
                <em>주어진 양식에 입력해주세요.</em>
            </div>
            <div class="second_section">
                <section class="schedul_date_box">
                    <div class="title_box">
                        <h3>일정 날짜</h3>
                        <span>(일정 날짜를 입력해주세요.)</span>
                    </div>
                    <%-- <div class="schedul_date">
                        <input type="text" name="year" id="year" pattern="\d{4}" required>년
                        <input type="text" name="month" id="month" pattern="^(0?[1-9]|1[0-2])$" required>월
                        <input type="text" name="day" id="day" pattern="^(0?[1-9]|[12][0-9]|3[01])$" required>일
                    </div> --%>
                    <input type="date" id="date" name="date" value="" pattern="^\d{4}-\d{2}-\d{2}$">
                </section>
                <section class="schedul_time_box">
                    <div class="title_box">
                        <h3>일정 시간</h3>
                        <span>(일정 시간을 입력해주세요.)</span>
                    </div>
                    <div class="schedul_time">
                        <input type="text" name="hour" id="hour" pattern="^(0?[0-9]|1[0-9]|2[0-3])$" required>시
                        <input type="text" name="minute" id="minute" pattern="^[0-5]?[0-9]$" required>분
                    </div>
                </section>
                <section class="schedul_text_box">
                    <div class="title_box">
                        <h3>일정 내용</h3>
                        <span>(내용을 입력하세요.)</span>
                    </div>
                    <div class="schedul_text">
                        <textarea name="content" id="content" required></textarea>
                    </div>
                </section>
                <div class="submit_box">
                    <button type="submit" class="submit_button" onclick="return checkForm(event)"> 제출</button>
                    <a href="../JSP/main.jsp">목록으로 돌아가기</a>
                </div>
            </div>
        </form>
    </main>
    <script src="../js/schedul_write.js"></script>
</body>
<% } else { %> 
<script>
alert('로그인 해주시기 바랍니다.');
location.href = "../index.html";
</script>
<% } %>
