package com.techzhiqi.web.borrower.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("itemDao")
public class ItemDao {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public ItemDao() {
		System.out.println("Successfully loaded item DAO.");
	}
	
	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	public Item getItem(long id) {
		 Criteria crit = session().createCriteria(Item.class);
		 crit.add(Restrictions.idEq(id));
		 return (Item)crit.uniqueResult();
	}
	
	public long saveItem(Item item) {
		return (Long)session().save(item);
	}

}
