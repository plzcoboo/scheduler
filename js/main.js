document.getElementById('prevYearBtn').addEventListener('click', () => changeYear(-1));
    document.getElementById('nextYearBtn').addEventListener('click', () => changeYear(1));

    function changeYear(direction) {
        currentYear += direction;
        currentMonth = 1; 
        updateCalendar(currentYear, currentMonth, scheduleList);
    }

    function changeMonth() {
        currentMonth = parseInt(document.querySelector('.monthSelect').value);
        updateCalendar(currentYear, currentMonth, scheduleList);
    }

    function clickWriteEvent(e) {
        e.preventDefault();
        location.href = "../html/schedule_write.html";
    }

    function updateCalendar(year, month, scheduleList) {
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
                    let fullDate = `${year}-${('0' + month).slice(-2)}-${('0' + date).slice(-2)}`;
                    scheduleList.forEach(item => {
                        if (item.date === fullDate) {
                            if (item.leader_count > 0) {
                                cellContent += `<span class="schedul_leader" onclick="redirectToDetail('${year}-${('0' + month).slice(-2)}-${('0' + date).slice(-2)}')">${event.leader_count}개의 일정</span>`;
                            }
                            if (item.member_count > 0) {
                                cellContent += `<span class="schedul_members" onclick="redirectToDetail('${year}-${('0' + month).slice(-2)}-${('0' + date).slice(-2)}')">${event.member_count}개의 일정</span>`;
                            }
                        }
                    });
                    cell.innerHTML = cellContent;
                    date++;
                }
            }
        }
        document.querySelector('.year').innerText = year;
        document.querySelector('.monthSelect').value = month;
    }

    function redirectToDetail(date) {
        location.href = `schedule_detail.jsp?date=${date}`;
    }