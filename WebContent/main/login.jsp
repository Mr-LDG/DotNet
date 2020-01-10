<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" href="/DotNet/css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Caveat|Concert+One|Dancing+Script|Fredoka+One|Kalam|Kaushan+Script|Lobster|Luckiest+Guy|Merienda|Neucha|Sniglet|ZCOOL+QingKe+HuangYou&display=swap" rel="stylesheet">
<!-- style_dotnet.csa -->
<link rel="stylesheet" type="text/css" href="/DotNet/css/style_dotnet.css" />


<style>
input.form-control {
	font-size: 30px;
	height: 40px;
	width: 300px;
	/* 	border-radius: 30px; */
	margin-left: 100px;
}

p {
	width: 400px;
	height: 20px;
	text-align: left;
	padding-left: 40px;
}

.btn {
	margin-top: 50px;
	width: 100px;
}

label {
	padding-top: 40px;
}

input.btn-info {
	margin-top: 0px;
}
</style>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-default">
	<jsp:include page="../mainNav.do" flush="false"></jsp:include>
</nav>


	<!--Modal: Login / Register Form-->
	<!-- aria-hidden="true" -->
	<!-- <div class="modal " id="modalLRForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" > -->
	<div class="container">
		<div class="modal-dialog cascading-modal" role="document">
			<div class="shadow bg-white">
				<!--Content-->
				<div class="modal-content">

					<!--Modal cascading tabs-->
					<div class="modal-c-tabs">
						<div class="text-center mt-2">
							<h2>로그인</h2>
						</div>
						<!-- Tab panels -->
						<form action="loginPro.do" method="post">
							<div class="tab-content">
								<!--Panel 7-->
								<div class="tab-pane fade in show active" id="panel7"
									role="tabpanel">
									<!--Body-->
									<div class="modal-body mb-1">
										<div class="container" >
											<label for="id" ><b>아이디</b></label>
	     									 <input class="form-control form-control-sm validate" style="margin:0" type="text" placeholder="id" name="id" required>
										</div>
										<div class="container">
										      <label for="passwd"><b>비밀번호</b></label>
										      <input class="form-control form-control-sm validate" style="margin:0" type="password" placeholder="password" name="passwd" required>
										</div>
<!-- 										<div class="container"> -->
											<div class="text-center mt">
												<input type="submit" class="btn " value="로그인" onclick=""><i class="fas fa-sign-in ml-1"></i>
											</div>
<!-- 										</div> -->
									</div>

									<!--Footer-->
									<div class="modal-footer">
										<div class="options text-center text-md-right mt-1">
											<p>
												아직 회원이 아니신가요? <a href="signup.do" class="blue-text">
													&nbsp;&nbsp;회원가입</a>
											</p>
											<!-- <p>
												비밀번호를 잊어버렸나요?<a href="#" class="blue-text">&nbsp;&nbsp;Password
													찾기 </a>
											</p> -->
										</div>
										<div>
											<button type="button"
												class="btn btn-outline-info waves-effect ml-auto"
												data-dismiss="modal" onclick="location.href='main.do'">Close</button>
										</div>
									</div>

								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!--/.Content-->
		</div>
	</div>
	<!--   </div> -->
	<script type="text/javascript" src="/DotNet/js/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/DotNet/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/DotNet/js/script_main.js"></script>
</body>
</html>