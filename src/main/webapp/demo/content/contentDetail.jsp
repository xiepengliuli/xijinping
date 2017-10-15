<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tools" uri="/WEB-INF/tld/ade-tools-tag.tld"%>
<%@ taglib prefix="string" uri="/WEB-INF/tld/ade-string-tags.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${content.title}-INFCNADE</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/demo/content/detail.css" type="text/css" />
</head>

<body>

	<div class="detail_container">
		<div class="title_container">

			<span class="title">${content.title}</span>

			<c:if test="${not empty content.subTitle}">
				<span class="subtitle">-${content.subTitle}</span>
			</c:if>

			<c:if test="${not empty content.author}">
				<span class="author">作者：${content.author}</span>
			</c:if>

			<c:if test="${not empty content.source}">
				<span class="source">文章来源：${content.source}</span>
			</c:if>

			<c:if test="${not empty content.publishTime}">
				<span class="publishTime">发布时间：${content.publishTime}</span>
			</c:if>
		</div>

		<div class="content">${content.content}</div>


		<c:if test="${not empty data.attachsPage}">
			<span>下载附件demo</span>
			<c:forEach items="${data.attachsPage}" var="data1" varStatus="varStatus">
				<div>
					<a href="${pageContext.request.contextPath}/content/download?id=${data1.id}">${data1.name}&nbsp;&nbsp;</a>
				</div>
			</c:forEach>
		</c:if>
	</div>
</body>
</html>
