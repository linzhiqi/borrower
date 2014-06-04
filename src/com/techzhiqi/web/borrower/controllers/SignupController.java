package com.techzhiqi.web.borrower.controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.web.ProviderSignInUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.WebRequest;

import com.techzhiqi.web.borrower.dao.User;
import com.techzhiqi.web.borrower.dao.UserDao;

@Controller
public class SignupController {

	private final ProviderSignInUtils providerSignInUtils;
	@Autowired
	private UserDao userDao;
	
	public SignupController(){
		this.providerSignInUtils = new ProviderSignInUtils();
	}
	
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public User signupForm(WebRequest request) {
		Connection<?> connection = providerSignInUtils.getConnectionFromSession(request);
		if (connection != null) {
			request.setAttribute("message", StringUtils.capitalize(connection.getKey().getProviderId()) + " account is not associated with a Spring Social Showcase account. If you're new, please sign up.", WebRequest.SCOPE_REQUEST);
			return User.fromProviderUser(connection.fetchUserProfile());
		} else {
			return new User();
		}
	}
	
//	@RequestMapping(value="/signup", method=RequestMethod.POST)
//	public String signup(@Valid User user, BindingResult formBinding, WebRequest request) {
//		if (formBinding.hasErrors()) {
//			return null;
//		}
//		Account account = createAccount(form, formBinding);
//		if (account != null) {
//			SignInUtils.signin(account.getUsername());
//			providerSignInUtils.doPostSignUp(account.getUsername(), request);
//			return "redirect:/";
//		}
//		return null;
//		System.out.println("!!!signup(), user:"+user);
//		return null;
//	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String createAccount(Model model, @Valid User user,
			BindingResult result, WebRequest request) {
		System.out.println("User:" + user.toString());

		if (result.hasErrors()) {
			System.out.println("result has errors: "
					+ result.getAllErrors().toString());
			user.setPassword(null);
			
			model.addAttribute("signuperror", true);
			return "home";
		}

		user.setAuthority("ROLE_USER");
		user.setEnabled(true);

		try {
			userDao.create(user);
		} catch (DuplicateKeyException e) {
			result.rejectValue("username", "DuplicateKey.user.username",
					"this username or already exists.");
			user.setPassword(null);
			model.addAttribute("signuperror", true);
			return "home";
		} catch (DataAccessException e) {
			result.rejectValue("username", "DataAccess.user.username",
					"this username or email already exists.");
			user.setPassword(null);
			model.addAttribute("signuperror", true);
			return "home";
		}
		providerSignInUtils.doPostSignUp(user.getUsername(), request);
		return "redirect:/";
	}
}
