<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectEmpList</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>
	<div>
		<button type="button" id="addEmpModalBtn" data-bs-toggle="modal" data-bs-target="#addEmpModal"> 사원등록</button>
	</div>
	<!-- 검색별 조회 -->
	<div>
		<form id="searchEmpListForm">
			<div>
				<div>사번</div>
				<input type="text" id="searchEmpNo" name="empNo">
			</div>
			<div>
				<div>사원명</div>
				<input type="text" id="searchEmpName" name="empName">
			</div>
			<div>
				<div>상태</div>
				<select id="searchActive" name="active">
					<option value="">선택하세요</option>
					<c:forEach var="a" items="${activeCodeList}">
						<option value="${a.code}">${a.codeName}</option>
					</c:forEach>
				</select>
			</div>
			<div>
				<div>입사일</div>
				<input type="date" id="searchStartEmpHireDate" name="startEmpHireDate"> &#126; 
				<input type="date" id="searchEndEmpHireDate" name="endEmpHireDate">
			</div>
			<div>
				<div>부서</div>
				<select id="searchDept" name="dept">
					<option value="">선택하세요</option>
					<c:forEach var="d" items="${deptCodeList}">
						<option value="${d.code}">${d.codeName}</option>
					</c:forEach>
				</select>
			</div>
			<div>
				<div>직급</div>
				<select id="searchPosition" name="position">
					<option value="">선택하세요</option>
					<c:forEach var="p" items="${positionCodeList}">
						<option value="${p.code}">${p.codeName}</option>
					</c:forEach>
				</select>
			</div>
			<div>
				<button type="button" id="searchEmpListBtn">검색</button>
			</div>
		</form>
	</div>
	
	<!-- 검색별 사원 목록 출력 -->
	<table>
		<thead>
			<tr>
				<th>사번</th>
				<th>사원명</th>
				<th>입사일</th>
				<th>부서</th>
				<th>직급</th>
				<th>재직상태</th>
			</tr>
		</thead>
		<tbody id="empInfoList">
		
		</tbody>
	</table>
	
	
	<!-- 페이지 네비게이션 -->
	<div id="pagination">
		
	</div>
	
	<!-- 사원 등록 모달창 -->
	<div class="modal" id="addEmpModal">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">사원 등록</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
					<form id="addEmpForm" method="post">
						<div>
							<div>사원명</div>
							<input type="text" id="empName" name="empName">
						</div>
						<div>
							<div>주민번호</div>
							<input type="text" id="empJuminNo1" name="empJuminNo1"> &#45; 
							<input type="text" id="empJuminNo2" name="empJuminNo2">
						</div>
						<div>
							<div>연락처</div>
							<input type="text" id="empPhone1" name="empPhone1"> &#45; 
							<input type="text" id="empPhone2" name="empPhone2"> &#45; 
							<input type="text" id="empPhone3" name="empPhone3">
						</div>
						<div>
							<div>주소</div>
							<div>
								<input type="text" name="zip" id="sample6_postcode" placeholder="우편번호">
							</div>
							<div>
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary">
							</div>
							<div>
								<input type="text" name="add1" id="sample6_address" placeholder="주소" class="form-control">
								<input type="text" name="add2" id="sample6_detailAddress" placeholder="상세주소" class="form-control">
								<input type="text" name="add3" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
							</div>
						</div>
						<div>
							<div>부서</div>
							<select id="deptCategory" name="dept">
								<option value="">선택하세요</option>
								<c:forEach var="d" items="${deptCodeList}">
									<option value="${d.code}">${d.codeName}</option>
								</c:forEach>
							</select>
						</div>
						<div>
							<div>직급</div>
							<select id="positionCategory" name="position">
								<option value="">선택하세요</option>
								<c:forEach var="p" items="${positionCodeList}">
									<option value="${p.code}">${p.codeName}</option>
								</c:forEach>
							</select>
						</div>
						<div>
							<div>내선번호</div>
							<input type="text" id="empExtensionNo" name="empExtensionNo">
						</div>
						<div>
							<div>입사일</div>
							<input type="date" id="empHireDate" name="empHireDate">
						</div>
						<div class="text-center">
							<button type="button" id="addEmpBtn">등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 사원 상세정보, 수정 모달창 -->
	<div class="modal" id="selectEmpOneModal">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" id="modarTitleEmpOne">사원 상세 정보</h4>
					<h4 class="modal-title" id="modarTitleModifyEmp">사원 정보 수정</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal" id="empOneModalClose"></button>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
					
					<!-- 사원 상세 정보 조회 -->
					<jsp:include page="./selectEmpOne.jsp"></jsp:include>
					
					<!-- 사원 정보 수정 -->
					<jsp:include page="./modifyEmpForm.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	
	
	
