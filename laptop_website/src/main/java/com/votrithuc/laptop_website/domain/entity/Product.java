package com.votrithuc.laptop_website.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "products")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    // Constructor với tham số cơ bản
    public Product(String name, Double price, String image, String shortDesc, String detailDesc) {
        this.name = name;
        this.price = price;
        this.image = image;
        this.shortDesc = shortDesc;
        this.detailDesc = detailDesc;
    }
}