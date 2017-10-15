<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/userManager/editPage')}">
	<script type="text/javascript">
    $.canEdit = true;
  </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/userManager/delete')}">
	<script type="text/javascript">
    $.canDelete = true;
  </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/userManager/grantPage')}">
	<script type="text/javascript">
    $.canGrant = true;
  </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/userManager/editPwdPage')}">
	<script type="text/javascript">
    $.canEditPwd = true;
  </script>
</c:if>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/user/user.js">
  
</script>
<script type="text/javascript">
  var currentUserId = '${LOGIN_USER.id}';
</script>
</head>
<body>

	<div id="toolbar" style="padding: 5px; height: auto">
		<div>
			<form id="searchForm" style="margin: 5px;">
				<table class="ade-table">
					<tr>
						<th>登录名:</th>
						<td><input name="loginName" class="easyui-textbox" data-options="width:150,prompt: '登录名',height:30" /></td>
						<th>用户状态:</th>
						<td><select id="cc" class="easyui-combobox" name="userState" style="width: 150px;"
							data-options="editable:false,multiple:false,height:30">
								<option value="">全部</option>
								<option value="1">正常</option>
								<option value="0">废弃</option>
						</select></td>
						<td colspan="4"><a href="javascript:void(0);" class="easyui-linkbutton ade-button-1"
							data-options="plain:true" onclick="searchFun();"><icon:icon name="search" />&nbsp;查询</a><a
							href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true" onclick="cleanFun();"><icon:icon
									name="clean" />&nbsp;清空条件</a><a href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
							data-options="plain:true" onclick="moreFun();"><icon:icon name="more" />&nbsp;更多</a></td>
					</tr>

					<tr class="ade-table-more">
						<th>创建时间开始:</th>
						<td><input class="easyui-datetimebox" name="createDateStart" type="text"
							data-options="width:150,height:25,prompt: '创建时间开始',editable:false,height:36" /></td>
						<th>创建时间结束:</th>
						<td><input class="easyui-datetimebox" name="createDateEnd" type="text"
							data-options="width:150,height:25,prompt: '创建时间结束',editable:false,height:36" /></td>
						<th>最后修改时间开始:</th>
						<td><input class="easyui-datetimebox" name="updateDateStart" type="text"
							data-options="width:150,height:25,prompt: '最后修改时间开始',editable:false,height:36" /></td>
						<th>最后修改时间结束:</th>
						<td><input class="easyui-datetimebox" name="updateDateEnd" type="text"
							data-options="width:150,height:25,prompt:'最后修改时间结束',editable:false,height:36" /></td>
					</tr>
				</table>
			</form>

			<hr />

			<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/userManager/addPage')}">
				<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton ade-button-1" data-options="plain:true"><icon:icon
						name="add" />&nbsp;添加</a>
				<a onclick="importFun();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
					data-options="plain:true"><icon:icon name="import" />&nbsp;导入Excel</a>
				<a href="${pageContext.request.contextPath}/resources/templete/users.xlsx" class="easyui-linkbutton ade-button-2"
					data-options="plain:true"><icon:icon name="export" />&nbsp;导出模板</a>
			</c:if>

			<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/userManager/grantPage')}">
				<a onclick="batchGrantFun();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
					data-options="plain:true"><icon:icon name="auth" />&nbsp;批量授权</a>
			</c:if>
			<c:if test="${fn:contains(LOGIN_USER.moduleList, '/admin/userManager/batchDelete')}">
				<a onclick="batchDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
					data-options="plain:true"><icon:icon name="stop" />&nbsp;批量停用</a>
			</c:if>
		</div>
	</div>
	<table id="dataGrid"></table>
</body>
</html>