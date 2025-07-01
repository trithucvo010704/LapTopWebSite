package com.votrithuc.laptop_website.services;

import com.votrithuc.laptop_website.domain.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface UserService {

    // Lấy danh sách users với filter
    Page<User> findUsersWithFilters(String searchName, String searchRole, String searchStatus, Pageable pageable);

    // Lấy user theo ID
    User findById(Long id);

    // Lưu user
    User save(User user);

    // Xóa user
    void deleteById(Long id);

    // Thay đổi trạng thái user
    User toggleStatus(Long id);

    // Đếm tổng số người dùng
    long countAllUsers();
}