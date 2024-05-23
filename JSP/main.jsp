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
                <span class="year">2024</span>
                <button id="nextYearBtn">></button>
            </div>
            <div class="show_schedul">
                <button>팀원 일정보기</button>
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
                <span>부서 : 디자인팀</span>
                <span>직책 : 팀장</span>
            </div>
            <div class="hello">
                <span>홍길동님 반갑습니다.</span>
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
        <button class="logout" onclick="clickLogOutEvent(event)">로그아웃</button>
    </main>
    <script src="../js/main.js"></script>
</body>
