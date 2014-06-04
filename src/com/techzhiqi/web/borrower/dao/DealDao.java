package com.techzhiqi.web.borrower.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("dealDao")
public class DealDao {

	@Autowired
	private SessionFactory sessionFactory;

	public DealDao() {
		System.out.println("Successfully loaded deal DAO.");
	}

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public Deal getDeal(long id) {
		Criteria crit = session().createCriteria(Deal.class);
		crit.add(Restrictions.idEq(id));
		return (Deal) crit.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	public List<Deal> getDealsOnBorrower(String borrower) {
		Criteria crit = session().createCriteria(Deal.class);
		crit.createAlias("borrower", "b").add(
				Restrictions.eq("b.username", borrower));

		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Deal> getDealsOnLender(String lender) {
		Criteria crit = session().createCriteria(Deal.class);
		crit.createAlias("lender", "l").add(
				Restrictions.eq("l.username", lender));

		return crit.list();
	}

	public void saveOrUpdate(Deal deal) {
		session().saveOrUpdate(deal);
	}

	public boolean delete(long id) {
		Query query = session().createQuery("delete from Deal where id=:id");
		query.setLong("id", id);
		return query.executeUpdate() == 1;
	}

	public void updateBorrowed(long id, boolean checked) {
		Query query = session().createQuery(
				"update Deal set borrowed=:checked " + "where id=:id");
		query.setLong("id", id);
		query.setInteger("checked", checked==true?1:0);
		query.executeUpdate();
	}

	public void updateReturned(long id, boolean checked) {
		Query query = session().createQuery(
				"update Deal set returned=:checked " + "where id=:id");
		query.setLong("id", id);
		query.setInteger("checked", checked==true?1:0);
		query.executeUpdate();
	}
}
