<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
  $(function() {
    $('#organizationid').combotree({
      url : '${pageContext.request.contextPath}/admin/organizationManager/organizationComboTree',
      parentField : 'pid',
      lines : true,
      panelHeight : 'auto',
      onLoadSuccess : function() {
        parent.$.messager.progress('close');
      }
    });
    comboxVlue();

    $('#form').form({
      url : '${pageContext.request.contextPath}/admin/userManager/${operate}',
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
  function comboxVlue() {
    var comvalue = "${user.organizationId}";
    $('#organizationid').combotree('setValue', comvalue);

  }
</script>

<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;" class="ade-gray">
		<form id="form" method="post">
			<input name="id" type="hidden" value="${user.id}" />
			<table class="ade-table">
				<tr>
					<th>登录名：</th>
					<td><c:if test="${operate=='edit'}">
							<input name="loginName" type="text" placeholder="请输入登录名称" class="easyui-validatebox" style="height: 30px;"
								data-options="required:true" value="${user.loginName}" readonly="readonly" />
						</c:if> <c:if test="${operate=='add'}">
							<input name="loginName" type="text" placeholder="请输入登录名称" class="easyui-validatebox" style="height: 30px;"
								data-options="required:true" value="" />
						</c:if></td>
					<th>密码：</th>
					<td><c:if test="${operate=='edit'}">******</c:if> <c:if test="${operate=='add'}">
							<input name="password" type="password" placeholder="请输入密码" class="easyui-validatebox" style="height: 30px;"
								data-options="required:true" />
						</c:if></td>
				</tr>
				<th>姓名：</th>
				<td><input name="userName" type="text" placeholder="请输入用户名称" class="easyui-validatebox" style="height: 30px;"
					value="${user.userName}" /></td>
				<th>性别：</th>
				<td><input name="sex" type="radio" value="男" <c:if test="${user.sex == '男'}">checked="checked"</c:if> />男<input
					name="sex" type="radio" value="女" <c:if test="${user.sex == '女'}">checked="checked"</c:if> />女</td>
				<tr>
					<th>手机：</th>
					<td><input name="mobilePhone" type="text" placeholder="请输入手机号" class="easyui-validatebox"
						style="height: 30px;" data-options="validType:'isMobilePhone'" value="${user.mobilePhone}" /></td>
					<th>座机：</th>
					<td><input name="telePhone" type="text" placeholder="请输入座机电话" class="easyui-validatebox" style="height: 30px;"
						data-options="validType:'isTelePhone'" value="${user.telePhone}" /></td>
				</tr>
				<tr>
					<th>邮箱：</th>
					<td><input name="email" type="text" placeholder="请输入邮箱" class="easyui-validatebox" style="height: 30px;"
						data-options="validType:'email'" value="${user.email}" /></td>
					<th>用户IP：</th>
					<td><input name="ip" type="text" placeholder="请输入用户IP" class="easyui-validatebox" style="height: 30px;"
						data-options="validType:'isIP'" value="${user.ip}" /></td>
				</tr>
				<tr>
					<th>用户状态：</th>
					<td><input name="userState" type="radio" value="1"
						<c:if test="${user.userState == '1'}">checked="checked"</c:if> />正常<input name="userState" type="radio" value="9"
						<c:if test="${user.userState != '1'}">checked="checked"</c:if> />冻结</td>
					<th>组织机构：</th>
					<td><select id="organizationid" name="organizationId" style="width: 140px; height: 30px;"
						value="${user.organizationId}"></select><img
						src="${pageContext.request.contextPath}/resources/css/images/extjs_icons/cut_red.png"
						onclick="$('#organizationid').combotree('clear');" /></td>
				</tr>
				<tr>
					<th>备注：</th>
					<td colspan="3"><textarea name="userDesc" style="width: 395px; height: 100px;">${user.userDesc}</textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>
