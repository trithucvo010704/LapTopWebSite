package com.votrithuc.laptop_website.repositories;

import com.votrithuc.laptop_website.domain.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    // Các phương thức tùy chỉnh có thể được thêm ở đây
}