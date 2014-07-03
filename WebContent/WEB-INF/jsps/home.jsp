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
	src="${pageContext.request.contextPath}/static/scripts/jssor.core.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/scripts/jssor.utils.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/scripts/jssor.slider.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/scripts/jquery.leanModal.min.js"></script>
<script type="text/javascript">
	jQuery(document)
			.ready(
					function($) {

						var _CaptionTransitions = [];
					
						_CaptionTransitions["RTT|2"] = {
							$Duration : 500,
							$Zoom : 3,
							$Rotate : 0,
							$Easing : {
								$Zoom : $JssorEasing$.$EaseInQuad,
								$Opacity : $JssorEasing$.$EaseLinear,
								$Rotate : $JssorEasing$.$EaseInQuad
							},
							$Opacity : 2,
							$Round : {
								$Rotate : 0.5
							}
						};
						
						var options = {
							$FillMode : 2, //[Optional] The way to fill image in slide, 0 stretch, 1 contain (keep aspect ratio and put all inside slide), 2 cover (keep aspect ratio and cover whole slide), 4 actual size, 5 contain for large image, actual size for small image, default value is 0
							$AutoPlay : true, //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
							$AutoPlayInterval : 8000, //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
							$PauseOnHover : 1, //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, default value is 1

							$ArrowKeyNavigation : true, //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
							$SlideEasing : $JssorEasing$.$EaseOutQuint, //[Optional] Specifies easing for right to left animation, default value is $JssorEasing$.$EaseOutQuad
							$SlideDuration : 1200, //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
							$MinDragOffsetToSlide : 20, //[Optional] Minimum drag offset to trigger slide , default value is 20
							//$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
							//$SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
							$SlideSpacing : 0, //[Optional] Space between each slide in pixels, default value is 0
							$DisplayPieces : 1, //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
							$ParkingPosition : 0, //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
							$UISearchMode : 1, //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
							$PlayOrientation : 1, //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
							$DragOrientation : 1, //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

							$CaptionSliderOptions : { //[Optional] Options which specifies how to animate caption
								$Class : $JssorCaptionSlider$, //[Required] Class to create instance to animate caption
								$CaptionTransitions : _CaptionTransitions, //[Required] An array of caption transitions to play caption, see caption transition section at jssor slideshow transition builder
								$PlayInMode : 1, //[Optional] 0 None (no play), 1 Chain (goes after main slide), 3 Chain Flatten (goes after main slide and flatten all caption animations), default value is 1
								$PlayOutMode : 3
							//[Optional] 0 None (no play), 1 Chain (goes before main slide), 3 Chain Flatten (goes before main slide and flatten all caption animations), default value is 1
							},

							$BulletNavigatorOptions : { //[Optional] Options to specify and enable navigator or not
								$Class : $JssorBulletNavigator$, //[Required] Class to create navigator instance
								$ChanceToShow : 2, //[Required] 0 Never, 1 Mouse Over, 2 Always
								$AutoCenter : 1, //[Optional] Auto center navigator in parent container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
								$Steps : 1, //[Optional] Steps to go for each navigation request, default value is 1
								$Lanes : 1, //[Optional] Specify lanes to arrange items, default value is 1
								$SpacingX : 8, //[Optional] Horizontal space between each item in pixel, default value is 0
								$SpacingY : 8, //[Optional] Vertical space between each item in pixel, default value is 0
								$Orientation : 1
							//[Optional] The orientation of the navigator, 1 horizontal, 2 vertical, default value is 1
							},

							$ArrowNavigatorOptions : { //[Optional] Options to specify and enable arrow navigator or not
								$Class : $JssorArrowNavigator$, //[Requried] Class to create arrow navigator instance
								$ChanceToShow : 1, //[Required] 0 Never, 1 Mouse Over, 2 Always
								$AutoCenter : 2, //[Optional] Auto center arrows in parent container, 0 No, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
								$Steps : 1
							//[Optional] Steps to go for each navigation request, default value is 1
							}
						};

						var jssor_slider1 = new $JssorSlider$(
								"slider1_container", options);

						//responsive code begin
						//you can remove responsive code if you don't want the slider scales while window resizes
						function ScaleSlider() {
							var bodyWidth = document.body.clientWidth;
							if (bodyWidth)
								jssor_slider1.$SetScaleWidth(Math.min(
										bodyWidth, 1920));
							else
								window.setTimeout(ScaleSlider, 30);
						}

						ScaleSlider();

						if (!navigator.userAgent
								.match(/(iPhone|iPod|iPad|BlackBerry|IEMobile)/)) {
							$(window).bind('resize', ScaleSlider);
						}
					});
