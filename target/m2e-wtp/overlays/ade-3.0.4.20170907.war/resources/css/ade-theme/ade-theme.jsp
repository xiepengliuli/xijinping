<%@ page language="java" contentType="text/css" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<c:choose>
	<c:when test="${param.adeThemes eq 'green' }">
		<c:set var="adeThemeLight" value="#1DA02B" />
		<c:set var="adeThemeDark" value="#167820" />
	</c:when>
	<c:when test="${param.adeThemes eq 'lightgreen' }">
		<c:set var="adeThemeLight" value="#33B6AE" />
		<c:set var="adeThemeDark" value="#319D96" />
	</c:when>
	<c:when test="${param.adeThemes eq 'darkgray' }">
		<c:set var="adeThemeLight" value="#526F77" />
		<c:set var="adeThemeDark" value="#045475" />
	</c:when>
	<c:when test="${param.adeThemes eq 'blue' }">
		<c:set var="adeThemeLight" value="#4B9CD7" />
		<c:set var="adeThemeDark" value="#157FCC" />
	</c:when>
	<c:otherwise>
		<c:set var="adeThemeLight" value="#4B9CD7" />
		<c:set var="adeThemeDark" value="#157FCC" />
	</c:otherwise>
</c:choose>
.ade-active {
	color: ${adeThemeLight};
}

.ade-link {
	cursor: pointer;
}

.ade-link:hover {
	color: ${adeThemeLight};
}

/*----------------*/
.tree-node-selected {
	background: ${adeThemeLight};
}
/*****重写kindeditor开始*****/
.ke-dialog-content {
	background-color: #F1F1F1;
	color: #000;
}

.ke-dialog-header {
	background: ${adeThemeLight};
	color: #fff;
}
/*****重写kindeditor结束*****/
.menu-active {
	background: ${adeThemeLight};
	border-color: ${adeThemeLight};
}

/*****重写进度条开始*****/
.progressbar-value .progressbar-text {
	background-color: ${adeThemeLight};
	color: #fff;
}
/*****重写进度条结束*****/
/*****覆盖重写页面中所有的LinkBtn信息开始*****/
.ade-button-1.l-btn, .ade-button-2.l-btn, .dialog-button .l-btn {
	margin-right: 5px;
}

/*有图标的按钮文字布局*/
.ade-button-1.l-btn .l-btn-left .l-btn-text, .ade-button-2.l-btn .l-btn-left .l-btn-text,
	.dialog-button .l-btn .l-btn-left.l-btn-left .l-btn-text {
	margin: 2px 15px 2px 15px;
}

/*没有图标的按钮文字布局*/
/* .dialog-button .l-btn .l-btn-left .l-btn-text { */
/* 	margin: 2px 15px 2px 32px; */
/* } */

/*设置按钮的图标位置*/
.ade-button-1.l-btn .l-btn-icon-left .l-btn-icon, .ade-button-2.l-btn .l-btn-icon-left .l-btn-icon,
	.dialog-button .l-btn-icon-left .l-btn-icon {
	left: 12px;
}

.ade-button-1.l-btn, .dialog-button .l-btn:first-child {
	background: ${adeThemeLight};
	padding: 1px;
	border: 1px solid ${adeThemeLight};
	color: #ffffff;
}

.ade-button-1.l-btn:hover, .dialog-button .l-btn:first-child:hover {
	padding: 1px;
	background: ${adeThemeDark};
	border: 1px solid ${adeThemeDark};
	color: #ffffff;
}

.ade-button-2.l-btn, .dialog-button .l-btn {
	padding: 1px;
	border: 1px solid #C2C2C2;
	background: #E8E8E8;
	color: #000000;
}

.ade-button-2.l-btn:hover, .dialog-button .l-btn:hover {
	padding: 1px;
	background: #D8D8D8;
	color: #000000;
	border: 1px solid #C2C2C2;
}

.m-btn-plain-active,
.s-btn-plain-active {
  border-color: ${adeThemeDark};
  background-color: ${adeThemeDark};
  color: #00438a;
  padding: 1px;
}

.l-btn-plain:hover {
  padding: 1px;
}

.l-btn:hover {
  background: ${adeThemeDark};
  color: #00438a;
  border: 1px solid ${adeThemeDark};;
  filter: none;
}


/*覆盖重写页面中所有的LinkBtn信息结束*/
/*----------------*/
/*覆盖重写页面中所有的input样式*/
.textbox {
	-moz-border-radius: 0px 0px 0px 0px;
	-webkit-border-radius: 0px 0px 0px 0px;
	border-radius: 0px 0px 0px 0px;
}

.textbox .textbox-text {
	-moz-border-radius: 0px 0px 0px 0px;
	-webkit-border-radius: 0px 0px 0px 0px;
	border-radius: 0px 0px 0px 0px;
}

/*页面顶端的重写开始*/
/*页面顶端最外层框架的一些属性*/
.index_north_bar {
	height: 70px;
	overflow: hidden;
	background-color: ${adeThemeLight};
	color: #fff
}

