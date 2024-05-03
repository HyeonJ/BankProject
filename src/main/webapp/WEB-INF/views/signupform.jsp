<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<style>

.image-container {
        width: 150px;
        height: 150px;
        overflow: hidden;
        border-radius: 50%;
        display: inline-block;
        
    }
   .profile-img {
       width: 100%;
       height: 10s0%;
       object-fit: cover; /* 중요 부분을 보여주며 주변을 잘라냄 */
   }

.terms {
	max-height: 600px; /* 최대 높이 설정 */
	overflow-y: auto; /* 세로 스크롤바가 필요할 때만 표시 */
	margin: 50px 0; /* 상하 마진으로 여백 제공 */
	padding: 0 50px; /* 패딩으로 내용과 경계 간 간격 제공 */
	border: 1px solid #ccc; /* 경계선 스타일 */
	background-color: #f9f9f9; /* 배경색 */
}

.modal-content {
	background-color: #fefefe;
	margin: 5% auto; /* 5% margin from the top */
	padding: 20px; /* 모든 내부 측면에 20px 패딩 추가 */
	border: 1px solid #888;
	width: 50%; /* Adjust container width */
	height: auto; /* Adjust height as needed */
	overflow: hidden; /* 내용이 넘칠 경우 숨김 */
}

/* 체크박스 크기 조정 */
#agreeCheckbox {
	transform: scale(1.5); /* 체크박스 크기 1.5배 확대 */
	margin-right: 10px; /* 텍스트와의 간격 */
}

/* 레이블 텍스트 크기 조정 */
label {
	font-size: 16px; /* 텍스트 크기를 16px로 설정 */
	display: inline-block; /* 인라인 블록 요소로 설정하여 transform 영향 받지 않도록 */
	vertical-align: middle; /* 체크박스와 텍스트 수직 중앙 정렬 */
}
</style>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">



