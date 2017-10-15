<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  $(function() {
    parent.$.messager.progress('close');
    $('#departmentId').combotree({
      url : '${pageContext.request.contextPath}/admin/organizationManager/organizationComboTree',
      parentField : 'pid',
      lines : true,
      panelHeight : 'auto',
      onLoadSuccess : function() {
        //回填上级部门
        $('#departmentId').combotree('setValue', '${organization.orgPid}');
        parent.$.messager.progress('close');
      }
    });

    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/organizationManager/${operate}',
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
          parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为role.jsp页面预定义好了
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
  });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;" class="ade-gray">
		<form id="form" method="post">
			<table class="ade-table">
				<tr>
					<th>组织机构名：</th>
					<td><input type="hidden" name="id" value="${organization.id}" /> <input name="orgName" type="text" type="text" value="${organization.orgName}"
						class="easyui-validatebox" data-options="required:true" style="width: 140px; height: 32px;" /></td>
					<th>负责人：</th>
					<td><input name="orgLeader" type="text" type="text" value="${organization.orgLeader}" class="easyui-validatebox " style="width: 140px; height: 32px;" /></td>
				</tr>
				<tr>
					<th>组织机构地址：</th>
					<td><input name="orgAddress" type="text" value="${organization.orgAddress}" class="easyui-validatebox" style="width: 140px; height: 32px;" /></td>
					<th>联系电话：</th>
					<td><input name="orgPhone" type="text" type="text" value="${organization.orgPhone}" class="easyui-validatebox " style="width: 140px; height: 32px;" /></td>
				</tr>
				<tr>
					<th>状态：</th>
					<td><select class="easyui-combobox" name="orgStatus" style="width: 140px; height: 32px;"><c:if test="${organization.orgStatus==1 }">
								<option value="1" selected="selected">使用</option>
								<option value="0">废弃</option>
							</c:if>
							<c:if test="${organization.orgStatus==0 }">
								<option value="0" selected="selected">废弃</option>
								<option value="1">使用</option>
							</c:if>
					</select></td>
					<th>上级部门：</th>
					<td><select id="departmentId" name="orgPid" style="width: 140px; height: 32px;"></select><img
						src="${pageContext.request.contextPath}/resources/css/images/extjs_icons/cut_red.png" onclick="$('#departmentId').combotree('clear');" /></td>
				</tr>
				<tr>
					<th>描述：</th>
					<td colspan="3"><textarea name="moduleDesc" style="width: 375px; height: 60px;"
							onKeyUp="if(this.value.length>80){this.value=this.value.substring(0,80);}"> ${module.moduleDesc}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>
