<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>组织机构管理</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<%-- <c:if
	test="${fn:contains(sessionInfo.moduleList, '/admin/dictionaryManager/addDictionary')}">
	<script type="text/javascript">
    $.canAdd = true;
  </script>
</c:if>
<c:if
	test="${fn:contains(sessionInfo.moduleList, '/admin/dictionaryManager/editDictionaryPage')}">
	<script type="text/javascript">
    $.canEdit = true;
  </script>
</c:if>
<c:if
	test="${fn:contains(sessionInfo.moduleList, '/admin/dictionaryManager/delete')}">
	<script type="text/javascript">
    $.canDelete = true;
  </script>
</c:if> --%>
<script type="text/javascript"
  src="${pageContext.request.contextPath}/resources/js/admin/organization/organization.js">
  
</script>
</head>
<body>
  <div id="toolbar" style="display: none;">
    <%--     <c:if test="${fn:contains(sessionInfo.moduleList, '/admin/dictionary/addDictionary')}"> --%>
    <a href="javascript:void(0);" onclick="addFun();" class="easyui-linkbutton ade-button-1"
      data-options="plain:true"><icon:icon name="add" />&nbsp;添加</a>
    <%--     </c:if> --%>
    <a onclick="redo();" href="javascript:void(0);" class="easyui-linkbutton ade-button-2"
      data-options="plain:true"><icon:icon name="expand" />&nbsp;展开</a> <a onclick="undo();"
      href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon name="collapse" />&nbsp;折叠</a><a onclick="treeGrid.treegrid('reload');"
      href="javascript:void(0);" class="easyui-linkbutton ade-button-2" data-options="plain:true"><icon:icon name="refresh" />&nbsp;刷新</a>
  </div>
  <div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false">
      <table id="treeGrid"></table>
    </div>
  </div>
  <!-- 	<div id="menu" class="easyui-menu" style="width: 120px; display: none;"> -->
  <%-- 		<c:if --%>
  <%-- 			test="${fn:contains(sessionInfo.moduleList, '/dictionaryManager/editDictionaryPage')}"> --%>
  <!-- 			<div onclick="editFun();" data-options="iconCls:'pencil'">修改</div> -->
  <%-- 		</c:if> --%>
  <%-- 		<c:if --%>
  <%-- 			test="${fn:contains(sessionInfo.moduleList, '/dictionaryManager/deleteDictionary')}"> --%>
  <!-- 			<div onclick="deleteFun();" data-options="iconCls:'delete'">删除</div> -->
  <%-- 		</c:if> --%>
  <!-- 	</div> -->

</body>
</html>