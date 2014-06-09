package com.techzhiqi.web.borrower.util;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class EmailUtil {
	@Autowired
	@Value("${emailutil.sender.username}")
	private String userName;
	@Autowired
	@Value("${emailutil.sender.emailpassword}")
	private String emailPassword;
	private Session session;
	
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setEmailPassword(String emailPassword) {
		this.emailPassword = emailPassword;
	}

	public EmailUtil() {
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, emailPassword);
			}
		});
	}
	
	public boolean sendMail(String to, String subject, String text){
		try {
			 
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("techzhiqi@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(text);
 
			Transport.send(message);
 
			System.out.println("Email sent");
 
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}

}
