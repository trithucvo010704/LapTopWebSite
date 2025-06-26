package com.votrithuc.laptop_website.controllers.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashBoardController {
    // This controller will handle the dashboard view for admin users
    // You can add methods to return the dashboard view, handle requests, etc.

    // Example method to return the dashboard view
    @GetMapping("/admin/dashboard")
    public String showDashboard(Model model) {
        return "admin/index"; // jsp file located at /WEB-INF/view/admin/index.jsp
    }
}
