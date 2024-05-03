document.querySelector('.login-form').addEventListener('submit', function(event){
    event.preventDefault(); // 폼 제출 막기
    alert("검사");
    var email = document.getElementById('email').value;
    var phone = document.getElementById('phone').value;
    var password = document.getElementById('password').value;
    var confirm_password = document.getElementById('confirm-password').value;

    // 이메일, 전화번호, 비밀번호 유효성 검사 등을 수행할 수 있습니다.
    
    console.log(email, phone, password, confirm_password);
    // 이후 서버에 데이터를 보내는 로직이 필요합니다.
});
