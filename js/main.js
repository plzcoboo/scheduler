    let currentYear = new Date().getFullYear();
    let currentMonth = new Date().getMonth() + 1;

    const schedules = {
        "2024-07-20": {
            "schedul_leader": 3,
            "schedul_members": 3 
        },
        "2024-06-11": {
            "schedul_leader": 3,
            "schedul_members": 3 
        },
        "2024-06-14": {
            "schedul_members": 3 
        },
        "2024-06-08": {
            "schedul_leader": 3,
        }
    };

    document.getElementById('prevYearBtn').addEventListener('click', () => changeYear(-1));
    document.getElementById('nextYearBtn').addEventListener('click', () => changeYear(1));

    updateCalendar(currentYear, currentMonth);

    function changeYear(direction) {
        currentYear += direction;
        currentMonth = 1; 
        updateCalendar(currentYear, currentMonth);
    }

    function changeMonth() {
        currentMonth = parseInt(document.querySelector('.monthSelect').value);
        updateCalendar(currentYear, currentMonth);
    }

    function updateCalendar(year, month) {
        const calendarBody = document.querySelector('tbody');
        calendarBody.innerHTML = '';
        const daysInMonth = new Date(year, month, 0).getDate();
        let date = 1;
        for (let i = 0; i < 6; i++) {
            let row = calendarBody.insertRow(i);
            for (let j = 0; j < 7; j++) {
                let cell = row.insertCell(j);
                if (i === 0 && j < new Date(year, month - 1, 1).getDay()) {
                    cell.innerHTML = '<span class="empty"></span>';
                } else if (date > daysInMonth) {
                    cell.innerHTML = '<span class="empty"></span>';
                } else {
                    let dateStr = `${year}-${String(month).padStart(2, '0')}-${String(date).padStart(2, '0')}`;
                    let cellContent = `<span class="date">${date}</span>`;
                    if (schedules[dateStr]) {
                        if (schedules[dateStr].schedul_leader) {
                            cellContent += `<span class="schedul_leader">${schedules[dateStr].schedul_leader}개의 일정</span>`;
                        }
                        if (schedules[dateStr].schedul_members) {
                            cellContent += `<span class="schedul_members">${schedules[dateStr].schedul_members}개의 일정</span>`;
                        }
                        cellContent = `<a href="schedule_detail.jsp">${cellContent}</a>`;
                    }
                    cell.innerHTML = cellContent;
                    date++;
                }
            }
        }
        document.querySelector('.year').innerText = year;
        document.querySelector('.monthSelect').value = month;
    }

    function clickLogOutEvent(e) {
        e.preventDefault();
        location.href = "../index.html";
    }

    function clickWriteEvent(e) {
        e.preventDefault();
        location.href = "../html/schedule_write.html";
    }