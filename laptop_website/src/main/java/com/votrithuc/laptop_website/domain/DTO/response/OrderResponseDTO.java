package com.votrithuc.laptop_website.domain.DTO.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderResponseDTO {
    private Long id;
    private String orderCode;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private String status;
    private String paymentStatus;
    private BigDecimal totalAmount;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime createdAt;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime updatedAt;
    private List<OrderDetailDTO> orderDetails;
    private UserShortDTO user;
    private Double shippingFee;
    private Double discountAmount;
    private Double finalPrice;
    private String paymentMethod;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class OrderDetailDTO {
        private Long id;
        private String productName;
        private Long productId;
        private Long quantity;
        private BigDecimal price;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserShortDTO {
        private Long id;
        private String username;
    }
}