/**
 * @Project: ADE3
 * @Author: 杨彪
 * @Copyright: 2017 www.infcn.com.cn Inc. All rights reserved.
 */

var index_tabs;
var index_tabsMenu;
var index_layout;
var ade_system_menu_tree = '';

/**
 * 系统的初始化
 */
$(function() {
  // initMenu();
  initMenu();
  initTab();
});

function initMenu() {

  ade_system_menu_tree = $('#adeSystemMenuTreeBar').tree({
    url : ade.bp() + '/admin/moduleManager/systemMenuTree',
    parentField : 'pid',
    // lines : true,
    onClick : function(node) {
      if (node.attributes && node.attributes.url) {
        var url;
        if (node.attributes.url.indexOf('/') == 0) {/* 如果url第一位字符是"/"，那么代表打开的是本地的资源 */
          url = codeBase + node.attributes.url;
          parent.$.messager.progress({
            title : '提示',
            text : '数据处理中，请稍后....'
          });
        } else {/* 打开跨域资源 */
          url = node.attributes.url;
        }
        addTab({
          url : url,
          title : node.text,
          iconCls : node.iconCls
        });
      }
    },
    onBeforeLoad : function(node, param) {
      if (ade_system_menu_tree) {// 只有刷新页面才会执行这个方法
        parent.$.messager.progress({
          title : '提示',
          text : '数据处理中，请稍后....'
        });
      }
    },
    onLoadSuccess : function(node, data) {
      // 清理掉easyui-Tree中自带的图标
      $("#adeSystemMenuTreeBar .tree-icon.tree-folder").remove();
      $("#adeSystemMenuTreeBar .tree-icon.tree-file").remove();

      if (indexPageUrl != '') {
        $("#iframe").attr("src", ade.bp() + indexPageUrl);
      }
    }
  });
}

function initTab() {

  index_layout = $('#index_layout').layout({
    fit : true
  });

  index_tabs = $('#index_tabs').tabs({
    fit : true,
    border : false,
    tabHeight : 36,
    onContextMenu : function(e, title) {
      e.preventDefault();
      index_tabsMenu.menu('show', {
        left : e.pageX,
        top : e.pageY
      }).data('tabTitle', title);
    }
  });

  index_tabsMenu = $('#index_tabsMenu').menu({
    onClick : function(item) {
      var curTabTitle = $(this).data('tabTitle');
      var type = $(item.target).attr('title');

      if (type === 'refresh') {
        index_tabs.tabs('getTab', curTabTitle).panel('refresh');
        return;
      }

      if (type === 'close') {
        var t = index_tabs.tabs('getTab', curTabTitle);
        if (t.panel('options').closable) {
          index_tabs.tabs('close', curTabTitle);
        }
        return;
      }

      var allTabs = index_tabs.tabs('tabs');
      var closeTabsTitle = [];

      $.each(allTabs, function() {
        var opt = $(this).panel('options');
        if (opt.closable && opt.title != curTabTitle && type === 'closeOther') {
          closeTabsTitle.push(opt.title);
        } else if (opt.closable && type === 'closeAll') {
          closeTabsTitle.push(opt.title);
        }
      });

      for (var i = 0; i < closeTabsTitle.length; i++) {
        index_tabs.tabs('close', closeTabsTitle[i]);
      }
    }
  });
}

function addTab(params) {
  var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:98%;"></iframe>';

  var t = $('#index_tabs');
  var opts = {
    title : params.title,
    closable : true,
    iconCls : params.iconCls,
    content : iframe,
    border : false,
    fit : true
  };
  if (t.tabs('exists', opts.title)) {
    t.tabs('select', opts.title);
    parent.$.messager.progress('close');
  } else {
    t.tabs('add', opts);
  }
}

var sysMenuTools = [ {
  iconCls : 'database_refresh',
  handler : function() {
    $('#layout_west_sys_tree').tree('reload');
  }
}, {
  iconCls : 'resultset_next',
  handler : function() {
    var node = $('#layout_west_sys_tree').tree('getSelected');
    if (node) {
      $('#layout_west_sys_tree').tree('expandAll', node.target);
    } else {
      $('#layout_west_sys_tree').tree('expandAll');
    }
  }
}, {
  iconCls : 'resultset_previous',
  handler : function() {
    var node = $('#layout_west_sys_tree').tree('getSelected');
    if (node) {
      $('#layout_west_sys_tree').tree('collapseAll', node.target);
    } else {
      $('#layout_west_sys_tree').tree('collapseAll');
    }
  }
} ];

/**
 * @requires jQuery,EasyUI,jQuery cookie plugin 更换EasyUI主题的方法
 * @param themeName
 *          主题名称
 */
function changeThemeFun(themeName) {
  if ($.cookie('easyuiThemeName')) {
    $('#layout_north_pfMenu').menu('setIcon', {
      target : $('#layout_north_pfMenu div[title=' + $.cookie('easyuiThemeName') + ']')[0],
      iconCls : 'emptyIcon'
    });
  }
  $('#layout_north_pfMenu').menu('setIcon', {
    target : $('#layout_north_pfMenu div[title=' + themeName + ']')[0],
    iconCls : 'tick'
  });

  var $easyuiTheme = $('#easyuiTheme');
  var url = $easyuiTheme.attr('href');
  var href = url.substring(0, url.indexOf('&adeThemes=')) + '&adeThemes=' + themeName;

  $easyuiTheme.attr('href', href);

  var $iframe = $('iframe');
  if ($iframe.length > 0) {
    for (var i = 0; i < $iframe.length; i++) {
      var ifr = $iframe[i];
      try {
        $(ifr).contents().find('#easyuiTheme').attr('href', href);
      } catch (e) {
        try {
          ifr.contentWindow.document.getElementById('easyuiTheme').href = href;
        } catch (e) {
        }
      }
    }
  }

  $.cookie('easyuiThemeName', themeName, {
    expires : 7,
    path : '/'
  });
}

function currentUserRole() {
  parent.$.modalDialog({
    title : '我的角色',
    width : 300,
    height : 250,
    href : ade.bp() + '/admin/userManager/currentUserRolePage'
  });
}
function currentUserResource() {
  parent.$.modalDialog({
    title : '我可以访问的资源',
    width : 300,
    height : 250,
    href : ade.bp() + '/admin/userManager/currentUserResourcePage'
  });
}

function editCurrentUserPwd() {
  parent.$.modalDialog({
    title : '修改密码',
    width : 300,
    height : 250,
    href : ade.bp() + '/admin/userManager/editMyselfPwdPage',
    buttons : [ {
      text : '修改',
      handler : function() {
        var f = parent.$.modalDialog.handler.find('#editCurrentUserPwdForm');
        f.submit();
      }
    } ]
  });
}

function logoutFun(b) {
  $.getJSON(ade.bp() + '/admin/userManager/logout', {
    t : new Date()
  }, function(result) {
    window.location.href = ade.bp() + '/admin/index.jsp';
  });
}