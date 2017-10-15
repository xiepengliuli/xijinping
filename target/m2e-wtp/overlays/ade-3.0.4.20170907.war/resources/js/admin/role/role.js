var dataGrid;
$(function() {
  dataGrid = $('#dataGrid').datagrid(
      {
        url : ade.bp() + '/admin/roleManager/dataGrid',
        fit : true,
        rownumbers : true,
        fitColumns : true,
        border : false,
        striped : true,
        pagination : true,
        idField : 'id',
        pageSize : 10,
        pageList : [ 10, 20, 30, 40, 50 ],
        sortName : 'roleName',
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
          field : 'roleName',
          title : '角色名称',
          width : 150
        } ] ],
        columns : [ [
            {
              field : 'roleSort',
              title : '排序',
              width : 40
            },
            {
              field : 'roleIsBuildin',
              title : '角色类型',
              width : 80,
              formatter : function(value, row) {
                if (value && value == 1) {
                  return '内置';
                }
                return '标准';
              }
            },
            {
              field : 'moduleIds',
              title : '拥有资源',
              width : 250,
              formatter : function(value, row) {
                if (value) {
                  return row.moduleNames;
                }
                return '';
              }
            },
            {
              field : 'moduleNames',
              title : '拥有资源名称',
              width : 80,
              hidden : true
            },
            {
              field : 'roleDesc',
              title : '备注',
              width : 150
            },
            {
              field : 'action',
              title : '操作',
              align : 'center',
              width : 70,
              formatter : function(value, row, index) {

                var roleIsBuildin = row.roleIsBuildin;

                var str = '';
                if ($.canEdit) {
                  if (!roleIsBuildin || roleIsBuildin != 1) {
                    str += $.formatString(
                        '<a onclick="editFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>', row.id,
                        "编辑", "编辑");
                    str += '&nbsp;';
                  }
                }

                if ($.canGrant) {
                  str += $.formatString(
                      '<a onclick="grantFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>', row.id,
                      "授权", "授权");
                  str += '&nbsp;';
                }

                if ($.canDelete) {
                  if (!roleIsBuildin || roleIsBuildin != 1) {
                    str += $.formatString(
                        '<a onclick="deleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
                        row.id, "删除", "删除");
                  }
                }

                return str;
              }
            } ] ],
        toolbar : '#toolbar',
        onLoadSuccess : function() {
          $(this).treegrid('tooltip');
        }
      });
});

function deleteFun(id, name) {

  if (id == undefined) {// 点击右键菜单才会触发这个
    var rows = dataGrid.datagrid('getSelections');
    id = rows[0].id;
    name = rows[0].roleName;
  } else {// 点击操作里面的删除图标会触发这个
    dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
  }
  parent.$.messager.confirm('询问', '您是否要删除角色[' + name + ']？', function(b) {
    if (b) {
      var currentUserId = '${LOGIN_USER.id}';/* 当前登录用户的ID */
      if (currentUserId != id) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        $.post(ade.bp() + '/admin/roleManager/delete', {
          id : id
        }, function(result) {
          if (result.success) {
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
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
    width : 500,
    height : 280,
    href : ade.bp() + '/admin/roleManager/editPage?id=' + id,
    buttons : [ {
      text : '编辑',
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
    title : '添加角色',
    width : 500,
    height : 280,
    href : ade.bp() + '/admin/roleManager/addPage',
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

function grantFun(id) {

  dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
  parent.$.modalDialog({
    title : '用户授权',
    width : 500,
    height : 500,
    href : ade.bp() + '/admin/roleManager/grantPage?id=' + id,
    buttons : [ {
      text : '授权',
      handler : function() {
        parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为授权成功之后，需要刷新这个dataGrid，所以先预定义好
        var f = parent.$.modalDialog.handler.find('#form');
        f.submit();
      }
    } ]
  });
}