<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  $(function() {
    $('#iconCls')
        .combobox(
            {
              data : $.iconData,
              formatter : function(v) {
                return $
                    .formatString(
                        '<span class="{0}" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span>{1}',
                        v.value, v.value);
              },
              value : '${module.moduleIcon}'
            });

    $('#parentModuleId').combotree({
      url : '${pageContext.request.contextPath}/admin/module/tree',
      parentField : 'parentModuleId',
      lines : true,
      panelHeight : 'auto',
      value : '${module.parentModuleId}',
      onLoadSuccess : function() {
        parent.$.messager.progress('close');
      }
    });

    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/module/edit',
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
          parent.$.modalDialog.openner_treeGrid.treegrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为module.jsp页面预定义好了
          parent.layout_west_tree.tree('reload');
          parent.$.modalDialog.handler.dialog('close');
        }
      }
    });
  });
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
  <div data-options="region:'center',border:false" title="" style="overflow: hidden;">
    <form id="form" method="post">
      <table class="table table-hover table-condensed">
        <tr>
          <th>编号</th>
          <td><input name="id" type="text" class="span2" value="${module.id}"
            readonly="readonly"></td>
          <th>资源名称</th>
          <td><input name="moduleName" type="text" placeholder="请输入资源名称"
            class="easyui-validatebox span2" data-options="required:true"
            value="${module.moduleName}"></td>
        </tr>
        <tr>
          <th>资源路径</th>
          <td><input name="moduleUrl" type="text" placeholder="请输入资源路径"
            class="easyui-validatebox span2" value="${module.moduleUrl}"></td>
          <th>资源类型</th>
          <td><select name="moduleTypeId" class="easyui-combobox"
            data-options="width:140,height:29,editable:false,panelHeight:'auto',readonly:true">
              <c:forEach items="${moduleTypeList}" var="moduleType">
                <option value="${moduleType.id}"
                  <c:if test="${moduleType.id == module.moduleTypeId}">selected="selected"</c:if>>${moduleType.name}</option>
              </c:forEach>
          </select></td>
        </tr>
        <tr>
          <th>排序</th>
          <td><input name="moduleSort" value="${module.moduleSort}"
            class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required"
            data-options="editable:false"></td>
          <th>上级资源</th>
          <td><select id="parentModuleId" name="parentModuleId"
            style="width: 140px; height: 29px;"></select><img
            src="${pageContext.request.contextPath}/resources/css/images/extjs_icons/cut_red.png"
            onclick="$('#parentModuleId').combotree('clear');" /></td>
        </tr>
        <tr>
          <th>菜单图标</th>
          <td colspan="3"><input id="iconCls" name="moduleIcon"
            style="width: 375px; height: 29px;" data-options="editable:false" /></td>
        </tr>
        <tr>
          <th>描述</th>
          <td colspan="3"><textarea name="moduleDesc" rows="" cols="" class="span5">${module.moduleDesc}</textarea></td>
        </tr>
      </table>
    </form>
  </div>
</div>
