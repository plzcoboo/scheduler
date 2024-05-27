function checkForm(event) {
    const year = document.getElementById('year').value;
    const month = document.getElementById('month').value;
    const day = document.getElementById('day').value;
    const hour = document.getElementById('hour').value;
    const minute = document.getElementById('minute').value;
    const content = document.getElementById('content').value;
    const date = document.getElementById('date').value;


    const isValidYear = /^\d{4}$/.test(year);
    const isValidMonth = /^(0?[1-9]|1[0-2])$/.test(month);
    const isValidDay = /^(0?[1-9]|[12][0-9]|3[01])$/.test(day);
    const isValidHour = /^(0?[0-9]|1[0-9]|2[0-3])$/.test(hour);
    const isValidMinute = /^[0-5]?[0-9]$/.test(minute);
    const isValidDate = /^\d{4}-\d{2}-\d{2}$/.test(date)

    if (!isValidDate) {
        alert('올바른 입력값을 입력하세요');
        event.preventDefault();
        return false;
    }

    if (!isValidYear) {
        alert('올바른 연도를 입력하세요');
        event.preventDefault();
        return false;
    }
    if (!isValidMonth) {
        alert('올바른 월을 입력하세요');
        event.preventDefault();
        return false;
    }
    if (!isValidDay) {
        alert('올바른 일을 입력하세요');
        event.preventDefault();
        return false;
    }
    if (!isValidHour) {
        alert('올바른 시간을 입력하세요');
        event.preventDefault();
        return false;
    }
    if (!isValidMinute) {
        alert('올바른 분을 입력하세요');
        event.preventDefault();
        return false;
    }
    if (content.trim() === "") {
        alert('일정 내용을 입력하세요');
        event.preventDefault();
        return false;
    }

    return true;
}