package com.votrithuc.laptop_website.controllers.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {
    @GetMapping("/test")
    public String testView() {
        return "forward:/WEB-INF/view/admin/test.jsp"; // Sử dụng forward: để truy cập trực tiếp file JSP
    }
}