<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<%@ include file="../fix/header.jsp"%>
	<div class="page-section" style="min-height: 500px">
		<div
			class="container d-flex justify-content-center align-items-center "
			style="margin-top: 5px;">
			<div class="col-md-4">
				<h6>
					<b>회원가입</b>
				</h6>
				<hr>

				<form action="#" method="post" enctype="multipart/form-data"
					accept-charset="UTF-8">
					<div class="profileContainer">
						<div class="row py-3" >
							<div class="col d-flex justify-content-center my-3 text-center">
							<div class="image-container" >
								<img src="resources/images/user.png" 
									class="profile-img" alt="defaultPhoto"
									id="profileImage">
								</div>
									
							</div>
						</div>

						<div class="mb-3">
							<input type="file"
								class="form-control form-control-sm fileSection" id="file"
								name="file" accept=".jpg, .jpeg, .png">
							<!-- 파일 선택을 위한 인풋 -->
						</div>
						<!-- <input type="button" id="uploadButton" name="uploadButton">(.img/.png/.jpg) -->
						<!-- <input type="file" class="btn btn-outline-primary" id="file" name="file" accept=".jpg, .jpeg, .png"> 파일 선택을 위한 인풋 -->
						<!-- <label for="file">사진 업로드</label> -->
						<!-- 인풋에 대한 레이블 -->
					</div>
					<!-- 
					<div class="row">
						<div class="col-8">
							<label for="txtEmail" class="form-label">이메일 </label> <input
								id="txtEmail" type="email" class="form-control" name="email"
								required />
						</div>
						<div class="col-4">
							<div>&nbsp;</div>
							<div>
								<button type="button" class="btn btn-sm btn-outline-primary"
									name="checkButton" id="emailcheckButton">중복확인</button>
							</div>
						</div>
					</div>
					 -->
					 
					<div class="row">
					<label for="" class="form-label">이메일 </label>
						<div class="col-8">
							<input type="email" class="form-control" name="email" required />
						</div>
						<div class="col-4">
							<button type="button" class="btn btn-sm btn-outline-primary px-10" name="checkButton" id="emailcheckButton">중복확인</button>
						</div>
					</div>

					<div class="row">
							<label for="" class="form-label">핸드폰번호 </label>
						<div class="col-8">
								<input id="phoneNumber" type="text" class="form-control" name="phoneNumber"
									required>
						</div>
						<div class="col-4">
							<div>
								<button type="button" class="btn btn-sm btn-outline-primary"
									name="checkButton" id="phonecheckButton">중복확인</button>
							</div>
						</div>
					</div>
					<div>
						<div>비밀번호</div>
						<div>
							<input type="password" class="form-control" name="password"
								required>
						</div>
					</div>
					<div>
						<div>비밀번호확인</div>
						<div>
							<input type="password" class="form-control" name="passwordCheck"
								required>
						</div>
						<div id="passwordError" style="color: red;"></div>
						<!-- 여기에 오류 메시지를 표시 -->
					</div>
					<div>
						<div>이름</div>
						<div>
							<input type="text" class="form-control" name="name" required>
						</div>
					</div>
					<div>
						<div>주소</div>
						<div>
							<input type="text" class="form-control" name="address" required>
						</div>
					</div>
					<div class="privacy-policy-group mb-3">
						<input type="checkbox" id="privacy-policy" required> <label
							for="privacy-policy">(필수) 개인정보취급방침 동의(<a href="#"
							id="privacyLink">보기</a>)
						</label>
					</div>
					<div class="mb-3 d-grid gap-2">
						<button type="submit" class="btn btn-primary" id="submitButton"
							name="submitButton" disabled>저장</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="../fix/footer.jsp"%>

	<!-- 모달 창 -->
	<div id="termsModal" class="modal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<span class="close">&times;</span>
				<p></p>
				<h2>이용 약관 동의</h2>
				<div class="container">

					<div class="terms">
						<p>전자뱅킹서비스 이용약관</p>
						<p>제1조 (목적)</p>
						<p>이 『전자뱅킹서비스 이용약관』(이하 "약관"이라 함)은 전자금융거래 기본약관에 근거하여 서비스의 제공자인
							우리은행(이하 "은행"이라 함)과 이용자간에 전자뱅킹 등의 서비스(이하 “서비스”라 함)이용에 관한 제반 사항을
							정함을 목적으로 합니다.</p>
						<p>제2조 (서비스의 종류)</p>
						<p>① 은행에서 제공하는 서비스는 전자뱅킹서비스(인터넷뱅킹, 스마트뱅킹 등), SCRAPING서비스, 기타
							서비스 등이며, 구체적인 서비스 종류는 제3조의 이용매체를 통하여 안내합니다.</p>
						<p>② 인터넷뱅킹이라 함은 PC 등 인터넷이 가능한 이용매체를 이용하여 계좌조회, 이체 등의 은행업무를 이용할
							수 있는 서비스를 말합니다.</p>
						<p>➂ 스마트뱅킹이라 함은 모바일기기(스마트폰, 태블릿PC 등 포함)를 통하여 계좌조회, 이체 등의 은행업무를
							이용할 수 있는 서비스를 말합니다.</p>
						<p>➃ 모바일ATM 현금출금 서비스란 스마트뱅킹에서 인증번호를 생성하고, 생성된 인증번호를 자동화기기에
							입력함으로써 현금출금 및 이체가 가능한 서비스를 말합니다.</p>
						<p>➄ 모바일창구거래서비스란 실물통장 없이 스마트뱅킹을 통해 영업점 창구에서 입·지급 등 창구거래가 가능한
							서비스를 말합니다.</p>
						<p>➅ SCRAPING서비스라 함은 고객이 사용하는 각 금융기관의 인터넷 접근매체 정보를 이용하여 고객의
							금융기관 계좌를 한화면에서 조회 및 관리 할 수 있는 서비스를 말합니다.</p>
						<p>제 3 조(서비스 이용매체)</p>
						<p>이용자는 개인용컴퓨터(PC), TV, 스마트폰, 태블릿PC 등 "전자적 장치"로 서비스를 이용할 수
							있습니다.</p>
						<p>제4조 (서비스의 이용 신청 및 해지)</p>
						<p>① 다음 각 호의 어느 하나에 해당하는 경우 이용계약이 성립됩니다.</p>
						<p>1. 이용자가 전자금융 이용신청서(이하 "신청서"라 함)를 작성하여 제출하고 은행이 이를 승낙한 후
							이용자가 직접 각종 비밀번호를 입력한 경우</p>
						<p>2. 이용자가 직접 전자뱅킹서비스에 접속하여 본 약관을 확인 한 후 동의한 경우. 단, 이 경우 제한된
							서비스만 이용할 수 있으며, 구체적인 서비스 종류는 이용매체를 통하여 안내합니다.</p>
						<p>3. 기타 은행이 정한 별도의 방법으로 신청한 경우</p>
						<p>② 이용자는 이용 업무에 따라 별도의 약정 또는 약관 동의가 필요한 경우에는 별도의 개별약정을 체결하거나
							약관동의를 하셔야 합니다.</p>
						<p>③ 기업이용자(개인사업자, 법인사업자)는 인터넷뱅킹서비스를 가입하셔야 그 밖의 서비스 이용이 가능합니다.</p>
						<p>④ 이용자가 제①항의 서비스 이용을 중단하고자 할 경우에는 신청서에 의하여 해지 신청을 하셔야 합니다.
							다만, 개인고객의 경우 이용매체를 통하여 직접 해지할 수 있습니다.</p>
						<p>제 5 조(본인 확인방법)</p>
						<p>은행은 이용자가 서비스 이용시마다 서비스 종류별로 은행이 요구하는 해당 항목을 이용자가 입력했을 때 동
							내용이 은행에 등록된 것과 일치할 경우 본인으로 간주하여 서비스를 제공합니다.</p>
						<p>1. 전자뱅킹 : 이용자 ID, 이용자비밀번호, 계좌비밀번호, 자금이체비밀번호, 보안카드 비밀번호,
							OTP발생기비밀번호, 은행이 정한 인증서 암호, 생체인증, 디지털OTP 인증번호, PIN번호 등</p>
						<p>2. 기타서비스 : 이용자 ID, 이용자비밀번호, 은행이 정한 인증서 암호, 서비스별 비밀번호 등</p>
						<p>제6조 (서비스 이용수수료)</p>
						<p>① 서비스 이용수수료는 별표1)에서 정한 바에 따르며, 별도 계약을 통해 수수료를 정한 경우는 별도 계약에
							따른다.</p>
						<p>② 수수료는 서비스의 실행과 동시에 또는 당월 중 실제 발생된 건수를 기준으로 은행이 지정한 날(익월
							10일) 또는 이용자와 협의하여 별도로 지정한 날에 이용자의 출금계좌에서 자동 출금합니다.</p>
						<p>제7조 (계좌의 개설과 해지)</p>
						<p>① 이용자가 서비스를 이용하여 계좌의 신규개설을 신청하는 경우 지정한 출금계좌에서 출금하여 본인명의의
							계좌를 신규 개설할 수 있습니다.</p>
						<p>② 제①항에서 개설한 계좌를 영업점에서 최초로 출금 또는 해지하실 경우에는 실명확인 절 차를 거친 후에만
							가능합니다.</p>
						<p>③ 전자뱅킹을 이용한 출금 또는 해지는 제②항의 절차 없이도 가능하나, 출금 또는 해지된 자금은 은행에
							개설된 본인명의의 실명확인된 계좌로만 이체가 가능합니다.</p>
						<p>④ 신규개설이 가능한 예금, 적금 및 신탁의 종류는 은행에서 정한 바에 따르기로 합니다.</p>
						<p>제8조 (출금계좌 및 입금계좌)</p>
						<p>① 출금계좌는 입출금이 자유로운 본인명의의 원화 및 외화예금 중에서 지정하실 수 있습니다. 다만, 일부
							서비스의 경우 이용계좌의 종류가 제한될 수 있습니다.</p>
						<p>② 자금이체 입금계좌는 이용자가 지정여부를 선택할 수 있으며, 입금계좌를 지정한 경우 미 지정계좌로는
							입금되지 않거나, 금액이 제한될 수 있습니다.</p>
						<p>제9조 (자금이체 한도)</p>
						<p>① 이용자의 이체한도는 개인 1회 1억원, 1일 5억원 이내, 기업은 1회 10억원, 1일 50억원
							이내에서 설정하여야 합니다. 단, 기타 세부사항은 은행이 정하는 바에 따르며, 은행 홈페이지에 공시하기로 합니다.</p>
						<p>② 이용자는 제1항에서 지정된 이체한도 내에서 거래할 수 있으며, 은행에서 정한 한도를 초과하여 지정할
							경우 별도의 계약을 통해 추가 약정할 수 있습니다. 단, 예금신규가입, 대출상환, 예금의 해지, 은행의 이자지급 등
							은행에서 지정한 일부 서비스는 거래한도에 포함되지 않습니다.</p>
						<p>③ 이체한도의 감액은 전자적 장치를 통하여 할 수 있으나, 이체한도의 증액은 영업점을 방문하여 신청하여야
							합니다.</p>
						<p>제10조 (SCRAPING 서비스 이용)</p>
						<p>① 이용절차</p>
						<p>1. 이용자는 자금관리업무를 처리할 수 있도록 “은행” 및 타행에 개설된 이용자의 계좌에 대하여 인터넷뱅킹
							신청 등의 필요한 조치를 합니다.</p>
						<p>2. 이용자는 “은행”이 제공한 Scraping 프로그램을 이용하여 “은행”과 타행에 개설된 이용자의
							계좌에 대해 필요한 전산등록을 합니다.</p>
						<p>② 책임과 면책</p>
						<p>1. 집금, 조회하려는 해당은행의 인터넷뱅킹시스템 장애 등으로 해당은행 계좌에 대한 자금관리업무를 처리하지
							못할 경우 이용자는 이용자의 책임아래 필요한 조치를 취합니다. 이러한 경우 “은행”의 귀책사유가 아니므로 “은행”은
							면책됩니다.</p>
						<p>2. 본서비스 이용을 위해 등록한 타행인터넷뱅킹 관련 제반정보는 이용자가 보호․관리하며, 은행은
							Scraping 서비스의 접속권한 관련 사항 외는 책임을 지지 아니합니다.</p>
						<p>3. “은행”이 이 서비스를 제공함에 있어서 집금 모계좌가 법적 또는 기타의 사유로 거래가 제한되었을 때는
							서비스를 처리하지 않기로 합니다.</p>
						<p>제11조 (서비스의 제한)</p>
						<p>① 은행은 다음과 같은 경우 서비스를 제한할 수 있으며, 거래제한시 거래처의 거래지시가 있을 때 해당
							전자적 장치를 통하여 그 사유를 즉시 알려드립니다.</p>
						<p>1. 본인확인을 위한 입력사항을 3회 연속하여 잘못 입력했을 때. 다만, 계좌비밀번호의 경우 연속 5회,
							OTP발생기 비밀번호의 경우 연속 10회(전 금융기관 통합), 생체인증시 연속 5회, PIN번호 연속 5회,
							디지털OTP 앱 비밀번호 연속 10회(전 금융기관 통합), 디지털OTP 인증번호 연속 5회 잘못 입력했을 때</p>
						<p>2. 후불수수료의 납부가 연체되었을 때</p>
						<p>② 제①항 제1호의 경우, 본인이 영업점에 오류해제 신청 후 서비스를 다시 이용할 수 있습니다. 다만,
							개인고객의 전자뱅킹 이용자비밀번호 오류해제는 전자뱅킹에서 정확한 이용자비밀번호를 입력하고 본인확인 후 해제할 수
							있으며, 생체인증 및 PIN번호 오류해제는 전자적 장치에 접속하여 본인확인 후 재등록하여 이용할 수 있습니다.</p>
						<p>제12조 (거래내역 확인)</p>
						<p>자금이체, 해외송금 및 기타거래에 관한 거래내역이 필요한 경우 은행 영업점에 발급을 요청하실 수 있으며,
							이용자는 수시로 잔액조회 및 통장정리를 통하여 거래의 이상 유무 등을 확인해야 합니다.</p>
						<p>제13조 (비밀번호의 관리)</p>
						<p>① 이용자는 각종 비밀번호의 누출을 방지하기 위해 언제라도 직접 제3조의 서비스 이용매체를 통해 변경할 수
							있습니다.</p>
						<p>② 각종 비밀번호의 조회나 확인은 불가능하며 보안카드의 분실, 도난 또는 각종 비밀번호의 누설 등 사고
							발생시에는 곧 거래 영업점으로 서면으로 신고해야 합니다. 그러나 긴급하거나 부득이할 때에는 영업시간 중에 전화 등으로
							신고할 수 있으며 이 때에는 다음 영업일 안에 서면으로 신고해야 합니다.</p>
						<p>제 14 조(서비스별 이용시간)</p>
						<p>서비스별 이용시간은 은행 홈페이지를 통해 안내합니다.</p>
						<p>제15조(외환매매 및 해외송금 한도)</p>
						<p>외환매매 및 해외송금한도는 은행 홈페이지를 통해 안내합니다.</p>
						<p>제 16 조(손해배상 및 면책)</p>
						<p>① 은행은 이용자로부터 접근매체의 분실이나 도난의 통지를 받은 후에 제3자가 그 접근매체를 사용하여
							이용자에게 손해가 발생한 경우 그 손해를 배상합니다.</p>
						<p>② 은행은 다음 각 호의 하나에 해당하는 사고로 인하여 이용자에게 손해가 발생한 경우 그 손해를
							배상합니다.</p>
						<p>1. 접근매체의 위조나 변조로 발생한 사고</p>
						<p>2. 계약체결 또는 거래지시의 전자적 전송이나 처리과정에서 발생한 사고</p>
						<p>3. 전자금융거래를 위한 전자적 장치 또는 ⌜정보통신망 이용촉진 및 정보보호 등에 관한 법률⌟ 제2조
							제1항 제1호에 따른 은행의 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한
							사고</p>
						<p>③ 제1항 및 제2항에 의하여 금전적 손해가 발생한 경우 해당 금액 및 이에 대한 1년 만기 정기예금
							이율로 계산한 경과이자를 배상한다. 다만, 손해액이 해당 금액과 1년 만기 정기예금 이율로 계산한 금액을 초과하는
							경우에는 실손해액을 배상합니다.</p>
						<p>④ 제2항의 규정에도 불구하고 은행은 이용자가 고의 또는 중과실로 다음 각호의 행위를 하였음을 증명하는
							경우 은행의 고의 또는 과실이 없는 경우에는 이용자에게 손해가 생기더라도 책임의 전부 또는 일부를 지지 아니합니다.</p>
						<p>1. 이용자가 접근매체를 제3자에게 대여하거나 사용을 위임한 경우 또는 양도나 담보의 목적으로 제공한
							경우(⌜전자금융거래법⌟제18조에 따라 선불전자지급수단이나 전자화폐를 양도하거나 담보로 제공한 경우를 제외합니다.)</p>
						<p>2. 제3자가 권한 없이 이용자의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 쉽게 알 수
							있었음에도 불구하고 이용자가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우</p>
						<p>3. 은행이 접근매체를 통하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인하는 것외에 보안강화를
							위하여 전자금융거래 시 사전에 요구하는 추가적인 보안조치를 이용자가 정당한 사유 없이 거부하여 사고가 발생한 경우</p>
						<p>4. 이용자가 제3호에 따른 추가적인 보안조치에 사용되는 매체‧수단 또는 정보에 대하여 다음 각 목의 어느
							하나에 해당하는 행위를 하여 사고가 발생한 경우</p>
						<p>가. 누설‧노출 또는 방치한 행위</p>
						<p>나. 제3자에게 대여하거나 그 사용을 위임한 행위 또는 양도나 담보의 목적으로 제공한 행위</p>
						<p>5. 법인(「중소기업기본법」제2조 제2항에 의한 소기업을 제외합니다.)인 이용자에게 손해가 발생한 경우로
							은행이 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한
							경우</p>
						<p>제17조(관할법원)</p>
						<p>① 서비스 이용과 관련하여 은행과 고객 사이에 분쟁이 발생한 경우, 은행과 고객은 분쟁의 해결을 위해
							성실히 협의합니다.</p>
						<p>② 제1항의 협의에서도 분쟁이 해결되지 않아 소송이 제기되는 경우, 관할법원은 민사소송법에서 정한 바에
							따르기로 합니다.</p>
						<p>제18조 (약관변경)</p>
						<p>전자뱅킹서비스 이용약관의 변경은 전자금융거래 기본약관 제29조에 따릅니다.</p>
						<p>제19조 (약관의 적용)</p>
						<p>① 이 약관에서 정하지 아니한 사항은 전자금융거래법 및 관계법령, 전자금융거래 기본약관, 예금거래기본약관
							및 은행여신거래기본약관(가계용/기업용), 외환거래 기본약관, 각 예금(신탁포함)별 약관, 기타 개별 거래약관 및
							약정서, 금융결제원 제규약 등에 따르기로 합니다. ② 이 약관에서 정한 전자뱅킹 이용관련 사항에 관해 다른 약관에서
							달리 정하고 있는 경우에는 이 약관이 우선 적용됩니다.</p>
					</div>
					<form>
						<label> <input type="checkbox" id="agreeCheckbox"
							style="transform: scale(1.5); margin-right: 10px;"> 약관에
							동의합니다.
						</label>
						<button type="button" class="btn btn-primary" id="agreeSubmit">제출</button>
					</form>
				</div>
				<input type="hidden" name="resultEmail" value="false"> <input
					type="hidden" name="resultPhoneNumber" value="false">
					<input type="hidden" name="resultAgree" id="resultAgree" value="false">
			</div>
		</div>
	</div>

	<script>
        // 모달 요소와 버튼 요소들을 변수에 할당합니다.
        var modal = document.getElementById('termsModal');
        var btn = document.getElementById('privacyLink');
        var span = document.getElementsByClassName("close")[0];
        var submitBtn = document.getElementById('submitButton');
        var agreeBtn = document.getElementById('agreeSubmit');
     // 현인: privacy checkbox와 resultAgree hidden input
        var privacyCheck = document.getElementById('privacy-policy');
        var resultAgree = document.getElementById('resultAgree');

        // 개인정보취급방침 보기 버튼을 클릭했을 때 모달을 표시합니다.
        btn.onclick = function() {
            modal.style.display = "block";
        }

        // 모달 닫기 버튼을 클릭했을 때 모달을 숨깁니다.
        span.onclick = function() {
            modal.style.display = "none";
        }

        // 모달 외부를 클릭했을 때 모달을 숨깁니다.
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        
     // 현인: privacy checkbox 클릭 시 modal을 보여줌
        privacyCheck.onclick = function(event) {
        	if(resultAgree.value === "false") {
	        	event.preventDefault();
	        	modal.style.display = "block";
        	}
        }

        // 동의 버튼을 클릭했을 때 약관에 동의한 경우 저장 버튼을 활성화하고 모달을 숨깁니다.
        agreeBtn.onclick = function() {
            if(document.getElementById('agreeCheckbox').checked) {
                submitBtn.disabled = false;
                modal.style.display = "none";
                resultAgree.value = "true";
                privacyCheck.checked = true;
            } else {
                alert("약관에 동의해주세요.");
            }
        };
    	
            
        // 문서가 준비되면 이메일 중복 확인 버튼에 대한 이벤트 리스너를 등록합니다.
        $(document).ready(function(){
            // 이메일 중복 확인 버튼을 클릭했을 때 중복 확인 함수를 호출합니다.
            $('#emailcheckButton').click(function(){
                checkEmailDuplicates();
            });

            // 핸드폰 번호 중복 확인 버튼을 클릭했을 때 중복 확인 함수를 호출합니다.
            $('#phonecheckButton').click(function(){
                checkPhoneDuplicates();
            });
        });

     // 이메일 중복 확인 함수
        function checkEmailDuplicates() {
            var email = $('input[name="email"]').val();
            
            var isEmail = emailCheck(email);
            console.log("isEmail?"+isEmail);
            if (isEmail == 1) {
            $.ajax({
            	// Context root 수정으로 인해 '/bank' 제거
                url: '/api/user/validate/email?email=' + email,
                type: 'POST',
                success: function(emailData) {
                    console.log(emailData);
                    if(emailData.result == "success") {
                       swal({
                         title: "",
                         text: "이메일을 사용하실 수 있습니다.",
                         type: "success",
                         confirmButtonText: "확인"
                      });
                       
                    } else {
                       swal({
                        title: "",
                        text: "입력하신 이메일을 사용하실 수 없습니다.",
                        type: "warning",
                        confirmButtonText: "확인"
                     });
                    }
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                },
                complete: function() {
                    enableSubmitButton();
                }
            });
        
        
     } else {
    	 swal({
    	      icon: 'warning',
    	      title: '이메일 형식을 확인하세요',
    	      text: 'example@email.com',
    	    });
     };
     }
        // Email 형식 확인 함수(중복확인 전 return)
        function emailCheck(email_address){		
    		email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
    		if(!email_regex.test(email_address)){ 
    			return false; 
    		}else{
    			return true;
    		}
    	}

        // 핸드폰 번호 중복 확인 함수
        function checkPhoneDuplicates() {
            var phoneNumber = $('input[name="phoneNumber"]').val();
            $.ajax({
            	// Context root 수정으로 인해 '/bank' 제거
                url: '/api/user/validate/phone?phoneNumber=' + phoneNumber,
                type: 'POST',
                success: function(phoneData) {
                    console.log(phoneData);
                    if(phoneData.result == "success") {
                       swal({
                         title: "",
                         text: "입력하신 핸드폰 번호는 사용가능합니다.",
                         type: "success",
                         confirmButtonText: "확인"
                      });
                    
                       
                    } else {
                       swal({
                        title: "",
                        text: "입력하신 핸드폰 번호는 사용하실 수 없습니다.",
                        type: "warning",
                        confirmButtonText: "확인"
                     });
                    }
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                },
                complete: function() {
                    enableSubmitButton();
                }
            });
        }
        // 저장 버튼 활성화 함수
        function enableSubmitButton() {
            if($('input[name="resultEmail"]').val() == "true" && $('input[name="resultPhoneNumber"]').val() == "true") {
                $('#submitButton').prop('disabled', false);
            }
        }
        
     // 이미지 업로드와 관련된 스크립트
        document.getElementById('file').addEventListener('change', function(event) {
            if (event.target.files && event.target.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    document.getElementById('profileImage').src = e.target.result; // 이미지 미리보기
                };

                reader.readAsDataURL(event.target.files[0]); // 파일을 읽어 버퍼에 저장
            }
        });
     

