var dataGrid;
$(function() {
  dataGrid = $('#dataGrid').datagrid(
      {
        url : ade.bp() + '/admin/userManager/dataGrid',
        fit : true,
        rownumbers : true,
        fitColumns : true,
        border : false,
        striped : true,
        pagination : true,
        idField : 'id',
        pageSize : 10,
        pageList : [ 10, 20, 30, 40, 50 ],
        sortName : 'loginName',
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
          field : 'loginName',
          title : '登录名称',
          width : 80,
          sortable : true
        } ] ],
        columns : [ [
            {
              field : 'userName',
              title : '姓名',
              width : 60
            },
            {
              field : 'sex',
              title : '性别',
              width : 50
            },
            {
              field : 'userState',
              title : '状态',
              width : 60,
              formatter : function(value, row, index) {
                if (value && value == 1) {
                  return '正常';
                }

                return '停用';
              }
            },
            {
              field : 'createDate',
              title : '创建时间',
              width : 120,
              sortable : true,
              formatter : function(value, row, index) {
                if (value) {
                  return new Date(value).format();
                }
              }
            },
            {
              field : 'updateDate',
              title : '修改时间',
              width : 120,
              sortable : true,
              formatter : function(value, row, index) {
                if (value) {
                  return new Date(value).format();
                }
              }
            },
            {
              field : 'roleIds',
              title : '所属角色ID',
              width : 150,
              hidden : true
            },
            {
              field : 'roleNames',
              title : '所属角色名称',
              width : 150
            },
            {
              field : 'organizationName',
              title : '所属部门名称',
              width : 150
            },
            {
              field : 'action',
              title : '操作',
              width : 120,
              align : 'center',
              formatter : function(value, row, index) {
                var str = '';

                if (!row.userState || row.userState != 1) {
                  str += $.formatString(
                      '<a onclick="recovery(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>', row.id,
                      "启用", "启用");

                } else {

                  if ($.canEditPwd) {
                    str += $.formatString(
                        '<a onclick="editPwdFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-1">{2}</a>',
                        row.id, "修改密码", "修改密码");
                    str += '&nbsp;';
                  }

                  if ($.canEdit) {
                    str += $.formatString(
                        '<a onclick="editFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>', row.id,
                        "编辑", "编辑");

                  }
                  str += '&nbsp;';
                  if ($.canGrant) {
                    str += $.formatString(
                        '<a onclick="grantFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
                        row.id, "授权", "授权");

                  }
                  str += '&nbsp;';
                  if ($.canDelete) {
                    str += $.formatString(
                        '<a onclick="deleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
                        row.id, "停用", "停用");
                  }
                }
                return str;
              }
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
        }
      });
});

function editPwdFun(id) {
  dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
  parent.$.modalDialog({
    title : '编辑用户密码',
    width : 300,
    height : 230,
    href : ade.bp() + '/admin/userManager/editPwdPage?id=' + id,
    buttons : [ {
      text : '修改密码',
      handler : function() {
        parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
        var f = parent.$.modalDialog.handler.find('#form');
        f.submit();
      }
    } ]
  });
}

function deleteFun(id) {
  if (id == undefined) {// 点击右键菜单才会触发这个
    var rows = dataGrid.datagrid('getSelections');
    id = rows[0].id;
  } else {// 点击操作里面的删除图标会触发这个
    dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
  }
  parent.$.messager.confirm('询问', '您是否要停用当前选择用户？', function(b) {
    if (b) {
      // var currentUserId = '${LOGIN_USER.id}';/*当前登录用户的ID*/
      if (currentUserId != id) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        $.post(ade.bp() + '/admin/userManager/delete', {
          id : id
        }, function(result) {
          if (result.success) {
            // parent.$.messager.show('提示', result.msg, 'info');
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
            dataGrid.datagrid('reload');
          }
          parent.$.messager.progress('close');
        }, 'JSON');
      } else {
        parent.$.messager.alert('提示', '不可以停用自己！', 'error');
      }
    }
  });
}

