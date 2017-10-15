var treeGrid;
var authGrid;
var moduleGroundMapping;// 维度的映射表
$(function() {

  treeGrid = $('#treeGrid').treegrid(
      {
        url : ade.bp() + '/admin/moduleManager/treeGrid',
        idField : 'id',
        treeField : 'moduleName',
        parentField : 'parentModuleId',
        fit : true,
        fitColumns : true,
        border : false,
        striped : true,
        singleSelect : true,
        onClickRow : loadPermissionGrid,
        frozenColumns : [ [ {
          title : '编号',
          field : 'id',
          width : 150,
          hidden : true
        } ] ],
        columns : [ [
            {
              field : 'moduleName',
              title : '资源名称',
              width : 130
            },
            {
              field : 'moduleGround',
              title : '维度',
              width : 50,
              formatter : function(value, row, index) {

                if (moduleGroundMapping) {
                  for (var i = 0; i < moduleGroundMapping.length; i++) {
                    var moduleGround = moduleGroundMapping[i];

                    if (moduleGround.dictCode == value) {
                      return moduleGround.dictName;
                    }
                  }
                }
                return "";
              }
            },
            {
              field : 'moduleSort',
              title : '排序',
              width : 50
            },
            {
              field : 'action',
              title : '操作',
              width : 70,
              align : 'center',
              formatter : function(value, row, index) {
                var str = '';
                if ($.canEdit) {
                  str += $.formatString(
                      '<a onclick="editFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>', row.id,
                      "编辑", "编辑");
                }
                str += '&nbsp;';
                if ($.canDelete) {
                  str += $.formatString(
                      '<a onclick="deleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>', row.id,
                      "删除", "删除");
                }
                return str;
              }
            } ] ],
        toolbar : '#menuToolbar',
        onBeforeLoad : function() {
          $.ajax({
            type : "GET",
            async : false,
            url : ade.bp() + "/admin/dictionaryManager/getDictsByTypeCode",
            data : {
              dictCode : 'ade_module_ground'
            },
            dataType : "json",
            success : function(data) {
              moduleGroundMapping = data;
            }
          });

          return true;
        },
        onLoadSuccess : function() {
          $(this).treegrid('tooltip');
        }
      });
  loadPermissionGrid(null);
});

