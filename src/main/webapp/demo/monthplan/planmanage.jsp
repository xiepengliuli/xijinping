<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>工作计划</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>

<c:if
	test="${fn:contains(LOGIN_USER.moduleList, '/demo/monthPlan/editPage')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>


<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/monthPlan/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/demo/monthplan/monthplan.js"></script>
</head>
<body>

		<div class="easyui-layout" data-options="fit:true,border:false">
			<input id="noteId" name="noteId" type="hidden" />
			<div
				data-options="region:'west',border:false,split:true, minWidth: 200"
				style="overflow: hidden; width: 200px;">
				<div id="channelTreePanel" class="easyui-panel" title="月度"
					style="height: 100%;">
					<div class="datagrid-toolbar">
						<rl:linkbutton permission="/demo/monthPlan/exportPlan"
						onclick="exportChannelFun();"
 							styleClass="easyui-linkbutton ade-button-2" 
 							dataOptions="plain:true"> 
							<icon:icon name="edit" />&nbsp;导出</rl:linkbutton> 
					</div>
									<ul id="channelTree" class="ade-noicon-tree"></ul>
				</div>
			</div>
			<div data-options="region:'center',border:false" >
				<div id="tt" class="easyui-tabs" style="width: 100%; height: 500px;">
					<div title="完成情况" style="padding: 1px;">
						<table id="dataGrid"></table>
					</div>
					<div title="下月计划" style="overflow: auto; padding: 1px;">
						<table id="dataGrid2"></table>
					</div>

				</div>
			</div>
		</div>

		<div id="toolbar" style="display: none;">

			<rl:linkbutton permission="/demo/monthPlan/addPlanCompletePage"
				onclick="addPlanCompleteFun();"
				styleClass="easyui-linkbutton ade-button-1" dataOptions="plain:true">
				<icon:icon name="add" />&nbsp;添加完成情况</rl:linkbutton>
			<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);"
				class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon
					name="refresh" />&nbsp;刷新</a>
		</div>
		<div id="toolbar2" style="display: none;">

			<rl:linkbutton permission="/demo/monthPlan/addPlanPage"
				onclick="addPlanFun();"
				styleClass="easyui-linkbutton ade-button-1" dataOptions="plain:true">
				<icon:icon name="add" />&nbsp;添加下月计划</rl:linkbutton>
			<a onclick="dataGrid2.datagrid('reload');" href="javascript:void(0);"
				class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon
					name="refresh" />&nbsp;刷新</a>
		</div>
</body>
</html>
