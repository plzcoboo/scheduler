function checkDuplicateId(event) {
    event.preventDefault(); // 기본 동작 막기
    let userId = document.getElementById('id_input').value.trim();
    const isValidId = /^[a-zA-Z0-9]+$/.test(userId);
    const isIdEmpty = userId === "";
    const isIdTooLong = userId.length > 20;

    if (isIdEmpty) {
        alert("올바른 아이디를 입력하세요.");
        return;
    }

    if (!isValidId || isIdTooLong) {
        alert("아이디는 20자 이내이며, 영문자와 숫자로만 이루어져야 합니다.");
        return;
    }
    
    window.open('../action/duplicate_id_action.jsp?userId=' + userId, '중복체크', 'width=1,height=1');
}


function setResultId(result, isAvailable) {
    let resultElement = document.getElementById('checkResult');
    if(result === '사용가능한 아이디입니다.') {
        resultElement.innerText = result;
        resultElement.style.color = "#1877F2"
    } else {
        resultElement.innerText = result;
        resultElement.style.color = "red"
    }
  
    if (isAvailable) {
        document.getElementById('id_input').readOnly = true;
        idConfirm = true;
    }
}