function loadPermissionGrid(row) {

  var pid = "";
  if (row) {
    pid = row.id;
  }

  if (pid == '') { // 如果什么取到ID，则使用当前选中行
    var rowSelected = treeGrid.datagrid('getSelected');
    if (rowSelected) {
      pid = rowSelected.id;
    }
  }

  authGrid = $('#authGrid')
      .treegrid(
          {
            url : ade.bp() + '/admin/moduleManager/dataGridForPermissions',
            queryParams : {
              pid : pid
            },
            fit : true,
            fitColumns : true,
            border : false,
            pagination : true,
            idField : 'id',
            pageSize : 10,
            pageList : [ 10, 20, 30, 40, 50 ],
            checkOnSelect : false,
            selectOnCheck : false,
            nowrap : false,
            striped : true,
            rownumbers : true,
            singleSelect : true,
            frozenColumns : [ [ {
              title : '编号',
              field : 'id',
              width : 150,
              hidden : true
            } ] ],
            columns : [ [
                {
                  field : 'moduleName',
                  title : '资源名称',
                  width : 100
                },
                {
                  field : 'moduleUrl',
                  title : '资源路径',
                  width : 230
                },
                {
                  field : 'moduleTypeId',
                  title : '资源类型ID',
                  width : 150,
                  hidden : true
                },
                {
                  field : 'moduleSort',
                  title : '排序',
                  width : 40
                },
                {
                  field : 'action',
                  title : '操作',
                  width : 80,
                  formatter : function(value, row, index) {
                    var str = '';
                    if ($.canEdit) {
                      str += $
                          .formatString(
                              '<a onclick="editPermissionFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>',
                              row.id, "编辑", "编辑");
                      str += '&nbsp;';
                    }

                    if ($.canDelete) {
                      str += $
                          .formatString(
                              '<a onclick="deletePermissionFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>',
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
              $(this).treegrid('tooltip');
            }
          });
}

function addFun() {
  parent.$.modalDialog({
    title : '添加菜单',
    width : 500,
    height : 380,
    iconCls : 'pencil_add',
    href : ade.bp() + '/admin/moduleManager/addPage',
    onOpen : function() {// 考虑到增加的时候，右侧的权限也要刷新，就不再弹出加载信息了。
    },
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

function editFun(id) {
  if (id != undefined) {
    treeGrid.treegrid('select', id);
  }
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    parent.$.modalDialog({
      title : '编辑资源',
      width : 500,
      height : 380,
      iconCls : 'pencil',
      onOpen : function() {// 考虑到增加的时候，右侧的权限也要刷新，就不再弹出加载信息了。
      },
      href : ade.bp() + '/admin/moduleManager/editPage?id=' + node.id,
      buttons : [ {
        text : '编辑',
        handler : function() {
          parent.$.modalDialog.openner_treeGrid = treeGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
          var f = parent.$.modalDialog.handler.find('#form');
          f.submit();
        }
      } ]
    });
  }
}

function deleteFun(id) {
  if (id != undefined) {
    treeGrid.treegrid('select', id);
  }
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    parent.$.messager.confirm('询问', '您是否要删除当前资源？', function(b) {
      if (b) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        $.post(ade.bp() + '/admin/moduleManager/delete', {
          id : node.id
        }, function(result) {
          if (result.success) {
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
            treeGrid.treegrid('reload');
            parent.ade_system_menu_tree.tree('reload');
          } else {
            parent.$.messager.alert('警告', result.msg, 'warning');
          }
          parent.$.messager.progress('close');
        }, 'JSON');
      }
    });
  }
}

function addPermissionFun() {

  var node = treeGrid.treegrid('getSelected');
  if (!node) {
    parent.$.messager.alert('警告', '请选择一个模块后，再添加权限！', 'warning');
    return;
  }

  parent.$.modalDialog({
    title : '添加权限',
    width : 500,
    height : 350,
    iconCls : 'pencil_add',
    href : ade.bp() + '/admin/moduleManager/addPermissionPage?pid=' + node.id,
    buttons : [ {
      text : '添加',
      handler : function() {
        parent.$.modalDialog.openner_treeGrid = authGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
        var f = parent.$.modalDialog.handler.find('#form');
        f.submit();
      }
    } ]
  });
}

function editPermissionFun(id) {
  if (id != undefined) {
    authGrid.treegrid('select', id);
  }
  var node = authGrid.treegrid('getSelected');
  if (node) {
    parent.$.modalDialog({
      title : '编辑权限',
      width : 500,
      height : 350,
      href : ade.bp() + '/admin/moduleManager/editPermissionPage?id=' + node.id,
      buttons : [ {
        text : '编辑',
        handler : function() {
          parent.$.modalDialog.openner_treeGrid = authGrid;// 因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
          var f = parent.$.modalDialog.handler.find('#form');
          f.submit();
        }
      } ]
    });
  }
}

function deletePermissionFun(id) {
  if (id != undefined) {
    authGrid.treegrid('select', id);
  }
  var node = authGrid.treegrid('getSelected');
  if (node) {
    parent.$.messager.confirm('询问', '您是否要删除当前资源？', function(b) {
      if (b) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        $.post(ade.bp() + '/admin/moduleManager/delete', {
          id : node.id
        }, function(result) {
          if (result.success) {
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
            authGrid.treegrid('reload');
          }
          parent.$.messager.progress('close');
        }, 'JSON');
      }
    });
  }
}

function redo() {
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    treeGrid.treegrid('expandAll', node.id);
  } else {
    treeGrid.treegrid('expandAll');
  }
}

function undo() {
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    treeGrid.treegrid('collapseAll', node.id);
  } else {
    treeGrid.treegrid('collapseAll');
  }
}