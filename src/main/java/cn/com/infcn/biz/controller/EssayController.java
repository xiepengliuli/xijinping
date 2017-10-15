package cn.com.infcn.biz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;

import cn.com.infcn.biz.service.EssayService;
import cn.com.infcn.model.JsonResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

/**
 * 文章表Service
 */
@Api(description = "资源分类接口")
@Controller
@RequestMapping("/portal/essay")
public class EssayController {

    @Autowired
    private EssayService essayService;

    /**
     * 
     * 描述: 获取资源分类
     *
     * @return JsonResult
     */
    @RequestMapping("/getResourceTypes")
    @ResponseBody
    @ApiOperation(value = "获取资源分类", httpMethod = "POST", notes = "获取资源分类")
    public JsonResult getResourceTypes() {
        JsonResult jsonResult = new JsonResult();
        try {

            List<String> resourceCategorys = essayService.getResourceTypes();
            // 调用业务层
            jsonResult.setObj(resourceCategorys);
            jsonResult.setSuccess(true);

        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

    /**
     * 
     * 描述: 获取资源类型
     *
     * @return JsonResult
     */
    @RequestMapping("/getResourceCategorys")
    @ResponseBody
    @ApiOperation(value = "获取获取资源类型", httpMethod = "POST", notes = "获取获取资源类型")
    public JsonResult getResourceCategorys() {
        JsonResult jsonResult = new JsonResult();
        try {

            List<String> resourceCategorys = essayService.getResourceCategorys();
            // 调用业务层
            jsonResult.setObj(resourceCategorys);
            jsonResult.setSuccess(true);

        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

    /**
     * 
     * 描述: 理论学习的导航
     *
     * @return JsonResult
     */
    @RequestMapping("/categoryLilunxuexi")
    @ResponseBody
    @ApiOperation(value = "获取理论学习的导航", httpMethod = "POST", notes = "获取理论学习的导航")
    public JsonResult categoryLilunxuexi() {
        JsonResult jsonResult = new JsonResult();
        try {

            JSONArray treeCategory = essayService.getTreeCategory("重要讲话", "治国理政");
            // 调用业务层
            jsonResult.setObj(treeCategory);
            jsonResult.setSuccess(true);
        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

    /**
     * 
     * 描述: 从政之路的导航
     *
     * @return JsonResult
     */
    @RequestMapping("/categoryCongzhengzhilu")
    @ResponseBody
    @ApiOperation(value = "获取从政之路的导航", httpMethod = "POST", notes = "获取从政之路的导航")
    public JsonResult categoryCongzhengzhilu() {
        JsonResult jsonResult = new JsonResult();
        try {

            JSONArray treeCategory = essayService.getTreeCategory("重要讲话", "从政之路");
            // 调用业务层
            jsonResult.setObj(treeCategory);
            jsonResult.setSuccess(true);
        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

    /**
     * 
     * 描述: 成长之路的导航
     *
     * @return JsonResult
     */
    @RequestMapping("/categoryChengzhangzhilu")
    @ResponseBody
    @ApiOperation(value = "获取成长之路的导航", httpMethod = "POST", notes = "获取成长之路的导航")
    public JsonResult categoryChengzhangzhilu() {
        JsonResult jsonResult = new JsonResult();
        try {

            JSONArray treeCategory = essayService.getTreeCategory("重要讲话", "成长之路");
            // 调用业务层
            jsonResult.setObj(treeCategory);
            jsonResult.setSuccess(true);
        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

    /**
     * 
     * 描述: 评论解读的导航(就一个资源分类)
     *
     * @return JsonResult
     */
    @RequestMapping("/categoryPinglunjiedu")
    @ResponseBody
    @ApiOperation(value = "获取评论解读的导航", httpMethod = "POST", notes = "获取评论解读的导航")
    public JsonResult categoryPinglunjiedu() {
        JsonResult jsonResult = new JsonResult();
        try {

            JSONArray treeCategory = essayService.getTreeCategory("评论解读", "治国理政");
            // 调用业务层
            jsonResult.setObj(treeCategory);
            jsonResult.setSuccess(true);
        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

    /**
     * 
     * 描述: 获取分面信息
     *
     * @param essay
     * @param resourceCategory
     * @param resourceType
     * @param titleTypeFirst
     * @param titleTypeSecond
     * @param addr
     * @param event
     * @param interviewer
     * @param related
     * @return JsonResult
     */
    @RequestMapping("/getfenpian")
    @ResponseBody
    @ApiOperation(value = "获取分面信息", httpMethod = "POST", notes = "此处会填写详细说明")
    public JsonResult getfenpian(
            @ApiParam(name = "resourceCategory", value = "资源类型 ", required = false) String resourceCategory,
            @ApiParam(name = "resourceType", value = "资源分类 ", required = true) String resourceType,
            @ApiParam(name = "titleTypeFirst", value = "主题分类一级 ") String titleTypeFirst,
            @ApiParam(name = "titleTypeSecond", value = "主题分类二级 ") String titleTypeSecond,
            @ApiParam(name = "addr", value = "地址") String addr, @ApiParam(name = "event", value = "事件") String event,
            @ApiParam(name = "interviewer", value = "(外事人物)陪同人") String interviewer,
            @ApiParam(name = "related", value = "(相关人物)参与人") String related,
            @ApiParam(name = "year", value = "年") String year) {
        // Essay essay
        JsonResult jsonResult = new JsonResult();
        try {

            JSONArray treeCategory = essayService.getTreeCategory("评论解读", "治国理政");
            // 调用业务层
            jsonResult.setObj(treeCategory);
            jsonResult.setSuccess(true);
        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

    /**
     * 
     * 描述: 测试参数的请求
     *
     * @return JsonResult
     */
    @RequestMapping("/testapi1")
    @ResponseBody
    @ApiOperation(value = "测试参数的请求", httpMethod = "POST", notes = "测试参数的请求",position=1)
    public JsonResult testapi1(
            @ApiParam(name = "name", value = "用户名", defaultValue = "use001", required = true) @RequestParam(required=true) String name,
            @ApiParam(name = "password", value = "密码", defaultValue = "12345678", required = true) @RequestParam(required=true) String password,
            @ApiParam(name = "email", value = "邮箱", defaultValue = "use001@163.com", required = false) @RequestParam(required=false) String email) {
        JsonResult jsonResult = new JsonResult();
        try {

            JSONArray treeCategory = essayService.getTreeCategory("评论解读", "治国理政");
            // 调用业务层
            jsonResult.setObj(treeCategory);
            jsonResult.setSuccess(true);
        } catch (Exception e) {
            jsonResult.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return jsonResult;

    }

}
