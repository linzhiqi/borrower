package com.techzhiqi.web.borrower.schedule;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.techzhiqi.web.borrower.dao.Deal;
import com.techzhiqi.web.borrower.dao.DealDao;
import com.techzhiqi.web.borrower.dao.User;
import com.techzhiqi.web.borrower.util.EmailUtil;

@EnableScheduling
public class ExpireNotifyTask {
	@Autowired
	private DealDao dealDao;
	@Autowired
	private EmailUtil emailUtil;
	private SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

	public DealDao getDealDao() {
		return dealDao;
	}

	public void setDealDao(DealDao dealDao) {
		this.dealDao = dealDao;
	}

	public EmailUtil getEmailUtil() {
		return emailUtil;
	}

	public void setEmailUtil(EmailUtil emailUtil) {
		this.emailUtil = emailUtil;
	}

	//every morning 10 am
	@Scheduled(cron = "0 0 10 * * ?")
	// every minute, seems different from linux crontab pattern
	//	@Scheduled(cron = "0 * * * * ?")
	public void scheduledTask() {
		System.out.println("!!!!!!!!!!!!!!!scheduledTask");
		// get all deals in db
		List<Deal> deals = dealDao.getAllDeals();
		// iterate all deals
		for (Deal deal : deals) {
			if (deal.isAccept()) {
				try {
					if (!deal.isBorrowed()
							&& formatter.parse(deal.getBorrow_time()).before(
									new Date())) {
						notify(deal.getLender(), "Borrower Notification",
								"You promised to lend "
										+ deal.getItem().getItem()+" to "+deal.getBorrower().getUsername()
										+ " by "+deal.getReturn_time());
					}
					if (deal.isBorrowed()
							&& !deal.isReturned()
							&& formatter.parse(deal.getReturn_time()).before(
									new Date())) {
						notify(deal.getBorrower(), "Borrower Notification",
								"You promised to return "
										+ deal.getItem().getItem()+" to "+deal.getLender().getUsername()
										+ " by " + deal.getReturn_time());

					}
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	private void notify(User borrower, String subject, String text) {
		System.out.println("!!!!!!!notify alarm.");
		emailUtil.sendMail(borrower.getEmail(), subject, text);
		
	}

}
