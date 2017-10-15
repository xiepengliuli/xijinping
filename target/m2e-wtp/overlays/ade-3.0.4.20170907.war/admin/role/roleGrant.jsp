<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  var resourceTree;
  $(function() {
    resourceTree = $('#resourceTree').tree({
      url : '${pageContext.request.contextPath}/admin/roleManager/grantModuleTree ',
      parentField : 'pid',
      //lines : true,
      checkbox : true,
      onClick : function(node) {
      },
      onLoadSuccess : function(node, data) {
        var ids = $.stringToList('${role.moduleIds}');
        if (ids.length > 0) {
          for (var i = 0; i < ids.length; i++) {
            if (resourceTree.tree('find', ids[i])) {
              resourceTree.tree('check', resourceTree.tree('find', ids[i]).target);
            }
          }
        }
        //             $('#roleGrantLayout').layout('panel', 'west').panel('setTitle',
        //                 $.formatString('[{0}]角色可以访问的资源', '${role.roleName}'));
        parent.$.messager.progress('close');
      },
      cascadeCheck : false
    });

    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/roleManager/grant',
      onSubmit : function() {
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
        var isValid = $(this).form('validate');
        if (!isValid) {
          parent.$.messager.progress('close');
        }
        var checknodes = resourceTree.tree('getChecked');
        var ids = [];
        if (checknodes && checknodes.length > 0) {
          for (var i = 0; i < checknodes.length; i++) {
            ids.push(checknodes[i].id);
          }
        }
        $('#moduleIds').val(ids);
        return isValid;
      },
      success : function(result) {
        parent.$.messager.progress('close');
        result = $.parseJSON(result);
        if (result.success) {
          parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_treeGrid这个对象，是因为role.jsp页面预定义好了
          parent.$.modalDialog.handler.dialog('close');
        }
      }
    });
  });

  function checkAll() {
    var nodes = resourceTree.tree('getChecked', 'unchecked');
    if (nodes && nodes.length > 0) {
      for (var i = 0; i < nodes.length; i++) {
        resourceTree.tree('check', nodes[i].target);
      }
    }
  }
  function uncheckAll() {
    var nodes = resourceTree.tree('getChecked');
    if (nodes && nodes.length > 0) {
      for (var i = 0; i < nodes.length; i++) {
        resourceTree.tree('uncheck', nodes[i].target);
      }
    }
  }
  function checkInverse() {
    var unchecknodes = resourceTree.tree('getChecked', 'unchecked');
    var checknodes = resourceTree.tree('getChecked');
    if (unchecknodes && unchecknodes.length > 0) {
      for (var i = 0; i < unchecknodes.length; i++) {
        resourceTree.tree('check', unchecknodes[i].target);
      }
    }
    if (checknodes && checknodes.length > 0) {
      for (var i = 0; i < checknodes.length; i++) {
        resourceTree.tree('uncheck', checknodes[i].target);
      }
    }
  }
</script>
<div id="roleGrantLayout" class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'west'" title="选择角色可以访问的资源" style="width: 300px; padding: 1px;">
		<form id="form" method="post">
			<input name="id" type="hidden" value="${role.id}" readonly="readonly">
			<ul id="resourceTree"></ul>
			<input id="moduleIds" name="moduleIds" type="hidden" />
		</form>
	</div>
	<div data-options="region:'center'" title="" style="overflow: scroll; padding: 10px;">
		<div class="easyui-panel" title="当前角色：${role.roleName}" style="padding: 10px;">
			<div>角色描述:${role.roleDesc}</div>
		</div>

		<div style="height: 10px;"></div>

		<div class="easyui-panel" title="操作" style="padding: 10px;">
			<button class="btn btn-success" onclick="checkAll();">全选</button>
			<br /> <br />
			<button class="btn btn-warning" onclick="checkInverse();">反选</button>
			<br /> <br />
			<button class="btn btn-inverse" onclick="uncheckAll();">取消</button>
		</div>

		<!-- 		<div class="well well-large"></div> -->
	</div>
</div>