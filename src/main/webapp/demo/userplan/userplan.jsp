<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>ade3demo</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/userplanManager/editPage')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/userplanManager/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>

<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/demo/userplanManager/dataGrid',
			fit : true,
			rownumbers : true,
			fitColumns : true,
			border : false,
			striped : true,
			pagination : true,
			idField : 'id',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'title',
			sortOrder : 'asc',
			checkOnSelect : false,
			selectOnCheck : false,
			nowrap : true,
			toolbar : '#toolbar',
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : 150,
				checkbox : true
			}, {
				field : 'title',
				title : '标题',
				width : 200
			} ] ],
			columns : [ [ {
				field : 'content',
				title : '内容',
				width : 300,
				hidden : false
			}, {
				field : 'planStartTime',
				title : '开始时间',
				width : 80,
				hidden : false,
				formatter : function(value, row, index) {
					if (value) {
						return new Date(value).format();
					}
				}
			}, {
				field : 'planEndTime',
				title : '结束时间',
				width : 80,
				hidden : false,
				formatter : function(value, row, index) {
					if (value) {
						return new Date(value).format();
					}
				}
			}, {
				field : 'userName',
				title : '创建人',
				width : 50,
				hidden : false
			}, {
				field : 'status',
				title : '状态',
				width : 50,
				formatter : function(value, row) {
					if (value == '0') {
						return '正常';
					} else if (value == '1') {
						return '完成';
					} else {
						return '删除';
					}

				}

			}, {
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {

					var str = '';
					if ($.canEdit) {
						str += $.formatString('<a onclick="editFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>', row.id, "编辑", "编辑");
						str += '&nbsp;';
					}

					if ($.canDelete) {
						str += $.formatString('<a onclick="deleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>', row.id, "删除", "删除");
					}

					return str;
				}
			} ] ],
			toolbar : '#toolbar',
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
				//                 parent.$.messager.progress('close');

				$(this).treegrid('tooltip');
			}
		});
	});

	function deleteFun(id) {

		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前内容？', function(b) {
			if (b) {
				var currentUserId = '${LOGIN_USER.id}';/*当前登录用户的ID*/
				if (currentUserId != id) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${pageContext.request.contextPath}/demo/userplanManager/delete', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : '不可以删除自己！'
					});
				}
			}
		});
	}

	function editFun(id) {

		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}

		parent.$.modalDialog({
			title : '编辑用户',
			width : 800,
			height : 600,
			href : '${pageContext.request.contextPath}/demo/userplanManager/editPage?id=' + id,
			buttons : [ {
				text : '保存',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});

	}

	function addFun() {

		parent.$.modalDialog({
			title : '添加内容',
			width : 800,
			height : 600,
			href : '${pageContext.request.contextPath}/demo/userplanManager/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}

	function redo() {
		var node = dataGrid.dataGrid('getSelected');
		if (node) {
			dataGrid.dataGrid('expandAll', node.id);
		} else {
			dataGrid.dataGrid('expandAll');
		}
	}

	function undo() {
		var node = dataGrid.dataGrid('getSelected');
		if (node) {
			dataGrid.dataGrid('collapseAll', node.id);
		} else {
			dataGrid.dataGrid('collapseAll');
		}
	}
</script>
</head>
<body>

	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(LOGIN_USER.moduleList, '/demo/userplanManager/addPage')}">
			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton ade-button-1" data-options="plain:true">
				<icon:icon name="add" />&nbsp;添加
			</a>
		</c:if>
		<a onclick="dataGrid.datagrid('reload');" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
			data-options="plain:true"> <icon:icon name="refresh" />&nbsp;刷新
		</a>
	</div>
</body>
</html>
