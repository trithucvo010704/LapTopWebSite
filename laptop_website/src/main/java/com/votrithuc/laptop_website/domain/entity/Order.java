package com.votrithuc.laptop_website.domain.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.List;

// Import các entity liên quan
import com.votrithuc.laptop_website.domain.entity.OrderDetail;
import com.votrithuc.laptop_website.domain.entity.User;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "order_code", unique = true, nullable = false)
    private String orderCode;

    @Column(name = "total_price", nullable = false)
    private Double totalPrice;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private OrderStatus status = OrderStatus.PENDING;

    @Column(name = "payment_method")
    private String paymentMethod;

    @Column(name = "payment_status")
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;

    @Column(name = "shipping_address", columnDefinition = "TEXT")
    private String shippingAddress;

    @Column(name = "receiver_name")
    private String receiverName;

    @Column(name = "receiver_phone")
    private String receiverPhone;

    @Column(name = "receiver_email")
    private String receiverEmail;

    @Column(name = "shipping_fee")
    private Double shippingFee = 0.0;

    @Column(name = "discount_amount")
    private Double discountAmount = 0.0;

    @Column(name = "final_price")
    private Double finalPrice;

    @Column(name = "note", columnDefinition = "TEXT")
    private String note;

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted = false;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderDetail> orderDetails;

    // Enum cho trạng thái đơn hàng
    public enum OrderStatus {
        PENDING("Chờ xử lý"),
        CONFIRMED("Đã xác nhận"),
        PROCESSING("Đang xử lý"),
        SHIPPING("Đang giao hàng"),
        DELIVERED("Đã giao hàng"),
        CANCELLED("Đã hủy"),
        RETURNED("Đã trả hàng");

        private final String displayName;

        OrderStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    // Enum cho trạng thái thanh toán
    public enum PaymentStatus {
        PENDING("Chờ thanh toán"),
        PAID("Đã thanh toán"),
        FAILED("Thanh toán thất bại"),
        REFUNDED("Đã hoàn tiền");

        private final String displayName;

        PaymentStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    // Constructor với tham số cơ bản
    public Order(String orderCode, Double totalPrice, User user) {
        this.orderCode = orderCode;
        this.totalPrice = totalPrice;
        this.user = user;
        this.finalPrice = totalPrice + this.shippingFee - this.discountAmount;
    }

    // Method để tính final price
    public void calculateFinalPrice() {
        this.finalPrice = this.totalPrice + this.shippingFee - this.discountAmount;
    }

    // Method để soft delete
    public void softDelete() {
        this.isDeleted = true;
    }

    // Method để restore
    public void restore() {
        this.isDeleted = false;
    }

    // Getters và Setters bổ sung cho enum
    public String getStatus() {
        return status != null ? status.name() : OrderStatus.PENDING.name();
    }

    public void setStatus(String status) {
        this.status = OrderStatus.valueOf(status);
    }

    public String getPaymentStatus() {
        return paymentStatus != null ? paymentStatus.name() : PaymentStatus.PENDING.name();
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = PaymentStatus.valueOf(paymentStatus);
    }

    // Additional getters for DTO compatibility
    public String getReceiverAddress() {
        return this.shippingAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.shippingAddress = receiverAddress;
    }

    public Double getTotalAmount() {
        return this.finalPrice != null ? this.finalPrice : this.totalPrice;
    }

    public void setTotalAmount(Double totalAmount) {
        this.finalPrice = totalAmount;
    }
}
