package com.techzhiqi.web.borrower.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.techzhiqi.web.borrower.dao.User;
import com.techzhiqi.web.borrower.dao.UserDao;

@Controller
public class LoginController {

	@Autowired
	private UserDao userDao;
	
	
	@RequestMapping("/")
	public String showHome(Model model, Principal principal) {
		if (principal != null) {
			System.out.println("logged in already.");
			return "redirect:/mypage";
		}

		model.addAttribute("user", new User());

		return "home";
	}

	
	@RequestMapping("/loggedout")
	public String showLoggedOut() {
		System.out.println("in loggedout.");
		return "loggedout";
	}
}
