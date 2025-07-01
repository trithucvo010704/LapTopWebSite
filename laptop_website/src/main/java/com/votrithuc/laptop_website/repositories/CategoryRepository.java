package com.votrithuc.laptop_website.repositories;

import com.votrithuc.laptop_website.domain.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
    // Các phương thức tùy chỉnh có thể được thêm ở đây
}