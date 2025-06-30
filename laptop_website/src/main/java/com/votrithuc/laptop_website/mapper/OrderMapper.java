package com.votrithuc.laptop_website.mapper;

import com.votrithuc.laptop_website.domain.entity.Order;
import com.votrithuc.laptop_website.domain.entity.OrderDetail;
import com.votrithuc.laptop_website.domain.entity.User;
import com.votrithuc.laptop_website.domain.DTO.response.OrderResponseDTO;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class OrderMapper {

    public OrderResponseDTO toDTO(Order order) {
        if (order == null) {
            return null;
        }

        OrderResponseDTO dto = new OrderResponseDTO();
        dto.setId(order.getId());
        dto.setOrderCode(order.getOrderCode());
        dto.setReceiverName(order.getReceiverName());
        dto.setReceiverPhone(order.getReceiverPhone());
        dto.setReceiverAddress(order.getReceiverAddress());
        dto.setStatus(order.getStatus());
        dto.setPaymentStatus(order.getPaymentStatus());
        dto.setTotalAmount(order.getTotalAmount() != null ? BigDecimal.valueOf(order.getTotalAmount()) : null);
        dto.setCreatedAt(order.getCreatedAt());
        dto.setUpdatedAt(order.getUpdatedAt());
        dto.setShippingFee(order.getShippingFee());
        dto.setDiscountAmount(order.getDiscountAmount());
        dto.setFinalPrice(order.getFinalPrice());
        dto.setPaymentMethod(order.getPaymentMethod());

        // Convert order details
        if (order.getOrderDetails() != null) {
            List<OrderResponseDTO.OrderDetailDTO> detailDTOs = order.getOrderDetails().stream()
                    .map(this::toOrderDetailDTO)
                    .collect(Collectors.toList());
            dto.setOrderDetails(detailDTOs);
        }

        // Convert user (if not null and not proxy)
        if (order.getUser() != null) {
            User user = order.getUser();
            OrderResponseDTO.UserShortDTO userDTO = new OrderResponseDTO.UserShortDTO();
            userDTO.setId(user.getId());
            userDTO.setUsername(user.getUsername());
            dto.setUser(userDTO);
        }

        return dto;
    }

    public List<OrderResponseDTO> toDTOList(List<Order> orders) {
        if (orders == null) {
            return null;
        }
        return orders.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    private OrderResponseDTO.OrderDetailDTO toOrderDetailDTO(OrderDetail orderDetail) {
        if (orderDetail == null) {
            return null;
        }

        OrderResponseDTO.OrderDetailDTO dto = new OrderResponseDTO.OrderDetailDTO();
        dto.setId(orderDetail.getId());
        dto.setProductName(orderDetail.getProduct() != null ? orderDetail.getProduct().getName() : null);
        dto.setProductId(orderDetail.getProduct() != null ? orderDetail.getProduct().getId() : null);
        dto.setQuantity(orderDetail.getQuantity());
        dto.setPrice(orderDetail.getPrice());
        return dto;
    }
}