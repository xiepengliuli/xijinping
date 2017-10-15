<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dict" uri="/WEB-INF/tld/ade-dict-tag.tld"%>
<%
    // 解决浏览器后退的时候，显示登录页面的问题
			response.addHeader("Pragma", "no-cache");
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.addHeader("Cache-Control", "pre-check=0, post-check=0");
			response.setDateHeader("Expires", 0);
%>
<%
    // 如果已经登录，则跳转到系统的首页
%>
<c:if test="${not empty sessionScope.LOGIN_USER}">
  <c:redirect url="/admin/index.jsp" />
</c:if>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><dict:print code="system_page_title" /></title>
<link href="${ctx}/favicon.ico?v=170222" rel="icon" type="image/ico" />
<link rel="stylesheet" type="text/css" href="${ctx}/resources/css/admin/login.css" />
<script src="${ctx}/resources/plugins/jquery.min.js"></script>
<script src="${ctx}/resources/js/admin/login.js"></script>
<script type="text/javascript">
  var codeBase = "${pageContext.request.contextPath}";
  var useCaptcha = '${ADMIN_LOGIN_CAPTCHA}';
</script>
</head>
<body>
  <div>
    <div class="login_top">
      <div class="login_title">后台管理系统</div>
    </div>
    <div style="float: left; width: 100%;">
      <div class="login_main">
        <div class="login_main_top"></div>
        <div id="login_main_errortip" class="login_main_errortip">&nbsp;</div>
        <div class="login_main_ln">
          <input type="text" id="loginName" name="loginName" value="" placeholder="请输入登录名" />
        </div>
        <div class="login_main_pw">
          <input type="password" id="password" name="password" value="" placeholder="请输入密码" />
        </div>
        <c:if test="${ADMIN_LOGIN_CAPTCHA}">
          <div class="login_main_yzm">
            <div>
              <input type="text" id="captcha" name="captcha" /> <img alt="验证码" src="${ctx}/core/captcha/random"
                title="点击更换" id="img_captcha" onclick="javascript:refreshCaptcha();"
                style="height: 45px; width: 85px; float: right; margin-right: 98px;" />
            </div>
          </div>
        </c:if>
        <div class="login_main_submit">
          <button id="loginBtn">登 录</button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
