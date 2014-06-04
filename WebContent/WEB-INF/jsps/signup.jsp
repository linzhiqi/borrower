<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/scripts/jquery.leanModal.min.js"></script>

<!-- <script type="text/javascript">
	$(document).ready(function() {
		document.f.j_username.focus();
	});
</script> -->


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" />
<link href="${pageContext.request.contextPath}/static/css/main.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/static/css/login_popup.css"
	rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>

	<a id="modal_trigger" href="#modal" class="btn">Click here to Login
		or register</a>

	<div id="modal" class="popupContainer" style="display: none;">
		<header class="popupHeader"> <span class="header_title">Login</span>
		<span class="modal_close"><i class="fa fa-times"></i></span> </header>

		<section class="popupBody"> <!-- Social Login -->
		<div class="social_login">
			<div class="">
				<a href="<c:url value="/auth/facebook"/>" class="social_box fb">
					<span class="icon"><i class="fa fa-facebook"></i></span> <span
					class="icon_title">Connect with Facebook</span>

				</a> <a href="#" class="social_box google"> <span class="icon"><i
						class="fa fa-google-plus"></i></span> <span class="icon_title">Connect
						with Google</span>
				</a>
			</div>

			<div class="centeredText">
				<span>Or use your Email address</span>
			</div>

			<div class="action_btns">
				<div class="one_half">
					<a href="#" id="login_form" class="btn">Login</a>
				</div>
				<div class="one_half last">
					<a href="#" id="register_form" class="btn">Sign up</a>
				</div>
			</div>
		</div>

		<!-- Username & Password Login form -->
		<div class="user_login">
			<form name='f'
				action='${pageContext.request.contextPath}/j_spring_security_check'
				method='POST'>
				<c:if test="${param.loginerror != null}">

					<p class="error">Login failed. Check that your username and
						password are correct.</p>

				</c:if>
				<label>Username</label> <input type='text' name='j_username'
					value=''> <br /> <label>Password</label> <input
					type='password' name='j_password' /> <br />
				<div class="checkbox">
					<input type='checkbox' name='_spring_security_remember_me'
						checked="checked" /> <label for="remember">Remember me on
						this computer</label>
				</div>

				<div class="action_btns">
					<div class="one_half">
						<a href="#" class="btn back_btn"><i
							class="fa fa-angle-double-left"></i> Back</a>
					</div>
					<div class="one_half last">
						<input name="submit" type="submit" value="Login"
							class="btn btn_red" />
					</div>
				</div>
			</form>

			<a href="#" class="forgot_password">Forgot password?</a>
		</div>

		<!-- Register Form -->
		<div class="user_register">
			<sf:form id="details" method="post"
				action="${pageContext.request.contextPath}/signup"
				commandName="user">
				<label>User Name</label>
				<sf:input path="username" name="username" type="text" />
				<br />
				<div class="error">
					<sf:errors path="username"></sf:errors>
				</div>
				<label>Name</label>
				<sf:input path="name" name="name" type="text" />
				<br />
				<div class="error">
					<sf:errors path="name"></sf:errors>
				</div>
				<label>Email Address</label>
				<sf:input path="email" name="email" type="text" />
				<div class="error">
					<sf:errors path="email"></sf:errors>
				</div>
				<label>Password</label>
				<sf:input id="password" path="password" name="password"
					type="password" />
				<div class="error">
					<sf:errors path="password"></sf:errors>
				</div>
				<label>Confirm Password</label>
				<input id="confirmpass" name="confirmpass" type="password" />
				<div id="matchpass"></div>

				<div class="checkbox">
					<input id="send_updates" type="checkbox" /> <label
						for="send_updates">Send me occasional email updates</label>
				</div>

				<div class="action_btns">
					<div class="one_half">
						<a href="#" class="btn back_btn"><i
							class="fa fa-angle-double-left"></i> Back</a>
					</div>
					<div class="one_half last">
						<input class="btn btn_red" value="Create account" type="submit" />

					</div>
				</div>
			</sf:form>
		</div>
		</section>
	</div>

	<%-- 	<sec:authorize access="!isAuthenticated()">
		<a class="login" href="<c:url value='/login'/>">Log in</a>
	</sec:authorize> --%>



	<%-- <sec:authorize access="isAuthenticated()">
		<a class="login" href="<c:url value='/j_spring_security_logout'/>">Log
			out</a>
	</sec:authorize> --%>
	<script type="text/javascript">
		$("#modal_trigger").leanModal({
			top : 200,
			overlay : 0.6,
			closeButton : ".modal_close"
		});

		$(function() {
			// Calling Login Form
			$("#login_form").click(function() {
				$(".social_login").hide();
				$(".user_login").show();
				return false;
			});

			// Calling Register Form
			$("#register_form").click(function() {
				$(".social_login").hide();
				$(".user_register").show();
				$(".header_title").text('Register');
				return false;
			});

			// Going back to Social Forms
			$(".back_btn").click(function() {
				$(".user_login").hide();
				$(".user_register").hide();
				$(".social_login").show();
				$(".header_title").text('Login');
				return false;
			});

		})
	</script>

	<c:if test="${param.loginerror != null}">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#modal_trigger').trigger('click');
				$('#login_form').trigger('click');
			});
		</script>
	</c:if>


	<script type="text/javascript">
		$(document).ready(function() {
			$('#modal_trigger').trigger('click');
			$('#register_form').trigger('click');
		});
	</script>



</body>
</html>