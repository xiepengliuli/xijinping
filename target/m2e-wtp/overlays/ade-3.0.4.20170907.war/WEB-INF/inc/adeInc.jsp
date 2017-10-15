<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rl" uri="/WEB-INF/tld/ade-role-tag.tld"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/ade-html-tag.tld"%>
<%@ taglib prefix="dict" uri="/WEB-INF/tld/ade-dict-tag.tld"%>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html:base />
<script type="text/javascript" charset="utf-8">
  var codeBase = "${pageContext.request.contextPath}";
</script>
<%
    //引入kindEditor插件
%>
<link rel="stylesheet" href="${ctx}/resources/plugins/kindeditor-4.1.7/themes/default/default.css">
<%
    //引入EasyUI
%>
<link rel="stylesheet" href="${ctx}/resources/plugins/jquery-easyui/themes/ade/easyui.css" type="text/css">
<%
    //扩展EasyUI界面
%>
<link rel="stylesheet" href="${ctx}/resources/css/extEasyUI.css?v=201305301906" type="text/css">
<%
    //引用ade覆盖的EasyUI的样式
%>
<link id="easyuiTheme" rel="stylesheet"
	href="${ctx}/resources/css/ade-theme/ade-theme.jsp?v=201305301906&adeThemes=<c:out value="${cookie.easyuiThemeName.value}"/>"
	type="text/css">
<%
    //引用ade自定义的样式
%>
<link rel="stylesheet" href="${ctx}/resources/css/ade.css" type="text/css">
<%
    //引用ade自定义图标
%>
<style type="text/css">
@font-face {
	font-family: "iconfont";
	src:
		url('${ctx}/resources/css/ade-theme/icons/iconfont.eot?t=1500885807311');
	/* IE9*/
	src:
		url('${ctx}/resources/css/ade-theme/icons/iconfont.eot?t=1500885807311#iefix')
		format('embedded-opentype'), /* IE6-IE8 */     
		
		
		url('${ctx}/resources/css/ade-theme/icons/iconfont.woff?t=1500885807311')
		format('woff'), /* chrome, firefox */     
		
		
		url('${ctx}/resources/css/ade-theme/icons/iconfont.ttf?t=1500885807311')
		format('truetype'),
		/* chrome, firefox, opera, Safari, Android, iOS 4.2+*/     
		
		
		url('${ctx}/resources/css/ade-theme/icons/iconfont.svg?t=1500885807311#iconfont')
		format('svg'); /* iOS 4.1- */
}

.iconfont {
	font-family: "iconfont" !important;
	font-size: 12px;
	font-weight: normal;
	font-style: normal;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}
</style>

<link href="${ctx}/favicon.ico?v=170222" rel="icon" type="image/ico" />

<%
    //////////////////////////////
%>
<%
    //引入jQuery
%>
<script src="${ctx}/resources/plugins/jquery.min.js" type="text/javascript" charset="utf-8"></script>
<%
    //浏览器版本的插件
%>
<script type="text/javascript" src="${ctx}/resources/plugins/extBrowser.js" charset="utf-8"></script>
<%
    //引入easyui
%>
<script type="text/javascript" src="${ctx}/resources/plugins/jquery-easyui/jquery.easyui.min.js" charset="utf-8"></script>
<%
    //引入easyui语言
%>
<script type="text/javascript" src="${ctx}/resources/plugins/jquery-easyui/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<%
    //扩展EasyUI
%>
<script type="text/javascript" src="${ctx}/resources/plugins/extEasyUI.js?v=201305241044" charset="utf-8"></script>
<%
    //扩展jQuery
%>
<script type="text/javascript" src="${ctx}/resources/plugins/extJquery.js?v=201305301341" charset="utf-8"></script>
<%
    //引入ade的扩展
%>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/js/ade.js"></script>
<%
    //引入kindEditor插件
%>
<script type="text/javascript" src="${ctx}/resources/plugins/kindeditor-4.1.7/kindeditor-all-min.js" charset="utf-8"></script>
<%
    //引入echarts
%>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugins/echarts/echarts-all.js"></script>