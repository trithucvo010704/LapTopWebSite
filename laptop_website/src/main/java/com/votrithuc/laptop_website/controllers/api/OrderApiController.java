package com.votrithuc.laptop_website.controllers.api;

import com.votrithuc.laptop_website.domain.entity.Order;
import com.votrithuc.laptop_website.domain.entity.OrderDetail;
import com.votrithuc.laptop_website.domain.entity.User;
import com.votrithuc.laptop_website.domain.DTO.response.OrderResponseDTO;
import com.votrithuc.laptop_website.services.OrderService;
import com.votrithuc.laptop_website.mapper.OrderMapper;
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
@RequestMapping("/api/orders")
@CrossOrigin(origins = "*")
public class OrderApiController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderMapper orderMapper;

    // GET /api/orders - Lấy danh sách đơn hàng với filter
    @GetMapping
    public ResponseEntity<Map<String, Object>> getOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String searchOrderCode,
            @RequestParam(required = false) String searchStatus,
            @RequestParam(required = false) String searchPaymentStatus,
            @RequestParam(required = false) String searchReceiverName,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir) {

        try {
            Sort sort = Sort.by(Sort.Direction.fromString(sortDir), sortBy);
            Pageable pageable = PageRequest.of(page, size, sort);

            Page<Order> orderPage = orderService.findOrdersWithFilters(
                    searchOrderCode, searchStatus, searchPaymentStatus, searchReceiverName, pageable);

            // Convert to DTO using mapper
            List<OrderResponseDTO> orderDTOs = orderPage.getContent().stream()
                    .map(orderMapper::toDTO)
                    .collect(Collectors.toList());

            Map<String, Object> response = new HashMap<>();
            response.put("orders", orderDTOs);
            response.put("currentPage", orderPage.getNumber());
            response.put("totalItems", orderPage.getTotalElements());
            response.put("totalPages", orderPage.getTotalPages());
            response.put("size", orderPage.getSize());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Lỗi khi tải danh sách đơn hàng: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // GET /api/orders/{id} - Lấy thông tin đơn hàng theo ID
    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDTO> getOrderById(@PathVariable Long id) {
        Order order = orderService.findById(id);
        if (order != null) {
            return ResponseEntity.ok(orderMapper.toDTO(order));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // PUT /api/orders/{id}/status - Cập nhật trạng thái đơn hàng
    @PutMapping("/{id}/status")
    public ResponseEntity<Map<String, Object>> updateOrderStatus(
            @PathVariable Long id,
            @RequestParam String status) {
        try {
            orderService.updateOrderStatus(id, status);
            Order updatedOrder = orderService.findById(id);
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Cập nhật trạng thái đơn hàng thành công");
            response.put("order", orderMapper.toDTO(updatedOrder));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Lỗi khi cập nhật trạng thái: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // PUT /api/orders/{id}/payment-status - Cập nhật trạng thái thanh toán
    @PutMapping("/{id}/payment-status")
    public ResponseEntity<Map<String, Object>> updatePaymentStatus(
            @PathVariable Long id,
            @RequestParam String paymentStatus) {
        try {
            orderService.updatePaymentStatus(id, paymentStatus);
            Order updatedOrder = orderService.findById(id);
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Cập nhật trạng thái thanh toán thành công");
            response.put("order", orderMapper.toDTO(updatedOrder));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Lỗi khi cập nhật trạng thái thanh toán: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // DELETE /api/orders/{id} - Soft delete đơn hàng
    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> softDeleteOrder(@PathVariable Long id) {
        try {
            orderService.softDeleteOrder(id);
            Map<String, Object> response = new HashMap<>();
            response.put("message", "Xóa đơn hàng thành công");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Lỗi khi xóa đơn hàng: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // GET /api/orders/statistics - Lấy thống kê đơn hàng
    @GetMapping("/statistics")
    public ResponseEntity<Map<String, Object>> getOrderStatistics() {
        try {
            Map<String, Object> statistics = new HashMap<>();
            statistics.put("totalOrders", orderService.countAllOrders());
            statistics.put("totalRevenue", orderService.getTotalRevenue());
            statistics.put("revenueByStatus", orderService.getRevenueByOrderStatus());
            return ResponseEntity.ok(statistics);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Lỗi khi lấy thống kê: " + e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }
}