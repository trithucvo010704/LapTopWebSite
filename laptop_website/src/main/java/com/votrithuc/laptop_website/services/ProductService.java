package com.votrithuc.laptop_website.services;

import com.votrithuc.laptop_website.domain.entity.Product;
import com.votrithuc.laptop_website.domain.entity.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface ProductService {

    // Lấy danh sách sản phẩm với filter
    Page<Product> findProductsWithFilters(String searchName, String brand, String category, Pageable pageable);

    // Lấy sản phẩm theo ID
    Product findById(Long id);

    // Lưu sản phẩm
    Product save(Product product);

    // Xóa sản phẩm
    void deleteById(Long id);

    // Lấy gợi ý tìm kiếm
    List<Map<String, Object>> getSearchSuggestions(String term);

    // Lấy tất cả brands
    List<String> getAllBrands();

    // Lấy tất cả categories
    List<String> getAllCategories();

    // Lấy tất cả category entities
    List<Category> getAllCategoryEntities();

    // Đếm tổng số sản phẩm
    long countAllProducts();
}