package uk.co.springworks.aws.hellocloud;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import uk.co.springworks.aws.hellocloud.controller.PriceController;
import uk.co.springworks.aws.hellocloud.repository.HashMapPriceRepository;
import uk.co.springworks.aws.hellocloud.repository.PriceRepository;

@SpringBootApplication
public class Application {
	public static void main(String... args){
		SpringApplication.run(Application.class, args);
	}

	@Bean
	PriceController priceController(){
		return new PriceController(priceRepository());
	}
	
	@Bean
	PriceRepository priceRepository(){
		return new HashMapPriceRepository();
	}
}
