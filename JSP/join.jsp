<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler</title>
    <link rel="stylesheet" href="../css/join.css">
    <link rel="icon" href="../images/logo.jpg">
</head>
<body>
    <main>
        <h1 class="logo">  
            <img src="../images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>Scheduler</span>
        </h1>
        <form action="../action/join_action.jsp" method="post" class="join_form">
            <div class="join_title">
                <h2>새 계정 만들기</h2>
                <em>빠르고 쉽게 가입할 수 있습니다.</em>
            </div>
            <section class="first_section">
                <fieldset class="role_settings">
                    <legend>권한 부서 선택</legend>
                    <div class="first_box">
                      <div>
                          <img src="../images/authority.jpg"></img>
                          <span>권한</span>
                      </div>
                      <div class="radio_box">
                          <label>팀장</label>
                          <input type="radio" name="chk_author" value="1" required>
                      </div>
                    </div>
                    <div class="mid_box">
                      <div class="radio_box">
                          <label>팀원</label>
                          <input type="radio" name="chk_author" value="2" required>
                      </div>
                    </div>
                    <div class="end_box">
                      <div>
                          <img src="../images/department.png"></img>
                          <span>부서</span>
                      </div>
                      <div>
                        <select name="department" class="select_box" name="department">
                            <option value="1">기획팀</option>
                            <option value="2">디자인팀</option>
                        </select>
                      </div>
                    </div>
                  </fieldset>
                  <fieldset class="name_box">
                        <legend>성함 작성</legend>
                        <div class="title_box">
                            <label>성함</label>
                            <span>(20자 이내 , 영문 , 한글 사용가능)</span>
                        </div>
                        <input type="text" name="name" id="name_input" placeholder="이름 입력" pattern="^[a-zA-Z가-힣]+$" required>
                  </fieldset>
            </section>
            <section class="second_section">
                <fieldset class="id_box">
                    <legend>아이디 작성</legend>
                    <div class="title_box">
                        <label>아이디</label>
                        <span>(20자 이내 , 영문 숫자 사용가능)</span>
                        <span id="checkResult"></span>
                    </div>
                    <div class="content">
                        <input type="text" name="id" id="id_input" placeholder="아이디 입력" pattern="^[a-z0-9_]{0,20}$" required>
                        <button onclick="checkDuplicateId(event)">중복 체크</button>
                    </div>
                  
                </fieldset>
                <fieldset>
                    <legend>비밀번호 작성</legend>
                    <div class="name_box">
                        <div class="title_box">
                            <label>비밀번호</label>
                            <span>(20자 이내 ,영문 숫자 기호 사용가능)</span>
                        </div>
                        <input type="password" name="password" id="pw_input" placeholder="비밀번호 입력" required>
                    </div>
                </fieldset>
                <fieldset class="phone_number_box">
                    <legend>전화번호 작성</legend>
                    <div class="title_box">
                        <label>전화번호</label>
                        <span>(11자 이내 ,숫자 만 사용가능)</span>
                        <span id="phoneCheckResult"></span>
                    </div>
                     <div class="content">
                        <input type="text" name="phone_number" id="phone_number_input" placeholder="전화번호 입력" pattern="[0-9]{11}" required>
                        <button onclick="checkDuplicatePhoneNum(event)">중복 체크</button>
                    </div>
                </fieldset>
                <div class="submit_box">
                    <button type="submit" class="submit_button"> 가입하기</button>
                    <a href="../index.jsp">이미 가입이 되어있으신가요?</a>
                </div>
            </section>
        </form>
    </main>
    <script src="../js/join.js"></script>
    <script src="../js/duplicate_id.js"></script>
    <script src="../js/duplicate_phone_num.js"></script>
</body>
</html>
