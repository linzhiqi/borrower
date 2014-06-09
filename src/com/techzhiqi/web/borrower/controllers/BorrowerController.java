package com.techzhiqi.web.borrower.controllers;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.techzhiqi.web.borrower.dao.Deal;
import com.techzhiqi.web.borrower.dao.DealDao;
import com.techzhiqi.web.borrower.dao.ItemDao;
import com.techzhiqi.web.borrower.dao.User;
import com.techzhiqi.web.borrower.dao.UserDao;

@Controller
public class BorrowerController {

	@Autowired
	private UserDao userDao;
	@Autowired
	private DealDao dealDao;
	@Autowired
	private ItemDao itemDao;

	private SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

	@RequestMapping("/mypage")
	public String showMyPage(Model model, Principal principal) {

		
		model.addAttribute("deal", new Deal());

		model.addAttribute("user", principal.getName());
		List<Deal> borrowDeals = dealDao
				.getDealsOnBorrower(principal.getName());
		List<Deal> lendDealsList = dealDao
				.getDealsOnLender(principal.getName());
		System.out.println("!!! received deal:" + lendDealsList);
		List<Deal> historyBorrowDeals = takeHistoryDealsOut(borrowDeals);
		List<Deal> historyLendDeals = takeHistoryDealsOut(lendDealsList);
		System.out.println("!!! received deal after take history out:" + lendDealsList);
		Deals lendDeals = new Deals();
		lendDeals.setDeals(lendDealsList);
		model.addAttribute("borrowdealsvalid", borrowDeals);
		model.addAttribute("lenddealsvalid", lendDeals);
		model.addAttribute("borrowdealshistory", historyBorrowDeals);
		model.addAttribute("lenddealshistory", historyLendDeals);

		return "mypage";
	}

	private List<Deal> takeHistoryDealsOut(List<Deal> deals) {
		List<Deal> historyDeals = new ArrayList<Deal>();
		
		for(Deal deal : deals){
			try {
				if(!deal.isAccept() && formatter.parse(deal.getBorrow_time()).before(new Date())){
					System.out.println("!!!!history: " + deal.toString());
					historyDeals.add(deal);
					
				}else if(deal.isBorrowed() && deal.isReturned()){
					System.out.println("!!!!history: " + deal.toString());
					historyDeals.add(deal);
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		deals.removeAll(historyDeals);
		return historyDeals;
	}

	@RequestMapping(value = "/createdeal", method = RequestMethod.POST)
	public String createDeal(Deal deal, Principal principal) {

		if (!userDao.exists(deal.getLender().getUsername())) {
			System.out.println("User name does not exist.");
			return "redirect:/mypage";
		}
		User me = new User();
		me.setUsername(principal.getName());
		deal.setBorrower(me);
		System.out.println("Deal: " + deal.toString());
		long itemId = itemDao.saveItem(deal.getItem());
		deal.getItem().setId(itemId);
		dealDao.saveOrUpdate(deal);
		return "redirect:/mypage";
	}

	@RequestMapping(value = "updatedeals", method = RequestMethod.POST)
	public String updateDeals(Deals deals, Principal principal) {
		List<Deal> list = deals.getDeals();
		for (Deal deal : list) {
			System.out.println("deal:" + deal);
//			dealDao.updateBorrowed(deal.getId(), deal.isBorrowed());
//			dealDao.updateReturned(deal.getId(), deal.isReturned());
			dealDao.updateStatus(deal.getId(), deal.isAccept(), deal.isBorrowed(), deal.isReturned());
		}
		return "redirect:/mypage";
	}

}
