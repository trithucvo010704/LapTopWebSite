package com.votrithuc.laptop_website.services.impl;

import com.votrithuc.laptop_website.domain.entity.Order;
import com.votrithuc.laptop_website.repositories.OrderRepository;
import com.votrithuc.laptop_website.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.criteria.Predicate;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public Page<Order> findOrdersWithFilters(String searchOrderCode, String searchStatus,
            String searchPaymentStatus, String searchReceiverName,
            Pageable pageable) {
        Specification<Order> spec = (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            // Chỉ lấy đơn hàng chưa bị xóa
            predicates.add(criteriaBuilder.equal(root.get("isDeleted"), false));

            // Tìm kiếm theo mã đơn hàng
            if (searchOrderCode != null && !searchOrderCode.trim().isEmpty()) {
                predicates.add(criteriaBuilder.like(
                        criteriaBuilder.lower(root.get("orderCode")),
                        "%" + searchOrderCode.toLowerCase() + "%"));
            }

            // Lọc theo trạng thái đơn hàng
            if (searchStatus != null && !searchStatus.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("status"), Order.OrderStatus.valueOf(searchStatus)));
            }

            // Lọc theo trạng thái thanh toán
            if (searchPaymentStatus != null && !searchPaymentStatus.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("paymentStatus"),
                        Order.PaymentStatus.valueOf(searchPaymentStatus)));
            }

            // Tìm kiếm theo tên người nhận
            if (searchReceiverName != null && !searchReceiverName.trim().isEmpty()) {
                predicates.add(criteriaBuilder.like(
                        criteriaBuilder.lower(root.get("receiverName")),
                        "%" + searchReceiverName.toLowerCase() + "%"));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };

        return orderRepository.findAll(spec, pageable);
    }

    @Override
    public Order findById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    @Override
    public Order findByOrderCode(String orderCode) {
        return orderRepository.findByOrderCodeAndIsDeletedFalse(orderCode).orElse(null);
    }

    @Override
    public Order save(Order order) {
        return orderRepository.save(order);
    }

    @Override
    public void softDeleteOrder(Long id) {
        orderRepository.softDeleteById(id);
    }

    @Override
    public void restoreOrder(Long id) {
        orderRepository.restoreById(id);
    }

    @Override
    public void updateOrderStatus(Long id, String status) {
        Order order = findById(id);
        if (order != null) {
            order.setStatus(status);
            orderRepository.save(order);
        }
    }

    @Override
    public void updatePaymentStatus(Long id, String paymentStatus) {
        Order order = findById(id);
        if (order != null) {
            order.setPaymentStatus(paymentStatus);
            orderRepository.save(order);
        }
    }

    @Override
    public long countAllOrders() {
        return orderRepository.countByIsDeletedFalse();
    }

    @Override
    public BigDecimal getTotalRevenue() {
        Double totalRevenue = orderRepository.getTotalRevenue();
        return totalRevenue != null ? BigDecimal.valueOf(totalRevenue) : BigDecimal.ZERO;
    }

    @Override
    public List<Map<String, Object>> getRevenueByOrderStatus() {
        List<Object[]> results = orderRepository.getRevenueByOrderStatus();
        List<Map<String, Object>> revenueData = new ArrayList<>();

        for (Object[] result : results) {
            Map<String, Object> data = new HashMap<>();
            data.put("status", result[0]);
            data.put("revenue", result[1]);
            data.put("count", result[2]);
            revenueData.add(data);
        }

        return revenueData;
    }
}