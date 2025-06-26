package com.votrithuc.laptop_website;

import org.springframework.boot.SpringApplication;

public class TestLaptopWebsiteApplication {

	public static void main(String[] args) {
		SpringApplication.from(LaptopWebsiteApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
