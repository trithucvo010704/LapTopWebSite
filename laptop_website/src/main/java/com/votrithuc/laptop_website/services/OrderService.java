package com.votrithuc.laptop_website.services;

import com.votrithuc.laptop_website.domain.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface OrderService {

    // Lấy danh sách đơn hàng với filter
    Page<Order> findOrdersWithFilters(String searchOrderCode, String searchStatus,
            String searchPaymentStatus, String searchReceiverName,
            Pageable pageable);

    // Lấy đơn hàng theo ID
    Order findById(Long id);

    // Lấy đơn hàng theo mã đơn hàng
    Order findByOrderCode(String orderCode);

    // Lưu đơn hàng
    Order save(Order order);

    // Soft delete đơn hàng
    void softDeleteOrder(Long id);

    // Restore đơn hàng
    void restoreOrder(Long id);

    // Cập nhật trạng thái đơn hàng
    void updateOrderStatus(Long id, String status);

    // Cập nhật trạng thái thanh toán
    void updatePaymentStatus(Long id, String paymentStatus);

    // Thống kê cho dashboard
    long countAllOrders();

    BigDecimal getTotalRevenue();

    List<Map<String, Object>> getRevenueByOrderStatus();
}