<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  var dataGrid;
  var roles = '${user.roleIds}';
  $(function() {
    dataGrid = $('#dataGrid').datagrid({
      url : '${pageContext.request.contextPath}/admin/roleManager/dataGrid',
      fit : true,
      rownumbers : true,
      fitColumns : true,
      border : false,
      striped : true,
      pagination : false,
      idField : 'id',
      sortName : 'roleName',
      sortOrder : 'asc',
      checkOnSelect : true,
      selectOnCheck : true,
      nowrap : true,
      frozenColumns : [ [ {
        field : 'id',
        title : '编号',
        width : 150,
        checkbox : true
      }, {
        field : 'roleName',
        title : '角色名称',
        width : 150
      } ] ],
      columns : [ [ {
        field : 'moduleIds',
        title : '拥有资源',
        width : 250,
        formatter : function(value, row) {
          if (value) {
            return row.moduleNames;
          }
          return '';
        }
      }, {
        field : 'moduleNames',
        title : '拥有资源名称',
        width : 80,
        hidden : true
      } ] ],
      onContextMenu : function(e, row) {
        e.preventDefault();
        $(this).treegrid('unselectAll');
        $(this).treegrid('select', row.id);
        $('#menu').menu('show', {
          left : e.pageX,
          top : e.pageY
        });
      },
      onLoadSuccess : function() {
        if (roles != null && roles != '') {
          var roleIdArray = roles.split(",");
          for (var i = 0; i < roleIdArray.length; i++) {
            var rowIndex = $(this).datagrid('getRowIndex', roleIdArray[i]);
            $(this).datagrid('selectRow', rowIndex);
          }
        }
        parent.$.messager.progress('close');
        $(this).treegrid('tooltip');
      }
    });

    $('#form').form(
        {
          url : '${pageContext.request.contextPath}/admin/userManager/grant',

          onSubmit : function() {
            parent.$.messager.progress({
              title : '提示',
              text : '数据处理中，请稍后....'
            });
            var ids = [];
            var rows = dataGrid.datagrid('getChecked');
            var isValid = true;

            for (var i = 0; i < rows.length; i++) {
              ids.push(rows[i].id);
            }

            $('#roleIds').val(ids.join(','));
            parent.$.messager.progress('close');
            return true;
          },
          success : function(result) {

            parent.$.messager.progress('close');
            result = $.parseJSON(result);
            if (result.success) {

              parent.$.messager.show({
                title : '提示',
                msg : '授权成功！'
              });

              parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
              parent.$.modalDialog.handler.dialog('close');
              parent.$.modalDialog.openner_dataGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid(
                  'clearSelections');
            } else {
              parent.$.messager.alert('错误', result.msg, 'error');
            }
          }
        });
  });
</script>


<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<table id="dataGrid"></table>
	</div>
</div>

<form id="form" method="post">
	<input name="userId" type="hidden" value="${user.id}" /><input id="roleIds" name="roleIds" type="hidden" value="" />
</form>