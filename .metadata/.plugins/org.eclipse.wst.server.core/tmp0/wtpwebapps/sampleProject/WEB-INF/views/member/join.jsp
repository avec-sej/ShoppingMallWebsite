<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join Us</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">
</script>
</head>
<body>
	<div class="wrapper">
		<form id="join_form" method="post">
		<div class="wrap">
				<div class="subjecet">
					<span>Join Us</span>
				</div>
				<div class="id_wrap">
					<div class="id_name">ID</div>
					<div class="id_input_box">
						<input class="id_input" name="memberId">
					</div>
					<span class="id_input_can">You can use this account.</span>
					<span class="id_input_cannot">This account already exists.</span>
					<span class="id_required">Id required</span>
				</div>
				<div class="pw_wrap">
					<div class="pw_name">Password</div>
					<div class="pw_input_box">
						<input class="pw_input"  name="memberPw">
					</div>
					<span class="pw_required">Password required</span>
				</div>
				<div class="pwck_wrap">
					<div class="pwck_name">Password Check</div>
					<div class="pwck_input_box">
						<input class="pwck_input">
					</div>
					<span class="pwck_input_match">The password matches</span>
					<span class="pwck_input_notMatch">The password does not match</span>
				</div>
				<div class="user_wrap">
					<div class="user_name">Name</div>
					<div class="user_input_box">
						<input class="user_input" name="memberName">
					</div>
					<span class="name_required">Name required</span>
				</div>
				<div class="mail_wrap">
					<div class="mail_name">Email</div> 
					<div class="mail_input_box">
						<input class="mail_input" name="memberMail">
					</div>
					<div class="mail_check_wrap">
						<div class="mail_check_input_box">
							<input class="mail_check_input">
						</div>
						<div class="mail_check_button">
							<span>Send a Code</span>
						</div>
						<div class="clearfix"></div>
						<span class="mail_required">MailAccount required</span>
					</div>
				</div>
				<div class="address_wrap">
					<div class="address_name">Address</div>
					<div class="address_input_1_wrap">
						<div class="address_input_1_box">
							<input class="address_input_1" name="memberAddr1" readonly="readonly" placeholder="Zip Code">
						</div>
						<div class="address_button" onclick="findAddress()">
							<span>Find an address</span>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class ="address_input_2_wrap">
						<div class="address_input_2_box">
							<input class="address_input_2" name="memberAddr2" readonly="readonly" placeholder="Address">
						</div>
					</div>
					<div class ="address_input_3_wrap">
						<div class="address_input_3_box">
							<input class="address_input_3" name="memberAddr3" readonly="readonly" placeholder="DetailAddress">
						</div>
					</div>
					<span class="addr_required">Address required</span>
				</div>
				<div class="join_button_wrap">
					<input type="button" class="join_button" value="JOIN">
				</div>
			</div>
		</form>
	</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	/* validation variables */
	var idCk = false;			//아이디
	var idDoubleCk = false;		//아이디 중복
	var pwCk = false;		//비번
	var pwDoubleCk = false;		//비번 일치 확인
	var nameCk = false;			//이름
	var mailCk = false;			//메일
	var addrCk = false;			//주소
 	

	$(document).ready(function(){
		//회원가입 버튼(회원가입 기능 작동)
		$(".join_button").click(function(){
			var id = $('.id_input').val();
			var pw = $('.pw_input').val();
			var pwCk = $('.pwck_input').val();
			var name = $('.user_input').val();
			var mail = $('.mail_input').val();
			var addr = $('.address_input_3').val();
			
			//id 유효성검사
			if(id == ""){
				$('.id_required').css('display', 'block');
				idCk = false;
			}else{
				$('.id_required').css('display', 'none');
				idCk = true;
			}
			
			//password 유효성검사
			if(pw == ""){
				$('.pw_required').css('display', 'block');
				pwCk = false;
			}else{
				$('.pw_required').css('display', 'none');
				pwCk = true;
			}
			
			//password doubleCheck 유효성검사
			if(pwCk == ""){
				$('.pwck_input_notMatch').css('display', 'block');
				pwDoubleCk = false;
			}else{
				$('.pwck_input_notMatch').css('display', 'none');
				pwDoubleCk = true;
			}
			
			//name 유효성검사
			if(name == ""){
				$('.name_required').css('display', 'block');
				nameCk = false;
			}else{
				$('.name_required').css('display', 'none');
				nameCk = true;
			}
			
			//email 유효성검사
			if(mail == ""){
				$('.mail_required').css('display', 'block');
				mailCk = false;
			}else{
				$('.mail_required').css('display', 'none');
				mailCk = true;
			}
			
			//address 유효성검사
			if(addr == ""){
				$('.addr_required').css('display', 'block');
				addrCk = false;
			}else{
				$('.addr_required').css('display', 'none');
				addrCk = true;
			}
			
			//최종 검사
			if(idCk&&idDoubleCk&&pwCk&&pwDoubleCk&&nameCk&&mailCk&&addrCk){
				$("#join_form").attr("action", "/member/join");
				$("#join_form").submit();
			}
			return false;
			
		});
	});
	
	/* 아이디 중복검사 */
	$('.id_input').on("propertychange change keyup paste input", function(){
		
		var memberIdVar = $('.id_input').val();			// .id_input에 입력되는 값
		var dataVar = {memberId : memberIdVar}			// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
		
		$.ajax({
			type : "post",
			url : "/member/memberIdChk",
			data : dataVar,
			success : function(result){
				if(result != 'fail'){
					$('.id_input_can').css("display","inline-block");
					$('.id_input_cannot').css("display", "none");	
					idDoubleCk = true;
				} else {
					$('.id_input_cannot').css("display","inline-block");
					$('.id_input_can').css("display", "none");	
					idDoubleCk = false;
				}
			}// success 종료 
		}); // ajax 종료	

	});// function 종료

	
	/* Interlock Address */
	function findAddress(){
		new daum.Postcode({
			oncomplete: function(data){
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

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
                    //document.getElementById("sample6_extraAddress").value = extraAddr;
                    // 주소필드 + 참고항목필드 
                    addr += extraAddr;
                
                } else {
                    //document.getElementById("sample6_extraAddress").value = '';
                    //추가 항목 필드가 없기때문에 아무것도 입력되지 않게 하기 위해서
                    addr += " ";
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('sample6_postcode').value = data.zonecode;
                //document.getElementById("sample6_address").value = addr;
                $('.address_input_1').val(data.zonecode); // 우편번호
                $('.address_input_2').val(addr);		  // 주소
                
                // 커서를 상세주소 필드로 이동한다.
                //document.getElementById("sample6_detailAddress").focus();
                $('.address_input_3').attr("readonly", false);
                $('.address_input_3').focus();
           
			}
		}).open();
	}
	
	/* passord matching 검사 */
	$('.pwck_input').on("propertychange change keyup paste input", function(){
		var pw = $('.pw_input').val();
		var pwCk = $('.pwck_input').val();
		if(pw == pwCk){
			$('.pwck_input_match').css('display', 'block');
			$('.pwck_input_notMatch').css('display', 'none');
			pwDoubleCk = true;
		}else{
			$('.pwck_input_match').css('display', 'none');
			$('.pwck_input_notMatch').css('display', 'block');
			pwDoubleCk = false;
		}
	});
	
</script>

</body>
</html>