<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>INFCN ADE</title>
<jsp:include page="/WEB-INF/inc/adeInc.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/systemInfo.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统环境</title>
</head>
<body>
  <div class="easyui-panel" title="系统环境" style="width: 100%; padding: 10px;">
    <div style="margin: 10px;">
      <div class="easyui-panel" title="运行情况" style="width: 100%; padding: 10px;">
        <table class="env">
          <c:forEach items="${runtimeInfos}" var="runtimeInfo">
            <tr>
              <th>${runtimeInfo.key}:</th>
              <td>${runtimeInfo.value}</td>
            </tr>
          </c:forEach>
        </table>
      </div>
    </div>

    <div style="margin: 10px;">
      <div class="easyui-panel" title="服务器基本信息" style="width: 100%; padding: 10px;">
        <table class="env">
          <c:forEach items="${serverInfos}" var="serverInfo">
            <tr>
              <th>${serverInfo.key }:</th>
              <td>${serverInfo.value }</td>
            </tr>
          </c:forEach>
        </table>
      </div>
    </div>

    <div style="margin: 10px;">
      <div id="p" class="easyui-panel" title="Java虚拟机信息" style="width: 100%; padding: 10px;">
        <table>
          <c:forEach items="${jdkVmInfos}" var="jdkVmInfo">
            <tr>
              <th>${jdkVmInfo.key }:</th>
              <td>${jdkVmInfo.value }</td>
            </tr>
          </c:forEach>
        </table>
      </div>
    </div>
  </div>
</body>
</html>