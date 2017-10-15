<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>字典管理</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/dictionaryManager/addDictionary')}">
	<script type="text/javascript">
    $.canAdd = true;
  </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/dictionaryManager/editUserDict')}">
	<script type="text/javascript">
    $.canEditUserDict = true;
  </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/dictionaryManager/editSystemDict')}">
	<script type="text/javascript">
    $.canEditSystemDict = true;
  </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/dictionaryManager/deleteUserDict')}">
	<script type="text/javascript">
    $.canDeleteUserDict = true;
  </script>
</c:if>

<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/dictionaryManager/deleteSystemDict')}">
	<script type="text/javascript">
    $.canDeleteSystemDict = true;
  </script>
</c:if>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/dictionary/dictionary.js"></script>
</head>
<body>
	<div id="toolbar" style="display: none;">
		<rl:linkbutton permission="/admin/dictionaryManager/addPage" onclick="addFun();"
			styleClass="easyui-linkbutton ade-button-1" dataOptions="plain:true">
			<icon:icon name="add" />&nbsp;添加</rl:linkbutton>

		<a onclick="redo();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon
				name="expand" />&nbsp;展开</a> <a onclick="undo();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
			data-options="plain:true"><icon:icon name="collapse" />&nbsp;折叠</a><a onclick="treeGrid.treegrid('reload');"
			href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon
				name="refresh" />&nbsp;刷新</a>
	</div>

	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false">
			<table id="treeGrid"></table>
		</div>
	</div>
</body>
</html>