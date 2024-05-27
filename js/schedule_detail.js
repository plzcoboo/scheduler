function displayScheduleList(data) {
    const scheduleListElement = document.getElementById('scheduleList');
    const scheduleCountElement = document.getElementById('scheduleCount');
    let count = data.length;
    scheduleCountElement.textContent = count;

    data.forEach(item => {
        let listItem = document.createElement('li');
        listItem.classList.add('schedul-list');

        let icon = document.createElement('i');
        icon.classList.add('xi-calendar-check');

        let contentDiv = document.createElement('div');
        contentDiv.classList.add('content');

        let contentSpan = document.createElement('span');
        contentSpan.textContent = item.content;

        let dateTimeSpan = document.createElement('span');
        dateTimeSpan.classList.add('year_month_date_time');
        dateTimeSpan.innerHTML = `<i class="xi-view-day"></i> ${item.date} ${item.event_time}`;

        contentDiv.appendChild(contentSpan);
        contentDiv.appendChild(dateTimeSpan);

        let showButton = document.createElement('button');
        showButton.classList.add('show');
        showButton.innerHTML = '<i class="xi-profile"></i>';
        showButton.onclick = function(e) {
            e.preventDefault();
            showProfileClickEvent(e, showButton);
        };

        let blockDiv = document.createElement('div');
        blockDiv.classList.add('block');

        let hideDiv = document.createElement('div');
        hideDiv.classList.add('hide');
        hideDiv.innerHTML = `<span>부서: ${item.department_name}</span><span>성함: ${item.user_name}</span>`;

        let editButton = document.createElement('button');
        editButton.classList.add('edit');
        editButton.textContent = '수정';
        editButton.onclick = function(e) {
            e.preventDefault();
            let scheduleId = item.idx;  // Assuming `item.id` contains the ID of the schedule
            location.href = `../JSP/schedule_list_edit.jsp?id=${scheduleId}`;
        };

        let deleteButton = document.createElement('button');
        deleteButton.classList.add('del');
        deleteButton.textContent = '삭제';
        deleteButton.type = 'submit';
        deleteButton.onclick = function(e) {
            e.preventDefault();
            let scheduleId = item.idx;  // Assuming `item.id` contains the ID of the schedule
            location.href = `../action/schedule_del_action.jsp?id=${scheduleId}`;
        };

        listItem.appendChild(icon);
        listItem.appendChild(contentDiv);
        listItem.appendChild(showButton);
        listItem.appendChild(blockDiv);
        listItem.appendChild(hideDiv);
        listItem.appendChild(editButton);
        listItem.appendChild(deleteButton);

        scheduleListElement.appendChild(listItem);
    });
}

function showProfileClickEvent(e, btn) {
    let listItem = btn.closest('.schedul-list');
    let hideDiv = listItem.querySelector('.hide');
    let block = listItem.querySelector('.block');

    btn.style.display = 'none';
    block.style.display = 'block';
    hideDiv.style.display = 'flex';
}

function redirectToDetail(date, role) {
    location.href = `schedule_detail.jsp?date=${date}&role=${role}`;
}

displayScheduleList(scheduleData);
