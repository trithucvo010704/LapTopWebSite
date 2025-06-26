package com.votrithuc.laptop_website.controllers.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminViewController {
    @GetMapping("/admin/dashboard")
    public String showDashboard() {
        return "admin/index";
    }

    @GetMapping("/admin/user")
    public String showUser() {
        return "admin/user";
    }

    @GetMapping("/admin/product")
    public String showProduct() {
        return "admin/product";
    }

    @GetMapping("/admin/order")
    public String showOrder() {
        return "admin/order";
    }

}
