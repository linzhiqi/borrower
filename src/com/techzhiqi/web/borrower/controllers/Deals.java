package com.techzhiqi.web.borrower.controllers;

import java.util.List;

import com.techzhiqi.web.borrower.dao.Deal;

public class Deals {

	private List<Deal> deals;
	
	public Deals() {
		
	}

	public List<Deal> getDeals() {
		return deals;
	}

	public void setDeals(List<Deal> deals) {
		this.deals = deals;
	}
	
	
}
