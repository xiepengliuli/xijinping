var dataGrid;
var dataGrid2;
var channelTree;

$(function() {
	initChannelTree();
});

function initChannelTree() {

	channelTree = $('#channelTree').tree({
		url : ade.bp() + '/demo/monthPlan/tree',
		parentField : 'pid',
		formatter : function(node) {
			return '<i class="iconfont">&#xe607;</i>' + node.text;
		},
		onLoadSuccess : function(node, data) {// 加载完成
			// 清理掉easyui-Tree中自带的图标
			$("#channelTree .tree-icon.tree-folder").remove();
			$("#channelTree .tree-icon.tree-file").remove();

			var nodes = channelTree.tree('getRoot');
		},
		onClick : function(node) {
			var children = channelTree.tree('getChildren', node.target);
			if (children.length == 0) {
				initPlanDataGrid(node.id);
				initPlanCompleteDataGrid(node.id);
				$("#noteId").val(node.id);
			}
		}
	});
}

function initPlanCompleteDataGrid(queryTime) {
	dataGrid = $('#dataGrid')
			.datagrid(
					{
						url : ade.bp() + '/demo/monthPlan/dataGrid',
						queryParams : {
							queryTime : queryTime
						},
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
						frozenColumns : [ [ {
							field : 'id',
							title : '编号',
							width : 50,
							checkbox : true
						} ] ],
						columns : [ [
								{
									field : 'organName',
									title : '部门',
									width : 80,
									hidden : false
								},
								{
									field : 'planLevelName',
									title : '级别',
									width : 50,
									hidden : false
								},
								{
									field : 'planContent',
									title : '计划工作内容',
									width : 80,
									hidden : false
								},
								{
									field : 'completeGoals',
									title : '完成目标',
									width : 80,
									hidden : false
								},
								{
									field : 'planfinishtime',
									title : '计划完成时间',
									width : 80,
									hidden : false
								},
								{
									field : 'implementationPlan',
									title : '实施方案',
									width : 80,
									hidden : false
								},
								{
									field : 'implementationUser',
									title : '实施人',
									width : 80,
									hidden : false
								},
								{
									field : 'planRemark',
									title : '备注(计划)',
									width : 80,
									hidden : false
								},
								{
									field : 'completeSituation',
									title : '完成情况',
									width : 80,
									hidden : false
								},
								{
									field : 'completeRatio',
									title : '完成比率(%)',
									width : 80,
									hidden : false
								},
								{
									field : 'reason',
									title : '原因分析',
									width : 80,
									hidden : false
								},
								{
									field : 'realremark',
									title : '备注(完成)',
									width : 80,
									hidden : false
								},
								{
									field : 'sortid',
									title : '排序',
									width : 50,
									hidden : false
								},
								{
									field : 'action',
									title : '操作',
									width : 70,
									formatter : function(value, row, index) {
										var str = '';
										if ($.canEdit) {
											str += $
													.formatString(
															'<a onclick="editPlanCompleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>',
															row.id, "编辑", "编辑");
											str += '&nbsp;';
										}
										if ($.canView) {
											str += $
													.formatString(
															'<a onclick="previewFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-1">{2}</a>',
															row.id, "预览", "预览");
											str += '&nbsp;';
										}
										if ($.canDelete) {
											str += $
													.formatString(
															'<a onclick="deletePlanCompleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
															row.id, "删除", "删除");
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
							parent.$.messager.progress('close');
						}
					});
}

function initPlanDataGrid(queryTime) {
	dataGrid2 = $('#dataGrid2')
			.datagrid(
					{
						url : ade.bp() + '/demo/monthPlan/completeDataGrid',
						fit : true,
						queryParams : {
							queryTime : queryTime
						},
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
						frozenColumns : [ [ {
							field : 'id',
							title : '编号',
							width : 50,
							checkbox : true
						} ] ],
						columns : [ [
								{
									field : 'organName',
									title : '部门',
									width : 80,
									hidden : false
								},
								{
									field : 'planLevelName',
									title : '级别',
									width : 40,
									hidden : false
								},
								{
									field : 'planContent',
									title : '计划工作内容',
									width : 80,
									hidden : false
								},
								{
									field : 'completeGoals',
									title : '完成目标',
									width : 80,
									hidden : false
								},
								{
									field : 'planfinishtime',
									title : '计划完成时间',
									width : 80,
									hidden : false
								},
								{
									field : 'implementationPlan',
									title : '实施方案',
									width : 80,
									hidden : false
								},
								{
									field : 'implementationUser',
									title : '实施人',
									width : 80,
									hidden : false
								},
								{
									field : 'planRemark',
									title : '备注(下月计划)',
									width : 80,
									hidden : false
								},
								{
									field : 'sortid',
									title : '排序',
									width : 50,
									hidden : false
								},
								{
									field : 'action',
									title : '操作',
									width : 70,
									formatter : function(value, row, index) {
										var str = '';
										if ($.canEdit) {
											str += $
													.formatString(
															'<a onclick="editPlanFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>',
															row.id, "编辑", "编辑");
											str += '&nbsp;';
										}
										if ($.canView) {
											str += $
													.formatString(
															'<a onclick="previewFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-1">{2}</a>',
															row.id, "预览", "预览");
											str += '&nbsp;';
										}
										if ($.canDelete) {
											str += $
													.formatString(
															'<a onclick="deletePlanFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
															row.id, "删除", "删除");
										}

										return str;
									}
								} ] ],
						toolbar : '#toolbar2',
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
							parent.$.messager.progress('close');
						}
					});
}

// function searchFun() {
// dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
// dataGrid2.datagrid('load', $.serializeObject($('#searchForm')));
// }
// function cleanFun() {
// $('#searchForm').form('reset');
// dataGrid.datagrid('load', {});
// }

function deleteFun(id) {

	if (id == undefined) {// 点击右键菜单才会触发这个
		var rows = dataGrid.datagrid('getSelections');
		id = rows[0].id;
	} else {// 点击操作里面的删除图标会触发这个
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
	}
	parent.$.messager.confirm('询问', '您是否要删除当前内容？', function(b) {
		if (b) {
			var currentUserId = '${LOGIN_USER.id}';/* 当前登录用户的ID */
			if (currentUserId != id) {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				$.post(ade.bp() + '/demo/monthPlan/deletePlan', {
					id : id
				}, function(result) {
					if (result.success) {
						parent.$.messager.alert('提示', result.msg, 'info');
						dataGrid.datagrid('reload');
					} else {
						parent.$.messager.show({
							title : '提示',
							msg : result.msg
						});
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

function deletePlanFun(id) {

	if (id == undefined) {// 点击右键菜单才会触发这个
		var rows = dataGrid2.datagrid('getSelections');
		id = rows[0].id;
	} else {// 点击操作里面的删除图标会触发这个
		dataGrid2.datagrid('unselectAll').datagrid('uncheckAll');
	}
	parent.$.messager.confirm('询问', '您是否要删除当前内容？', function(b) {
		if (b) {
			parent.$.messager.progress({
				title : '提示',
				text : '数据处理中，请稍后....'
			});
			$.post(ade.bp() + '/demo/monthPlan/deletePlan', {
				id : id
			}, function(result) {
				if (result.success) {
					parent.$.messager.alert('提示', result.msg, 'info');
					dataGrid2.datagrid('reload');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : result.msg
					});
				}
				parent.$.messager.progress('close');
			}, 'JSON');
		}
	});
}

function deletePlanCompleteFun(id) {

	if (id == undefined) {// 点击右键菜单才会触发这个
		var rows = dataGrid.datagrid('getSelections');
		id = rows[0].id;
	} else {// 点击操作里面的删除图标会触发这个
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
	}
	parent.$.messager.confirm('询问', '您是否要删除当前内容？', function(b) {
		if (b) {
			parent.$.messager.progress({
				title : '提示',
				text : '数据处理中，请稍后....'
			});
			$.post(ade.bp() + '/demo/monthPlan/deletePlanComplete', {
				id : id
			}, function(result) {
				if (result.success) {
					parent.$.messager.alert('提示', result.msg, 'info');
					dataGrid.datagrid('reload');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : result.msg
					});
				}
				parent.$.messager.progress('close');
			}, 'JSON');
		}
	});
}

function editPlanFun(id) {

	if (id == undefined) {
		var rows = dataGrid2.datagrid('getSelections');
		id = rows[0].id;
	} else {
		dataGrid2.datagrid('unselectAll').datagrid('uncheckAll');
	}

	parent.$.modalDialog({
		title : '编辑计划',
		width : 500,
		height : 530,
		href : ade.bp() + '/demo/monthPlan/editPlanPage?id=' + id,
		buttons : [ {
			text : '保存',
			handler : function() {
				parent.$.modalDialog.openner_dataGrid2 = dataGrid2;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
				var f = parent.$.modalDialog.handler.find('#form');
				f.submit();
			}
		} ]
	});
}
function editPlanCompleteFun(id) {

	if (id == undefined) {
		var rows = dataGrid.datagrid('getSelections');
		id = rows[0].id;
	} else {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
	}

	parent.$.modalDialog({
		title : '编辑完成情况',
		width : 800,
		height : 600,
		href : ade.bp() + '/demo/monthPlan/editPlanCompletePage?id=' + id,
		buttons : [ {
			text : '保存',
			handler : function() {
				parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
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
		href : ade.bp() + '/demo/content/addPage',
		buttons : [ {
			text : '添加',
			handler : function() {
				parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
				var f = parent.$.modalDialog.handler.find('#form');
				f.submit();
			}
		} ]
	});
}

function previewFun(id) {
	window.open("${pageContext.request.contextPath}/content/contentDetail?id="
			+ id);
}

function addChannelFun() {
//	parent.$.modalDialog({
//		title : '添加栏目',
//		width : 400,
//		height : 250,
//		href : ade.bp() + '/demo/monthPlan/addMonthPage',
//		buttons : [ {
//			text : '添加',
//			handler : function() {
//				parent.$.modalDialog.openner_tree = channelTree;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
//				// var f = parent.$.modalDialog.handler.find('#form');
//				// f.submit();
//			}
//		} ]
//	});
	parent.$.messager.progress({
		title : '提示',
		text : '数据处理中，请稍后....'
	});
	$.post(ade.bp() + '/demo/monthPlan/addPlanMonth', function(result) {
		if (result.success) {
			parent.$.messager.alert('提示', result.msg, 'info');
			channelTree.tree('reload')
		} else {
			parent.$.messager.show({
				title : '提示',
				msg : result.msg
			});
		}
		parent.$.messager.progress('close');
	}, 'JSON');
}

function addPlanFun() {
	// alert($("#noteId").val());
	parent.$
			.modalDialog({
				title : '添加下月计划',
				width : 500,
				height : 530,
				href : ade.bp() + '/demo/monthPlan/addPlanPage?noteId='
						+ $("#noteId").val(),
				buttons : [ {
					text : '添加',
					handler : function() {
						parent.$.modalDialog.openner_dataGrid2 = dataGrid2;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
						var f = parent.$.modalDialog.handler.find('#form');
						f.submit();
					}
				} ]
			});
}
function addPlanCompleteFun() {
	// alert($("#noteId").val());
	parent.$.modalDialog({
		title : '添加完成情况',
		width : 800,
		height : 600,
		href : ade.bp() + '/demo/monthPlan/addPlanCompletePage?noteId='
				+ $("#noteId").val(),
		buttons : [ {
			text : '添加',
			handler : function() {
				parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
				var f = parent.$.modalDialog.handler.find('#form');
				f.submit();
			}
		} ]
	});
}

function exportChannelFun() {

	var rows = channelTree.tree('getSelected');
	
	if (!rows) {
		parent.$.messager.alert('警告', '请选择一个月份后再导出', 'warning');
		return;
	}
	id = rows.id;

	parent.$.messager.confirm('询问', '您是否要导出当前月度报表？', function(b) {
		if (b) {
			window.location.href = ade.bp() + '/demo/monthPlan/exportPlan?id=' + id;
		}
	});

}