</script>
<script type="text/javascript">
	function onLoad() {

		$("#password").keyup(checkPasswordsMatch);
		$("#confirmpass").keyup(checkPasswordsMatch);
		$("#details").submit(canSubmit);
	}

	function canSubmit() {
		var password = $("#password").val();
		var confirmpass = $("#confirmpass").val();
		if (password != confirmpass) {
			alert("password not matched");
			return false;
		} else {
			return true;
		}
	}

	function checkPasswordsMatch() {
		var password = $("#password").val();
		var confirmpass = $("#confirmpass").val();

		if (password.length > 3 || confirmpass.length > 3) {

			if (password == confirmpass) {
				$("#matchpass").text("password matched");
				$("#matchpass").addClass("valid");
				$("#matchpass").removeClass("error");
			} else {
				$("#matchpass").text("password not matched");
				$("#matchpass").addClass("error");
				$("#matchpass").removeClass("valid");
			}
		}
	}

	$(document).ready(onLoad);
</script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" />
<link href="${pageContext.request.contextPath}/static/css/main.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/static/css/login_popup.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/static/css/jssor.css"
	rel="stylesheet" type="text/css">
<title>Borrower -  ease borrowing and lending</title>
</head>
<body>

	<div id="container">

		<div id="fixedHeader">
			<div id="logo">
				<a href="<c:url value="/mypage"/>">Borrower</a>
			</div>
			<div id="login">
				<a class="login" id="modal_trigger" href="#modal">Sign in</a>
			</div>
		</div>

				<!-- Jssor Slider Begin -->
		<!-- You can move inline styles to css file or css block. -->
		<div id="slider1_container"
			style="position: relative; margin: 0 auto; top: 73px; left: 0px; width: 1300px; height: 500px; overflow: hidden;">
			<!-- Loading Screen -->
			<div u="loading" style="position: absolute; top: 0px; left: 0px;">
				<div
					style="filter: alpha(opacity = 70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;">
				</div>
				<div
					style="position: absolute; display: block; background: url(${pageContext.request.contextPath}/static/images/img/loading.gif) no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
				</div>
			</div>
			<!-- Slides Container -->
			<div u="slides"
				style="cursor: move; position: absolute; left: 0px; top: 0px; width: 1300px; height: 500px; overflow: hidden;">
				<div>
					<img u="image"
						src="${pageContext.request.contextPath}/static/images/img/1920/blue.jpg" />
					<div u="caption" t="RTT|2" r="-75%" du="1000" d="1000"
						style="position: absolute; width: 470px; height: 220px; top: 120px; left: 650px;">
						<img
							src="${pageContext.request.contextPath}/static/images/lend_borrow.png"
							style="position: absolute; width: 470px; height: 220px; top: 0px; left: 0px;" />
					</div>
					<div
						style="position: absolute; width: 500px; height: 120px; top: 30px; left: 30px; padding: 5px; text-align: left; line-height: 60px; text-transform: uppercase; font-size: 50px; color: #FFFFFF;">ease both borrowing and lending</div>
					<div
						style="position: absolute; width: 500px; height: 120px; top: 300px; left: 30px; padding: 5px; text-align: left; line-height: 36px; font-size: 30px; color: #FFFFFF;">
						helps borrowers keep their credits.<br>
						gives lenders more protection.
					</div>
				</div>
				<div>
					<img u="image"
						src="${pageContext.request.contextPath}/static/images/img/1920/purple.jpg" />
					<div
						style="position: absolute; width: 500px; height: 120px; top: 30px; left: 30px; padding: 5px; text-align: left; line-height: 60px; text-transform: uppercase; font-size: 50px; color: #FFFFFF;">managing IOU + alarm</div>
					<div
						style="position: absolute; width: 500px; height: 120px; top: 300px; left: 30px; padding: 5px; text-align: left; line-height: 36px; font-size: 30px; color: #FFFFFF;">
						transaction management - never lose an IOU. <br>
						overdue alarm - can never say "I forgot".</div>
				</div>
				<div>
					<img u="image"
						src="${pageContext.request.contextPath}/static/images/img/1920/red.jpg" />
					<div
						style="position: absolute; width: 500px; height: 120px; top: 30px; left: 30px; padding: 5px; text-align: left; line-height: 60px; text-transform: uppercase; font-size: 50px; color: #FFFFFF;">return power back to lender</div>
					<div
						style="position: absolute; width: 500px; height: 120px; top: 300px; left: 30px; padding: 5px; text-align: left; line-height: 36px; font-size: 30px; color: #FFFFFF;">
						lender says whether an item is lent out or not.<br>
						lender says whether an item is returned or not.
						</div>
				</div>
			</div>
			<!-- Bullet Navigator Skin Begin -->
			
			<!-- bullet navigator container -->
			<div u="navigator" class="jssorb21"
				style="position: absolute; bottom: 26px; left: 6px;">
				<!-- bullet navigator item prototype -->
				<div u="prototype"
					style="POSITION: absolute; WIDTH: 19px; HEIGHT: 19px; text-align: center; line-height: 19px; color: White; font-size: 12px;"></div>
			</div>
			<!-- Bullet Navigator Skin End -->

			<!-- Arrow Navigator Skin Begin -->
			
			<!-- Arrow Left -->
			<span u="arrowleft" class="jssora21l"
				style="width: 55px; height: 55px; top: 123px; left: 8px;"> </span>
			<!-- Arrow Right -->
			<span u="arrowright" class="jssora21r"
				style="width: 55px; height: 55px; top: 123px; right: 8px"> </span>
			<!-- Arrow Navigator Skin End -->
		</div>


		<div id="modal" class="popupContainer" style="display: none;">
			<header class="popupHeader"> <span class="header_title">Login</span>
			<span class="modal_close"><i class="fa fa-times"></i></span> </header>

			<section class="popupBody"> <!-- Social Login -->
			<div class="social_login">
				<div class="">
					<a href="<c:url value="/auth/facebook"/>" class="social_box fb">
						<span class="icon"><i class="fa fa-facebook"></i></span> <span
						class="icon_title">Connect with Facebook</span>

					</a> <a href="<c:url value="/auth/linkedin"/>"
						class="social_box google"> <span class="icon"><i
							class="fa fa-linkedin-square"></i></span> <span class="icon_title">Connect
							with Linkedin</span>
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
							checked="checked" /> <label for="remember">Remember me
							on this computer</label>
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
					<div class="error">
						<sf:errors path="username"></sf:errors>
					</div>
					<label>Name</label>
					<sf:input path="name" name="name" type="text" />
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

		<div id="contentPage">
		
			<div id="content">
				<div class="feature">
					<div class="featurec">
					 sign up with your social network account
					</div>
					<div class="featuret">
					 it actually also creates a borrower account
					 with the user name of your social account and links them.
					</div>
				</div>
				<div class="feature">
					<div class="featurec">
					 links with multiple social network accounts
					</div>
					<div class="featuret">
					 after login, user can add more social network accounts with the borrower account.
					</div>
				</div>
				<div class="feature">
					<div class="featurec">
					 log in with any of them
					</div>
					<div class="featuret">
					 user can log in with the borrower account or any of its linked social network accounts.
					</div>
				</div>
				<div class="feature">
					<div class="featurec">
					 Instruction for borrower
					</div>
					<div class="featuret">
						<ol>
						<li>get the user name of lender</li>
						<li>create a request to the lender, speicify lending and returning dates</li>
						<li>wait until lender accepts the request(lender can decline)</li>
						<li>lender will be notificed to lend out the item before the lending day</li>
						<li>lender should mark the request status as lent</li> 
						<li>borrower will be notificed to return the item before the returning day</li>
						<li>lender should mark the request status as returned</li>
						</ol>
					</div>
				</div>
				
				<div class="feature">
					<div class="featurec">
					 Instruction for lender
					</div>
					<div class="featuret">
						<ol>
						<li>give your user name to borrower and let borrower create a request</li>
						<li>you can decline a request if item is not availabe or other consideration</li>
						<li>if you accept a request, you will be notified to lend the item by the lending date</li>
						<li>you should mark the request status as lent only after you really lend it out to the borrower</li>
						<li>don't mark the request status as returned until borrower returns the item</li> 
						<li>if item is not returned in time, borrower will get notifications via emial and social network account once a day</li>
						<li>do mark request to returned status when item is returned</li>
						</ol>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="loadingDialog">
		<p>loading...</p>
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
			top : 50,
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

			$(".social_box").click(function() {
				$(".modal_close").trigger('click');
				$("#loadingDialog").show();
				return true;
			});

		});
	</script>

	<c:if test="${param.loginerror != null}">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#modal_trigger').trigger('click');
				$('#login_form').trigger('click');
			});
		</script>
	</c:if>

	<c:if test="${signuperror == true}">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#modal_trigger').trigger('click');
				$('#register_form').trigger('click');
			});
		</script>
	</c:if>

	<c:if test="${user.username != null}">
		<script type="text/javascript">
			$(document).ready(function() {
				$('#modal_trigger').trigger('click');
				$('#register_form').trigger('click');
			});
		</script>
	</c:if>
</body>
</html>