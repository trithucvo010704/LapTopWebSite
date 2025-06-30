package com.votrithuc.laptop_website;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class LaptopWebsiteApplication {

	public static void main(String[] args) {
		SpringApplication.run(LaptopWebsiteApplication.class, args);
	}

}
