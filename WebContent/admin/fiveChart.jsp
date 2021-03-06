<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
<style>
.modal-row{
		font-size: 2em;
		
	}
</style>
<div class="modal fade" id="reGraphModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">오지선다 데이터 분석 결과</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="closeModal">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="row justify-content-md-center modal-row">
			총:
			<div id="totalCheck"></div>
		</div>
		<div class="row modal-row ">
			<div class="col-sm-6 text-center" >True Count<div id="trueCheck"></div></div>
			<div class="col-sm-6 text-center" >False Count<div id="falseCheck"></div></div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn " data-dismiss="modal" id ="closeModalBtn">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- 사이드바  1-1 start-->
<jsp:include page="../mypage.do"/>
<main class="page-content">
<div class="container-fluid">
	<div class="card col-md-12">
		<h2 class="mt-3">설문 유형 5 데이터</h2>
		<hr>
		<h5>사이트 데이터관리 > 설문유형 5 데이터</h5>
		<hr>
		<!-- 사이드바  1-1 end -->
		<br>
<!-- 		<div class="col-md-2"> -->
<!-- 			<button class="btn" id="reGraph" data-toggle="modal" data-target="#reGraphModal">최신화</button> -->
<!-- 		</div> -->
		<br>
		<div class="row">
		
			<label>오지선다 번호</label>
			<div class="col-md-4">
				<select class="form-control" id="fsnum" >
					<c:forEach var="el" items="${getS_numList}"> 
						<option>${el}</option>
					</c:forEach>
				</select>
			</div>
			<br><br>
		</div>
		<h3 class="noData"></h3>
		
		<div class="row">
			<div id="sexAll" class="dataArea" style="height: 30rem; width: 50%;"></div>
			<div id="ageAll" class="dataArea" style="height: 30rem; width: 50%;"></div>
		</div>
		<br>
		<br>
		<br>
		<div class="row qBtnRow">
			<c:forEach begin="1" end="5" varStatus="i">
				<input class="btn btn-primary ml-4 dataArea" type="button" value="질문${i.count}" id="${i.count}">
			</c:forEach>
		</div>
		<br>
		<br>
		<br>
		<div class="row chartRow justify-content-center">
			<div id="chartContainer" class="dataArea" style="height: 30rem; width: 100%;"></div>
		</div>
		


		<!-- 사이드바 2-2 start --> 
	</div>
</div>
</main>
<!-- 사이드바 2-2 end --> 

<!-- <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script> -->
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script>
var dttt = {"type":5}
$( document ).ready(function() {
// 	setInterval(()=>{
		$.ajax({
	
			data:dttt,
			dataType:"json",
			type:"post",
			url:"CheckAdmin.do",
			success:function(rs){
				var total = rs.length
				var t ,f ,tper,fper
				if(rs.length != 0){
					t = rs.filter(el=>el.isRightSur == 1).length
					f = total - t
					tper = t/total * 100
					fper = f/total * 100
					tper = tper.toFixed(2)
					fper = fper.toFixed(2)
					
					console.log("총 미검사 수 : " +total+ ",진실:" + t  + ",거짓: " + f)
					$("#totalCheck").text(total).addClass("animated bounceInDown");
				
					setTimeout(()=>{
						$("#trueCheck").html(t + "<br>" +tper + "%").css({"font-size":"2.5em","color":"gold"}).addClass("animated zoomInLeft fast");
						$("#falseCheck").html(f + "<br>" + fper + "%").css({"font-size":"2.5em"}).addClass("animated zoomInRight fast");
					},1000);
					
					 $("#reGraphModal").modal('show')
					 isChecked=false

				}else{
					$(".modal-body").html("<h1>현재 최신 상태입니다.</h1>");
					 $("#reGraphModal").modal('show')
					 isChecked=false
				}
					
			}
		});
// },2000);
});
var isChecked = true

//modal close 하면 새로고침됨 <<-- 마지막 작업 (checkAdmin ==> 1)
$("#closeModal,#closeModalBtn").on("click",function(){
	var dt = {"type":5}
	$.ajax({
		
		data:dt,
		dataType:"text",
		type:"post",
		url:"updateCheckAdmin.do",
		success:function(rs){
			if(isChecked)	
				location.reload()
		}
	});
});

