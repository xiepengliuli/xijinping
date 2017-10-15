package cn.com.infcn.biz.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cn.com.infcn.ade.framework.dao.BaseDaoI;
import cn.com.infcn.model.pmodel.Essay;
import cn.com.infcn.model.tmodel.Tessay;

/**
 * 文章表Service
 */
@Service
public class EssayService {

    @Autowired
    private BaseDaoI<Tessay> essayDao;

    /**
     * 
     * 描述: 获取资源类型
     *
     * @return List<String>
     */
    public List<String> getResourceCategorys() {

        List<String> resourceCategorys = new ArrayList<String>();
        StringBuilder hql = new StringBuilder();
        Map<String, Object> params = new HashMap<String, Object>();
        hql.append(
                "  from Tessay t group by t.resourceCategory having (t.resourceCategory !=null and  t.resourceCategory !='') ");

        List<Tessay> find = essayDao.find(hql.toString(), params);

        for (Tessay tessay : find) {
            resourceCategorys.add(tessay.getResourceCategory());
        }

        return resourceCategorys;
    }

    /**
     * 
     * 描述: 获取资源分类
     *
     * @return List<String>
     */
    public List<String> getResourceTypes() {

        List<String> resourceTypes = new ArrayList<String>();
        StringBuilder hql = new StringBuilder();
        Map<String, Object> params = new HashMap<String, Object>();
        hql.append("  from Tessay t group by t.resourceType having (t.resourceType !=null and  t.resourceType !='') ");

        List<Tessay> find = essayDao.find(hql.toString(), params);

        for (Tessay tessay : find) {
            resourceTypes.add(tessay.getResourceType());
        }

        return resourceTypes;
    }

    /**
     * 
     * 描述: 获取所有的树分类数据
     *
     * @return JSONArray
     */
    public JSONArray getTreeCategory(String resourceCategory, String resourceType) {

        JSONArray jsonArray = new JSONArray();
        List<String> categorys = getCategorys(resourceCategory, resourceType, "");
        for (String category : categorys) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", category);
            jsonObject.put("children", getCategorys(resourceCategory, resourceType, category));
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }

    /**
     * 
     * 描述: 根据名称获取下一级分类(如果为空表示获取所有的一级分类,否则根据名称查询二级分类)
     *
     * @param firstCategoryName
     *            一级分类名称
     * @param resourceCategory
     *            资源类型(如“重要讲话”,“评论解读”)
     * @param resourceType
     *            资源分类(如“治国理政”，“从政之路”，“成长之路”)
     * @return List<Essay>
     */
    public List<String> getCategorys(String resourceCategory, String resourceType, String firstCategoryName) {

        List<String> essays = new ArrayList<String>();

        List<Essay> categorysByName = getCategorysByName(resourceCategory, resourceType, firstCategoryName);
        for (Essay essay : categorysByName) {
            if (StringUtils.isNotBlank(firstCategoryName)) {
                essays.add(essay.getTitleTypeSecond());
            } else {
                essays.add(essay.getTitleTypeFirst());
            }
        }

        return essays;
    }

    /**
     * 
     * 描述: 根据名称获取下一级分类(如果为空表示获取所有的一级分类,否则根据名称查询二级分类)
     *
     * @param firstCategoryName
     *            一级分类名称
     * @param resourceType
     *            资源分类(如“治国理政”，“从政之路”，“成长之路”)
     * @param resourceCategory
     *            资源类型(如“重要讲话”,“评论解读”)
     * @return List<Essay>
     */
    private List<Essay> getCategorysByName(String resourceCategory, String resourceType, String firstCategoryName) {
        List<Essay> essays = new ArrayList<Essay>();
        Map<String, Object> params = new HashMap<String, Object>();

        StringBuilder hql = new StringBuilder(" select distinct  t  from Tessay t ");
        if (StringUtils.isNotBlank(firstCategoryName)) {// 查询二级分类
            hql.append(
                    " where (t.titleTypeSecond !=null and  t.titleTypeSecond !='') and t.titleTypeFirst=:titleTypeFirst ");
            hql.append(" and t.resourceCategory=:resourceCategory and t.resourceType=:resourceType");
            hql.append(" group by t.titleTypeSecond ");
            params.put("titleTypeFirst", firstCategoryName);
        } else {// 查询一级分类
            hql.append(" where (t.titleTypeFirst !=null and  t.titleTypeFirst !='')");
            hql.append(" and t.resourceCategory=:resourceCategory and t.resourceType=:resourceType");
            hql.append(" group by t.titleTypeFirst ");
        }

        params.put("resourceCategory", resourceCategory);
        params.put("resourceType", resourceType);

        List<Tessay> find = essayDao.find(hql.toString(), params);

        for (Tessay tessay : find) {
            Essay essay = new Essay();
            BeanUtils.copyProperties(tessay, essay);
            essays.add(essay);
        }

        return essays;
    }

}
