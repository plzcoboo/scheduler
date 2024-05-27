document.addEventListener("DOMContentLoaded", function() {
    let schedulEdit = "../html/schedul_list_edit.html";

    // scheduleData 변수를 사용하여 HTML 요소 생성
    let scheduleList = document.getElementById("scheduleList");
    scheduleData.forEach(schedule => {
        let listItem = document.createElement("li");
        listItem.classList.add("schedul-list");

        listItem.innerHTML = `
            <i class="xi-calendar-check"></i>
            <div class="content">
                <span>${schedule.content}</span>
                <span class="year_month_date_time"><i class="xi-view-day"></i>${schedule.date} ${schedule.time}</span>
            </div>
            <button class="show"><i class="xi-profile"></i></button>
            <div class="block"></div>
            <div class="hide">
                <span>${schedule.departmentName}</span>
                <span>성함:${schedule.userName}</span>
            </div>
            <button class="edit">수정</button>
            <button class="del" type="submit">삭제</button>
        `;

        scheduleList.appendChild(listItem);
    });

    // 이벤트 핸들러 등록
    document.querySelectorAll('.show').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            let listItem = button.closest('.schedul-list');
            let showButton = listItem.querySelector('.show');
            let hideDiv = listItem.querySelector('.hide');
            let block = listItem.querySelector('.block');

            showButton.style.display = 'none';
            block.style.display = 'block';
            hideDiv.style.display = 'flex';
        });
    });

    document.querySelectorAll('.edit').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            location.href = schedulEdit;
        });
    });
});
