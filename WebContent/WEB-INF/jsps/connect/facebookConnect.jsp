<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib
	uri="http://www.springframework.org/spring-social/facebook/tags"
	prefix="facebook"%>
<%@ page session="false"%>

<div>
	<h4>
		<img src="<c:url value="/static/images/facebook-logo.jpg" />"
			width="36" height="36" />facebook
	</h4>

	<p>
	<form action="<c:url value="/connect/facebook" />" method="POST">
		<input type="hidden" name="scope"
			value="publish_stream,user_photos,offline_access" />
		<div class="formInfo">
			<p>You aren't connected to facebook yet. <br/>
			Click the button to	connect borrower account with your facebook account.</p>
		</div>
		<p>
			<button type="submit">connect</button>
		</p>
	</form>
	</p>


</div>
