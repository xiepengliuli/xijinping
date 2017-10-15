$(function() {

  $('#iconSelectDialog a').bind('click', function() {
    $('#iconSelectDialog a').removeClass('ade-active');
    $(this).addClass('ade-active');
  });

  // moduleGround要与parentModuleId进行联动
  $('#moduleGround')
      .combobox(
          {
            valueField : 'dictCode',
            editable : false,
            textField : 'dictName',
            url : ade.bp()
                + '/admin/dictionaryManager/getDictsByTypeCode?dictCode=ade_module_ground',
            value : moduleGround,
            onLoadSuccess : function() {

              $('#parentModuleId').combotree(
                  {
                    parentField : 'pid',
                    lines : true,
                    panelHeight : '400',
                    panelWidth : '250',
                    url : ade.bp()
                        + '/admin/moduleManager/comboTree?moduleGround='
                        + moduleGround,
                    value : parentModuleId,
                  });
            },
            onSelect : function(rec) {

              $('#parentModuleId').combotree(
                  {
                    parentField : 'pid',
                    lines : true,
                    panelHeight : '400',
                    panelWidth : '250',
                    url : ade.bp()
                        + '/admin/moduleManager/comboTree?moduleGround='
                        + rec.dictCode,
                    value : parentModuleId
                  });
            }
          });

  $('#form').form({
    url : ade.bp() + '/admin/moduleManager/' + operate,
    onSubmit : function() {
      parent.$.messager.progress({
        title : '提示',
        text : '数据处理中，请稍后....'
      });
      var isValid = $(this).form('validate');
      if (!isValid) {
        parent.$.messager.progress('close');
      }
      return isValid;
    },
    success : function(result) {
      parent.$.messager.progress('close');
      result = $.parseJSON(result);
      if (result.success) {
        parent.$.messager.alert('提示', '维护成功，权限可能需要重新登录后生效！', 'info');
        parent.$.modalDialog.openner_treeGrid.treegrid('reload');
        parent.ade_system_menu_tree.tree('reload');
        parent.$.modalDialog.handler.dialog('close');
      }
    }
  });
});

/**
 * 选择对话框
 */
function showSelectIcon() {

  $('#iconSelectDialog').dialog({
    title : '选择菜单图标',
    width : 500,
    height : 400,
    closed : false,
    cache : false,
    modal : true,
    buttons : [ {
      text : '确定',
      handler : function() {
        $("#iconCls").val($('#iconSelectDialog .ade-active i').attr('title'));
        $('#iconSelectDialog').dialog("close");
      },
    } ]
  });

}
/**
 * 传输选中对象
 */
// function select(tu) {
// tu = tu;
// var tt = "div-" + tu;
// var key;
// $("#iconSelectDialog >div").each(function() {
// key = "" + $(this).attr("id");
// if (key.indexOf(tu) > 0) {
// document.getElementById("div-" + tu).style.color = "#33B6AE";
// $("#iconCls").val(tu);
// } else {
// $('#' + key).css('color', '');// 为id为box的div添加行间样式
// }
// });
// }
