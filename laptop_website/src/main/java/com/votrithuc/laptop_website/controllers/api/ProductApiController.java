package com.votrithuc.laptop_website.controllers.api;

import com.votrithuc.laptop_website.domain.entity.Product;
import com.votrithuc.laptop_website.domain.entity.Category;
import com.votrithuc.laptop_website.domain.DTO.response.ProductResponseDTO;
import com.votrithuc.laptop_website.services.ProductService;
import com.votrithuc.laptop_website.repositories.CategoryRepository;
import com.votrithuc.laptop_website.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/products")
@CrossOrigin(origins = "*")
public class ProductApiController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ProductMapper productMapper;

    // Lấy danh sách sản phẩm với phân trang và tìm kiếm
    @GetMapping
    public ResponseEntity<Map<String, Object>> getProducts(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String searchName,
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String sortBy) {

        Pageable pageable;
        if (sortBy != null && !sortBy.isEmpty()) {
            Sort sort = getSortBy(sortBy);
            pageable = PageRequest.of(page, size, sort);
        } else {
            pageable = PageRequest.of(page, size);
        }

        Page<Product> productPage = productService.findProductsWithFilters(
                searchName, brand, category, pageable);

        // Convert to DTO using mapper
        List<ProductResponseDTO> productDTOs = productPage.getContent().stream()
                .map(productMapper::toDTO)
                .collect(Collectors.toList());

        Map<String, Object> response = new HashMap<>();
        response.put("products", productDTOs);
        response.put("currentPage", productPage.getNumber());
        response.put("totalItems", productPage.getTotalElements());
        response.put("totalPages", productPage.getTotalPages());
        response.put("size", productPage.getSize());

        return ResponseEntity.ok(response);
    }

    // Lấy thông tin một sản phẩm
    @GetMapping("/{id}")
    public ResponseEntity<ProductResponseDTO> getProduct(@PathVariable Long id) {
        Product product = productService.findById(id);
        if (product != null) {
            return ResponseEntity.ok(productMapper.toDTO(product));
        }
        return ResponseEntity.notFound().build();
    }

    // Tạo sản phẩm mới
    @PostMapping
    public ResponseEntity<Map<String, Object>> createProduct(@RequestBody Map<String, Object> productData) {
        Map<String, Object> response = new HashMap<>();
        try {
            Product product = new Product();

            // Set các trường từ request data
            if (productData.containsKey("name")) {
                product.setName((String) productData.get("name"));
            }
            if (productData.containsKey("factory")) {
                product.setFactory((String) productData.get("factory"));
            }
            if (productData.containsKey("quantity")) {
                product.setQuantity(Long.valueOf(productData.get("quantity").toString()));
            }
            if (productData.containsKey("sold")) {
                product.setSold(Long.valueOf(productData.get("sold").toString()));
            }
            if (productData.containsKey("price")) {
                product.setPrice(Double.valueOf(productData.get("price").toString()));
            }
            if (productData.containsKey("shortDesc")) {
                product.setShortDesc((String) productData.get("shortDesc"));
            }
            if (productData.containsKey("detailDesc")) {
                product.setDetailDesc((String) productData.get("detailDesc"));
            }
            if (productData.containsKey("image")) {
                product.setImage((String) productData.get("image"));
            }
            if (productData.containsKey("target")) {
                product.setTarget((String) productData.get("target"));
            }

            // Xử lý category
            if (productData.containsKey("categoryId") && productData.get("categoryId") != null
                    && !productData.get("categoryId").toString().isEmpty()) {
                Long categoryId = Long.valueOf(productData.get("categoryId").toString());
                Category category = categoryRepository.findById(categoryId).orElse(null);
                product.setCategory(category);
            }

            Product savedProduct = productService.save(product);
            response.put("success", true);
            response.put("message", "Sản phẩm đã được tạo thành công");
            response.put("product", productMapper.toDTO(savedProduct));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi tạo sản phẩm: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    // Cập nhật sản phẩm
    @PutMapping("/{id}")
    public ResponseEntity<Map<String, Object>> updateProduct(@PathVariable Long id,
            @RequestBody Map<String, Object> productData) {
        Map<String, Object> response = new HashMap<>();
        try {
            Product existingProduct = productService.findById(id);
            if (existingProduct == null) {
                response.put("success", false);
                response.put("message", "Không tìm thấy sản phẩm");
                return ResponseEntity.notFound().build();
            }

            // Cập nhật các trường từ request data
            if (productData.containsKey("name")) {
                existingProduct.setName((String) productData.get("name"));
            }
            if (productData.containsKey("factory")) {
                existingProduct.setFactory((String) productData.get("factory"));
            }
            if (productData.containsKey("quantity")) {
                existingProduct.setQuantity(Long.valueOf(productData.get("quantity").toString()));
            }
            if (productData.containsKey("sold")) {
                existingProduct.setSold(Long.valueOf(productData.get("sold").toString()));
            }
            if (productData.containsKey("price")) {
                existingProduct.setPrice(Double.valueOf(productData.get("price").toString()));
            }
            if (productData.containsKey("shortDesc")) {
                existingProduct.setShortDesc((String) productData.get("shortDesc"));
            }
            if (productData.containsKey("detailDesc")) {
                existingProduct.setDetailDesc((String) productData.get("detailDesc"));
            }
            if (productData.containsKey("image")) {
                existingProduct.setImage((String) productData.get("image"));
            }
            if (productData.containsKey("target")) {
                existingProduct.setTarget((String) productData.get("target"));
            }

            // Xử lý category
            if (productData.containsKey("categoryId") && productData.get("categoryId") != null
                    && !productData.get("categoryId").toString().isEmpty()) {
                Long categoryId = Long.valueOf(productData.get("categoryId").toString());
                Category category = categoryRepository.findById(categoryId).orElse(null);
                existingProduct.setCategory(category);
            } else {
                existingProduct.setCategory(null);
            }

            Product updatedProduct = productService.save(existingProduct);
            response.put("success", true);
            response.put("message", "Sản phẩm đã được cập nhật thành công");
            response.put("product", productMapper.toDTO(updatedProduct));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi cập nhật sản phẩm: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    // Xóa sản phẩm
    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> deleteProduct(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            productService.deleteById(id);
            response.put("success", true);
            response.put("message", "Sản phẩm đã được xóa thành công");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi khi xóa sản phẩm: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    // Lấy gợi ý tìm kiếm
    @GetMapping("/search-suggestions")
    public ResponseEntity<List<Map<String, Object>>> getSearchSuggestions(@RequestParam String term) {
        try {
            List<Map<String, Object>> suggestions = productService.getSearchSuggestions(term);
            return ResponseEntity.ok(suggestions);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Lấy danh sách brands
    @GetMapping("/brands")
    public ResponseEntity<List<String>> getBrands() {
        try {
            List<String> brands = productService.getAllBrands();
            return ResponseEntity.ok(brands);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    // Lấy danh sách categories
    @GetMapping("/categories")
    public ResponseEntity<List<Map<String, Object>>> getCategories() {
        try {
            List<Category> categories = categoryRepository.findAll();
            List<Map<String, Object>> categoryList = categories.stream()
                    .map(category -> {
                        Map<String, Object> map = new HashMap<>();
                        map.put("id", category.getId());
                        map.put("name", category.getName());
                        return map;
                    })
                    .collect(Collectors.toList());
            return ResponseEntity.ok(categoryList);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    private Sort getSortBy(String sortBy) {
        switch (sortBy) {
            case "priceAsc":
                return Sort.by(Sort.Direction.ASC, "price");
            case "priceDesc":
                return Sort.by(Sort.Direction.DESC, "price");
            case "nameAsc":
                return Sort.by(Sort.Direction.ASC, "name");
            case "nameDesc":
                return Sort.by(Sort.Direction.DESC, "name");
            default:
                return Sort.by(Sort.Direction.ASC, "id");
        }
    }
}