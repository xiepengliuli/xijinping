<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>
<!DOCTYPE html>
<html>
<head>
<title>用户日志管理</title>
<jsp:include page="/WEB-INF/inc/adeInc.jsp"></jsp:include>
<script type="text/javascript">
  // 构造表单
  var dataGrid;
  $(function() {

    $('#userId').combotree({
      url : '${pageContext.request.contextPath}/admin/userManager/userComboTree',
      lines : true,
      panelHeight : 'auto'
    });

    dataGrid = $('#dataGrid').datagrid({
      url : '${pageContext.request.contextPath}/admin/userLogsManager/dataGrid',
      fit : true,
      fitColumns : true,
      border : false,
      pagination : true,
      idField : 'id',
      pageSize : 10,
      pageList : [ 10, 20, 30, 40, 50 ],
      sortName : 'id',
      sortOrder : 'desc',
      checkOnSelect : false,
      selectOnCheck : false,
      nowrap : false,
      frozenColumns : [ [ {
        field : 'id',
        title : '编号',
        width : 150,
        checkbox : true
      }, {
        field : 'userName',
        title : '操作人',
        width : 150,
        sortable : true
      } ] ],
      columns : [ [ {
        field : 'logType',
        title : '操作类型',
        width : 80,
        sortable : true
      }, {
        field : 'operateTime',
        title : '操作时间',
        width : 200,
        sortable : true,
        formatter : function(value, row, index) {
          return new Date(value).format();
        }
      }, {
        field : 'content',
        title : '操作描述',
        width : 200,
        sortable : true
      }, {
        field : 'browserType',
        title : '浏览器类型',
        width : 150,
        sortable : true
      }, {
        field : 'browserVersion',
        title : '浏览器版本',
        width : 150,
        sortable : true
      }, {
        field : 'osType',
        title : '操作系统类型',
        width : 150,
        sortable : true
      }, {
        field : 'osVersion',
        title : '操作系统版本',
        width : 150,
        sortable : true
      }, {
        field : 'ip',
        title : '登录IP',
        width : 100,
        sortable : true
      } ] ],
      toolbar : '#toolbar',
      onLoadSuccess : function() {
        $('#searchForm table').show();
        $(this).datagrid('tooltip');
      },
      onRowContextMenu : function(e, rowIndex, rowData) {
        e.preventDefault();
        $(this).datagrid('unselectAll').datagrid('uncheckAll');
        $(this).datagrid('selectRow', rowIndex);
        $('#menu').menu('show', {
          left : e.pageX,
          top : e.pageY
        });
      },
      onLoadError : function() {
        $.messager.confirm('提示', '您未登录或者长时间没有操作，请重新登录！', function(result) {
          if (result) {
            parent.location.href = '${pageContext.request.contextPath}/admin/login.jsp';
          }
        });
      }
    });
  });

  // 过滤条件
  function searchFun() {
    dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
  }

  // 清空条件
  function cleanFun() {
    $('#searchForm input').val('');
    dataGrid.datagrid('load', {});
  }

  //导出系统日志==>改为导出用户日志
  function downloadFun() {
    var rows = dataGrid.datagrid('getChecked');
    var ids = [];
    if (rows.length > 0) {
      for (var i = 0; i < rows.length; i++) {
        ids.push(rows[i].id);
      }
    }
    window.location = "${pageContext.request.contextPath}/admin/userLogsManager/dowExcel?ids=" + ids.join(',');
  }
</script>
</head>
<body>

	<div class="easyui-panel" title="日志列表" data-options="fit:true">
		<div id="toolbar" style="padding: 5px; height: auto">
			<form id="searchForm">
				<table class="ade-table">
					<tr>
						<th>操作人:</th>
						<td><select id="userId" name="userId" data-options="width:150,height:25,prompt: '选择操作人',editable:false"
							style="width: 140px; height: 27px;"></select></td>
						<th>操作类型:</th>
						<td><input name="logType" placeholder="可以模糊查询操作类型"
							data-options="width:150,height:25,prompt: '选择操作类型',editable:true" class="easyui-textbox" /></td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton ade-button-1" data-options="plain:true"
							onclick="searchFun();"><icon:icon name="search" />&nbsp;查询</a><a href="javascript:void(0);"
							class="easyui-linkbutton ade-button-2" data-options="plain:true" onclick="cleanFun();"><icon:icon
									name="clean" />&nbsp;清空条件</a> <a onclick="downloadFun();" href="javascript:void(0);"
							class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon name="export" />&nbsp;导出Excel</a></td>
					</tr>
				</table>
			</form>
		</div>

		<table id="dataGrid"></table>
	</div>
</body>
</html>