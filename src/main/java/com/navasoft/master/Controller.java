package com.navasoft.master;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {
  @GetMapping
  public String helloWorld() {
    var a = 1;
    return "Hello, devOps";
  }
}
