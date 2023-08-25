<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
 	<!-- head, body 사용 안함 // 다른 부분도 템플릿 바꾸기 -->
	<!-- header -->
	<jsp:include page="/WEB-INF/view/inc/header.jsp"/> 
	    <script>
	        $(document).ready(function() {
	        	const urlParams = new URL(location.href).searchParams;
				const msg = urlParams.get("msg");
					if (msg != null) {
						alert(msg);
					}
					
				const fileInput = $('#fileInput');
		        const previewImage = $('#previewImage');
		        const removeBtn = $('#removeBtn');
		        
		        // 초기에 파일 삭제 버튼 숨기기
		        removeBtn.hide();
		            
		        // 파일 선택 시 미리보기, 파일 크기 검사, 파일 확장자 검사
	            fileInput.change(function() {
	                const file = fileInput.prop('files')[0]; // 선택한 파일 객체 가져오기
	                if (file) {
	                    const reader = new FileReader(); // FileReader 객체 생성
	                    reader.onload = function(e) { // 파일 읽기 완료 후 실행될 함수 정의
	                    	// 미리보기 이미지의 'src' 속성을 읽은 파일 내용으로 설정
	                        previewImage.attr('src', e.target.result); 
	                    };
	                    reader.readAsDataURL(file); // 파일을 데이터 URL로 읽기 시작
	                    
	                    // 파일 크기, 확장자 검사
	                    const fileSize = file.size;
	                    const maxSize = 3 * 1024 * 1024; // 3MB
	                    const allowedExtensions = ['.jpg', '.jpeg', '.png', 'gif', '.bmp'];
	                    const fileExtension = file.name.substr(file.name.lastIndexOf('.')).toLowerCase();
	                    
	                    if (fileSize > maxSize) {
	                    	alert("파일 크기가 3MB를 초과합니다.");
	                    	fileInput.val(''); // 파일 선택 초기화
	                    	previewImage.attr('src', ''); // 미리보기 초기화
	                    	// removeBtn.hide(); // 파일 삭제 버튼 숨기기
	                    } else if (!allowedExtensions.includes(fileExtension)) {
	                    	alert("이미지 파일만 첨부 가능합니다.");
	                    	fileInput.val(''); // 파일 선택 초기화
	                    	previewImage.attr('src', ''); // 미리보기 초기화
	                    } else {
	                    	// 파일 선택 시 파일 삭제 버튼 표시
		                	removeBtn.show();
	                    }
	                    
	                 
	                } else {
	                    previewImage.attr('src', ''); // 파일이 선택되지 않았을 때 미리보기 초기화
	                }
	            });
		        
	            // 파일 삭제 버튼 클릭 시 파일 선택 초기화
	            removeBtn.click(function() {
	                fileInput.val(''); // 파일 선택 초기화
	                previewImage.attr('src', ''); // 미리보기 초기화
	                removeBtn.hide(); // 파일 삭제 버튼 숨기기
	            });
	        	
				// textarea에 placeholder과 비슷한 기능 적용
	            function setPlaceholder(element, placeholder) {
	                element.val(placeholder).css('color', 'gray');
	                
	                element.focus(function() {
	                    if (element.val() === placeholder) {
	                        element.val('').css('color', 'black');
	                    }
	                });
	                
	                element.blur(function() {
	                    if (element.val() === '') {
	                        element.val(placeholder).css('color', 'gray');
	                    }
	                });
	            }
	            
	            setPlaceholder($('#content'), '내용을 입력해주세요.');
	        });
	    </script>

		<div class="container-fluid page-body-wrapper">
		<jsp:include page="/WEB-INF/view/inc/sideContent.jsp"/> <!-- 사이드바 -->
			<div class="content-wrapper"> <!-- 컨텐츠부분 wrapper -->

				<h1>게시글 입력</h1>
				<!-- 추후 삭제 -->
				<div>
					부서코드: ${dept}
				</div>		
				
				<div>
					카테고리: 자유게시판
				</div>
				<form action="/community/freeCommList/addFreeComm" method="post" enctype="multipart/form-data" id="addFreeComm">
					<input type="hidden" name="empNo" value="${loginAccount.empNo}">
					<input type="hidden" name="boardCategory" value="B0103">
					<div>
						<c:if test="${dept eq 'D0202'}">	
							게시판 상단고정 <input type="checkbox" name="boardPinned"> <!-- value 지정하지 않았을 경우 체크박스 선택 시 boardPinned="on" 과 같이 넘어감 -->
		 				</c:if>
					</div>
					<table border="1">
						<tr>
							<td><input type="text" name="boardTitle" placeholder="제목을 입력해주세요."></td>
						</tr>
						<tr>
							<td>
								<textarea id="boardContent" name="boardContent" rows="4" cols="50">
								</textarea>
							</td>
						</tr>
						<tr>
							<td>
								<input type="file" name="multipartFile" id="fileInput">
								<button type="button" id="removeBtn">파일 삭제</button>
								(3MB 이하의 이미지 파일만 첨부 가능합니다.)<br>
								<img id="previewImage" src="" style="max-width: 300px; max-height: 300px;">
							
							</td>
						</tr>
					</table>
					<button type="submit">게시글 등록</button>
				</form>
		</div>
	</div>
</html>