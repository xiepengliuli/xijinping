var treeGrid;
// 初始化datagrid
$(function() {
  // 初始化数据
  treeGrid = $('#treeGrid').treegrid(
      {
        url : ade.bp() + '/admin/organizationManager/loadTreeGrid',
        idField : 'id',
        treeField : 'orgName',
        parentField : 'orgPid',
        initialState : "expandAll",
        fit : true,
        fitColumns : true,
        border : false,
        striped : true,
        rownumbers : true,
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
              field : 'orgName',
              title : '机构名称',
              // state:'closed',
              width : 200
            },
            {
              field : 'orgAddress',
              title : '地址',
              width : 150
            },
            {
              field : 'orgLeader',
              title : '负责人',
              width : 100
            },
            {
              field : 'orgPhone',
              title : '联系电话',
              width : 100
            },
            {
              field : 'orgDesc',
              title : '备注',
              width : 250
            },
            {
              field : 'orgStatus',
              title : '状态',
              width : 80,
              formatter : function(value, row) {
                if (value && value == 1) {
                  return '使用';
                }
                return '废弃';
              }
            },
            {
              field : 'action',
              title : '操作',
              align : 'center',
              width : 100,
              formatter : function(value, row, index) {
                var str = '';
                // if ($.canEdit) {
                // str += $.formatString('<img onclick="editFun(\'{0}\');"
                // src="{1}" title="修改1"/>',
                // row.id, ade.bp() +
                // '/resources/css/images/extjs_icons/pencil.png');

                str += $.formatString(
                    '<a onclick="editFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-2">{2}</a>', row.id,
                    "修改", "修改");

                // }
                str += '&nbsp;';
                // if ($.canDelete) {
                // str += $.formatString('<img onclick="deleteFun(\'{0}\');"
                // src="{1}" title="删除"/>',
                // row.id, ade.bp() +
                // '/resources/css/images/extjs_icons/delete.png');

                str += $.formatString(
                    '<a onclick="deleteFun(\'{0}\');" title="{1}" class="ade-operate ade-operate-3">{2}</a>', row.id,
                    "删除", "删除");

                // }
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
          $(this).treegrid('tooltip');
        },
        onLoadError : function() {
          $.messager.confirm('提示', '您未登录或者长时间没有操作，请重新登录！', function(result) {
            if (result) {
              parent.location.href = ade.bp() + '/adminlogin.jsp';
            }
          });
        }
      });

});

// 添加组织机构
function addFun() {
  parent.$.modalDialog({
    title : '添加组织机构项',
    width : 550,
    height : 320,
    href : ade.bp() + '/admin/organizationManager/addPage',
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

// 修改组织机构
function editFun(id) {
  if (id != undefined) {
    treeGrid.treegrid('select', id);
  }
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    parent.$.modalDialog({
      title : '修改组织机构',
      width : 550,
      height : 320,
      href : ade.bp() + '/admin/organizationManager/editPage?id=' + node.id + '&orgPid=' + node.orgPid,
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
function deleteFun(id) {
  if (id != undefined) {
    treeGrid.treegrid('select', id);
  }
  var node = treeGrid.treegrid('getSelected');
  if (node) {
    parent.$.messager.confirm('确认', '您确定要删除所选机构吗？', function(b) {
      if (b) {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        $.post(ade.bp() + '/admin/organizationManager/delete', {
          id : node.id
        }, function(result) {

          if (result.success) {
            parent.$.messager.show({
              title : '成功',
              msg : result.msg
            });
            treeGrid.treegrid('reload');
          } else {
            parent.$.messager.alert('错误', result.msg, 'error');
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