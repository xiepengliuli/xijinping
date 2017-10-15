<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>角色管理</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<c:if test="${fn:contains(LOGIN_USER.moduleList, 'admin/roleManager/editPage')}">
  <script type="text/javascript">
      $.canEdit = true;
    </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, 'admin/roleManager/delete')}">
  <script type="text/javascript">
      $.canDelete = true;
    </script>
</c:if>
<c:if test="${fn:contains(LOGIN_USER.moduleList, 'admin/roleManager/grantPage')}">
  <script type="text/javascript">
      $.canGrant = true;
    </script>
</c:if>
<script type="text/javascript" charset="utf-8"
  src="${pageContext.request.contextPath}/resources/js/admin/role/role.js"></script>
</head>
<body>

  <div class="easyui-layout" data-options="fit:true,border:false">
    <div data-options="region:'center',border:false" title="" style="overflow: hidden;">
      <table id="dataGrid"></table>
    </div>
  </div>
  <div id="toolbar" style="display: none;">
    <rl:linkbutton permission="/admin/roleManager/addPage" onclick="addFun();"
      styleClass="easyui-linkbutton ade-button-1" dataOptions="plain:true">
      <icon:icon name="add" />&nbsp;添加</rl:linkbutton>
  </div>
</body>
</html>
