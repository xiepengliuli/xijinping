<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>
<script type="text/javascript">
	$(function() {
		// 延迟1毫秒初始化文本框
		window.setTimeout(function() {
			editor = KindEditor.create('#editor_id', {
				minWidth : '600px',
				width : '600px',
				height : '70px',
				items : [
				//第一行
				'source', '|', 'undo', 'redo', '|', 'cut', 'copy', 'paste', 'plainpaste',
						'wordpaste', 'code', '/'
						//第二行
						, 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull',
						'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent',
						'subscript', 'superscript', 'clearhtml', 'quickformat', 'selectall', '|',
						'fullscreen', '/', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor',
						'hilitecolor', 'bold', 'italic', 'underline', 'strikethrough',
						'lineheight', 'removeformat', '|', 'image', 'flash', '/', 'media',
						'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
						'anchor', 'link', 'unlink', '/', 'template', , 'print', , 'preview' ],

				uploadJson : '${pageContext.request.contextPath}/admin/file/upload',
				fileManagerJson : '${pageContext.request.contextPath}/admin/file/fileManage',
				allowFileManager : true,
				afterBlur: function () { this.sync(); }
			});
			
			parent.$.messager.progress('close');
		}, 1);

		$('#form').form({
			url : '${pageContext.request.contextPath}/demo/userplanManager/${operate}',
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
						msg : '内容修改成功！'
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
      <input name="id" type="hidden" value="${plans.id}" />
      <table class="ade-table">
        
        <tr>
			<th>标题：</th>
			<td colspan="3"><input name="title" type="text" value="${plans.title}"
				placeholder="请输入标题" class="easyui-validatebox" data-options="required:true,validType:['length[0,100]']"
				style="height: 30px; width: 600px;" /></td>
		</tr>
				
		<tr>
			
			<th>开始时间：</th>
			<td><input name="planStartTime" value="${plans.planStartTime}" type="text" placeholder="请输入开始日期" class="easyui-datetimebox"
				data-options="width:254,height:30,editable:true" validType="numValid" value=""></td>
			<th>结束时间：</th>
			<td><input name="planEndTime" value="${plans.planEndTime}" type="text" placeholder="请输入结束日期" class="easyui-datetimebox"
				data-options="width:254,height:30,editable:true" validType="numValid" value=""></td>
		</tr>		
						
		<tr>	
			<th>内容：</th>
			<td colspan="3"><textarea style="width: 600px; height: 70px;" name="content"
					id="editor_id" class="easyui-validatebox" data-options="validType:['length[0,1000]']">${plans.content}</textarea></td>
		</tr>
					
		<tr>			
			<th>状态：</th>
			<td><input name="status" type="radio" value="0"
          		<c:if test="${plans.status != '0'||plans.status != ''||plans.status != null}">checked="checked"</c:if> />正常
          		<input name="status" type="radio" value="1"
          		<c:if test="${plans.status == '1'}">checked="checked"</c:if> />完成
          		<input name="status" type="radio" value="9" 
          		<c:if test="${plans.status == '1'}">checked="checked"</c:if> />删除</td>
		</tr>
				
		</table>
    </form>
  </div>
</div>
