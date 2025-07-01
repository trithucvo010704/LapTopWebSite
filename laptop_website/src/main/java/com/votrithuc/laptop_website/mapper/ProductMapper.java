package com.votrithuc.laptop_website.mapper;

import com.votrithuc.laptop_website.domain.entity.Product;
import com.votrithuc.laptop_website.domain.DTO.response.ProductResponseDTO;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ProductMapper {

    public ProductResponseDTO toDTO(Product product) {
        if (product == null) {
            return null;
        }

        ProductResponseDTO dto = new ProductResponseDTO();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setPrice(product.getPrice());
        dto.setImage(product.getImage());
        dto.setDetailDesc(product.getDetailDesc());
        dto.setShortDesc(product.getShortDesc());
        dto.setQuantity(product.getQuantity());
        dto.setSold(product.getSold());
        dto.setFactory(product.getFactory());
        dto.setTarget(product.getTarget());

        // Convert category
        if (product.getCategory() != null) {
            ProductResponseDTO.CategoryShortDTO categoryDTO = new ProductResponseDTO.CategoryShortDTO();
            categoryDTO.setId(product.getCategory().getId());
            categoryDTO.setName(product.getCategory().getName());
            dto.setCategory(categoryDTO);
        }

        return dto;
    }

    public List<ProductResponseDTO> toDTOList(List<Product> products) {
        if (products == null) {
            return null;
        }
        return products.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }
}