package com.techzhiqi.web.borrower.dao;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "deals")
public class Deal {

	@Id
	@GeneratedValue
	private long id;
	@OneToOne
	@JoinColumn(name = "items_id")
	private Item item;

	@ManyToOne
	@JoinColumn(name = "borrower")
	private User borrower;
	
	@ManyToOne
	@JoinColumn(name = "lender")
	private User lender;

	@GeneratedValue
	private Timestamp created_time;
	private Date borrow_time;
	private Date return_time;
	private boolean borrowed = false;
	private boolean returned = false;
	private boolean accept = false;
	
	@Transient
	private SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
	
	public Deal() {
		
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public User getBorrower() {
		return borrower;
	}

	public void setBorrower(User borrower) {
		this.borrower = borrower;
	}

	public User getLender() {
		return lender;
	}

	public void setLender(User lender) {
		this.lender = lender;
	}

	public Timestamp getCreated_time() {
		return created_time;
	}

	public void setCreated_time(Timestamp created_time) {
		this.created_time = created_time;
	}

	public String getBorrow_time() {
		if(borrow_time == null) {
			return null;
		}
		return formatter.format(borrow_time);
	}

	public void setBorrow_time(String borrow_time) throws ParseException {
		System.out.println("borrow_time:" + borrow_time);
		
		this.borrow_time = formatter.parse(borrow_time);
		System.out.println("borrow_time:" + this.borrow_time);
	}

	public String getReturn_time() {
		if(return_time == null) {
			return null;
		}
		return formatter.format(return_time);
	}

	public void setReturn_time(String return_time) throws ParseException {
		System.out.println("return_time:" + return_time);
		
		this.return_time = formatter.parse(return_time);
		System.out.println("return_time:" + this.return_time);
	}

	public boolean isBorrowed() {
		return borrowed;
	}

	public void setBorrowed(boolean borrowed) {
		this.borrowed = borrowed;
	}

	public boolean isReturned() {
		return returned;
	}

	public void setReturned(boolean returned) {
		this.returned = returned;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((borrow_time == null) ? 0 : borrow_time.hashCode());
		result = prime * result + (borrowed ? 1231 : 1237);
		result = prime * result
				+ ((borrower == null) ? 0 : borrower.hashCode());
		result = prime * result
				+ ((created_time == null) ? 0 : created_time.hashCode());
		result = prime * result + (int) (id ^ (id >>> 32));
		result = prime * result + ((item == null) ? 0 : item.hashCode());
		result = prime * result + ((lender == null) ? 0 : lender.hashCode());
		result = prime * result
				+ ((return_time == null) ? 0 : return_time.hashCode());
		result = prime * result + (returned ? 1231 : 1237);
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Deal other = (Deal) obj;
		if (borrow_time == null) {
			if (other.borrow_time != null)
				return false;
		} else if (!borrow_time.equals(other.borrow_time))
			return false;
		if (borrowed != other.borrowed)
			return false;
		if (borrower == null) {
			if (other.borrower != null)
				return false;
		} else if (!borrower.equals(other.borrower))
			return false;
		if (created_time == null) {
			if (other.created_time != null)
				return false;
		} else if (!created_time.equals(other.created_time))
			return false;
		if (id != other.id)
			return false;
		if (item == null) {
			if (other.item != null)
				return false;
		} else if (!item.equals(other.item))
			return false;
		if (lender == null) {
			if (other.lender != null)
				return false;
		} else if (!lender.equals(other.lender))
			return false;
		if (return_time == null) {
			if (other.return_time != null)
				return false;
		} else if (!return_time.equals(other.return_time))
			return false;
		if (returned != other.returned)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Deal [id=" + id + ", item=" + item + ", borrower=" + borrower
				+ ", lender=" + lender + ", created_time=" + created_time
				+ ", borrow_time=" + borrow_time + ", return_time="
				+ return_time + ", borrowed=" + borrowed + ", returned="
				+ returned + "]";
	}

	public Deal(long id, Item item, User borrower, User lender,
			Timestamp created_time, Date borrow_time, Date return_time,
			boolean borrowed, boolean returned) {
		this.id = id;
		this.item = item;
		this.borrower = borrower;
		this.lender = lender;
		this.created_time = created_time;
		this.borrow_time = borrow_time;
		this.return_time = return_time;
		this.borrowed = borrowed;
		this.returned = returned;
	}

	public boolean isAccept() {
		return accept;
	}

	public void setAccept(boolean accept) {
		this.accept = accept;
	}


	

}
