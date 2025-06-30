package com.votrithuc.laptop_website.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(name = "fullname", nullable = false)
    private String fullname;

    @Column(name = "user_phone")
    private String userPhone;

    private String address;

    private String avatar;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserStatus status = UserStatus.ACTIVE;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserRole role = UserRole.USER;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Enum cho trạng thái user
    public enum UserStatus {
        ACTIVE("Hoạt động"),
        LOCKED("Bị khóa"),
        INACTIVE("Không hoạt động");

        private final String displayName;

        UserStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    // Enum cho vai trò user
    public enum UserRole {
        ADMIN("Quản trị viên"),
        EDITOR("Biên tập viên"),
        USER("Người dùng");

        private final String displayName;

        UserRole(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    // Constructor với tham số cơ bản
    public User(String email, String password, String fullname) {
        this.email = email;
        this.password = password;
        this.fullname = fullname;
    }

    // Getters và Setters bổ sung cho enum
    public String getStatus() {
        return status != null ? status.name() : UserStatus.ACTIVE.name();
    }

    public void setStatus(String status) {
        this.status = UserStatus.valueOf(status);
    }

    public String getRole() {
        return role != null ? role.name() : UserRole.USER.name();
    }

    public void setRole(String role) {
        this.role = UserRole.valueOf(role);
    }

    // Method để toggle status
    public void toggleStatus() {
        if (this.status == UserStatus.ACTIVE) {
            this.status = UserStatus.LOCKED;
        } else {
            this.status = UserStatus.ACTIVE;
        }
    }

    // Additional getters for DTO compatibility
    public String getUsername() {
        return this.email; // Username is mapped to email
    }

    public void setUsername(String username) {
        this.email = username;
    }

    public String getPhone() {
        return this.userPhone;
    }

    public void setPhone(String phone) {
        this.userPhone = phone;
    }
}
