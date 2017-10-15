<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="logo" style="width: 124px; height: 60px; margin-left: 10px;"></div>

<div style="position: absolute; right: 25px; bottom: 20px;">
	<a href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_pfMenu'">更换皮肤</a> |<a
		href="javascript:void(0);" class="easyui-menubutton" data-options="menu:'#layout_north_kzmbMenu'"><strong>${LOGIN_USER.userName}(${LOGIN_USER.loginName})</strong>
	</a>
</div>

<div id="layout_north_pfMenu" style="width: 120px; display: none;">
	<div onclick="changeThemeFun('blue');" title="blue">天空蓝（默认）</div>
	<div onclick="changeThemeFun('lightgreen');" title="default">浅绿</div>
	<div onclick="changeThemeFun('darkgray');" title="darkgray">深灰</div>
	<div onclick="changeThemeFun('green');" title="green">绿色</div>
</div>

<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
	<div onclick="editCurrentUserPwd();">修改密码</div>
	<div class="menu-sep"></div>
	<div onclick="currentUserRole();">我的角色</div>
	<div class="menu-sep"></div>
	<div onclick="currentUserResource();">我的权限</div>
	<div class="menu-sep"></div>
	<div onclick="logoutFun();">退出系统</div>
</div>