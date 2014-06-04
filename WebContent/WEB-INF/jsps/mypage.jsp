<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/static/css/main.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
	$(function() {
		$(".datepicker").datepicker();
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<h2>Welcome ${user}</h2>
	<a class="login" href="<c:url value='/j_spring_security_logout'/>">Log out</a>
	<h3>all users</h3>
	<table class="users">
		<tr>
			<td>username</td>
			<td>name</td>
			<td>password</td>
			<td>email</td>
			<td>enabled</td>
		</tr>

		<c:forEach var="user" items="${users}">
			<tr>

				<td><c:out value="${user.username}"></c:out></td>

				<td><c:out value="${user.name}"></c:out></td>

				<td><c:out value="${user.password}"></c:out></td>

				<td><c:out value="${user.email}"></c:out></td>

				<td><c:out value="${user.enabled}"></c:out></td>

			</tr>
		</c:forEach>
	</table>

	<h3>created requests</h3>
	<table class="deals">
		<tr>
			<td>borrow from</td>
			<td>item</td>
			<td>description</td>
			<td>borrow date</td>
			<td>return date</td>
			<td>is borrowed</td>
			<td>is returned</td>
		</tr>

		<c:forEach var="deal" items="${borrowdeals}">
			<tr>

				<td><c:out value="${deal.lender.name}"></c:out></td>

				<td><c:out value="${deal.item.item}"></c:out></td>

				<td><c:out value="${deal.item.description}"></c:out></td>

				<td><c:out value="${deal.borrow_time}"></c:out></td>

				<td><c:out value="${deal.return_time}"></c:out></td>

				<td><c:out value="${deal.return_time}"></c:out></td>

				<td><c:out value="${deal.borrowed}"></c:out></td>

				<td><c:out value="${deal.returned}"></c:out></td>

			</tr>
		</c:forEach>


	</table>

	<h3>received requests</h3>
	<sf:form id="received_req" method="post"
		action="${pageContext.request.contextPath}/updatedeals"
		commandName="lenddeals">
		<table class="deals">
			<tr>
				<td>lend to</td>
				<td>item</td>
				<td>description</td>
				<td>borrow date</td>
				<td>return date</td>
				<td>is lent</td>
				<td>is returned</td>
			</tr>

			<c:forEach var="deal" items="${lenddeals.deals}" varStatus="loop">
				<tr>

					<td><c:out value="${deal.borrower.name}"></c:out></td>

					<td><c:out value="${deal.item.item}"></c:out></td>

					<td><c:out value="${deal.item.description}"></c:out></td>

					<td><c:out value="${deal.borrow_time}"></c:out></td>

					<td><c:out value="${deal.return_time}"></c:out></td>

					<sf:hidden path="deals[${loop.index}].id" />

					<td><sf:checkbox class="control"
							path="deals[${loop.index}].borrowed" /></td>

					<td><sf:checkbox class="control"
							path="deals[${loop.index}].returned" /></td>

				</tr>
			</c:forEach>
			<tr>
				<td class="label"></td>
				<td><input class="control" value="save" type="submit" /></td>
			</tr>
		</table>

	</sf:form>

	<h3>
		Create request
		</h2>

		<sf:form id="borrowItem" method="post"
			action="${pageContext.request.contextPath}/createdeal"
			commandName="deal">

			<table class="formtable">
				<tr>
					<td class="label">borrow from:</td>
					<td><sf:input class="control" path="lender.username"
							name="username" type="text" /></td>
				</tr>
				<tr>
					<td class="label">item:</td>
					<td><sf:input class="control" path="item.item"
							name="item.item" type="text" /></td>
				</tr>
				<tr>
					<td class="label">Description:</td>
					<td><sf:input class="control" path="item.description"
							name="description" type="text" /></td>
				</tr>
				<tr>
					<td class="label">borrow time:</td>
					<td><sf:input class="control datepicker" path="borrow_time"
							type="text" /></td>
				</tr>
				<tr>
					<td class="label">return time:</td>
					<td><sf:input class="control datepicker" path="return_time"
							type="text" /></td>
				</tr>
				<tr>
					<td class="label"></td>
					<td><input class="control" value="Send deal" type="submit" /></td>
				</tr>
			</table>

		</sf:form>
</body>
</html>