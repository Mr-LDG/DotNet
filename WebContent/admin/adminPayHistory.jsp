<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 사이드바  1-1 start-->
<jsp:include page="../mypage.do"/>
<main class="page-content">
<div class="container-fluid">
	<div class="card col-md-12">
		<h2 class="mt-3">회원 결제 내역</h2>
		<hr>
		<h5>회원 결제 관련 > 회원 결제 내역</h5>
		<hr>
		<!-- 사이드바  1-1 end -->
	
		<!-- 		<div class="table"> -->
		<table class="table ">
			<thead>
				<tr>
					<th style="width: 10%">상품이름</th>
					<th style="width: 10%">포인트</th>
					<th style="width: 10%">개수</th>
					<th style="width: 20%">사용자 아이디</th>
					<th style="width: 20%">날짜</th>
					<th style="width: 20%">상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="st" items="${his }">
					<tr id="${st.t_num}">
						<td>${st.g_name }</td>
						<td>${st.g_point }</td>
						<td>${st.g_cnt}</td>
						<td>${st.mem_id}</td>
						<td>${st.t_date}</td>
						<c:if test="${st.tst_num ==0}">
							<td><button class="btn req" id="${st.t_num }">요청 수락</button></td>
						</c:if>
						<c:if test="${st.tst_num == 1 }">
							<td>처리 완료됨</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
			<!-- 사이드바 2-2 start --> 
	</div>
</div>
</main>
<!-- 사이드바 2-2 end --> 