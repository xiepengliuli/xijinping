$(function() {
  document.onkeydown = keyListener;
  resetLoginButton();

  // 设置用户名称获的焦点
  $('#loginName')[0].focus();
})

function resetLoginButton() {

  $loginBtn = $('#loginBtn');

  $loginBtn.removeClass("disabled");

  $loginBtn.one("click", function() {
    login();
  });
}

function keyListener(e) {
  e = e ? e : event;
  if (e.keyCode == 13) {
    login();
  }
}

function loginOK() {
  window.location.href = codeBase + '/admin/index.jsp';
}

function refreshCaptcha() {
  $('#captcha').val('');
  document.getElementById("img_captcha").src = codeBase + "/core/captcha/random?t=" + Math.random();
}
function login() {

  $('#login_main_errortip').html('&nbsp;');

  var message = validate();
  if (message != '') {// 校验失败
    $('#login_main_errortip').html(message);
    return;
  }

  $('#loginBtn').addClass("disabled");

  $.ajax({
    type : 'POST',
    url : codeBase + '/admin/userManager/login',
    data : {
      t : new Date(),
      loginName : $('#loginName').val(),
      password : $('#password').val(),
      captcha : $('#captcha').val()
    },
    dataType : 'json',
    success : function(result) {

      if (result.success) {
        loginOK();
      } else {
        $('#login_main_errortip').html(result.msg);
        resetLoginButton();

        if (useCaptcha != 'false') {
          refreshCaptcha();
        }
      }
    },
    error : function(jqXHR, textStatus, errorThrown) {

      resetLoginButton();

      switch (jqXHR.status) {
      case (500):
        alert("服务器系统内部错误");
        break;
      default:
        console.log(errorThrowns);
        alert("未知错误");
      }
    }
  });
}

function validate() {

  if ($('#loginName').val() == '') {
    return '登录名不能为空，请输入登录名！';
  }
  if ($('#password').val() == '') {
    return '密码不能为空，请输入密码！';
  }

  if (useCaptcha && $('#captcha').val() == '') {
    return '验证码不能为空，请输入验证码！';
  }

  return '';
}