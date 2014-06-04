package com.techzhiqi.web.borrower.dao;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.social.connect.UserProfile;


@Entity
@Table(name="users")
public class User {
	
	@Id
	@Size(min=5, max=60)
	@NotNull
	private String username;
	@Size(min=5, max=60)
	@NotNull
	private String name;
	@Size(min=5, max=100)
	@NotNull
	private String password;
	@Size(min=5, max=50)
	@NotNull
	@Pattern(regexp=".*\\@.*\\..*", message="This does not appear to be an email.")
	private String email;
	private String authority;
	private boolean enabled;
	
	public User() {
		
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String role) {
		this.authority = role;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((authority == null) ? 0 : authority.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + (enabled ? 1231 : 1237);
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result
				+ ((password == null) ? 0 : password.hashCode());
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
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
		User other = (User) obj;
		if (authority == null) {
			if (other.authority != null)
				return false;
		} else if (!authority.equals(other.authority))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (enabled != other.enabled)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", name=" + name + ", password="
				+ password + ", email=" + email + ", authority=" + authority
				+ ", enabled=" + enabled + "]";
	}

	public User(String username, String name, String password, String email,
			String authority, boolean enabled) {
		super();
		this.username = username;
		this.name = name;
		this.password = password;
		this.email = email;
		this.authority = authority;
		this.enabled = enabled;
	}
	
	public static User fromProviderUser(UserProfile providerUser) {
		User user = new User();
		user.setName(providerUser.getFirstName()+" "+ providerUser.getLastName());
		
		user.setUsername(providerUser.getUsername());
		return user;
	}
	
}
