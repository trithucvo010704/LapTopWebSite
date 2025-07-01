package com.votrithuc.laptop_website.controllers.api;

import com.votrithuc.laptop_website.domain.entity.User;
import com.votrithuc.laptop_website.domain.DTO.response.UserResponseDTO;
import com.votrithuc.laptop_website.services.UserService;
import com.votrithuc.laptop_website.mapper.UserMapper;
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
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class UserApiController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserMapper userMapper;

    // GET /api/users - Lấy danh sách users với filter
    @GetMapping
    public ResponseEntity<Map<String, Object>> getUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String searchName,
            @RequestParam(required = false) String searchRole,
            @RequestParam(required = false) String searchStatus,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir) {

        try {
            Sort sort = Sort.by(Sort.Direction.fromString(sortDir), sortBy);
            Pageable pageable = PageRequest.of(page, size, sort);

            Page<User> userPage = userService.findUsersWithFilters(
                    searchName, searchRole, searchStatus, pageable);

            // Convert to DTO using mapper
            List<UserResponseDTO> userDTOs = userPage.getContent().stream()
                    .map(userMapper::toDTO)
                    .collect(Collectors.toList());

            Map<String, Object> response = new HashMap<>();
            response.put("users", userDTOs);
            response.put("currentPage", userPage.getNumber());
            response.put("totalItems", userPage.getTotalElements());
            response.put("totalPages", userPage.getTotalPages());
            response.put("size", userPage.getSize());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Lỗi khi tải danh sách người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // GET /api/users/{id} - Lấy thông tin user theo ID
    @GetMapping("/{id}")
    public ResponseEntity<UserResponseDTO> getUserById(@PathVariable Long id) {
        User user = userService.findById(id);
        if (user != null) {
            return ResponseEntity.ok(userMapper.toDTO(user));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // POST /api/users - Tạo user mới
    @PostMapping
    public ResponseEntity<Map<String, Object>> createUser(@RequestBody User user) {
        try {
            User savedUser = userService.save(user);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Tạo người dùng thành công");
            response.put("user", userMapper.toDTO(savedUser));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "Lỗi khi tạo người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // Dùng put bởi vì cập nhật toàn bộ thông tin của user
    // PUT /api/users/{id} - Cập nhật user
    @PutMapping("/{id}")
    public ResponseEntity<Map<String, Object>> updateUser(@PathVariable Long id, @RequestBody User userDetails) {
        try {
            User existingUser = userService.findById(id);
            if (existingUser == null) {
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("error", "Không tìm thấy người dùng");
                return ResponseEntity.notFound().build();
            }

            // Update fields
            existingUser.setFullname(userDetails.getFullname());
            existingUser.setEmail(userDetails.getEmail());
            existingUser.setPhone(userDetails.getPhone());
            existingUser.setStatus(userDetails.getStatus());
            existingUser.setRole(userDetails.getRole());

            User updatedUser = userService.save(existingUser);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Cập nhật người dùng thành công");
            response.put("user", userMapper.toDTO(updatedUser));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "Lỗi khi cập nhật người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // DELETE /api/users/{id} - Xóa user
    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> deleteUser(@PathVariable Long id) {
        try {
            userService.deleteById(id);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Xóa người dùng thành công");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "Lỗi khi xóa người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // PATCH /api/users/{id}/toggle-status - Thay đổi trạng thái user
    @PatchMapping("/{id}/toggle-status")
    public ResponseEntity<Map<String, Object>> toggleUserStatus(@PathVariable Long id) {
        try {
            User updatedUser = userService.toggleStatus(id);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Thay đổi trạng thái người dùng thành công");
            response.put("user", userMapper.toDTO(updatedUser));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "Lỗi khi thay đổi trạng thái: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // GET /api/users/count - Đếm tổng số người dùng
    @GetMapping("/count")
    public ResponseEntity<Map<String, Object>> getUserCount() {
        try {
            long count = userService.countAllUsers();
            Map<String, Object> response = new HashMap<>();
            response.put("count", count);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Lỗi khi đếm người dùng: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }
}