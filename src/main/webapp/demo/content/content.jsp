<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>demo附件上传</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>

<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/content/editPage')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>

<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/content/publish')}">
	<script type="text/javascript">
		$.canPublish = true;
	</script>
</c:if>

<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/content/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/content/contentDetail')}">
	<script type="text/javascript">
		$.canView = true;
	</script>
</c:if>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/demo/content/content.js"></script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'west',border:false,split:true, minWidth: 200" style="overflow: hidden; width: 200px;">
			<div id="channelTreePanel" class="easyui-panel" title="栏目列表" style="height: 100%;">
				<div class="datagrid-toolbar">
					<a onclick="channelTree.tree('reload');" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
						data-options="plain:true"><icon:icon name="refresh" />&nbsp;刷新</a>
				</div>
				<ul id="channelTree" class="ade-noicon-tree"></ul>
			</div>
		</div>
		<div data-options="region:'center',border:false" title="文章列表">
			<table id="dataGrid"></table>
		</div>
	</div>

	<div id="toolbar" style="display: none;">
		<form id="searchForm" style="margin: 5px;">
			<table class="ade-table">
				<tr>
					<th>标题:</th>
					<td><input id="title" name="title" class="easyui-textbox" data-options="width:150,prompt: '标题',height:30" /></td>
					<th>状态:</th>
					<td><select id="status" class="easyui-combobox" name="status" style="width: 150px;"
						data-options="editable:false,multiple:false,height:30"></select></td>
					<td colspan="4"><a href="javascript:void(0);" class="easyui-linkbutton ade-button-1" data-options="plain:true"
						onclick="searchFun();"><icon:icon name="search" />&nbsp;查询</a><a href="javascript:void(0);"
						class="easyui-linkbutton ade-button-2" data-options="plain:true" onclick="cleanFun();"><icon:icon name="clean" />&nbsp;清空条件</a></td>
				</tr>
			</table>
		</form>
		<hr />
		<rl:linkbutton permission="/demo/content/addPage" onclick="addFun();" styleClass="easyui-linkbutton ade-button-1"
			dataOptions="plain:true">
			<icon:icon name="add" />&nbsp;添加</rl:linkbutton>
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
			data-options="plain:true"><icon:icon name="refresh" />&nbsp;刷新</a>
	</div>
</body>
</html>
