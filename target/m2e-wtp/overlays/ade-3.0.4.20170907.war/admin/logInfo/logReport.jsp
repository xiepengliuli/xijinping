<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>用户日志管理</title>
<jsp:include page="/WEB-INF/inc/adeInc.jsp"></jsp:include>
<%-- <script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugins/echarts.min.js"></script> --%>
<%-- <script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugins/esl.js"></script> --%>

</head>

<body>
		<div>
				<table>
						<th>
						<td>
								<!--               <a target="_blank" --> <%--               href="${pageContext.request.contextPath}/admin/userLogs/logReport" --%>
								<!--               class="easyui-linkbutton" data-options="plain:true,iconCls:'chart_chart_bar'">报表统计</a> -->
								<!--               <a --> <!--               onclick="logReport();" href="javascript:void(0);" class="easyui-linkbutton" -->
								<!--               data-options="plain:true,iconCls:'chart_chart_bar'">浏览器类型统计</a> --> <!--               <a -->
								<!--               onclick="logReport();" href="javascript:void(0);" class="easyui-linkbutton" -->
								<!--               data-options="plain:true,iconCls:'chart_chart_bar'">操作系统类型统计</a> --> <!--               </td> -->
						<td>查询类型：<select id="searchType" name="userState" style="width: 200px;">
										<option value="selectType">--请选择-</option>
										<option value="BROWSER_TYPE">浏览器类型</option>
										<option value="OS_TYPE">操作系统类型</option>
						</select></td>
						<td>查询日期：<select id="month" name="userState" style="width: 200px;">
										<option value="selectMonth">--请选择-</option>
										<option value="3">3个月</option>
										<option value="6">半年</option>
										<option value="12">一年</option>
						</select></td>
						<td><a href="javascript:void(0);" class="easyui-linkbutton"
								data-options="iconCls:'map_magnifier',plain:true" onclick="searchReport();">查询</a></td>

						</th>
				</table>
		</div>

		<!-- 为ECharts准备一个具备大小（宽高）的Dom -->

		<div id="main" style="height: 400px" style="display:none"></div>

		<script type="text/javascript" language="javascript">
      var myChart;
      var options;
      var searchType;
      var month;
      var searchName;

      require.config({
        paths : {
          'echarts' : '${pageContext.request.contextPath}/resources/plugins/echarts',
          'echarts/chart/bar' : '${pageContext.request.contextPath}/resources/plugins/echarts' //需要的组件  
        }
      });

      //       require([ 'echarts', 'echarts/chart/line' ], DrawEChart //异步加载的回调函数绘制图表  
      //       );
      parent.$.messager.progress('close');

      //查询按钮
      function searchReport() {
        searchType = $("#searchType").val();
        month = $("#month").val();
        //           alert(searchType+month);
        searchName = $("#searchType option:selected").html();
        //         alert(searchName);
        if ("selectType" == searchType || "selectMonth" == month) {
          alert("请选择查询条件");
        } else {
          getChartData(searchType, month, searchName);

        }

      }

      //获取echarts展示所需数据
      function getChartData(searchType, month, searchName) {
        //通过Ajax获取数据  
        $.ajax({
          type : "post",
          async : false, //同步执行  
          url : "${pageContext.request.contextPath}/admin/userLogsManager/getLogBrowserData",
          data : {
            searchType : searchType,
            month : month,
            searchName : searchName
          },
          dataType : "json", //返回数据形式为json  
          success : function(result) {
            drawBar("main", result);
          },
          error : function(errorMsg) {
            alert("图表请求数据失败啦!");
            //             myChart.hideLoading();
          }
        });
      }

      function drawBar(divId, data) {
        // 加载需要使用到的echarts包  
        require([ 'echarts'], function(ec) {
          myChart = ec.init(document.getElementById(divId));
          myChart.setOption({
            tooltip : {
              trigger : 'axis'
            },
            legend : {
              //1. json数据中的图例  
              data : data.legend
            },
            toolbox : {
              show : true,
              feature : {
                mark : {
                  show : true
                },
                dataView : {
                  show : true,
                  readOnly : false
                },
                magicType : {
                  show : true,
                  type : [ 'line', 'bar' ]
                },
                restore : {
                  show : true
                },
                saveAsImage : {
                  show : true
                }
              }
            },
            calculable : true,
            xAxis : [ {
              type : 'category',
              data : data.category
            //2. json数据中的横坐标

            } ],
            yAxis : [ {
              name : '人数/人',

              type : 'value',
              splitNumber : 1,
              splitArea : {
                show : true
              },
              interval : 1
            } ],
            grid : {
              width : '60%'
            },
            series : data.series
//               [ {
// //               data : data.series[0].data,
// // 				name : data.series[0].name,
// // 				data : data.series[0].data,
//                 barWidth : 40
//             } ]
          //3. json数据中的显示数据  
//             series : []
          });
        });
      }
    </script>
</body>
</html>