let number = document.getElementById('phone_number_input');
number.onkeydown = function(e) {
    if(!((e.keyCode > 95 && e.keyCode < 106) || (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {return false;}
}
let confirm = false;

function checkForm() {
        let nameInput = document.querySelector("input[name='name']");
        let idInput = document.querySelector("input[name='id']");
        let phoneNumberInput = document.querySelector("input[name='phone_number']");
        let radios = document.querySelectorAll('input[type="radio"][name="chk_author"]');
        let isChecked = false;
        let isValiedId = /^[a-z0-9_]{0,20}$/.test(idInput.value)
        let isValiedName = /^[a-zA-Z가-힣]+$/.test(nameInput.value)
        let isValidPhoneNumber = /^01[0-9]*$/.test(phoneNumberInput.value)
    
        radios.forEach(item => item.checked && (isChecked = true))
        if(!isChecked){alert("권한을 설정해주세요");return false;}
    
        if (nameInput.value.trim() === "") {
            alert("올바른 성함을 입력하세요.");
            return false;
        } else if (/\s/.test(nameInput.value) || nameInput.value.length > 20 || !isValiedName ) {
            alert("성함은 20자 이내이며, 영문과 한글로만 이루어져야 합니다.");
            return false;
        }
    
        // 아이디 필드 유효성 검사
        if (idInput.value.trim() === "" || !isValiedId) {
            alert("올바른 아이디를 입력하세요.");
            return false;
        } else if (/\s/.test(idInput.value) || idInput.value.length > 20) {
            alert("아이디는 20자 이내이며, 공백을 포함할 수 없습니다.");
            return false;
        }
    
        if (phoneNumberInput.value.trim() === "" || !isValidPhoneNumber) {
            alert("올바른 전화번호를 입력해주세요.");
            return false;
        } else if (phoneNumberInput.value.length !== 11) {
            alert("전화번호는 11자여야 합니다.");
            return false;
        }
        
    return true;

    }