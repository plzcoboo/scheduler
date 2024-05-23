let mainLink = "./html/main.html";
let joinLink = "./html/join.html"
let id = document.querySelector('.id_input');
let pw = document.querySelector('.pw_input');
let loginBtn = document.querySelector('.login_button');
function loginChk(e) {
    let idComment = ['올바른 아이디를 입력해주세요.','아이디는 20자 이내로 작성해주시기 바랍니다.']
    let pwComment = ['올바른 비밀번호를 입력해주세요.','비밀번호는 20자 이내로 작성해주시기 바랍니다.']
    
    function checkIdEvent(n){
     e.preventDefault()
     alert(idComment[n]);
     id.focus();
     }

    function checkPwEvent(n){
     e.preventDefault()
     alert(pwComment[n]);
     pw.focus();
     }
    
    if(!id.value){
     checkIdEvent(0)
     return false
     }

     if(id.value.length > 20) {
     checkIdEvent(1) 
     return false
     }

     if(!pw.value){
     checkPwEvent(0)
     return false
     }

     if(pw.value.length > 20) {
     checkPwEvent(1)
     return false
     }
     
     return true
    }

      function linkToJoin(e) {
        e.preventDefault()
        location.href = joinLink;
    }