<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>
<script type="text/javascript">
	$(function() {
		parent.$.messager.progress('close');
		$('#form').form({
			url : '${pageContext.request.contextPath}/demo/monthPlan/${operate}',
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
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
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

		$('#organId').combotree({
			parentField : 'pid',
			lines : true,
			panelHeight : '300',
			panelWidth : '250',
			url : ade.bp() + '/demo/monthPlan/organTree',
		// 			value : parentId,
		});
		combotreeVlue();
		var planLevelId = $("#planLevelId");
		planLevelId = planLevelId.combobox({
			url : ade.bp() + '/demo/monthPlan/getPlanLevel',
			editable : false, //不可编辑状态  
			panelHeight : '300',
			panelWidth : '250',
			valueField : 'id',
			textField : 'dictName'
		});
		comboboxVlue();

	});

	function combotreeVlue() {
		var comvalue = "${adePlan.organId}";
		$('#organId').combotree('setValue', comvalue);

	}
	function comboboxVlue() {
		var comvalue = "${adePlan.planLevelId}";
		$('#planLevelId').combobox('setValue', comvalue);

	}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style="overflow: auto;" class="ade-gray">
		<form id="form" method="post">
			<input type="hidden" name="id" value="${adePlan.id}" />
			<h2 style="text-align:center;">计划情况</h2>
			<table class="ade-table">
				<tr>
					<th>月度：</th>
					<td><input name="planId" type="hidden" value="${noteId}" />${noteName}</td>
					<th>排序：</th>
					<td><input name="sortid" value="${adePlan.sortid}"
						class="easyui-numberspinner" style="width: 250px; height: 30px;"
						required="required" data-options="editable:false"></td>

				</tr>
				<tr>
					<th>部门：</th>
					<td><input id="organId" name="organId"
						style="width: 230px; height: 30px;" /><a
						class="easyui-linkbutton"
						onclick="$('#organId').combotree('clear');"><icon:icon
								name="clean" /></a></td>
					<th>级别：</th>
					<td><input id="planLevelId" name="planLevelId"
						style="width: 230px; height: 30px;" /><a
						class="easyui-linkbutton"
						onclick="$('#planLevelId').combobox('clear');"><icon:icon
								name="clean" /></a></td>
				</tr>
				<tr>
					<th>计划完成时间：</th>
					<td><input name="planfinishtime" type="date"
						value="${adePlan.planfinishtime}" class="easyui-datebox"
						data-options="required:true" style="height: 28px; width: 250px;" /></td>
					<th>实施人：</th>
					<td><input name="implementationUser" type="text"
						value="${adePlan.implementationUser}" class="easyui-validatebox"
						data-options="required:true" style="height: 28px; width: 250px;" /></td>
				</tr>
				<tr>
					<th>计划工作内容：</th>
					<td><input name="planContent" type="text"
						value="${adePlan.planContent}" class="easyui-validatebox"
						data-options="required:true" style="height: 28px; width: 250px;" /></td>
					<th>实施方案：</th>
					<td><input name="implementationPlan" type="text"
						value="${adePlan.implementationPlan}" class="easyui-validatebox"
						data-options="required:true" style="height: 28px; width: 250px;" /></td>
				</tr>
				<tr>
					<th>完成目标：</th>
					<td><input name="completeGoals" type="text" value="${adePlan.completeGoals}" 
						class="easyui-validatebox" data-options="required:true" style="height: 28px; width: 250px;" /></td>
					<th>备注(计划)：</th>
					<td><input name="planRemark" type="text"
						value="${adePlan.planRemark}" class="easyui-validatebox"
						 style="height: 28px; width: 250px;" /></td>
					
				</tr>
				</table>
				<h2  style="text-align:center;">计划完成情况</h2>
				<table class="ade-table">
				<tr>
					<th>完成情况：</th>
					<td><input name="completeSituation" type="text"
						value="${adePlan.completeSituation}" class="easyui-validatebox"
						data-options="required:true" style="height: 28px; width: 250px;" /></td>
					<th>完成比率(%)：</th>
					<td><input name="completeRatio" type="text" placeholder="请输入0-100的数字"
						value="${adePlan.completeRatio}" class="easyui-numberbox"
						data-options="required:true,min:0,max:100" style="height: 28px; width: 250px;" /></td>
				</tr>
				<tr>
				<th>备注(完成时)：</th>
					<td><input name="realremark" type="text"
						value="${adePlan.realremark}" class="easyui-validatebox"
						 style="height: 28px; width: 250px;" /></td>
					<th>原因分析：</th>
					<td><textarea name="reason" 
							class="easyui-validatebox" data-options="required:true"
							style="height: 50px; width: 250px;" >${adePlan.reason}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>