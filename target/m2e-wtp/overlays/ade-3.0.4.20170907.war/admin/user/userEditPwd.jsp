<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  $(function() {
    parent.$.messager.progress('close');
    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/userManager/editPwd',
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
          parent.$.messager.show({
            title : '成功',
            msg : result.msg
          });
          parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
          parent.$.modalDialog.handler.dialog('close');
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
			<input name="id" type="hidden" value="${user.id}" />
			<table class="ade-table">
				<tr>
					<th>登录名：</th>
					<td>${user.loginName}</td>
				</tr>
				<tr>
					<th>姓名：</th>
					<td>${user.loginName}</td>
				</tr>
				<tr>
					<th>密码：</th>
					<td><input name="password" type="password" placeholder="请输入密码" class="easyui-validatebox"
						style="width: 140px; height: 32px;" data-options="required:true"></td>
				</tr>
			</table>
		</form>
	</div>
</div>