/*设置按钮字的颜色*/
.index_north_bar .l-btn {
	color: #fff;
}

.index_north_bar .l-btn-plain{
  border: 1px solid ${adeThemeLight};
}

/*设置按钮的字划过的颜色*/
.index_north_bar .m-btn-active, .s-btn-active {
	background: ${adeThemeDark};
	border: none;
}

/*设置按钮的字划过的颜色*/
.index_north_bar .m-btn-plain-active {
	background: ${adeThemeDark};
	border: 1px solid ${adeThemeDark};
}

/*覆盖更新btnMenu后面的向下箭头为白色，默认为黑色*/
.index_north_bar .m-btn-downarrow, .s-btn-downarrow {
	background: url('images/menu_arrows.png') no-repeat 0 center;
}
/*页面顶端的重写结束*/

/*在tab页签上面增加一个绿色的条*/
.tabs li a.tabs-inner {
	background: #D8D8D8;
	border: 1px solid #C2C2C2;
	border-top: 1px solid #C2C2C2;
	padding-top: 2px;
	padding-left: 15px;
	padding-right: 15px;
}

.tabs li.tabs-selected a.tabs-inner {
	background: #FFFFFF;
	border: 1px solid #C2C2C2;
	border-top: 3px solid ${adeThemeLight};
	padding-top: 0px;
}

.tabs li a.tabs-inner {
	color: #000000;
}

.tabs li.tabs-selected a.tabs-inner {
	color: #000000;
}

/**覆盖表格的样式*/
.datagrid-toolbar {
	padding: 5px;
}

.datagrid-row-selected {
	background: ${adeThemeLight};
	color: #FFFFFF;
}

.datagrid-toolbar, .datagrid-pager {
	background: #F1F1F1;
	background-color: rgb(241, 241, 241);
}

.datagrid-header-row, .datagrid-row {
	height: 32px;
}

.datagrid-cell, .datagrid-cell-group {
	padding: 0 15px;
}

.datagrid-header td {
	text-align: center;
}

.datagrid-header .datagrid-cell span {
	font-weight: bold;
}

.datagrid-header td {
	border-color: #DADADA;
	border-width: 1px 1px 1px 0;
	border-style: solid;
}

.datagrid-body td, .datagrid-footer td {
	border-color: #DADADA;
	border-width: 0px 1px 1px 0;
	border-style: solid;
}

/**重写分页信息*/
.pagination .l-btn {
	padding: 1px;
	border: 1px solid #C2C2C2;
	margin-right: 3px;
	-moz-border-radius: 0px 0px 0px 0px;
	-webkit-border-radius: 0px 0px 0px 0px;
	border-radius: 0px 0px 0px 0px;
}

.pagination .l-btn:hover {
	background-color: ${adeThemeDark};
	padding: 1px;
	border: 1px solid #C2C2C2;
	color: #ffffff;
}

.l-btn:hover .pagination-first {
	background: url('images/pagination_hover_icons.png') no-repeat 0 center;
}

.l-btn:hover .pagination-prev {
	background: url('images/pagination_hover_icons.png') no-repeat -16px
		center;
}

.l-btn:hover .pagination-next {
	background: url('images/pagination_hover_icons.png') no-repeat -32px
		center;
}

.l-btn:hover .pagination-last {
	background: url('images/pagination_hover_icons.png') no-repeat -48px
		center;
}

.l-btn:hover .pagination-load {
	background: url('images/pagination_hover_icons.png') no-repeat -64px
		center;
}

/*面板样式覆盖*/
.window {
	padding: 2px;
	background: ${adeThemeLight};
	border-width: 0px;
}

.window .panel-header {
	/* 	background-color: ${adeThemeLight}; */
	
}

.window .panel-header {
	padding-left: 15px;
}

.window .window-header .panel-icon {
	left: 10px;
}

.window .window-header .panel-tool {
	right: 15px;
}

.window .window-header .panel-title {
	height: 35px;
	line-height: 35px;
	/* 	background-color: ${adeThemeLight}; */
	color: #FFF;
}

/**重写面板*/
.panel-title {
	color: #000000;
}

.panel-header {
	background: #D8D8D8;
}

/*重写面板上的工具*/
.panel-tool-close {
	background: url('images/panel_tools.png') no-repeat -16px 0px;
}

.panel-tool-min {
	background: url('images/panel_tools.png') no-repeat 0px 0px;
}

.panel-tool-max {
	background: url('images/panel_tools.png') no-repeat 0px -16px;
}

.panel-tool-restore {
	background: url('images/panel_tools.png') no-repeat -16px -16px;
}

.panel-tool-collapse {
	background: url('images/panel_tools.png') no-repeat -32px 0;
}

.panel-tool-expand {
	background: url('images/panel_tools.png') no-repeat -32px -16px;
}

/**重写树*/
.tree-node {
	height: 28px;
}

.tree-title {
	height: 28px;
	line-height: 28px;
}

.tree-expanded, .tree-collapsed, .tree-folder, .tree-file,
	.tree-checkbox, .tree-indent {
	margin: 5px 0px;
}