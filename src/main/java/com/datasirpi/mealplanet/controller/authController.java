package com.datasirpi.mealplanet.controller;


import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
@RequestMapping("/auth")

public class authController {

    @GetMapping("/users")
    String getUsers() {
        return "Users Data";
    }
}