</body>

<script>
	
	// 사원등록 버튼(addEmpBtn) click
	$('#addEmpBtn').on('click', function(){
		
		// 값 유효성 검사 후 사원 등록
	    let addEmpUrl = '/empManage/addEmp';
		$('#addEmpForm').attr('action', addEmpUrl);
	    $('#addEmpForm').submit();
	});
	
	// 주소찾기 https://devofroad.tistory.com/42 참고
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById('sample6_extraAddress').value = extraAddr;
                
                } else {
                    document.getElementById('sample6_extraAddress').value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById('sample6_address').value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_detailAddress').focus();
            }
        }).open();
    }
	
	
	 //검색 조건별 사원 목록 출력
	 $(document).ready(function(){
	    
		// 페이지 로드 시 초기화
		searchEmpListResults();
		
		// 검색 버튼 클릭 이벤트
		$('#searchEmpListBtn').click(function(){
			searchEmpListResults();
		});
		
		// 페이지 이동 버튼 클릭 이벤트
		$('#pagination').on('click','.page-btn',function(){
			let page = $(this).text();
			goToPage(page);
		});
		
		// 검색 및 페이지 데이터 수정 함수
		function searchEmpListResults(page =1){
			
			// 검색 조건
			let searchEmpList = {
				empNo: $('#searchEmpNo').val(),
				empName: $('#searchEmpName').val(),
				active: $('#searchActive').val(),
				startEmpHireDate: $('#searchStartEmpHireDate').val(),
				endEmpHireDate: $('#searchEndEmpHireDate').val(),
				dept: $('#searchDept').val(),
				position: $('#searchPosition').val()
			};
			
			// 데이터 조회
			$.ajax({
				url: '/empManage/searchEmpList',
				type: 'GET',
				data: {
					// 검색조건 객체를 JSON으로 변환
					searchEmpList: JSON.stringify(searchEmpList),
					currentPage: page,
					rowPerPage: 10 
				},
				success: function(data){
					console.log(data);
			        updateTableWithData(data), // 테이블 데이터 수정 함수
			        updatePagination(data); // 페이지네이션 데이터 수정 함수
				},
				error: function(){
					console.log(data);
				}
			});
		}
		
		// 페이지 이동 함수
		function goToPage(page){
			
			// 검색 및 페이지 데이터 수정 함수
		  	searchEmpListResults(page);
	    } 
     
		// 페이지 네비게이션 수정 함수
		function updatePagination(data){
			let pagination = $('#pagination');
			pagination.empty();
			
			// 이전 페이지 버튼
			if(data.startPage > 1){
				let prevButton = $('<button type="button" class="page-btn">').text('이전');
	            prevButton.click(function() {
	                goToPage(data.startPage - data.pageLength);
	            });
	            pagination.append(prevButton);
			}
			
			// 페이지 버튼 생성
			for(let i = data.startPage; i <= data.endPage; i++){
				const page = i;
				let pageButton = $('<button type="button" class="page-btn">').text(i);
		        pageButton.click(function(){
		        	goToPage(page);
		        });
		        pagination.append(pageButton);
			}
			
			// 다음 페이지 버튼
			if(data.endPage < data.lastPage){
				let nextButton = $('<button type="button" class="page-btn">').text('다음');
	            nextButton.click(function() {
	                goToPage(data.endPage + data.pageLength);
	            });
	            pagination.append(nextButton);
			}
		}
		
		// 테이블 데이터 수정 함수
		function updateTableWithData(data) {
		    // data는 서버에서 반환된 JSON 데이터
		    // data 객체 속성에 접근하여 값 추출
		    let empList = data.searchEmpListByPage;
		    
		    // 테이블의 tbody를 선택하고 초기화
		    let tbody = $('#empInfoList');
		    tbody.empty();
	
		    // data의 길이만큼 테이블 행을 추가
		    for (let i = 0; i < empList.length; i++) {
		        let emp = empList[i];
		        let row = $('<tr>');
		        row.append($('<td>').text(emp.empNo));
		        row.append($('<td>').text(emp.empName));
		        row.append($('<td>').text(emp.empHireDate));
		        row.append($('<td>').text(emp.dept));
		        row.append($('<td>').text(emp.position));
		        row.append($('<td>').text(emp.active));
		        tbody.append(row);
		    }
		}
	
		});
	 	
		// 사원 상세정보, 수정폼 관리
	 	let modifyFormMode = false; // 수정폼 실행 상태 변수
	 	
	 	// 사원 상세정보로 초기화
	 	function resetEmpOne(){
	 		$('#empOneModalBody').show();
	 		$('#modarTitleEmpOne').show();
	        $('#modifyEmpForm').hide();
	        $('#modarTitleModifyEmp').hide();
	        modifyFormMode = false;
	 	}
	 	
	 	// 수정버튼(modifyEmpBtn) click
	 	$('#modifyEmpBtn').click(function(){
	 		$('#modifyEmpForm').show();
	 		$('#modarTitleModifyEmp').show();
	 		$('#empOneModalBody').hide();
	 		$('#modarTitleEmpOne').hide();
	 		modifyFormMode = true;
	 	});
	 	
	 	// 모달창 닫을 때
	 	$('#empOneModalClose').click(function(){
	 		// 사원 상세정보 초기화
	 		resetEmpOne();
	 	});
	 
	 	// 사원 상제정보, 수정폼 데이터 관리
	 	$('#empInfoList').on('click', 'tr', function(){
	 		 
	 		// tr 클릭 시 사원 상세정보로 초기화
	        resetEmpOne();
	        document.getElementsByClassName("tablink")[0].click();
	 		// empNo의 값이 들어있는 첫 번째 열의 값을 가져온다
	 		let empNo = $(this).find('td:eq(0)').text();
	 		   
               // 상세 정보 가져오기
               $.ajax({
   	 			url: '/empManage/selctEmpOne',
   	 			type: 'GET',
   	 			data: {empNo: empNo},
   	 			success: function(data){
   	 				
   	 				console.log(data);
   	 				
   	 				let empInfoOne = data.selectEmpOne;// 사원 상세정보
   	 				let reshuffleHistoryList = data.reshuffleHistoryList; // 인사이동 이력 목록
   	 				
   	 				// 사원 상세정보 값 변수에 저장
   	 				let empNo = empInfoOne.empNo;
   	 				let empName = empInfoOne.empName;
   	 				let empJuminNo = empInfoOne.empJuminNo;
   	 				let empPhone = empInfoOne.empPhone;
   	 				let empAddress = empInfoOne.empAddress;
   	 				let dept = empInfoOne.dept;
   	 				let deptCode = empInfoOne.deptCode;
   	 				let position = empInfoOne.position;
   	 				let positionCode = empInfoOne.positionCode;
   	 				let empExtensionNo = empInfoOne.empExtensionNo;
   	 				let empHireDate = empInfoOne.empHireDate;
   	 				let empLastDate = empInfoOne.empLastDate;
   	 				let active = empInfoOne.active;
   	 				let activeCode = empInfoOne.activeCode;
   	 				let empSaveImgName = empInfoOne.empSaveImgName;
   	 	            
   	 				// 사원 상세정보 값 설정
   	 	            //$('#empImgOne img').attr('src', empInfo.empImage || '기본이미지경로');
   	 	            $('.empNo').text(empNo);
   	 				$('.empNameOne').text(empName);
   	 	            $('.empJuminNoOne').text(empJuminNo);
   	 	            $('.empPhoneOne').text(empPhone);
   	 	            $('.empoAddressOne').text(empAddress);
   	 	            $('#deptOne').text(dept);
   	 	            $('#positionOne').text(position);
   	 	            $('#empExtensionNoOne').text(empExtensionNo);
   	 	            $('#empHireDateOne').text(empHireDate);
   	 	        	$('#empActiveOne').text(active);
   	 	        	
   	 	            // 이미지 유무에 따른 분기
   	 	            if (empSaveImgName) {
   	                    //$('#empImgOne img').attr('src', empInfo.empSaveImgName);
   	 	            	$('.empImgOne').text('사진 정보 있음');
   	                } else {
   	                    // 이미지가 없는 경우 처리
   	                    //$('#empImgOne img').attr('src', '#');
   	                    $('.empImgOne').text('사진 정보 없음');
   	                }
   	 	            
   	 	            // 퇴사일 분기
   	 	            if (empLastDate) {
   	                    $('#empLastDateOne').text(empLastDate);
   	                } else {
   	                    $('#empLastDateOne').text('퇴사일 정보 없음');
   	                }
   	 	            
   	 	            // 사원 정보 수정 input 요소에 값 설정
				    $('input[name="empExtensionNo"]').val(empExtensionNo);
				    $('input[name="empHireDate"]').val(empHireDate);
				    $('input[name="empLastDate"]').val(empLastDate);
				    $('input[name="departBeforeNo"]').val(deptCode);
				    $('input[name="positionBeforeLevel"]').val(positionCode);
   					// 사원 정보로 값 selected		 	      
				    $('#modifyDeptCategory option[value="' + deptCode + '"]').prop('selected', true);
				    $('#modifyPositionCategory option[value="' + positionCode + '"]').prop('selected', true);
				    $('#modifyEmpAtiveCategory option[value="' + activeCode + '"]').prop('selected', true);
				    
				    // 인사이동 테이블 데이터
				    updateReshuffleHistoryTableWithData(reshuffleHistoryList);
			
   	 	            // 모달창 열기
   	 	        	$('#selectEmpOneModal').modal('show');

   	 			},
   	 			error: function(){
   	 				console.log("잘못된 요청입니다");
   				}
   	 		});
         
		});
	 	
	 	// 인사이동 테이블 데이터 수정 함수
		function updateReshuffleHistoryTableWithData(data) {
		    // data는 서버에서 반환된 JSON 데이터
		    // data 값 저장
		    let reshuffleHistoryList = data;
		    
		    // 테이블의 tbody를 선택하고 초기화
		    let tbody = $('#reshuffleHistoryList');
		    tbody.empty();
	
		    // data의 길이만큼 테이블 행을 추가
		    for (let i = 0; i < reshuffleHistoryList.length; i++) {
		        let rh = reshuffleHistoryList[i];
		        let row = $('<tr>');
		        let dateOnly = rh.createdate.split(" ")[0];
		        row.append($('<td>').text(dateOnly));
		        row.append($('<td>').text(rh.departBeforeNo));
		        row.append($('<td>').text(rh.departNo));
		        row.append($('<td>').text(rh.positionBeforeLevel));
		        row.append($('<td>').text(rh.position));
		        tbody.append(row);
		    }
		}
	 	
	 	
	 	// 사원정보 수정확인 버튼(modifyEmpConfirmBtn) click
       	$('#modifyEmpConfirmBtn').on('click', function(){
       		
       		// 카테고리별 이름 값 저장 변수
       		let deptCategory = $('#modifyDeptCategory option:selected').text();
       		let positionCategory = $('#modifyPositionCategory option:selected').text();
       		let activeCategory = $('#modifyEmpAtiveCategory option:selected').text();
       		
       		// 수정할 사원 정보, 인사이동 이력 정보(이전부서, 이전직급)
       		let modifyEmpOne = {
       			empNo: $('#modifyEmpNo').val(),
       			dept: $('#modifyDeptCategory').val(),
       			position: $('#modifyPositionCategory').val(),
       			active: $('#modifyEmpAtiveCategory').val(),
       			empExtensionNo: $('#modifyEmpExtensionNo').val(),
       			empHireDate: $('#modifyEmpHireDate').val(),
       			empLastDate: $('#modifyEmpLastDate').val(),
       			departBeforeNo: $('#departBeforeNo').val(),
       			positionBeforeLevel: $('#positionBeforeLevel').val()
       		}
       		
       		$.ajax({
       			url: '/empManage/modifyEmp',
       			type: 'POST',
       			contentType: 'application/json',
       			dataType: 'json',
       			data: JSON.stringify(modifyEmpOne),
       			success: function(data){
       				console.log(data + "<-- modifyEmpOne data");
       				let activeResult = data.modifyActiveResult;
       				let empInfoResult = data.modifyEmpInfoResult;
       				
       				if(activeResult == 1 || empInfoResult == 1){
       					alert('사원 정보 수정 성공');
       					
       					// 수정된 내용 업데이트
       					$('#deptOne').text(deptCategory);
	   	 	            $('#positionOne').text(positionCategory);
	   	 	            $('#empExtensionNoOne').text(modifyEmpOne.empExtensionNo);
	   	 	            $('#empHireDateOne').text(modifyEmpOne.empHireDate);
	   	 	        	$('#empActiveOne').text(activeCategory);
       					
       					// 모달 창 내용 변경 후, 수정 폼을 숨기고 상세 정보를 보이게 설정
       		            $('#modifyEmpForm').hide();
       		            $('#modarTitleModifyEmp').hide();
       		            $('#empOneModalBody').show();
       		            $('#modarTitleEmpOne').show();
       		         	
       				} 
       			},
       			error: function(){
       				console.log(data + "<-- modifyEmpOne error data");
       			}
       		});
       	});
	 	
	 	// 수정취소 버튼(modifyEmpCancelBtn) click
	 	$('#modifyEmpCancelBtn').click(function(){
	 		// 수정 폼을 숨기고 상세 정보를 보이게 설정
            $('#modifyEmpForm').hide();
            $('#modarTitleModifyEmp').hide();
            $('#empOneModalBody').show();
            $('#modarTitleEmpOne').show();
	 	});
	 	
</script>
</html>