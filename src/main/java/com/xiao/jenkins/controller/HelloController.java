package com.xiao.jenkins.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @RequestMapping(value = "/hello")
    @ResponseBody
    public Object hello(){
        return "hello jenkins! docker!";
    }
}
