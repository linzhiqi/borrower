<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ page session="false"%>

<h3>Your Connections</h3>

<c:forEach var="providerId" items="${providerIds}">
	<c:set var="connections" value="${connectionMap[providerId]}" />
	<%-- <s:message code="${providerId}.displayName" var="providerDisplayName" /> --%>
	<div class="accountConnection">
		<div>
			<%-- <s:message code="${providerId}.icon" var="iconUrl"/> --%>
			<h4>
				<img src="<c:url value="static/images/${providerId}-logo.jpg" />"
					width="36" height="36" />${providerId}</h4>

			
				<c:if test="${not empty connections}">
					
					<div >
						You are connected to ${providerId} as
						${connections[0].displayName}.
						<a id="toDisconnect-${providerId}" style="position:absolute; right:50px; display:inline; "
							href="javascript:disconnectAjax('<c:url value="/connect/${providerId}"/>', '#toDisconnect-${providerId}')">
							<button>disconnect</button></a>
					</div>

					<hr>
					<a id="checkProfile-${providerId}"
						href="javascript:getProfileAjax('<c:url value='/${providerId}'/>', '#socialProfile-${providerId}', '#checkProfile-${providerId}', '#checkProfile-fold-${providerId}')">show
						profile</a>
					<a id="checkProfile-fold-${providerId}"
						href="javascript:foldProfile('#socialProfile-${providerId}', '#checkProfile-${providerId}', '#checkProfile-fold-${providerId}')"
						style="display: none">collapse</a>
					<div id="socialProfile-${providerId}"></div>

				</c:if>
				<c:if test="${empty connections}">
					<%-- You are not yet connected to ${providerId}.
			Click <a class="connectToProvider"
						href="javascript:connectToProvider('<c:url value="/connect/${providerId}" />', '#goingToConnect-${providerId}')">here</a> to connect.
					<div id="goingToConnect-${providerId}"></div> --%>
					<form action="<c:url value="/connect/${providerId}" />"
						method="POST">

						<c:if test="${providerId}==facebook">
							<input type="hidden" name="scope"
								value="publish_stream,user_photos,offline_access" />
						</c:if>
						<div class="formInfo">
							<p>
								You aren't connected to ${providerId} yet. <br /> Click the
								button to connect borrower account with your ${providerId} account.
							</p>
						</div>
						<p>
							<button type="submit">connect</button>
						</p>
					</form>
				</c:if>

			
		</div>
	</div>
</c:forEach>

<script>
	function getProfileAjax(url, contentId, unfoldId, foldId) {

		$.ajax({
			url : url,
			success : function(data) {
				$(contentId).html(data);
				$(contentId).show();
				$(unfoldId).hide();
				$(foldId).show();
			}
		});

	};
	function foldProfile(contentId, unfoldId, foldId) {
		$(foldId).hide();
		$(unfoldId).show();
		$(contentId).hide();
	};

	
</script>