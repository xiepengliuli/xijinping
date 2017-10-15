<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
  $(function() {
    parent.$.messager.progress('close');
    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/userManager/importInfo',
      fileElementId : 'btnFile',
      success : function(result) {
        result = $.parseJSON(result);
        if (result.success) {
          parent.$.messager.alert('成功', result.msg, 'info');
          parent.$.modalDialog.openner_dataGrid.datagrid('reload');
          parent.$.modalDialog.handler.dialog('close');
        } else {
          parent.$.messager.alert('错误', result.msg, 'error');
        }
      }
    });
  });
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title=""
		style="overflow: hidden;">
		<form id="form" method="post" enctype="multipart/form-data">
			<table class="table table-hover table-condensed">
				<tr>
					<th>选择Excel文件</th>
					<td><input type="file" id="btnFile" name="btnFile"
						class="easyui-validatebox" /></td>
				</tr>
			</table>
		</form>
		<span style="color: red; font-size: 14px; margin-left: 5px;">选择标准.xlsx文件</span>
	</div>
</div>
