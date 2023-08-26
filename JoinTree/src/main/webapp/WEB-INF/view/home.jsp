<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<!-- header -->
	<jsp:include page="/WEB-INF/view/inc/header.jsp"/> 
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			// 로그인
			const urlParams = new URL(location.href).searchParams;
			const msg = urlParams.get("msg");
				if (msg != null) {
					alert(msg);
				}
			
			// 쿼리 매개변수 "msg"를 제거하고 URL을 업데이트 (새로고침 시 메시지 알림창 출력하지 않음)
	        urlParams.delete("msg");
	        const newUrl = `${location.pathname}?${urlParams.toString()}`;
	        history.replaceState({}, document.title, newUrl);
		
			// 현재시간 출력
			updateTime();
			setInterval(updateTime, 1000); // 1초마다 시간 업데이트
		
			function updateTime() {
				const time = new Date();
				const hour = time.getHours();
				const minutes = time.getMinutes();
				const seconds = time.getSeconds();
				
				const formattedHour = hour < 10 ? '0' + hour : hour;
				const formattedMinutes = minutes < 10 ? '0' + minutes : minutes;
				const formattedSeconds = seconds < 10 ? '0' + seconds : seconds;
						
				const formattedTime = formattedHour + ":" + formattedMinutes + ":" + formattedSeconds;
				$('.clock').text(formattedTime);
			}
			
			// 출퇴근 시간 업데이트 함수
		    function updateCommuteTimes(empOnTime, empOffTime){
		    	$('#onTime').text('출근시간 : '+empOnTime);
	    		$('#offTime').text('퇴근시간 : '+empOffTime);
		    }
		    
			// 출퇴근 데이터 화면 출력 함수
			function selectCommuteByDate(){
		    	$.ajax({
    		    	type:'GET',
    		    	url: '/JoinTree/getCommuteTime',
    		    	success: function(data){
    		    		
    		    		if(data){
    		    			let empOnTime = data.empOnTime;
    		    			let empOffTime = data.empOffTime;
    		            	console.log(empOnTime+'<--empOnTime');
    		            	console.log(empOffTime+'<--empOffTime');
    			    		
    		            	updateCommuteTimes(empOnTime, empOffTime); // 출퇴근 시간 업테이트
    		            	
    		            	// 출퇴근 시간 값에 따른 출퇴근 버튼 상태 분기
							if(empOnTime == null && empOffTime == null){
								$('#commuteBtn').text('출근하기');
								$('#commuteBtn').prop('disabled', false);
    		            	} else if(empOffTime == ''){
    		            		$('#commuteBtn').prop('disabled', false);
    							$('#commuteBtn').text('퇴근하기');
    		            	} else{
   		            			$('#commuteBtn').prop('disabled', true);
       							$('#commuteBtn').text('출근하기');
    		    			}
    		    		}
    		    	},
    		    	error: function(error){
    		    		console.error('error commute data', error);
    		    	}
    		    });
			}
			
			// 초기 페이지 로드 시 출퇴근 데이터 출력, 출퇴근 버튼 초기화
			selectCommuteByDate();
			
		 	// 출근/퇴근 버튼 클릭 이벤트 처리
	        $('#commuteBtn').click(function() {
	            const commuteBtnText = $('#commuteBtn').text().trim(); // 버튼 텍스트 저장
	            const currentTime = $('.clock').text(); // 현재시간 저장
	            const isCommute = commuteBtnText === '출근하기';
	            
	            $.ajax({
	            	type: 'post',
	            	url: '/JoinTree/saveCommuteTime',
	            	data:{
	            		time: currentTime,
	            		type: isCommute ? 'C0101' : 'C0102' // C0101:출근, C0102:퇴근
	            	},
		            success: function(data){
		            	console.log(data+'<--data');
		            	
		    		    selectCommuteByDate(); // 출퇴근 데이터 화면 출력
		            },
		            error: function(error){
		            	console.error('error commute time:', error);
		            }
	            });
	        });

		});
	</script>
	
	<!-- 필수 요소-->
	<div class="container-fluid page-body-wrapper">
		<jsp:include page="/WEB-INF/view/inc/sideContent.jsp"/> <!-- 사이드바 -->
			<div class="content-wrapper"> <!-- 컨텐츠부분 wrapper -->
			
				<!-- 컨텐츠 시작 -->
				<div class="row home">
					<div class="col-md-4 stretch-card grid-margin">
						<div class="card card-img-holder">
							<div class="card-body center ">
								<div class="home-profile">
									<img class="mb-2" src="/JoinTree/empImg/tiger.png" >
									<h1 class="mb-2 center">${empInfo.empName}${empInfo.position}</h1>
									<h4 class="mb-2 center">${empInfo.dept}</h4>
									<h1 class="mb-2 clock"></h1>
									<h4 class="mb-2" id="onTime">출근시간 : </h4>
									<h4 class="mb-2" id="offTime">퇴근시간 : </h4>
									<button type="button" class="btn btn-success btn-fw" id="commuteBtn">출근하기</button>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-5 stretch-card grid-margin">
						<div class="card card-img-holder">
							<div class="card-body"> 
								공지사항
								<hr>
								<ul>
										
										<c:forEach var="p" items="${homeProejctList}" varStatus="status">
											<li>
												${p.projectName}(${p.empName})
											</li>
										</c:forEach>
										<li>
											테스트
											</li>
											<li>
											테스트
											</li>
											<li>
											테스트
											</li>
											
									</ul>
								<div>
									<div>프로젝트</div>
									<hr>
									<ul>
										
										<c:forEach var="p" items="${homeProejctList}" varStatus="status">
											<li>
												${p.projectName}(${p.empName})
											</li>
										</c:forEach>
										<li>
											테스트
											</li>
											<li>
											테스트
											</li>
											<li>
											테스트
											</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-3 stretch-card grid-margin">
						<div class="card card-img-holder">
							<div class="card-body"> 
								오늘일정
							</div>
						</div>
					</div>
				</div>
				<!--  두번째 줄 -->
				<div class="row">
					<div class="col-md-9 stretch-card grid-margin">
						<div class="card card-img-holder">
							<div class="card-body"> 
								결재문서목록
								<hr>
								문서함
							</div>
						</div>
					</div>		
					
					<div class="col-md-3 stretch-card grid-margin">
						<div class="card card-img-holder">
							<div class="card-body"> 
								todo
							</div>
						</div>
					</div>					
				</div>
				
				<!--  로그인 임시 -->
				<div class="row">
					<div class="col-md-3 stretch-card grid-margin">
						<div class="card card-img-holder">
							<div class="card-body"> 
								<a href="/login/login">로그인</a>
								<a href="/logout">로그아웃</a>
							</div>
						</div>
					</div>					
				</div>
				
		</div><!-- 컨텐츠 끝 -->
	</div><!-- 컨텐츠전체 끝 -->
</html>