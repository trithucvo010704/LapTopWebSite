package com.votrithuc.laptop_website.services.impl;

import com.votrithuc.laptop_website.domain.entity.User;
import com.votrithuc.laptop_website.repositories.UserRepository;
import com.votrithuc.laptop_website.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public Page<User> findUsersWithFilters(String searchName, String searchRole, String searchStatus,
            Pageable pageable) {
        Specification<User> spec = (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            // Tìm kiếm theo tên
            if (searchName != null && !searchName.trim().isEmpty()) {
                predicates.add(criteriaBuilder.like(
                        criteriaBuilder.lower(root.get("fullname")),
                        "%" + searchName.toLowerCase() + "%"));
            }

            // Lọc theo vai trò
            if (searchRole != null && !searchRole.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("role"), User.UserRole.valueOf(searchRole)));
            }

            // Lọc theo trạng thái
            if (searchStatus != null && !searchStatus.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("status"), User.UserStatus.valueOf(searchStatus)));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };

        return userRepository.findAll(spec, pageable);
    }

    @Override
    public User findById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public User toggleStatus(Long id) {
        User user = findById(id);
        if (user != null) {
            user.toggleStatus();
            return userRepository.save(user);
        }
        return null;
    }

    @Override
    public long countAllUsers() {
        return userRepository.count();
    }
}