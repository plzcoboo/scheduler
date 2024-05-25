function checkDuplicatePhoneNum(event) {
    event.preventDefault(); // 기본 동작 막기
    let phoneNumber = document.getElementById('phone_number_input').value.trim();
    const isValidPhoneNum = /^01[0-9]*$/.test(phoneNumber);
    const isPhoneNumEmpty = phoneNumber === "";
    const isPhoneNumTooLong = phoneNumber.length !== 11;

    if (isPhoneNumEmpty) {
        alert("올바른 전화번호를 입력하세요.");
        return;
    }

    if (!isValidPhoneNum || isPhoneNumTooLong) {
        alert("올바른 전화번호를 입력하세요");
        return;
    }
    
   window.open('../action/duplicate_phone_num_action.jsp?phoneNumber=' + phoneNumber, '중복체크', 'width=1,height=1');
}

function setResultPhoneNum(result, isAvailable) {
    let resultElement = document.getElementById('phoneCheckResult');
    if(result === '사용가능한 전화번호입니다.') {
        resultElement.innerText = result;
        resultElement.style.color = "#1877F2"
    } else {
        resultElement.innerText = result;
        resultElement.style.color = "red"
    }
  
    if (isAvailable) {
        document.getElementById('phone_number_input').readOnly = true;
        phoneConfirm = true;
    }
}