    document.getElementById('prevYearBtn').addEventListener('click', () => changeYear(-1));
    document.getElementById('nextYearBtn').addEventListener('click', () => changeYear(1));

    function changeYear(direction) {
        currentYear += direction;
        currentMonth = 1; 
        updateCalendar(currentYear, currentMonth);
    }

    function changeMonth() {
        currentMonth = parseInt(document.querySelector('.monthSelect').value);
        updateCalendar(currentYear, currentMonth);
    }

    function clickWriteEvent(e) {
        e.preventDefault();
        location.href = "../html/schedule_write.html";
    }

    function updateCalendar(year, month,leaderCount,memberCount) {
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
                    let cellContent = `<span class="date">${date}</span>`;
                    cell.innerHTML = cellContent;
                    date++;
                }
            }
        }
        document.querySelector('.year').innerText = year;
        document.querySelector('.monthSelect').value = month;
    }

/* 
let dateStr = `${year}-${String(month).padStart(2, '0')}-${String(date).padStart(2, '0')}`;
 if (schedules[dateStr]) {
                        if (schedules[dateStr].schedul_leader) {
                            cellContent += `<span class="schedul_leader">${schedules[dateStr].schedul_leader}개의 일정</span>`;
                        }
                        if (schedules[dateStr].schedul_members) {
                            cellContent += `<span class="schedul_members">${schedules[dateStr].schedul_members}개의 일정</span>`;
                        }
                        cellContent = `<a href="schedul_detail.html">${cellContent}</a>`;
                    }
*/
