<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty sessionScope.LOGIN_USER}">
	<c:redirect url="/admin/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<title><dict:print code="system_page_title" /></title>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resources/js/admin/index.js"></script>
<script type="text/javascript">
  var indexPageUrl = '<dict:print code="index_page_url" />';
</script>
</head>
<body>
	<div id="index_layout">
		<div class="index_north_bar"
			data-options="region:'north',href:'${pageContext.request.contextPath}/admin/layout/north.jsp'"></div>
		<div data-options="region:'west',split:true" title="导航菜单" style="width: 200px; overflow-x: hidden; overflow-y: auto;">
			<div id="adeSystemMenuTreeBar" class="ade-noicon-tree"></div>
		</div>
		<div data-options="region:'center'" style="overflow: hidden;">
			<div id="index_tabs" style="overflow: hidden;" style="height:100px;padding:10px;">
				<div title="首页" data-options="border:false" style="overflow: hidden;">
					<iframe id="iframe" style="border: 0; width: 100%; height: 98%;"></iframe>
				</div>
			</div>
		</div>
		<%
		    //右侧的日历，目前看没有任何意义
		    /*
		    <div data-options="region:'east',href:'${pageContext.request.contextPath}/admin/layout/east.jsp'" title="日历"
		      style="width: 230px; overflow: hidden;"></div>*/
		%>
		<div data-options="region:'south',href:'${pageContext.request.contextPath}/admin/layout/south.jsp',border:false"
			style="height: 30px; overflow: hidden;"></div>
	</div>

	<div id="index_tabsMenu" style="width: 120px; display: none;">
		<div title="refresh" data-options="iconCls:'transmit'">刷新</div>
		<div class="menu-sep"></div>
		<div title="close" data-options="iconCls:'arrow_cross'">关闭</div>
		<div title="closeOther" data-options="iconCls:'arrow_cross'">关闭其他</div>
		<div title="closeAll" data-options="iconCls:'arrow_cross'">关闭所有</div>
	</div>

</body>
</html>