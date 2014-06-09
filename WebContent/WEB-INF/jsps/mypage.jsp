<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/static/css/main.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
	$(function() {
		$(".datepicker").datepicker();
	});

	function tabSwitch(active, number, tab_prefix, content_prefix) {

		for (var i = 1; i < number + 1; i++) {
			document.getElementById(content_prefix + i).style.display = 'none';
			document.getElementById(tab_prefix + i).className = '';
		}
		document.getElementById(content_prefix + active).style.display = 'block';
		document.getElementById(tab_prefix + active).className = 'active';

	}

	$(document).ready(function() {
		connectStatusAjax();
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<div id="container">
		<div id="fixedHeader">
			<div id="logo">
				<a href="<c:url value="/mypage"/>">Borrower</a>
			</div>
			<div id="logout">
				<a class="login" href="<c:url value='/j_spring_security_logout'/>">Log
					out</a>
			</div>
		</div>
		<div id="contentPage">
			<div id="content">
				<h2>Welcome ${user}</h2>

				<div class="tabbed_area">
					<ul class="tabs">
						<li><a href="javascript:tabSwitch(1, 3, 'tab_', 'content_');"
							id="tab_1" class="active">Requests</a></li>
						<li><a href="javascript:tabSwitch(2, 3, 'tab_', 'content_');"
							id="tab_2">History</a></li>
						<li><a href="javascript:tabSwitch(3, 3, 'tab_', 'content_');"
							id="tab_3">Accounts</a></li>
					</ul>

					<div id="content_1" class="content">
						<div class="sub_tab_content center">
							<h3>created requests</h3>
							<div class="CSSTableGenerator">
								<table class="deals">
									<tr>
										<td>borrow from</td>
										<td>item</td>
										<td>description</td>
										<td>borrow date</td>
										<td>return date</td>
										<td>is accepted</td>
										<td>is borrowed</td>
										<td>is returned</td>
									</tr>

									<c:forEach var="deal" items="${borrowdealsvalid}">
										<tr>

											<td><p style="width:100%;"><c:out value="${deal.lender.username}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.item.item}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.item.description}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.borrow_time}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.return_time}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.accept}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.borrowed}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.returned}"></c:out></p></td>



										</tr>
									</c:forEach>


								</table>
							</div>
						</div>
						<div class="sub_tab_content center">
							<h3>received requests</h3>
							<sf:form id="received_req" method="post"
								action="${pageContext.request.contextPath}/updatedeals"
								commandName="lenddealsvalid">
								<div class="CSSTableGenerator">
									<table class="deals">
										<tr>
											<td>lend to</td>
											<td>item</td>
											<td>description</td>
											<td>borrow date</td>
											<td>return date</td>
											<td>is accepted</td>
											<td>is lent</td>
											<td>is returned</td>

										</tr>

										<c:forEach var="deal" items="${lenddealsvalid.deals}"
											varStatus="loop">
											<tr>

												<td><p style="width:100%;"><c:out value="${deal.borrower.username}"></c:out></p></td>

												<td><p style="width:100%;"><c:out value="${deal.item.item}"></c:out></p></td>

												<td><p style="width:100%;"><c:out value="${deal.item.description}"></c:out></p></td>

												<td><p style="width:100%;"><c:out value="${deal.borrow_time}"></c:out></p></td>

												<td><p style="width:100%;"><c:out value="${deal.return_time}"></c:out></p></td>

												<sf:hidden path="deals[${loop.index}].id" />

												<td><sf:checkbox class="control"
														path="deals[${loop.index}].accept" /></td>

												<td><sf:checkbox class="control"
														path="deals[${loop.index}].borrowed" /></td>

												<td><sf:checkbox class="control"
														path="deals[${loop.index}].returned" /></td>

											</tr>
										</c:forEach>
									</table>
								</div>
								<br />
								<input value="save changes" type="submit" />
							</sf:form>
						</div>
						<div class="sub_tab_content center">
							<h3>Create request</h3>

							<sf:form id="borrowItem" method="post" class="center"
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
										<td><sf:input class="control datepicker"
												path="borrow_time" type="text" /></td>
									</tr>
									<tr>
										<td class="label">return time:</td>
										<td><sf:input class="control datepicker"
												path="return_time" type="text" /></td>
									</tr>
									<tr>
										<td class="label"></td>
										<td><input class="control" value="Send request"
											type="submit" /></td>
									</tr>
								</table>

							</sf:form>
						</div>
					</div>
					<div id="content_2" class="content">
						<div id="borrowedRequests" class="sub_tab_content center">
							<h3>As borrower</h3>
							<div class="CSSTableGenerator">
								<table width="100%" class="deals">
									<tr>
										<td>borrow from</td>
										<td>item</td>
										<td>description</td>
										<td>borrow date</td>
										<td>return date</td>
										<td>is accepted</td>
										<td>is borrowed</td>
										<td>is returned</td>
									</tr>

									<c:forEach var="deal" items="${borrowdealshistory}">
										<tr>

											<td><p style="width:100%;"><c:out value="${deal.lender.username}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.item.item}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.item.description}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.borrow_time}"></c:out>/</td>

											<td><p style="width:100%;"><c:out value="${deal.return_time}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.accept}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.borrowed}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.returned}"></c:out></p></td>



										</tr>
									</c:forEach>


								</table>

							</div>
						</div>
						<div id="lentRequests" class="sub_tab_content center">
							<h3>As lender</h3>
							<div class="CSSTableGenerator">
								<table class="deals">
									<tr>
										<td>lend to</td>
										<td>item</td>
										<td>description</td>
										<td>borrow date</td>
										<td>return date</td>
										<td>is accepted</td>
										<td>is borrowed</td>
										<td>is returned</td>
									</tr>

									<c:forEach var="deal" items="${lenddealshistory}">
										<tr>

											<td><p style="width:100%;"><c:out value="${deal.borrower.username}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.item.item}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.item.description}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.borrow_time}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.return_time}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.accept}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.borrowed}"></c:out></p></td>

											<td><p style="width:100%;"><c:out value="${deal.returned}"></c:out></p></td>

										</tr>
									</c:forEach>


								</table>
							</div>
						</div>
					</div>

					<div id="content_3" class="content">
						<div id="social_status_div">
							<a id="social_status" href="#">refresh</a>
						</div>

						<div id="result" class="center"></div>
						<script type="text/javascript">
							function connectStatusAjax() {
								$.ajax({
									url : "<c:url value='/connect'/>",
									success : function(data) {
										$('#result').html(data);
									}
								});
							};

							$(function() {
								$("#social_status").click(function() {
									connectStatusAjax();
									return false;
								});
							});

							function disconnectAjax(url, thisId) {
								$.ajax({
									url : url,
									type : 'POST',
									data : {
										'_method' : 'delete'
									},
									success : function(data) {
										$(thisId).parent().parent().html(data);
										$(thisId).parent().remove();
									}
								});
							}
						</script>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
</html>