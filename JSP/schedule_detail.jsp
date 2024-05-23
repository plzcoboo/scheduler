<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler</title>
    <link rel="stylesheet" href="../css/schedule_detail.css">
    <link rel="icon" href="../images/logo.jpg">
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <style>
        .hide {
            display: none;
        }
    </style>
</head>
<body>
    <main>
        <h1 class="logo">  
            <img src="../images/logo.jpg" alt="logo_icon" class="logo_img">
            <span>Scheduler</span>
        </h1>
        <form action="" class="detail_form">
            <div class="detail_title">
                <h2>2023년 03월 22일 일정 목록</h2>
            </div>
            <div class="first_section">
                <div class="title_box">
                    <h3>일정목록</h3>
                    <span>3</span>
                </div>
            </div>
            <div class="second_section">
                <ul>
                    <li class="schedul-list">
                        <i class="xi-calendar-check"></i>
                        <div class="content">
                            <span>결제 상신하기</span>
                            <span class="year_month_date_time"><i class="xi-view-day"></i>2023년3월22일 04시00분</span>
                        </div>
                        <button class="show" onclick="showProfileClickEvent(event, this)"><i class="xi-profile"></i></button>
                        <div class="block"></div>
                        <div class="hide">
                            <span>디자인팀</span>
                            <span>성함:안녕하세요</span>
                        </div>
                        <button class="edit" onclick="clickSchedulEditEvent(event)">수정</button>
                        <button class="del" type="submit">삭제</button>
                    </li>
                    <li class="schedul-list">
                        <i class="xi-calendar-check"></i>
                        <div class="content">
                            <span>결제 상신하기</span>
                            <span class="year_month_date_time"><i class="xi-view-day"></i>2023년3월22일 04시00분</span>
                        </div>
                        <button class="show" onclick="showProfileClickEvent(event, this)"><i class="xi-profile"></i></button>
                        <div class="block"></div>
                        <div class="hide">
                            <span>디자인팀</span>
                            <span>성함:안녕하세요</span>
                        </div>
                        <button class="edit" onclick="clickSchedulEditEvent(event)">수정</button>
                        <button class="del" type="submit">삭제</button>
                    </li>
                    <li class="schedul-list">
                        <i class="xi-calendar-check"></i>
                        <div class="content">
                            <span>결제 상신하기</span>
                            <span class="year_month_date_time"><i class="xi-view-day"></i>2023년3월22일 04시00분</span>
                        </div>
                        <button class="show" onclick="showProfileClickEvent(event, this)"><i class="xi-profile"></i></button>
                        <div class="block"></div>
                        <div class="hide">
                            <span>디자인팀</span>
                            <span>성함:안녕하세요</span>
                        </div>
                        <button class="edit" onclick="clickSchedulEditEvent(event)">수정</button>
                        <button class="del" type="submit">삭제</button>
                    </li>
                    <li class="schedul-list">
                        <i class="xi-calendar-check"></i>
                        <div class="content">
                            <span>결제 상신하기</span>
                            <span class="year_month_date_time"><i class="xi-view-day"></i>2023년3월22일 04시00분</span>
                        </div>
                        <button class="show" onclick="showProfileClickEvent(event, this)"><i class="xi-profile"></i></button>
                        <div class="block"></div>
                        <div class="hide">
                            <span>디자인팀</span>
                            <span>성함:안녕하세요</span>
                        </div>
                        <button class="edit" onclick="clickSchedulEditEvent(event)">수정</button>
                        <button class="del" type="submit">삭제</button>
                    </li>
                    <li class="schedul-list">
                        <i class="xi-calendar-check"></i>
                        <div class="content">
                            <span>결제 상신하기</span>
                            <span class="year_month_date_time"><i class="xi-view-day"></i>2023년3월22일 04시00분</span>
                        </div>
                        <button class="show" onclick="showProfileClickEvent(event, this)"><i class="xi-profile"></i></button>
                        <div class="block"></div>
                        <div class="hide">
                            <span>디자인팀</span>
                            <span>성함:안녕하세요</span>
                        </div>
                        <button class="edit" onclick="clickSchedulEditEvent(event)">수정</button>
                        <button class="del" type="submit">삭제</button>
                    </li>
                    <li class="schedul-list">
                        <i class="xi-calendar-check"></i>
                        <div class="content">
                            <span>결제 상신하기</span>
                            <span class="year_month_date_time"><i class="xi-view-day"></i>2023년3월22일 04시00분</span>
                        </div>
                        <button class="show" onclick="showProfileClickEvent(event, this)"><i class="xi-profile"></i></button>
                        <div class="block"></div>
                        <div class="hide">
                            <span>디자인팀</span>
                            <span>성함:안녕하세요</span>
                        </div>
                        <button class="edit" onclick="clickSchedulEditEvent(event)">수정</button>
                        <button class="del" type="submit">삭제</button>
                    </li>
                </ul>
                <div class="submit_box">
                    <a href="../JSP/main.jsp">목록으로 돌아가기</a>
                </div>
            </div>
        </form>
    </main>
    <script>
        let schedulEdit = "../html/schedul_list_edit.html";

        function showProfileClickEvent (e, btn) {
            e.preventDefault();
            console.log(btn.closest('.schedul-list'))
            let listItem = btn.closest('.schedul-list');
            let showButton = listItem.querySelector('.show');
            let hideDiv = listItem.querySelector('.hide');
            let block = listItem.querySelector('.block')

            showButton.style.display = 'none';
            block.style.display = 'block';
            hideDiv.style.display = 'flex';
        }

        function clickSchedulEditEvent(e) {
            e.preventDefault();
            location.href = schedulEdit;
        }
    </script>
</body>