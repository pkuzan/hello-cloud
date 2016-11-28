package uk.co.springworks.aws.hellocloud;

import com.google.common.base.Predicates;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Tag;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.time.LocalDate;

/**
 * Created by pkuzan on 28/11/2016.
 */
@Component
@EnableSwagger2
public class SwaggerConfig {

    public static final String VERSION = "1.0";
    public static final String TITLE = "Pricer";
    public static final String DESCRIPTION = "One-stop Stock Pricing Shop!";

    public Docket api(){
        return new Docket(DocumentationType.SWAGGER_2).select()
                .apis(RequestHandlerSelectors.any())
                .apis(Predicates.not(RequestHandlerSelectors.basePackage("org.springframework.boot")))
                .paths(PathSelectors.any())
                .build()
                .pathMapping("/")
                .apiInfo(metadata())
                .directModelSubstitute(LocalDate.class, String.class)
                .genericModelSubstitutes(ResponseEntity.class)
                .tags(new Tag(TITLE, DESCRIPTION));

    }

    private ApiInfo metadata(){
        return new ApiInfoBuilder()
                .title(TITLE)
                .description(DESCRIPTION)
                .version(VERSION)
                .build();
    }

}
