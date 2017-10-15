<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>
<script type="text/javascript">
  $(function() {
    $('#dictPid').combotree({
      url : '${pageContext.request.contextPath}/admin/dictionaryManager/dictionaryComboTree?excapeId=${dictionary.id}',
      parentField : 'pid',
      lines : true,
      panelHeight : 'auto',
      value : '${dictionary.dictPid}',
      onLoadSuccess : function() {
        parent.$.messager.progress('close');
      }
    });

    $('#dictType').combobox({
      editable : false
    });
    var pDictType = '${dictionary.dictType}';
    if (pDictType != '') {
      $('#dictType').combobox('setValue', pDictType);
    }

    $('#dictStatus').combobox({
      editable : false
    });
    var pDictStatus = '${dictionary.dictStatus}';
    if (pDictStatus != '') {
      $('#dictStatus').combobox('setValue', pDictStatus);
    }

    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/dictionaryManager/${operate}',
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
          parent.$.messager.alert('警告', result.msg, 'warning');
        }
      }
    });
  });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;" class="ade-gray">
		<form id="form" method="post">
			<input name="id" type="hidden" value="${dictionary.id}">
			<table class="ade-table">
				<tr>
					<th>字典名称：</th>
					<td><input id="zdName" name="dictName" type="text" placeholder="请输入字典名称" class="easyui-validatebox"
						data-options="required:true" value="${dictionary.dictName}" style="width: 140px; height: 30px;"></td>
					<th>字典编号：</th>
					<td><input id="zdCode" name="dictCode" type="text" placeholder="请输入字典编号" class="easyui-validatebox"
						data-options="required:true" value="${dictionary.dictCode}" style="width: 140px; height: 30px;"></td>
				</tr>
				<tr>
					<th>字典项值：</th>
					<td colspan="3"><input name="dictValue" value="${dictionary.dictValue}" required="required"
						style="width: 375px; height: 30px;"></td>
				</tr>
				<tr>
					<th>排序：</th>
					<td><input name="dictSort" value="${dictionary.dictSort}" class="easyui-numberspinner" required="required"
						data-options="editable:false" style="width: 140px; height: 30px;"></td>
					<th>上级字典：</th>
					<td><select id="dictPid" name="dictPid" style="width: 112px; height: 30px;"></select> <a
						class="easyui-linkbutton" onclick="$('#dictPid').combotree('clear');"><icon:icon name="clean" /></a></td>
				</tr>
				<tr>
					<th>类型：</th>
					<td><select id="dictType" name="dictType" style="width: 140px; height: 30px;" required="required">
							<option value="1">用户字典</option>
							<option value="8">系统字典</option>
					</select></td>
					<th>是否使用</th>
					<td><select id="dictStatus" name="dictStatus" style="width: 140px; height: 30px;" required="required">
							<option value="1">使用</option>
							<option value="9">不使用</option>
					</select></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td colspan="3"><textarea name="dictDesc"
							onKeyUp="if(this.value.length>80){this.value=this.value.substring(0,80);}" style="width: 375px; height: 60px;">${dictionary.dictDesc}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>