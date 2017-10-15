<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  $(function() {
    parent.$.messager.progress('close');

    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/moduleManager/${operate}',
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
          parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为resource.jsp页面预定义好了
          parent.$.modalDialog.handler.dialog('close');
          parent.$.messager.show({
            title : '成功',
            msg : result.msg
          });
        }
      }
    });
  });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="form" method="post">

			<table class="ade-table">
				<tr>
					<th>资源名称：</th>
					<td colspan="3"><input type="hidden" name="id" value="${module.id}" /> <input type="hidden" name="moduleType" value="1" /> <input type="hidden"
						name="moduleGround" value="${module.moduleGround}" /><input name="moduleName" type="text" placeholder="请输入资源名称" class="easyui-validatebox"
						data-options="required:true" style="width: 375px; height: 30px;" value="${module.moduleName}" /></td>
				</tr>
				<tr>
					<th>资源路径：</th>
					<td colspan="3"><input name="moduleUrl" type="text" placeholder="请输入资源路径" class="easyui-validatebox" style="width: 375px; height: 30px;"
						value="${module.moduleUrl}" /></td>
				</tr>
				<tr>
					<th>上级资源：</th>
					<td><input id="parentModuleId" name="parentModuleId" type="hidden" value="${module.parentModuleId}" /> ${module.parentModuleName }</td>
					<th>排序：</th>
					<td><input name="moduleSort" class="easyui-numberspinner" style="width: 140px; height: 32px;" required="required"
						data-options="editable:false,min:100" value="<c:out value="${module.moduleSort}" default="100"/>" /></td>
				</tr>
				<tr>
					<th>描述:</th>
					<td colspan="3"><textarea name="moduleDesc" style="width: 375px; height: 60px;">${module.moduleDesc}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>