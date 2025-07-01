package com.votrithuc.laptop_website.domain.DTO.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductResponseDTO {
    private Long id;
    private String name;
    private Double price;
    private String image;
    private String detailDesc;
    private String shortDesc;
    private Long quantity;
    private Long sold;
    private String factory;
    private String target;
    private CategoryShortDTO category;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CategoryShortDTO {
        private Long id;
        private String name;
    }
}