/*         // 비밀번호 입력란과 비밀번호 확인 입력란에 이벤트 리스너 추가
        document.getElementsByName('password')[0].addEventListener('keyup', validatePasswords);
        document.getElementsByName('passwordCheck')[0].addEventListener('keyup', validatePasswords);
 */
/* 	 function validatePasswords() {
		    var password = document.getElementsByName('password')[0].value;
		    var passwordCheck = document.getElementsByName('passwordCheck')[0].value;
		    var passwordError = document.getElementById('passwordError');
	
		    if (password !== passwordCheck) {
		        passwordError.textContent = "비밀번호가 일치하지 않습니다.";
		        submitBtn.disabled = true; // 저장 버튼 비활성화
		    } else {
		        passwordError.textContent = ""; // 오류 메시지 제거
		        submitBtn.disabled = false; // 저장 버튼 활성화
		    }
		}
	
		// 비밀번호 입력란과 비밀번호 확인 입력란에 이벤트 리스너 추가
		document.getElementsByName('password')[0].addEventListener('keyup', validatePasswords);
		document.getElementsByName('passwordCheck')[0].addEventListener('keyup', validatePasswords); */
/*
		function validatePasswords() {
		    var password = document.getElementsByName('password')[0].value;
		    var passwordCheck = document.getElementsByName('passwordCheck')[0].value;
		    var passwordError = document.getElementById('passwordError');

		    // 비밀번호와 비밀번호 확인 필드 모두 입력되었는지 확인
		    if (password.length > 0 && passwordCheck.length > 0) {
		        if (password !== passwordCheck) {
		            passwordError.textContent = "비밀번호가 일치하지 않습니다.";
		            submitBtn.disabled = true; // 저장 버튼 비활성화
		        } else {
		            passwordError.textContent = ""; // 오류 메시지 제거
		            submitBtn.disabled = false; // 저장 버튼 활성화
		        }
		    } else {
		        passwordError.textContent = ""; // 필드 중 하나라도 비어있다면 메시지 제거
		    }
		}
*/
		// 비밀번호 확인 필드에 이벤트 리스너 추가
		document.getElementsByName('passwordCheck')[0].addEventListener('keyup', validatePasswords);

	    function validatePasswords() {
	        var password = document.getElementsByName('password')[0].value;
	        var passwordCheck = document.getElementsByName('passwordCheck')[0].value;
	        var passwordError = document.getElementById('passwordError');
	        var email = $('input[name="email"]').val();
	        var phoneNumber = $('input[name="phoneNumber"]').val();
	        var name = $('input[name="name"]').val();
	        
	        // 비밀번호 복잡성 검증 정규식
	        var regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/; // 최소 6자리, 하나 이상의 문자 및 숫자

	        // 모든 검증 로직을 하나의 if-else 체인으로 통합
	        if (!regex.test(password)) {
	            passwordError.textContent = "비밀번호는 영문과 숫자를 포함한 6자리 이상으로 설정해야 합니다.";
	            submitBtn.disabled = true;
	        } else if (password === email || password === phoneNumber || password === name) {
	            passwordError.textContent = "비밀번호는 이메일, 핸드폰 번호, 이름과 같을 수 없습니다.";
	            submitBtn.disabled = true;
	        } else if (password !== passwordCheck) {
	            passwordError.textContent = "비밀번호가 일치하지 않습니다.";
	            submitBtn.disabled = true;
	        } else {
	            passwordError.textContent = "";
	            submitBtn.disabled = false; // 모든 검증 통과 시 버튼 활성화
	        }
	    }

	    // 이벤트 리스너 연결
	    document.getElementsByName('password')[0].addEventListener('keyup', validatePasswords);
	    document.getElementsByName('passwordCheck')[0].addEventListener('keyup', validatePasswords);
   
		// 파일 업로드시 미리보기
	      $("#file").change(function() {
	    	// Context root 수정으로 인해 '/bank' 제거
	         $("#file").attr("src", "/profile/file/${profileId}");
	      });
	     
	      // 핸드폰 번호 입력시 자동으로 하이픈 추가
	      $("#phoneNumber").on("propertychange change keyup paste input", function(e) {
	         var x = e.target.value;
	          e.target.value = phoneNumber(x);
	         });
	      
	      function phoneNumber(value) {
	           if (!value) {
	             return "";
	           }

	           value = value.replace(/[^0-9]/g, "");

	           let result = [];
	           let restNumber = "";

	           // 지역번호와 나머지 번호로 나누기
	           if (value.startsWith("02")) {
	             // 서울 02 지역번호
	             result.push(value.substr(0, 2));
	             restNumber = value.substring(2);
	           } else if (value.startsWith("1")) {
	             // 지역 번호가 없는 경우
	             // 1xxx-yyyy
	             restNumber = value;
	           } else {
	             // 나머지 3자리 지역번호
	             // 0xx-yyyy-zzzz
	             result.push(value.substr(0, 3));
	             restNumber = value.substring(3);
	           }

	           if (restNumber.length === 7) {
	             // 7자리만 남았을 때는 xxx-yyyy
	             result.push(restNumber.substring(0, 3));
	             result.push(restNumber.substring(3));
	           } else {
	             result.push(restNumber.substring(0, 4));
	             result.push(restNumber.substring(4));
	           }

	           return result.filter((val) => val).join("-");
	         }
	      
	      
     
     
    </script>

</body>
</html>