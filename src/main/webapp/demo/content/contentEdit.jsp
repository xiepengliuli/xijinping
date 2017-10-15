<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="icon" uri="/WEB-INF/tld/ade-icon-tag.tld"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/ade-html-tag.tld"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/plugins/uploadify/uploadify.css">
<script type="text/javascript" charset="utf-8"
	src="${pageContext.request.contextPath}/resources/plugins/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
	$(function() {

		$('#status').combobox({
			valueField : 'id',
			editable : false,
			textField : 'text',
			url : ade.bp() + '/demo/content/statusComboTree',
			value : '${content.status}'
		});

		// 延迟1毫秒初始化文本框以及附件控件
		window.setTimeout(function() {

			editor = KindEditor.create('#editor_id', {
				minWidth : '600px',
				width : '600px',
				height : '270px',
				allowFileManager : false,
				items : [
				//第一行
				'source', '|', 'undo', 'redo', '|', 'selectall', 'cut', 'copy', 'paste', 'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter',
						'justifyright', 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript', 'superscript', '/',
						//第二行
						'clearhtml', 'quickformat', '|', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'strikethrough', 'lineheight', 'removeformat', '/',
						// 第三行
						'code', 'image', 'flash', 'template', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak', 'anchor', 'link',
						'unlink', '|', 'print', 'preview', 'fullscreen' ],

				uploadJson : '${pageContext.request.contextPath}/demo/attacheManagerController/uploadEditorFile?contentId=${content.id}',
				afterBlur : function() {
					this.sync();
				}
			});

			// 初始化附件上传控件
			initAddPageAttachs();

			parent.$.messager.progress('close');
		}, 1);

		$('#form').form({
			url : '${pageContext.request.contextPath}/demo/content/${operate}',
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
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
					parent.$.messager.show({
						title : '成功',
						msg : result.msg
					});
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});

	/*上传多个文件，数据资源用**/
	function initAddPageAttachs() {
		$('#uploadify').uploadify({
			'fileSizeLimit' : '100000KB',
			/* 'fileTypeExts' : '*.pdf', */
			'swf' : '${pageContext.request.contextPath}/resources/plugins/uploadify/uploadify.swf',//上传按钮的图片，默认是这个flash文件
			'uploader' : '${pageContext.request.contextPath}/demo/attacheManagerController//uploadAttaches', //上传所处理的服务器
			//       'cancelImg' : '${pageContext.request.contextPath}/resources/images/uploadify-cancel.png',//取消图片
			'method' : 'post',
			//             'folder' : '/UploadFile',//上传后，所保存文件的路径
			'queueID' : 'fileQueue',//上传显示进度条的那个div
			'buttonText' : '请选择文件',
			//             progressData : 'percentage',
			'auto' : true,
			'multi' : false,
			'onFallback' : function() {//检测FLASH失败调用  
				alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
			},
			'onDisable' : function() {
				alert('uploadify is disable');
			},
			'onError' : function(errorType, errObj) {
				alert('The error was: ' + errObj.info);
			},
			'onUploadSuccess' : function(file, data, response) {
				console.debug(data);
				var tempJson = JSON.parse(data);
				if ($("#add_hidden_input_clear input[id='" + file.name + "']").size() > 0) {

				} else {//如果没有添加过则添加隐藏域
					var tempi = $("#add_hidden_input_clear input").size() / 3;
					var tempsize = '<input type="hidden" name="attachs['+tempi+'].size" id="'+file.name+'" value="'+tempJson.size+'">';
					$("#add_hidden_input_clear").append(tempsize);
					var tempfileName_old = '<input type="hidden" name="attachs['+tempi+'].fileName_old" id="'+file.name+'" value="'+tempJson.fileName_old+'">';
					$("#add_hidden_input_clear").append(tempfileName_old);
					var filePath = '<input type="hidden" name="attachs['+tempi+'].filePath" id="'+file.name+'" value="'+tempJson.filePath+'">';
					$("#add_hidden_input_clear").append(filePath);
					var cancel = $("#" + file.id + " .cancel a");

					cancel.click(function() {
						$("#add_hidden_input_clear input[id='" + file.name + "']").remove();
					});
				}
			}
		});
	}

	/*删除附件*/
	function deleteAttach(id) {

		$.post("${pageContext.request.contextPath}/content/deleteAttach", {
			'id' : id
		}, function(data) {
			if (data.success) {
				$("#edit_attach_show_clear span[id='" + id + "']").remove();
			} else {
				alert(data.msg);
			}
		}, "json");
	}
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: scroll;" class="ade-gray">
		<form id="form" method="post">
			<input type="hidden" name="id" value="${content.id}" />
			<table class="ade-table">
				<tr>
					<th>栏目：</th>
					<td colspan="3"><input name="channelId" type="hidden" value="${content.channelId}" />${content.channelName}</td>
				</tr>
				<tr>
					<th>标题：</th>
					<td colspan="3"><input name="title" type="text" value="${content.title}" placeholder="请输入标题"
						class="easyui-validatebox" data-options="required:true" style="height: 30px; width: 600px;" /></td>
				</tr>
				<tr>
					<th>副标题：</th>
					<td colspan="3"><input name="subTitle" type="text" value="${content.subTitle}" placeholder="请输入副标题"
						style="height: 30px; width: 600px;" /></td>
				</tr>
				<tr>
					<th>文章作者：</th>
					<td><input name="author" type="text" value="${content.author}" placeholder="请输入文章作者"
						style="height: 30px; width: 250px;" /></td>
					<th>文章来源：</th>
					<td><input name="source" type="text" value="${content.source}" placeholder="请输入文章来源"
						style="height: 30px; width: 250px;" /></td>
				</tr>
				<tr>
					<th>是否外链：</th>
					<td><input name="isOutLink" type="radio" value="1"
						<c:if test="${content.isOutLink == '1'}">checked="checked"</c:if> />是<input name="isOutLink" type="radio"
						value="0" <c:if test="${content.isOutLink != '1'}">checked="checked"</c:if> />不是</td>
					<th>原文地址：</th>
					<td><input name="link" type="text" value="${content.link}" placeholder="请输入原文地址"
						style="height: 30px; width: 250px;" /></td>
				</tr>
				<tr>
					<th>状态：</th>
					<td><select id="status" name="status" style="width: 250px; height: 30px;"></select></td>
					<th>发布时间：</th>
					<td><input name="publishTimeStr" validType="numValid" value="${content.publishTimeStr}" type="text"
						placeholder="请输入日期" class="easyui-datebox" data-options="width:250,height:30,editable:true" editable="true"
						value=""></td>
				</tr>
				<tr>
					<th>内容：</th>
					<td colspan="3"><textarea style="width: 600px; height: 270px;" name="content" id="editor_id">${content.content}</textarea></td>
				</tr>

				<tr>
					<th>备注：</th>
					<td colspan="3"><textarea style="width: 600px; height: 70px;" name="remark" class="easyui-validatebox"
							data-options="validType:['length[0,10000]']">${content.remark}</textarea></td>
				</tr>
				<tr>

					<th>附件：</th>
					<td colspan="3"><div>
							<div id="fileQueue"></div>
							<input type="file" name="uploadify" id="uploadify">
						</div></td>
				</tr>
				<%--         <input  value="${content.attachsPage}"/> --%>
			</table>
			<div id="add_hidden_input_clear">
				<c:forEach var="item" items="${content.attachsPage}" varStatus="status">
					<span id="${ item.id}" style="line_hight: 5px;"> ${item.name } <a style="margin-left: 5px; color: red;"
						href="javascript:deleteAttach('${item.id }');">X</a>
					</span>

				</c:forEach>
			</div>
		</form>
	</div>
</div>