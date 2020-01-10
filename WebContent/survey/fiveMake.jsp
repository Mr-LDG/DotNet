<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>오지선다형 만들기</title>
		
		<!-- bootstrap css -->
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
		
		<!-- responsive(반응형)을 위한 meta -->
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- css for this page -->
		<style type="text/css">
			.dad {
			  padding-top: 5px;
			  padding-bottom: 5px;
			  display: table-cell;
			  /* float: left;
				position: relative; */
			  height: 237px;
			  width: 200px;
			  vertical-align: middle;
			  text-align: center;
			  color: #37474F;
			  background-color: #FFFFFF;
			  border: solid 2px #333333;
			  border-radius: 10px;
			}
			img {
			  display: none;
			  height: 203px;
			  width: 192px;
			}
		</style>
	</head>
	<body>
	
		<!-- 상단 바 -->
	
		<nav class="navbar navbar-expand-md navbar-default">
			<jsp:include page="../mainNav.do" flush="false"></jsp:include>
		</nav>
		<!-- 상단 바  끝-->
		
		<form action="fivePro.do" method="post" enctype="multipart/form-data">
			<!-- 글제목, 포인트 작성 -->
			<div class="row justify-content-center mt-5 ml-5 pl-5">
				<div class="form row w-75" id="topDiv">
					<div class="form-group col-md-8">
						<label> 제목 </label>
						<input type="text" class="form-control" name="subject" placeholder="글 제목을 적어주세요">
						<br>
						
						
						<input type="hidden" class="form-control" name="point" placeholder="포인트">
						<input id="category" type="hidden" name="cate_num">
						<div class="dropdown row justify-content-end pr-3">
							<button class="btn btn-outline-success btn-lg dropdown-toggle" type="button"
								id="dropdownMenuButton" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false" style="width:40%">
								카테고리 선택
							</button>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
								<c:forEach items="${categorys}" var="cate">
									<a class="dropdown-item" href="#" title="${cate.ct_num}">${cate.ct_name}</a> 
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="dad" id="userActions1" ondragover="dragOver()" >
			            <img id="img1" alt="uploaded image placeholder">
			            <p>Drag &amp; Drop Image</p> <input type="file" id="fileUpload1" name="upload1" multiple accept="image/*">
		          	</div>
				</div>
			</div>
			
			<!-- 캐로슬(슬라이딩) - 질문 및 보기 작성 -->
			<div id="fiveCarousel" class="carousel slide">
				<div class="carousel-inner">
					<div class="carousel-item active">
					    <!-- 첫번째 질문(기본화면) -->
					    <div class="container-fluid mt-5" id="QBox1">
				  			<div class="row justify-content-center">
								<div class="form-group row w-75">
									<label class="col-sm-1 col-form-label text-right">Q1</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="Q1" placeholder="질문을 작성해주세요">
									</div>
								</div>
							</div>
				  			<div class="row justify-content-center">
							    <c:set var="num" value="${1}"/>
							    <c:forEach begin="1" end="5">
								    <div class="form-group row w-75">
									    <label class="col-sm-1 col-form-label text-right">${num}</label>
									    <div class="col-sm-10">
									      <input type="text" class="form-control" name="Q1Sel${num}" placeholder="보기${num}">
									    </div>
									</div>
								<c:set var="num" value="${num+1}"/>
								</c:forEach>
				  			</div>
				  		</div>
					</div>
					<!-- 2~8번 질문 슬라이드는 jQuery로 처리-->
					
				</div>
			</div>
		
			<!-- 버튼 모음 -->
			<div class="row justify-content-center">
				<button type="button" class="btn btn-outline-primary m-3" name="delButton" id="delBtn">-</button>
				<button type="button" class="btn btn-outline-primary m-3" name="prevButton">이전</button>
				<input type="submit" class="btn btn-outline-primary m-3" value="작성완료">
				<input type="reset" class="btn btn-outline-primary m-3" value="작성취소">
				<button type="button" class="btn btn-outline-primary m-3" name="nextButton">다음</button>
				<button type="button" class="btn btn-outline-primary m-3" name="addButton" id="addBtn">+</button>
			</div>
			<input type="hidden" name="s_tp_num" value="5">
		</form>
		
		
		<!-- bootstrap js -->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
		<!-- event for this page -->
		<script type="text/javascript" src="/DotNet/survey/DAD1.js"></script>
		<script>
		jQuery(document).ready(
			function(){
				var cntq = 1;
				jQuery("#delBtn").on('click',function(){
					if(cntq > 1){
						cntq--;
						//alert("cntq : " + cntq);
					}
					if(cntq == 1)
						return false;
					
				});
				jQuery("#addBtn").on('click',function(){
					if(cntq < 5) {
						cntq++;
						//alert("cntq : " + cntq);
					}
					if(cntq == 5)
						return false;
				});
				
				jQuery("input[type=submit]").on('click',function(){
					if(jQuery('input[placeholder="글 제목을 적어주세요"]').val()=="" ){
						alert("제목을 넣어 주세용!!")
						return false;
					}else if(jQuery('input[name=Q1]').val()==""	){
						alert("질문을 입력해 주세요!!");
						return false;
					}else if(cntq == 1  ){
						if(	jQuery('#QBox1 > div:nth-child(1) > div > div > input').val() == "" ||
								jQuery('#QBox1 > div:nth-child(2) > div:nth-child(1) > div > input').val() == "" ||
								jQuery('#QBox1 > div:nth-child(2) > div:nth-child(2) > div > input').val() == "" ||
								jQuery('#QBox1 > div:nth-child(2) > div:nth-child(3) > div > input').val() == "" ||
								jQuery('#QBox1 > div:nth-child(2) > div:nth-child(4) > div > input').val() == "" ||
								jQuery('#QBox1 > div:nth-child(2) > div:nth-child(5) > div > input').val() == ""){		
							
						alert('보기를 마저 입력해 주세요');
						return false;
						}
					}else if(cntq == 2){
						if(	jQuery('#QBox2 > div:nth-child(1) > div > div > input').val() == "" ||
								jQuery('#QBox2 > div:nth-child(2) > div:nth-child(1) > div > input').val() == "" ||
								jQuery('#QBox2 > div:nth-child(2) > div:nth-child(2) > div > input').val() == "" ||
								jQuery('#QBox2 > div:nth-child(2) > div:nth-child(3) > div > input').val() == "" ||
								jQuery('#QBox2 > div:nth-child(2) > div:nth-child(4) > div > input').val() == "" ||
								jQuery('#QBox2 > div:nth-child(2) > div:nth-child(5) > div > input').val() == ""){		
							
						alert('보기를 마저 입력해 주세요');
						return false;
						}
					}else if(cntq == 3){
						if(	jQuery('#QBox3 > div:nth-child(1) > div > div > input').val() == "" ||
								jQuery('#QBox3 > div:nth-child(2) > div:nth-child(1) > div > input').val() == "" ||
								jQuery('#QBox3 > div:nth-child(2) > div:nth-child(2) > div > input').val() == "" ||
								jQuery('#QBox3 > div:nth-child(2) > div:nth-child(3) > div > input').val() == "" ||
								jQuery('#QBox3 > div:nth-child(2) > div:nth-child(4) > div > input').val() == "" ||
								jQuery('#QBox3 > div:nth-child(2) > div:nth-child(5) > div > input').val() == ""){		
							
						alert('보기를 마저 입력해 주세요');
						return false;
						}
					}else if(cntq == 4){
						if(	jQuery('#QBox4 > div:nth-child(1) > div > div > input').val() == "" ||
								jQuery('#QBox4 > div:nth-child(2) > div:nth-child(1) > div > input').val() == "" ||
								jQuery('#QBox4 > div:nth-child(2) > div:nth-child(2) > div > input').val() == "" ||
								jQuery('#QBox4 > div:nth-child(2) > div:nth-child(3) > div > input').val() == "" ||
								jQuery('#QBox4 > div:nth-child(2) > div:nth-child(4) > div > input').val() == "" ||
								jQuery('#QBox4 > div:nth-child(2) > div:nth-child(5) > div > input').val() == ""){		
							
						alert('보기를 마저 입력해 주세요');
						return false;
						}
					}else if(cntq == 5){
						if(	jQuery('#QBox5 > div:nth-child(1) > div > div > input').val() == "" ||
								jQuery('#QBox5 > div:nth-child(2) > div:nth-child(1) > div > input').val() == "" ||
								jQuery('#QBox5 > div:nth-child(2) > div:nth-child(2) > div > input').val() == "" ||
								jQuery('#QBox5 > div:nth-child(2) > div:nth-child(3) > div > input').val() == "" ||
								jQuery('#QBox5 > div:nth-child(2) > div:nth-child(4) > div > input').val() == "" ||
								jQuery('#QBox5 > div:nth-child(2) > div:nth-child(5) > div > input').val() == ""){		
							
						alert('보기를 마저 입력해 주세요');
						return false;
						}
					}
				});
			}
		);
		</script>
		<script type="text/javascript">
		//<!--
			
			jQuery(document).ready(
				function(){
					// 슬라이드 자동으로 넘어가는 것 방지
					jQuery("#fiveCarousel").carousel('pause');
					
					// 회원이면 포인트 0 
					// 관리자이면 포인트 100
					var isAdmin = "${sessionScope.isAdmin}";
					
					if(isAdmin == 2) {
						jQuery("input[name=point]").attr("value",0);
					} else{
						jQuery("input[name=point]").attr("value",100);				
					}
					
					// 카테고리 선택되었을때
					jQuery(".dropdown-item").on("click",
						function(){
							jQuery("#dropdownMenuButton").text(jQuery(this).text());
							jQuery("#category").attr("value",jQuery(this).attr("title"));
					});
					
					// 파일업로드 버튼 숨기기
					jQuery("input[type=file]").attr("hidden",true);
					
					// 이전, 다음 버튼 누르면 넘어가도록
					jQuery("button[name=prevButton]").on(
						"click",
						function(){
							jQuery("#fiveCarousel").carousel('prev');
						}
					);
					jQuery("button[name=nextButton]").on(
						"click",
						function(){
							jQuery("#fiveCarousel").carousel('next');
						}
					);
					var Qnum = 2;
					
					jQuery("button[name=addButton]").on(
						"click",
						function(){
							if(jQuery(".carousel-item").length < 5){
								var carouselItem =
									"<div class='carousel-item'>" +
										"<div class='container-fluid mt-5' id='QBox"+Qnum+"'>" +
								  			"<div class='row justify-content-center'>" +
												"<div class='form-group row w-75'>" +
													"<label class='col-sm-1 col-form-label text-right'>Q"+Qnum+"</label>" +
													"<div class='col-sm-10'>" +
														"<input type='text' class='form-control' name='Q"+Qnum+"' placeholder='질문을 작성해주세요'>" +
													"</div>" +
												"</div>" +
											"</div>" +
								  			"<div class='row justify-content-center'>" +
											    "<c:set var='num' value='${1}'/>" +
											    "<c:forEach begin='1' end='5'>" +
												    "<div class='form-group row w-75'>" +
													    "<label class='col-sm-1 col-form-label text-right'>${num}</label>" +
													    "<div class='col-sm-10'>" +
													      "<input type='text' class='form-control' name='Q"+Qnum+"Sel${num}' placeholder='보기${num}'>" +
													    "</div>" +
													"</div>" +
												"<c:set var='num' value='${num+1}'/>" +
												"</c:forEach>" +
								  			"</div>" +
								  		"</div>" +
									"</div>";
								jQuery(".carousel-inner").append(carouselItem);
								var length = jQuery(".carousel-item").length - 1;
								jQuery("#fiveCarousel").carousel(length);
								Qnum>5? Qnum=5 : Qnum++;
								console.log(Qnum);
							}
						}
					);
					jQuery("button[name=delButton]").on(
						"click",
						function(){
							if(jQuery(".carousel-item").length > 1){
								var length = jQuery(".carousel-item").length - 1;
								
								jQuery("#fiveCarousel").carousel(length - 1);
								setTimeout(function(){
									jQuery(".carousel-item:last").remove();
								},1200);
								Qnum--;
								console.log(Qnum);
							}
						}
					);
					
					
				}		
			);
		//-->
		</script>
	</body>
</html>

								