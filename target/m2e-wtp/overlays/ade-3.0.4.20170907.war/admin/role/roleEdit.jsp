<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  $(function() {

    parent.$.messager.progress('close');
    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/roleManager/${operate}',
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
          if (result.obj == "success") {
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
          } else if (result.obj == "roleExist") {//  角色名称已经存在
            parent.$.messager.alert('警告', "角色已经存在", 'warning', function() {
            });

          } else if (result.obj == "formEmpty") {// 表单提交有误
            parent.$.messager.alert('警告', "空表单", 'warning', function() {
            });
          } else {
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
          }
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
			<input type="hidden" name="id" value="${role.id}" />
			<table class="ade-table">
				<tr>
					<th>角色名称：</th>
					<td><input name="roleName" type="text" placeholder="请输入角色名称" class="easyui-validatebox " data-options="required:true" value="${role.roleName}"
						style="width: 375px; height: 30px;"></td>
				</tr>
				<tr>
					<th>排序：</th>
					<td><input name="roleSort" value="${role.roleSort}" class="easyui-numberspinner" style="width: 375px; height: 30px;" required="required"
						data-options="editable:false"></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td><textarea name="roleDesc" onKeyUp="if(this.value.length>80){this.value=this.value.substring(0,80);}" style="width: 375px; height: 60px;">${role.roleDesc}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>