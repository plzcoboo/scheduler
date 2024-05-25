<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler</title>
    <link rel="stylesheet" href="./css/index.css">
    <link rel="icon" href="./images/logo.jpg">
</head>
<body>
    <main>
        <h1 class="logo">  
            <img src="./images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>Scheduler</span>
        </h1>
        <form action="./action/login_action.jsp" class="login_form">
            <strong>Scheduler에 로그인</strong>
            <div class="login_input">
                <input type="text" name="account" placeholder="ID" class="id_input" pattern="^[a-z0-9_]{0,20}$" required>
                <input type="password" name="password" placeholder="Password" class="pw_input" required>
            </div>
            <button class="login_button" type="submit" onclick="return loginChk(event)">로그인</button>
            <div class="account_recovery">
                <a href="./html/find_user_id.html" class="find_id">아이디 찾기</a>
                <a href="./html/find_user_pw.html" class="find_pw">비밀번호 찾기</a>
            </div>
            <div class="divide_line">
                <span>or</span>
            </div>
            <button class="join_button" onclick="linkToJoin(event)">회원가입</button>
        </form>
    </main>
    <script src="./js/index.js"></script>
</body>
<script>
    // 세션에서 메시지를 읽어와서 alert로 표시
    const message = "<%= session.getAttribute("message") %>";

    if (message === "success") {
        alert('가입이 성공적으로 완료되었습니다.');
    } else if (message === "error") {
        alert('가입 중 오류가 발생했습니다. 다시 시도해주세요.');
    }

    // 메시지 출력 후 세션에서 제거
    <% session.removeAttribute("message"); %>
</script>
</html>