window.onload = function () {
////////////////////////////그래프 담을 변수들 /////////////////////////////////
	var sexAllChart = null;		// 전체 참여 성별
	var ageAllChart = null;		// 전체 참여 연령별
	var selAllChart = null;		// 전체 보기 선택수
	var sexSelChart = null;		// 선택 보기 성별
	var ageSelChart = null;		// 선택 보기 연령별
	
	if( ${q_len} == 0 ) {
		$(".noData").text("이 설문에 대한 참여정보가 아직 없습니다.");
		$(".dataArea").hide();
	}
//////////////////////////// 그래프 안에 들어갈 옵션을 담은 변수 //////////////////
	var selChartOptions = {
			// 전체 참여 성별
			sexAll : {
				animationEnabled: true,
				title:{
					text: "남여 총 참여 비율",
				},
				data: [{
					type: "doughnut",
					startAngle: 60,
					indexLabelFontSize: 14,
					indexLabel: "{label} - #percent%",
					toolTipContent: "<b>{label}:</b> {y} (#percent%)",
					dataPoints: []
				}]
			},
			// 전체 참여 연령
			ageAll : {
				animationEnabled: true,
				theme: "light1",
				title:{
					text: "연령별 총 참여 비율"
				},
				data: [{
					type: "column",
					indexLabel: "{y}",
					indexLabelFontColor: "#5A5757",
					indexLabelPlacement: "outside",
					dataPoints: []
				}]
			},
			// 해당 질문 전체 보기
			selAll : {
				animationEnabled: true,
				theme: "light2", // "light1", "light2", "dark1", "dark2"
				title:{
					text: "설문 보기별 선택수"
				},
				subtitles:[{
					text: "각 보기를 클릭하여 자세한 정보를 확인하세요"
					//Uncomment properties below to see how they behave
					//fontColor: "red",
					//fontSize: 30
				}],
				data: [{        
					type: "column",
					click: onClick,
					dataPoints: []
				}]
			},
			// 해당 질문 해당 보기 성별
			sexSel : {
				animationEnabled: true,
				title: {
					text: "성별"
				},
				data: [{
					type: "pie",
					startAngle: 240,
					toolTipContent: "<b>{label}:</b> {y} 명",
					indexLabel: "{label} - #percent%",
					dataPoints: []
				}]
			},
			// 해당 질문 해당 보기 연령별
			ageSel : {
				animationEnabled: true,
				theme: "light2", // "light1", "light2", "dark1", "dark2"
				title:{
					text: "연령별"
				},
				data: [{        
					type: "column",  
					dataPoints: []
				}]
			}
		};
///////////////////////////// 초기 데이터 /////////////////////////////////////
	var dataForAll = new Array();
		dataForAll = ${dataForAll};
	var dataForEachQ = new Array();
		dataForEachQ = ${dataForEachQ};
		
	var initData = [
		[	// 전체 참여 성별 분포 		index : 0
			{ y : dataForAll[0], label : "남자" },
			{ y : dataForAll[1], label : "여자" }
		],
		[	// 전체 참여 연령별 분포		index : 1
			{ y : dataForAll[2], label : "10대" },
			{ y : dataForAll[3], label : "20대" },
			{ y : dataForAll[4], label : "30대" },
			{ y : dataForAll[5], label : "40대" },
			{ y : dataForAll[6], label : "50대" },
			{ y : dataForAll[7], label : "60대" },
			{ y : dataForAll[8], label : "70대" }
		],
		[   // 해당 질문 전체 보기 분포	index : 2
			{ y: dataForEachQ[0],	label: "보기1" , value: 0},
			{ y: dataForEachQ[1],	label: "보기2" , value: 1},
			{ y: dataForEachQ[2],	label: "보기3" , value: 2},
			{ y: dataForEachQ[3],	label: "보기4" , value: 3},
			{ y: dataForEachQ[4],	label: "보기5" , value: 4}
		],
		[	// 해당 질문 해당 보기 성별 분포	index : 3
			{y: dataForEachQ[5], label: "남자"},
			{y: dataForEachQ[10], label: "여자"}
		],
		[   // 해당 질문 해당 보기 연령분포	index : 4
			{ y: dataForEachQ[15],  label: "10대" },
			{ y: dataForEachQ[20],  label: "20대" },
			{ y: dataForEachQ[25],  label: "30대" },
			{ y: dataForEachQ[30],  label: "40대" },
			{ y: dataForEachQ[35],  label: "50대" },
			{ y: dataForEachQ[40],  label: "60대" },
			{ y: dataForEachQ[45],  label: "70대" }
		]
		
	];
	
	function setData(Data) {
		// 그래프 데이터 설정
		sexAllChart.options.data[0].dataPoints = Data[0];
		ageAllChart.options.data[0].dataPoints = Data[1];
		selAllChart.options.data[0].dataPoints = Data[2];
		selChartOptions.sexSel.data[0].dataPoints = Data[3];
		selChartOptions.ageSel.data[0].dataPoints = Data[4];
	}
	
	// 실제 그래프 그리는 부분
	function makeChart(Data) {
		// 해당 설문 전체 분포
		sexAllChart = new CanvasJS.Chart("sexAll", selChartOptions.sexAll); // 해당 설문 전체 참여 성별 분포
		ageAllChart = new CanvasJS.Chart("ageAll", selChartOptions.ageAll); // 해당 설문 전체 참여 연령 분포
		
		// 해당 질문별 분포
		selAllChart = new CanvasJS.Chart("chartContainer", selChartOptions.selAll);	// 해당 질문 전체보기
		
		setData(Data);
		
		// 그래프 그리기
		sexAllChart.render();
		ageAllChart.render();
		selAllChart.render();
	}// makeChart
	makeChart(initData);

	// 해당 질문 전체 보기 데이터 중 하나를 눌렀을 때
	function onClick(e) {
		
		
		// 선택한 보기에 맞는 데이터 세팅
		initData[3][0].y = dataForEachQ[5 + e.dataPoint.value];		//남
		initData[3][1].y = dataForEachQ[10 + e.dataPoint.value];	//여
		initData[4][0].y = dataForEachQ[15 + e.dataPoint.value];	//10
		initData[4][1].y = dataForEachQ[20 + e.dataPoint.value];	//20
		initData[4][2].y = dataForEachQ[25 + e.dataPoint.value];	//30
		initData[4][3].y = dataForEachQ[30 + e.dataPoint.value];	//40
		initData[4][4].y = dataForEachQ[35 + e.dataPoint.value];	//50
		initData[4][5].y = dataForEachQ[40 + e.dataPoint.value];	//60
		initData[4][6].y = dataForEachQ[45 + e.dataPoint.value];	//70
		
		setData(initData);
				
		$("#chartContainer").remove();
		$(".chartRow").append(
				'<div id="sexSel" style="height: 25rem; width: 50%;"></div>' +
				'<div id="ageSel" style="height: 25rem; width: 50%;"></div>' +
				'<button type="button" class="btn btn-outline-info backBtn">뒤로가기</button>'
		);
		// 해당 질문 해당 보기 데이터를 보던 중 다시 전체 보기 데이터로 돌아갈 때
		$(".backBtn").on("click",function(){
			$(".chartRow").children().remove();
			$(".chartRow").append(
				'<div id="chartContainer" style="height: 30rem; width: 100%;"></div>'
			);
			selAllChart = new CanvasJS.Chart("chartContainer", selChartOptions.selAll);
			selAllChart.render();
			
		});
		sexSelChart = new CanvasJS.Chart("sexSel", selChartOptions.sexSel);			// 해당 질문 해당 보기 성별
		ageSelChart = new CanvasJS.Chart("ageSel", selChartOptions.ageSel);			// 해당 질문 해당 보기 연령별
		
		sexSelChart.render();
		ageSelChart.render();
	}//onClick
	
	////////////////////////// ajax 처리 영역 //////////////////////////////////////////
	function remakeChart(q_num, s_num){
		$.ajax({
			data:{
				"q_num" : q_num,
				"s_num" : s_num
			},
			dataType:"json",
			type:"POST",
			url:"changeDataFive.do",
			
			success:function(d){
				dataForEachQ = d.dataForEachQ;
				dataForAll = d.dataForAll;
				if(d.q_len == 0) {
					$(".noData").text("이 설문에 대한 참여정보가 아직 없습니다.");
					$(".dataArea").hide();
				} else {
					$(".noData").text("");
					$(".dataArea").show();
					initData = [
						[	// 전체 참여 성별 분포 		index : 0
							{ y : dataForAll[0], label : "남자" },
							{ y : dataForAll[1], label : "여자" }
						],
						[	// 전체 참여 연령별 분포		index : 1
							{ y : dataForAll[2], label : "10대" },
							{ y : dataForAll[3], label : "20대" },
							{ y : dataForAll[4], label : "30대" },
							{ y : dataForAll[5], label : "40대" },
							{ y : dataForAll[6], label : "50대" },
							{ y : dataForAll[7], label : "60대" },
							{ y : dataForAll[8], label : "70대" }
						],
						[   // 해당 질문 전체 보기 분포	index : 2
							{ y: dataForEachQ[0],	label: "보기1" , value: 0},
							{ y: dataForEachQ[1],	label: "보기2" , value: 1},
							{ y: dataForEachQ[2],	label: "보기3" , value: 2},
							{ y: dataForEachQ[3],	label: "보기4" , value: 3},
							{ y: dataForEachQ[4],	label: "보기5" , value: 4}
						],
						[	// 해당 질문 해당 보기 성별 분포	index : 3
							{y: dataForEachQ[5], label: "남자"},
							{y: dataForEachQ[10], label: "여자"}
						],
						[   // 해당 질문 해당 보기 연령분포	index : 4
							{ y: dataForEachQ[15],  label: "10대" },
							{ y: dataForEachQ[20],  label: "20대" },
							{ y: dataForEachQ[25],  label: "30대" },
							{ y: dataForEachQ[30],  label: "40대" },
							{ y: dataForEachQ[35],  label: "50대" },
							{ y: dataForEachQ[40],  label: "60대" },
							{ y: dataForEachQ[45],  label: "70대" }
						]
						
					];
					
					makeChart(initData);
				}
			},
			error:function(){
				console.log("five data change ajax failed");
			}
		});
	}
	$(".btn.btn-primary").on("click",function(){
		var q_num = $(this).attr("id");
		var s_num = $("#fsnum").val();
		remakeChart(q_num, s_num);
	});
	$("#fsnum").on("change",function(){
		var q_num = 1;
		var s_num = $(this).val();
		remakeChart(q_num, s_num);
	});
}
</script>



