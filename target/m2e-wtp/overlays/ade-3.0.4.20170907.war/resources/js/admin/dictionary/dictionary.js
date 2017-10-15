var treeGrid;

// 初始化datagrid
$(function() {
  // 初始化数据
  treeGrid = $('#treeGrid')
      .treegrid(
          { // loadFilter:function(data){return undo();},
            url : ade.bp() + '/admin/dictionaryManager/dictionaryDataGrid',
            idField : 'id',
            treeField : 'dictName',
            parentField : 'dictPid',
            initialState : "collapsed",
            fit : true,
            fitColumns : true,
            border : false,
            pagination : false,
            singleSelect : true,
            columns : [ [
                {
                  title : 'id',
                  field : 'id',
                  width : 50,
                  checkbox : true,
                  hidden : true
                },
                {
                  field : 'dictName',
                  title : '字典名称',
                  width : 250
                },
                {
                  field : 'dictCode',
                  title : '字典编号',
                  width : 150
                },
                {
                  field : 'dictValue',
                  title : '字典项值',
                  width : 250
                },
                {
                  field : 'dictType',
                  title : '字典类型',
                  width : 100,
                  formatter : function(value, row, index) {
                    if (value == '1') {
                      return '用户字典';
                    } else if (value == '8') {
                      return '系统字典';
                    } else {
                      return '其它'
                    }
                  }
                },
                {
                  field : 'dictStatus',
                  title : '字典状态',
                  width : 100,
                  formatter : function(value, row, index) {
                    if (value == '1') {
                      return '使用';
                    } else if (value == '9') {
                      return '不使用';
                    } else {
                      return '其它'
                    }
                  }
                },
                {
                  field : 'dictSort',
                  title : '排序',
                  width : 50
                },
                {
                  field : 'dictDesc',
                  title : '备注',
                  width : 250
                },
                {
                  field : 'action',
                  title : '操作',
                  width : 100,
                  align : 'center',
                  formatter : function(value, row, index) {

                    var str = '';
                    if (($.canEditUserDict && row.dictType == '1') || ($.canEditSystemDict && row.dictType == '8')) {
                      str += $
                          .formatString(
                              '<a onclick="editFun(\'{0}\', \'{1}\');" title="{2}" class="ade-operate ade-operate-2">{3}</a>',
                              row.id, row.dictType, "编辑", "编辑");
                      str += '&nbsp;';
                    }

                    // 可以删除用户字典
                    if (($.canDeleteUserDict && row.dictType == '1') || ($.canDeleteSystemDict && row.dictType == '8')) {
                      str += $
                          .formatString(
                              '<a onclick="deleteFun(\'{0}\', \'{1}\');" title="{2}" class="ade-operate ade-operate-3">{3}</a>',
                              row.id, row.dictType, "删除", "删除");
                    }

                    return str;
                  }
                } ] ],
            toolbar : '#toolbar',
            onLoadSuccess : function() {
              $('#dataGrid').treegrid('collapseAll');
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
    title : '添加字典项',
    width : 500,
    height : 350,
    href : ade.bp() + '/admin/dictionaryManager/addPage',
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

// 判断是否有子集，若有子集将子集收起
function TreeGridShow(data) {
  $(data).each(function(index, item) {
    if (item.pid == '0') {
      // item.state = "open";
      item.state = "closed";
    } else {
      treeGrid.treegrid('collapseAll');
      item.state = "open";
      // TreeGridShow(item.children);
    }
  });
  return data;
}

// 修改字典
function editFun(id, dictType) {
  if (id != undefined) {
    treeGrid.treegrid('select', id);
  }
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    parent.$.modalDialog({
      title : '修改字典',
      width : 500,
      height : 350,
      href : ade.bp() + '/admin/dictionaryManager/editPage?id=' + node.id + '&dictType=' + dictType,
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

// 删除角色
function deleteFun(id, dictType) {
  if (id != undefined) {
    treeGrid.treegrid('select', id);
  }
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    parent.$.messager.confirm('确认', '您确定要删除所选字典吗？', function(b) {
      if (b) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });

        var deleteAction = '';

        if (dictType == '1') {
          deleteAction = 'deleteUserDict';
        } else if (dictType == '8') {
          deleteAction = 'deleteSystemDict';
        } else {
          parent.$.messager.show({
            title : '错误',
            msg : '对应的字典类型没有删除操作，请确认'
          });
        }

        $.post(ade.bp() + '/admin/dictionaryManager/' + deleteAction, {
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

// 展开菜单
function redo() {

  var node = treeGrid.treegrid('getSelected');
  if (node) {
    treeGrid.treegrid('expandAll', node.id);
  } else {
    treeGrid.treegrid('expandAll');
  }
}

// 折叠菜单
function undo() {
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    treeGrid.treegrid('collapseAll', node.id);
  } else {
    treeGrid.treegrid('collapseAll');
  }
}