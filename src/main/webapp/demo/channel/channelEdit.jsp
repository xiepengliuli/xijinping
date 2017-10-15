<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>
<script type="text/javascript">
	var parentId = '${channel.pid}';

	$(function() {
		$('#form').form({
			url : '${pageContext.request.contextPath}/demo/channel/${operate}',
			onSubmit : function() {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				var isValid = $(this).form('validate');
				if (!isValid) {
					parent.$.messager.progress('close');
				}
				return isValid;
			},

			success : function(result) {

				parent.$.messager.progress('close');

				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
					parent.$.messager.show({
						title : '成功',
						msg : result.msg
					});
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});

		$('#parentId').combotree({
			parentField : 'pid',
			lines : true,
			panelHeight : '300',
			panelWidth : '250',
			url : ade.bp() + '/demo/channel/tree',
			value : parentId,
		});

		parent.$.messager.progress('close');
	});
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;"
		class="ade-gray">
		<form id="form" method="post">
			<input type="hidden" name="id" value="${channel.id}" />
			<table class="ade-table">
				<tr>
					<th>栏目名称：</th>
					<td><input name="name" type="text" value="${channel.name}" placeholder="请输入栏目名称"
						class="easyui-validatebox" data-options="required:true" style="height: 28px; width: 250px;" /></td>
				</tr>
				<tr>
					<th>父栏目:</th>
					<td><input id="parentId" name="pid" style="width: 230px; height: 30px;" /><a
						class="easyui-linkbutton" onclick="$('#parentId').combotree('clear');"><icon:icon
								name="clean" /></a></td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="moduleSort" value="${channel.sortid}" class="easyui-numberspinner"
						style="width: 250px; height: 30px;" required="required" data-options="editable:false"></td>
				</tr>
			</table>
		</form>
	</div>
</div>