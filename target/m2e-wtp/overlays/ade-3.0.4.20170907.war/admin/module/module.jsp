<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>资源管理</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/moduleManager/editPage')}">
	<script type="text/javascript">
    $.canEdit = true;
  </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/moduleManager/delete')}">
	<script type="text/javascript">
    $.canDelete = true;
  </script>
</c:if>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/module/module.js"></script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'west',border:false,split:true, minWidth: 400" style="overflow: hidden; width: 400px;">
			<div class="easyui-panel" title="模块列表" style="height: 100%;">
				<table id="treeGrid"></table>
			</div>
		</div>
		<div data-options="region:'center',border:false" title="权限列表">
			<table id="authGrid"></table>
		</div>
	</div>

	<div id="menuToolbar" style="display: none;">
		<rl:linkbutton permission="/admin/moduleManager/addPage" onclick="addFun();" styleClass="easyui-linkbutton ade-button-1" dataOptions="plain:true">
			<icon:icon name="add" />&nbsp;添加模块</rl:linkbutton>
		<a onclick="redo();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon name="expand" />&nbsp;展开</a> <a
			onclick="undo();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon name="collapse" />&nbsp;折叠</a> <a
			onclick="treeGrid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon
				name="refresh" />&nbsp;刷新</a>
	</div>

	<div id="toolbar" style="display: none;">
		<rl:linkbutton permission="/admin/moduleManager/addPermission" onclick="addPermissionFun();" styleClass="easyui-linkbutton ade-button-1"
			dataOptions="plain:true">
			<icon:icon name="add" />&nbsp;添加权限</rl:linkbutton>
		<a onclick="authGrid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon
				name="refresh" />&nbsp;刷新</a>
	</div>
</body>
</html>