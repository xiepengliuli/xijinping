var dataGrid;
var channelTree;
var channelId;

$(function() {

	$('#status').combobox({
		valueField : 'id',
		editable : false,
		textField : 'text',
		url : ade.bp() + '/demo/content/statusComboTree'
	});

	initChannelTree();
});

function initChannelTree() {

	channelTree = $('#channelTree').tree({
		url : ade.bp() + '/demo/channel/tree',
		parentField : 'pid',
		formatter : function(node) {
			return '<i class="iconfont">&#xe607;</i>' + node.text;
		},
		onLoadSuccess : function(node, data) {// 加载完成
			// 清理掉easyui-Tree中自带的图标
			$("#channelTree .tree-icon.tree-folder").remove();
			$("#channelTree .tree-icon.tree-file").remove();

			var node = channelTree.tree('getRoot');
			channelTree.tree('select', node.target);
			channelId = node.id;
			initContentDataGrid();
		},
		onClick : function(node) {
			channelId = node.id;
			initContentDataGrid();
		}
	});
}

function initContentDataGrid() {
	dataGrid = $('#dataGrid')
			.datagrid(
					{
						url : ade.bp() + '/demo/content/dataGrid',
						queryParams : {
							channelId : channelId
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
						toolbar : '#toolbar',
						frozenColumns : [ [ {
							field : 'id',
							title : '编号',
							width : 150,
							checkbox : true
						}, {
							field : 'title',
							title : '标题',
							width : 300,
							formatter : function(value, row) {
								if (row.isOutLink == '0') {
									return value;
								} else {
									return '<a href="' + row.link + '" target="_blank">' + value + '</a>';
								}
							}
						} ] ],
						columns : [ [
								{
									field : 'author',
									title : '文章作者',
									width : 150,
									hidden : true
								},
								{
									field : 'publishTimeStr',
									title : '发布时间',
									width : 80,
									hidden : false
								},
								{
									field : 'createTime',
									title : '录入时间',
									width : 120,
									sortable : true,
									formatter : function(value, row, index) {
										if (value) {
											return new Date(value).format();
										}
									}
								},
								{
									field : 'status',
									title : '状态',
									width : 50,
									formatter : function(value, row) {
										if (value == '0') {
											return '未发布';
										} else if (value == '1') {
											return '发布';
										} else if (value == '9') {
											return '删除';
										} else {
											return '其它';
										}
									}
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
															'<a onclick="editFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>',
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
										if ($.canPublish) {
											str += $
													.formatString(
															'<a onclick="publishFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
															row.id, "发布", "发布");
											str += '&nbsp;';
											str += $
													.formatString(
															'<a onclick="unPublishFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>',
															row.id, "取消发布", "取消发布");
											str += '&nbsp;';
										}
										if ($.canDelete) {
											str += $
													.formatString(
															'<a onclick="deleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
															row.id, "删除", "删除");
										}

										return str;
									}
								} ] ],
						toolbar : '#toolbar',
						onLoadSuccess : function() {
						}
					});
}

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
				$.post(ade.bp() + '/demo/content/delete', {
					id : id
				}, function(result) {
					if (result.success) {

						parent.$.messager.show({
							title : '提示',
							msg : result.msg
						});

						// parent.$.messager.alert('提示', result.msg, 'info');
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
		href : ade.bp() + '/demo/content/editPage?id=' + id,
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
		height : 700,
		href : ade.bp() + '/demo/content/addPage?channelId=' + channelId,
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

function publishFun(id) {

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
				$.post(ade.bp() + '/demo/content/delete', {
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

function unPublishFun(id) {

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
				$.post(ade.bp() + '/demo/content/delete', {
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

function searchFun() {
	dataGrid.datagrid('load', {
		channelId : channelId,
		title : $('#title').val(),
		status : $('#status').combobox('getValue')
	});
}

function cleanFun() {
	$('#searchForm').form('reset');
	dataGrid.datagrid('load', {
		channelId : channelId
	});
}

function previewFun(id) {
	window.open(ade.bp() + "/demo/content/detail/" + id);
}