<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<link rel="stylesheet" href="/DotNet/css/bootstrap.css">
	
	<!-- bootstrap css -->
	<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> -->
	 
	<!-- 네비게이션 바 아이콘용 CDN -->	
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
        integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
        		
	<link
		href="https://fonts.googleapis.com/css?family=Caveat|Concert+One|Dancing+Script|Fredoka+One|Kalam|Kaushan+Script|Lobster|Luckiest+Guy|Merienda|Neucha|Sniglet|ZCOOL+QingKe+HuangYou&display=swap"
		rel="stylesheet">
		
	<!-- style_dotnet.css -->
	<link rel="stylesheet" type="text/css" href="/DotNet/css/style_dotnet.css" />
	
	<!-- css for this page -->
	<style type="text/css">
		/* 상단바 전용 css */
		a {
			color : black;
		}
		.btn{
		color : white;
		background-color: rgba(227, 179, 255, 0.938);
	}
	</style>
	
<!-- <nav class="navbar navbar-expand-lg"> -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#myNavbar"
            aria-controls="myNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="" id="myNavbar">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item"><a class="nav-link mainboard" href="main.do?b_tp=1">메인&nbsp;&nbsp;&nbsp;</a></li>
                <li class="nav-item"><a class="nav-link subboard" href="main.do?b_tp=2">보조</a></li>
                <li class="nav-item"><a class="nav-link askboard" href="main.do?b_tp=3">.Net 질문</a></li>
            </ul>
        </div>

       	<div class="mx-auto">
	        <a class="navbar-brand" href="main.do">
	            <h1 id="logo" class="tomain">.Net</h1>
	        </a>
       	</div>
        <div class="" id="myNavbar">

            <ul class="navbar-nav ml-auto navbar-right">

                <c:choose>
                    <c:when test="${not empty sessionScope.memId }">
                        <li style="padding-top: 15px; padding-right: 10px;">
                            ${sessionScope.memId} 님
                        </li>
                        <c:if test="${sessionScope.isAdmin eq 2}">
                            <li><a class="nav-link" href="myFrSur.do"><i class="fas fa-portrait"></i>
                                    My Page&nbsp;&nbsp;&nbsp;
                                </a></li>
                        </c:if>
                        <c:if test="${sessionScope.isAdmin eq 1}">
                            <li><a class="nav-link" href="memberMng.do"><i class="fas fa-portrait"></i>
                                    My Page&nbsp;&nbsp;&nbsp;
                                </a></li>
                        </c:if>
                        <li><a class="nav-link" href="main.do" id="logoutNav"><i class="fas fa-user-circle"></i>
                                Logout&nbsp;&nbsp;&nbsp;
                            </a></li>
                    </c:when>
                    <c:otherwise>
                        <!-- change login form to modal -->
                        <li><a class="nav-link" href="" id="loginModal" data-toggle="modal" data-target="#navLogin"><i
                                    class="far fa-user-circle"></i>
                                Login&nbsp;&nbsp;&nbsp;
                            </a></li>

                        <li><a class="nav-link" href="signup.do"><i class="fas fa-user-plus"></i>
                                Sign Up&nbsp;&nbsp;&nbsp;
                            </a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
<!--     </nav> -->
    <div class="modal fade" id="navLogin" tabindex="-1" role="dialog" aria-labelledby="navLoginTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="navLoginTitle" align="center">로그인</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="loginForm">
                        <div class="form-group">
                            <label for="navId" class="col-form-label">아이디</label>
                            <input type="text" class="form-control" id="navId">
                        </div>
                        <label for="navPasswd" class="col-form-label">비밀번호</label>
                        <input type="password" class="form-control" id="navPasswd" placeholder="">
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="loginBtn" type="button" class="btn btn-primary" data-dismiss="">로그인</button>
                    <input type="reset" class="btn btn-secondary" form="loginForm">

                </div>
            </div>
        </div>
    </div>


	
<script type="text/javascript" src="/DotNet/js/jquery-3.4.1.js"></script>
<!-- <script type="text/javascript" src="/DotNet/js/bootstrap.bundle.js"></script> -->
	<script>
	$(document).ready(function(){
		jQuery('#loginBtn').on('click',function(){
			if(!$('#navId').val()){
				alert("아이디를 입력해 주세용 ~~");
				return false;
			}else if(! $('#navPasswd').val()){
				alert("비밀번호를 입력해 주세요~~");
				return false;
			}else{
				var navData = {id : $('#navId').val(), passwd : $('#navPasswd').val()};
			
				$.ajax({
					data:navData,
					dataType:"text",
					type:"post",
					url:"login.do",
					success:function(data){
						if(data == "1"){
							$("#askSubmit").attr("data-dismiss","modal");
							location.reload();
						}else if(data == "0"){
							alert('아이디 존재하지 않아요 ㅠㅠ\n다시한번 확인해 주세요')
						}else if(data == "-1"){
							alert('비밀번호가 달라요ㅠㅠ');
						}else if(data == "block"){
							alert("해당 아이디는 정지 먹었습니다.ㅠㅠ \n 필요하시다면 문의주시길 바랍니다.");
						}
						
					}
					
				});
			}
		});
		
		
	});
	</script>
	<script>
		$(document).ready(function(){
			jQuery("#logoutNav").on('click',function(){
				
				var dd = {1:"1"};
				$.ajax({
					data:dd,
					dataType:"text",
					type:"post",
					url:"logout.do",
					success:function(){
						alert("로그아웃");
						location.reload = "main.do"
					}
				
				})
			});
		});
	</script>