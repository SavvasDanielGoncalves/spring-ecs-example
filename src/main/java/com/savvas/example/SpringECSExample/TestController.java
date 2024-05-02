package com.savvas.example.SpringECSExample;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/demo")
public class TestController {

    @GetMapping("/test")
    public String test() {
        return "Hello World!";
    }

}