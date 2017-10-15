var treeGrid;
// 初始化datagrid
$(function() {
	// 初始化数据
	treeGrid = $('#treeGrid').treegrid({ // loadFilter:function(data){return
		// undo();},
		url : ade.bp() + '/demo/channel/dataGrid',
		idField : 'id',
		treeField : 'name',
		parentField : 'pid',
		initialState : "collapsed",
		fit : true,
		fitColumns : true,
		border : false,
		pagination : false,
		singleSelect : true,
		columns : [ [ {
			title : 'id',
			field : 'id',
			width : 50,
			checkbox : true,
			hidden : true
		}, {
			field : 'name',
			title : '栏目名称',
			width : 250
		}, {
			field : 'action',
			title : '操作',
			width : 100,
			align : 'center',
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
		onLoadSuccess : function() {
			$('#dataGrid').treegrid('collapseAll');
			parent.$.messager.progress('close');

			$(this).datagrid('tooltip');
			//            
		},
		onLoadError : function() {
			$.messager.confirm('提示', '您未登录或者长时间没有操作，请重新登录！', function(result) {
				if (result) {
					parent.location.href = '${pageContext.request.contextPath}/adminlogin.jsp';
				}
			});
		}
	});

});

// 添加字典
function addFun() {
	parent.$.modalDialog({
		title : '添加栏目',
		width : 500,
		height : 240,
		href : ade.bp() + '/demo/channel/addPage',
		buttons : [ {
			text : '添加',
			handler : function() {
				parent.$.modalDialog.openner_treeGrid = treeGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
				var f = parent.$.modalDialog.handler.find('#form');
				f.submit();
			}
		} ]
	});
}

// 修改字典
function editFun(id) {
	if (id != undefined) {
		treeGrid.treegrid('select', id);
	}
	var node = treeGrid.treegrid('getSelected');
	if (node) {
		parent.$.modalDialog({
			title : '修改栏目',
			width : 500,
			height : 240,
			href : ade.bp() + '/demo/channel/editPage?id=' + node.id,
			buttons : [ {
				text : '修改',
				handler : function() {
					parent.$.modalDialog.openner_treeGrid = treeGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}
}

// 删除栏目
function deleteFun(id) {
	if (id != undefined) {
		treeGrid.treegrid('select', id);
	}
	var node = treeGrid.treegrid('getSelected');
	if (node) {
		parent.$.messager.confirm('确认', '您确定要删除所选栏目吗？', function(b) {
			if (b) {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				$.post(ade.bp() + '/demo/channel/delete', {
					id : node.id
				}, function(result) {
					if (result.success) {
						parent.$.messager.show({
							title : '成功',
							msg : result.msg
						});
						treeGrid.treegrid('reload');
					} else {
						parent.$.messager.alert('警告', result.msg, 'warning');
					}
					parent.$.messager.progress('close');
				}, 'JSON');
			}
		});
	}
}