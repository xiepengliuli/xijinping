<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>

<script type="text/javascript">
  var moduleGround = '${module.moduleGround}';
  var parentModuleId = '${module.parentModuleId}';
  var moduleIcon = '${module.moduleIcon}';
  var operate = '${operate}';
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/admin/module/moduleEdit.js"></script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;" class="ade-gray">
		<form id="form" method="post">
			<table class="ade-table">
				<tr>
					<th>菜单名称:</th>
					<td colspan="3"><input name="id" type="hidden" value="${module.id}" /><input name="moduleType" type="hidden"
						value="0" /><input name="moduleName" type="text" placeholder="请输入菜单名称" class="easyui-validatebox"
						data-options="required:true" style="width: 375px; height: 30px;" value="${module.moduleName}"></td>
				</tr>
				<tr>
					<th>菜单路径:</th>
					<td colspan="3"><input name="moduleUrl" type="text" placeholder="请输入菜单路径" class="easyui-validatebox"
						style="width: 375px; height: 30px;" value="${module.moduleUrl}"></td>
				</tr>
				<tr>
					<th>维度:</th>
					<td><input id="moduleGround" name="moduleGround" style="width: 140px; height: 32px;" required="required" /></td>
					<th>上级资源:</th>
					<td><input id="parentModuleId" name="parentModuleId" style="width: 115px; height: 32px;" /> <a
						class="easyui-linkbutton" onclick="$('#parentModuleId').combotree('clear');"><icon:icon name="clean" /></a></td>
				</tr>
				<tr>
					<th>排序:</th>
					<td><input name="moduleSort" value="${module.moduleSort}" class="easyui-numberspinner"
						style="width: 140px; height: 32px;" required="required" data-options="editable:false"></td>
					<th>菜单图标:</th>
					<td><input id="iconCls" name="moduleIcon" type="text" style="width: 112px; height: 30px;"
						value="${module.moduleIcon}" /> <a class="easyui-linkbutton" onclick="showSelectIcon();"><icon:icon
								name="system" /></a></td>
				</tr>
				<tr>
					<th>描述:</th>
					<td colspan="3"><textarea name="moduleDesc" style="width: 375px; height: 60px;">${module.moduleDesc}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>

<div id="iconSelectDialog" class="list">
	<c:if test="${not empty icons}">
		<c:forEach items="${icons}" var="icon">
			<div style="float: left; padding-left: 14px; padding-top: 5px; width: 32px; height: 32px">
				<a class="ade-link"><i class="icon iconfont" style="font-size: 21px" title="${icon.key}">${icon.value}</i></a>
			</div>
		</c:forEach>
	</c:if>
</div>
