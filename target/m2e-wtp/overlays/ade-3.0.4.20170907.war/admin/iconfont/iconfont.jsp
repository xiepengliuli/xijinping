<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>图标管理</title>
<jsp:include page="/WEB-INF/inc/adeInc.jsp"></jsp:include>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	list-style: none;
}
/*
KISSY CSS Reset
理念：1. reset 的目的不是清除浏览器的默认样式，这仅是部分工作。清除和重置是紧密不可分的。
2. reset 的目的不是让默认样式在所有浏览器下一致，而是减少默认样式有可能带来的问题。
3. reset 期望提供一套普适通用的基础样式。但没有银弹，推荐根据具体需求，裁剪和修改后再使用。
特色：1. 适应中文；2. 基于最新主流浏览器。
维护：玉伯<lifesinger@gmail.com>, 正淳<ragecarrier@gmail.com>
 */

/** 清除内外边距 **/
body, h1, h2, h3, h4, h5, h6, hr, p, blockquote,
	/* structural elements 结构元素 */ dl, dt, dd, ul, ol, li,
	/* list elements 列表元素 */ pre, /* text formatting elements 文本格式元素 */
	form, fieldset, legend, button, input, textarea,
	/* form elements 表单元素 */ th, td /* table elements 表格元素 */ {
	margin: 0;
	padding: 0;
}

/** 设置默认字体 **/
body, button, input, select, textarea /* for ie */ {
	font: 12px/1.5 tahoma, arial, \5b8b\4f53, sans-serif;
}

h1, h2, h3, h4, h5, h6 {
	font-size: 100%;
}

address, cite, dfn, em, var {
	font-style: normal;
} /* 将斜体扶正 */
code, kbd, samp {
	font-family: courier new, courier, monospace;
} /* 统一等宽字体 */

/** 重置列表元素 **/
ul, ol {
	list-style: none;
}

/** 重置文本格式元素 **/
a {
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

/** 重置表单元素 **/
legend {
	color: #000;
} /* for ie6 */
fieldset, img {
	border: 0;
} /* img 搭车：让链接里的 img 无边框 */
button, input, select, textarea {
	font-size: 100%;
} /* 使得表单元素在 ie 下能继承字体大小 */
/* 注：optgroup 无法扶正 */

/* 清除浮动 */
.ks-clear:after, .clear:after {
	content: '\20';
	display: block;
	height: 0;
	clear: both;
}

.ks-clear, .clear {
	*zoom: 1;
}

.main {
	padding: 30px 100px;
	width: 960px;
	margin: 0 auto;
}

.main h1 {
	font-size: 36px;
	color: #333;
	text-align: left;
	margin-bottom: 30px;
	border-bottom: 1px solid #eee;
}

.helps {
	margin-top: 40px;
}

.icon_lists {
	width: 100% !important;
}

.icon_lists li {
	float: left;
	width: 100px;
	height: 180px;
	text-align: center;
	list-style: none !important;
}

.icon_lists .icon {
	font-size: 42px;
	line-height: 100px;
	margin: 10px 0;
	color: #333;
	-webkit-transition: font-size 0.25s ease-out 0s;
	-moz-transition: font-size 0.25s ease-out 0s;
	transition: font-size 0.25s ease-out 0s;
}

.icon_lists .icon:hover {
	font-size: 100px;
}

.markdown {
	color: #666;
	font-size: 14px;
	line-height: 1.8;
}

.highlight {
	line-height: 1.5;
}

.markdown img {
	vertical-align: middle;
	max-width: 100%;
}

.markdown h1 {
	color: #404040;
	font-weight: 500;
	line-height: 40px;
	margin-bottom: 24px;
}

.markdown h2, .markdown h3, .markdown h4, .markdown h5, .markdown h6 {
	color: #404040;
	margin: 1.6em 0 0.6em 0;
	font-weight: 500;
	clear: both;
}

.markdown h1 {
	font-size: 28px;
}

.markdown h2 {
	font-size: 22px;
}

.markdown h3 {
	font-size: 16px;
}

.markdown h4 {
	font-size: 14px;
}

.markdown h5 {
	font-size: 12px;
}

.markdown h6 {
	font-size: 12px;
}

.markdown hr {
	height: 1px;
	border: 0;
	background: #e9e9e9;
	margin: 16px 0;
	clear: both;
}

.markdown p {
	margin: 1em 0;
}

.markdown>p, .markdown>blockquote, .markdown>.highlight, .markdown>ol,
	.markdown>ul {
	width: 80%;
}

.markdown ul>li {
	list-style: circle;
}

.markdown>ul li, .markdown blockquote ul>li {
	margin-left: 20px;
	padding-left: 4px;
}

.markdown>ul li p, .markdown>ol li p {
	margin: 0.6em 0;
}

.markdown ol>li {
	list-style: decimal;
}

.markdown>ol li, .markdown blockquote ol>li {
	margin-left: 20px;
	padding-left: 4px;
}

.markdown code {
	margin: 0 3px;
	padding: 0 5px;
	background: #eee;
	border-radius: 3px;
}

.markdown strong, .markdown b {
	font-weight: 600;
}

.markdown blockquote {
	font-size: 90%;
	color: #999;
	border-left: 4px solid #e9e9e9;
	padding-left: 0.8em;
	margin: 1em 0;
	font-style: italic;
}

.markdown blockquote p {
	margin: 0;
}

.markdown .anchor {
	opacity: 0;
	transition: opacity 0.3s ease;
	margin-left: 8px;
}

.markdown .waiting {
	color: #ccc;
}

.markdown h1:hover .anchor, .markdown h2:hover .anchor, .markdown h3:hover .anchor,
	.markdown h4:hover .anchor, .markdown h5:hover .anchor, .markdown h6:hover .anchor
	{
	opacity: 1;
	display: inline-block;
}

.markdown>br, .markdown>p>br {
	clear: both;
}
</style>
</head>
<body>
	<div class="main markdown">
		<h1>ADE内置图标库</h1>

		<c:if test="${empty icons}">
			<span style="color: red">加载图标库出现错误</span>
		</c:if>

		<c:if test="${not empty icons}">
			<ul class="icon_lists">
				<c:forEach items="${icons}" var="icon">
					<li><i class="icon iconfont">${icon.value}</i>
						<div class="name">${icon.key}</div>
						<div class="code">
							<c:out value="${icon.value}" />
						</div></li>
				</c:forEach>
			</ul>

			<h2>使用方式有下面两种：</h2>
			<h3>第一种(不推荐使用)，HTML标签unicode引用：</h3>
			<blockquote>&lt;i class="iconfont"&gt;&amp;#xe60e;&lt;/i&gt;</blockquote>
			<h3>第二种，JSP标签名称引用：</h3>
			<blockquote>注意引用&lt;%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%&gt;</blockquote>
			<blockquote>&lt;icon:icon name="add" /&gt;</blockquote>
		</c:if>

	</div>
</body>
</html>