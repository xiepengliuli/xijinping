<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>Echarts Demo</title>
<%@ include file="/WEB-INF/inc/adeInc.jsp"%>
<script type="text/javascript" src="/ade/resources/plugins/echarts.min.js"></script>
<script type="text/javascript" src="/ade/resources/plugins/zhejiang.js"></script>
<link rel="stylesheet" href="/ade/resources/css/demo/demo.css">
<script type="text/javascript">
  $(function() {
    initPie();
    initBar();
    initMap();
  })
  function initPie() {
    option = {
      tooltip : {
        trigger : 'item',
        formatter : "{a} <br/>{b}: {c} ({d}%)"
      },
      legend : {
        orient : 'vertical',
        x : 'left',
        data : [ '直达', '营销广告', '搜索引擎', '邮件营销', '联盟广告', '视频广告', '百度', '谷歌', '必应', '其他' ]
      },
      series : [ {
        name : '访问来源',
        type : 'pie',
        selectedMode : 'single',
        radius : [ 0, '30%' ],

        label : {
          normal : {
            position : 'inner'
          }
        },
        labelLine : {
          normal : {
            show : false
          }
        },
        data : [ {
          value : 335,
          name : '直达',
          selected : true
        }, {
          value : 679,
          name : '营销广告'
        }, {
          value : 1548,
          name : '搜索引擎'
        } ]
      }, {
        name : '访问来源',
        type : 'pie',
        radius : [ '40%', '55%' ],

        data : [ {
          value : 335,
          name : '直达'
        }, {
          value : 310,
          name : '邮件营销'
        }, {
          value : 234,
          name : '联盟广告'
        }, {
          value : 135,
          name : '视频广告'
        }, {
          value : 1048,
          name : '百度'
        }, {
          value : 251,
          name : '谷歌'
        }, {
          value : 147,
          name : '必应'
        }, {
          value : 102,
          name : '其他'
        } ]
      } ]
    };
    var myChart = echarts.init(document.getElementById('pie'));
    myChart.setOption(option);
  }
  function initBar() {
    option = {
      title : {
        text : '阶梯瀑布图',
        subtext : 'From ExcelHome',
        sublink : 'http://e.weibo.com/1341556070/Aj1J2x5a5'
      },
      tooltip : {
        trigger : 'axis',
        axisPointer : { // 坐标轴指示器，坐标轴触发有效
          type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
        },
        formatter : function(params) {
          var tar;
          if (params[1].value != '-') {
            tar = params[1];
          } else {
            tar = params[0];
          }
          return tar.name + '<br/>' + tar.seriesName + ' : ' + tar.value;
        }
      },
      legend : {
        data : [ '支出', '收入' ]
      },
      grid : {
        left : '3%',
        right : '4%',
        bottom : '3%',
        containLabel : true
      },
      xAxis : {
        type : 'category',
        splitLine : {
          show : false
        },
        data : function() {
          var list = [];
          for (var i = 1; i <= 11; i++) {
            list.push('11月' + i + '日');
          }
          return list;
        }()
      },
      yAxis : {
        type : 'value'
      },
      series : [ {
        name : '辅助',
        type : 'bar',
        stack : '总量',
        itemStyle : {
          normal : {
            barBorderColor : 'rgba(0,0,0,0)',
            color : 'rgba(0,0,0,0)'
          },
          emphasis : {
            barBorderColor : 'rgba(0,0,0,0)',
            color : 'rgba(0,0,0,0)'
          }
        },
        data : [ 0, 900, 1245, 1530, 1376, 1376, 1511, 1689, 1856, 1495, 1292 ]
      }, {
        name : '收入',
        type : 'bar',
        stack : '总量',
        label : {
          normal : {
            show : true,
            position : 'top'
          }
        },
        data : [ 900, 345, 393, '-', '-', 135, 178, 286, '-', '-', '-' ]
      }, {
        name : '支出',
        type : 'bar',
        stack : '总量',
        label : {
          normal : {
            show : true,
            position : 'bottom'
          }
        },
        data : [ '-', '-', '-', 108, 154, '-', '-', '-', 119, 361, 203 ]
      } ]
    };
    var myChart = echarts.init(document.getElementById('bar'));
    myChart.setOption(option);
  }
  function initMap() {
    var mapDataArray = [ {
      name : '杭州',
      value : '10'
    }, {
      name : '绍兴',
      value : '20'
    }, {
      name : '金华',
      value : '30'
    }, {
      name : '宁波',
      value : '40'
    }, {
      name : '衢州',
      value : '50'
    }, {
      name : '台州',
      value : '60'
    }, {
      name : '舟山',
      value : '70'
    }, {
      name : '丽水',
      value : '76'
    }, {
      name : '湖州',
      value : '80'
    }, {
      name : '温州',
      value :' 90'
    }, {
      name : '嘉兴',
      value : '95'
    } ];
 var cityarray=['1','2','3'];
    option = {
      legend : {
        orient : 'vertical',
        left : 'left',
        data : cityarray
      },
      tooltip : {
        trigger : 'item',
        formatter: '{b}<br/>'
      },
      visualMap : {
        min : 0,
        max : 100,
        left : 'right',
        top : 'top',
        color : [ '#379978', '#d4fae7' ],
        text : [ '高', '低' ], // 文本，默认为数值文本
        show : false,
        calculable : true
      },
      toolbox : {
        show : false,
        orient : 'vertical',
        left : 'right',
        top : 'center',
        feature : {
          dataView : {
            readOnly : false
          },
          restore : {},
          saveAsImage : {}
        }
      },
      series : [ {
        name : '经费',
        type : 'map',
        mapType : 'zj',
        label : {
          normal : {
            show : true
          },
          emphasis : {
            show : true
          }
        },
        zoom : 1.2,
        roam : true,
        symbolSize : function(val) {
          return 23;
        },
        data : mapDataArray,
        zlevel : 1,
        itemStyle : {
          emphasis : {
            areaColor : '#007500'
          }
        }

      } ]
    };
    var myChartMap = echarts.init(document.getElementById('map'));
    myChartMap.setOption(option);
  }
</script>
</head>
<body>
  <div class="mapAndPie">
    <div class="pieDiv">
      <div id="pie" class="pie"></div>
    </div>
    <div class="mapDiv">
      <div id="map" class="map"></div>
    </div>
  </div>
  <div class="barDiv">
    <div id="bar" class="bar"></div>
  </div>

</body>
</html>