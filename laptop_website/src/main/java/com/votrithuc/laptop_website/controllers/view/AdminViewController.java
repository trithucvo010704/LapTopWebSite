package com.votrithuc.laptop_website.controllers.view;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.votrithuc.laptop_website.services.OrderService;
import com.votrithuc.laptop_website.services.ProductService;
import com.votrithuc.laptop_website.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AdminViewController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private ObjectMapper objectMapper;

    @GetMapping("/admin/dashboard")
    public String showDashboard(@RequestParam(required = false) String filter, Model model) {
        try {
            // Lấy thống kê tổng quan
            Map<String, Object> summary = new HashMap<>();
            summary.put("totalProducts", productService.countAllProducts());
            summary.put("totalUsers", userService.countAllUsers());
            summary.put("totalOrders", orderService.countAllOrders());
            summary.put("totalRevenue", orderService.getTotalRevenue());

            // Lấy thống kê doanh thu theo trạng thái đơn hàng
            List<Map<String, Object>> orderRevenueByStatus = orderService.getRevenueByOrderStatus();

            // Chuyển đổi sang JSON để truyền vào JavaScript
            String orderRevenueByStatusJson = objectMapper.writeValueAsString(orderRevenueByStatus);

            model.addAttribute("summary", summary);
            model.addAttribute("orderRevenueByStatusJson", orderRevenueByStatusJson);
            model.addAttribute("filter", filter != null ? filter : "month");

        } catch (JsonProcessingException e) {
            // Log error và sử dụng dữ liệu mặc định
            model.addAttribute("summary", getDefaultSummary());
            model.addAttribute("orderRevenueByStatusJson", "[]");
            model.addAttribute("filter", "month");
        }

        return "admin/index";
    }

    @GetMapping("/admin/user")
    public String showUser() {
        return "admin/user";
    }

    @GetMapping("/admin/product")
    public String showProduct(Model model) {
        model.addAttribute("categories", productService.getAllCategoryEntities());
        return "admin/product";
    }

    @GetMapping("/admin/order")
    public String showOrder() {
        return "admin/order";
    }

    private Map<String, Object> getDefaultSummary() {
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalProducts", 0);
        summary.put("totalUsers", 0);
        summary.put("totalOrders", 0);
        summary.put("totalRevenue", BigDecimal.ZERO);
        return summary;
    }
}
