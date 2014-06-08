<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ page session="false" %>

<div>

<h4>
		<img src="<c:url value="/static/images/linkedin-logo.jpg" />"
			width="36" height="36" />linkedin
	</h4>

<form action="<c:url value="/connect/linkedin" />" method="POST">
	<div class="formInfo">
		<p>
			<p>You aren't connected to linkedin yet. <br/>
			Click the button to	connect borrower account with your linkedin account.</p>
		</p>
	</div>
	<p><button type="submit">connect</button></p>
</form>

</div>