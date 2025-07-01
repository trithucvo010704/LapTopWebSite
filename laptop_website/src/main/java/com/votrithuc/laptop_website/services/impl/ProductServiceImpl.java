package com.votrithuc.laptop_website.services.impl;

import com.votrithuc.laptop_website.domain.entity.Product;
import com.votrithuc.laptop_website.domain.entity.Category;
import com.votrithuc.laptop_website.repositories.ProductRepository;
import com.votrithuc.laptop_website.repositories.CategoryRepository;
import com.votrithuc.laptop_website.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public Page<Product> findProductsWithFilters(String searchName, String brand, String category, Pageable pageable) {
        Specification<Product> spec = (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            // Tìm kiếm theo tên sản phẩm
            if (searchName != null && !searchName.trim().isEmpty()) {
                predicates.add(criteriaBuilder.like(
                        criteriaBuilder.lower(root.get("name")),
                        "%" + searchName.toLowerCase() + "%"));
            }

            // Lọc theo thương hiệu
            if (brand != null && !brand.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("factory"), brand));
            }

            // Lọc theo danh mục
            if (category != null && !category.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("category").get("name"), category));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };

        return productRepository.findAll(spec, pageable);
    }

    @Override
    public Product findById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }

    @Override
    public void deleteById(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    public List<Map<String, Object>> getSearchSuggestions(String term) {
        // Implementation for search suggestions
        return new ArrayList<>();
    }

    @Override
    public List<String> getAllBrands() {
        return productRepository.findAll().stream()
                .map(Product::getFactory)
                .distinct()
                .filter(brand -> brand != null && !brand.trim().isEmpty())
                .toList();
    }

    @Override
    public List<String> getAllCategories() {
        return categoryRepository.findAll().stream()
                .map(Category::getName)
                .toList();
    }

    @Override
    public List<Category> getAllCategoryEntities() {
        return categoryRepository.findAll();
    }

    @Override
    public long countAllProducts() {
        return productRepository.count();
    }
}