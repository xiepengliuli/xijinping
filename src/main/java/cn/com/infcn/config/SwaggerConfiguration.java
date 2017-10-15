package cn.com.infcn.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger.web.UiConfiguration;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Created by max on 8/16/16.
 *
 */
@Configuration
@EnableSwagger2
@EnableWebMvc
public class SwaggerConfiguration {

    @Bean
    public Docket getApiInfo() {
        return new Docket(DocumentationType.SWAGGER_2).groupName("portal api").select()
                .apis(RequestHandlerSelectors.basePackage("cn.com.infcn.biz")).paths(PathSelectors.any()).build().apiInfo(outApiInfo());

    }

    private ApiInfo outApiInfo() {
        return new ApiInfo("习大大学习_接口文档", // title 标题
                "外部接口文档", // description 描述 标题下
                "1.0.0", // version
                "http://infcn.com.cn/*", // termsOfService
                new Contact("xiep", "", "xiepengtest@163.com"), // contact
                "Apache 2.0", // licence
                "http://www.apache.org/licenses/LICENSE-2.0.html" // licence url
        );

    }

    @Bean
    public UiConfiguration getUiConfig() {
        return new UiConfiguration(null, // url,暂不用
                "none", // docExpansion => none | list
                "alpha", // apiSorter => alpha
                "schema", // defaultModelRendering => schema
                true, // enableJsonEditor => true | false
                true); // showRequestHeaders => true | false
    }
}