function recovery(id) {
  if (id == undefined) {// 点击右键菜单才会触发这个
    var rows = dataGrid.datagrid('getSelections');
    id = rows[0].id;
  } else {// 点击操作里面的删除图标会触发这个
    dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
  }
  parent.$.messager.confirm('询问', '您是否要启用当前选择用户？', function(b) {
    if (b) {
      // var currentUserId = '${LOGIN_USER.id}';/*当前登录用户的ID*/
      if (currentUserId != id) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        $.post(ade.bp() + '/admin/userManager/recovery', {
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

function batchDeleteFun() {
  var rows = dataGrid.datagrid('getChecked');
  var ids = [];
  if (rows.length > 0) {
    parent.$.messager.confirm('确认', '您是否要停用当前选中的用户？', function(r) {
      if (r) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        // var currentUserId = '${LOGIN_USER.id}';/*当前登录用户的ID*/
        var flag = false;
        for (var i = 0; i < rows.length; i++) {
          if (currentUserId != rows[i].id) {
            ids.push(rows[i].id);
          } else {
            flag = true;
          }
        }
        $.getJSON(ade.bp() + '/admin/userManager/batchDelete', {
          ids : ids.join(',')
        }, function(result) {
          if (result.success) {
            dataGrid.datagrid('load');
            dataGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
          }
          if (flag) {
            parent.$.messager.alert('提示', '不可以停用自己！', 'error');
          } else {
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
          }
          parent.$.messager.progress('close');
        });
      }
    });
  } else {
    parent.$.messager.alert('提示', '请勾选要停用的用户！', 'info');
  }
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
    width : 530,
    height : 480,
    href : ade.bp() + '/admin/userManager/editPage?id=' + id,
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
    title : '添加用户',
    width : 550,
    height : 470,
    href : ade.bp() + '/admin/userManager/addPage',
    iconCls : 'pencil_add',
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

function batchGrantFun() {
  var rows = dataGrid.datagrid('getChecked');
  var ids = [];
  if (rows.length > 0) {
    for (var i = 0; i < rows.length; i++) {
      ids.push(rows[i].id);
    }
    parent.$.modalDialog({
      title : '用户授权',
      width : 500,
      height : 300,
      href : ade.bp() + '/admin/userManager/grantPage?ids=' + ids.join(','),
      buttons : [ {
        text : '授权',
        handler : function() {
          parent.$.modalDialog.openner_dataGrid = dataGrid;// 因为授权成功之后，需要刷新这个dataGrid，所以先预定义好
          var f = parent.$.modalDialog.handler.find('#form');
          f.submit();
        }
      } ]
    });
  } else {
    parent.$.messager.alert('提示', '请勾选要授权的用户！', 'info');
  }
}

function grantFun(id) {
  dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
  parent.$.modalDialog({
    title : '用户授权',
    width : 900,
    height : 300,
    href : ade.bp() + '/admin/userManager/grantPage?ids=' + id,
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

function searchFun() {
  dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
}
function cleanFun() {
  $('#searchForm').form('reset');
  dataGrid.datagrid('load', {});
}

/* 导入功能 */
function importFun() {
  parent.$.modalDialog({
    title : '导入文件',
    width : 500,
    height : 200,
    href : ade.bp() + '/admin/userManager/importPage',
    buttons : [ {
      text : '导入文件',
      handler : function() {
        parent.$.modalDialog.openner_dataGrid = dataGrid; // 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
        var f = parent.$.modalDialog.handler.find('#form');
        f.submit();
      }
    } ]
  });
}

function moreFun() {
  $('.ade-table-more').fadeToggle();
}

function editMyselfPwdFun() {
  dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
  parent.$.modalDialog({
    title : '修改密码',
    width : 500,
    height : 310,
    href : ade.bp() + '/admin/userManager/editMyselfPwdPage',
    buttons : [ {
      text : '修改密码',
      handler : function() {
        parent.$.modalDialog.openner_dataGrid = dataGrid; // 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
        var f = parent.$.modalDialog.handler.find('#editCurrentUserPwdForm');
        f.submit();
      }
    } ]
  });
}