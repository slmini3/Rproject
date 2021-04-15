<%@page contentType="text/html; charset=UTF-8" %>
<html>
	<head>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script type="text/javascript">
		
			
			function post(){
				if(!checkAll()){
					return false;
				}else{
					inForm.action ="resultpost";
					inForm.method = "post";
					inForm.submit();
				}
			}

			function checkAll() {
				if (!checkIdPw(inForm.id.value, inForm.password.value, inForm.passwordConf.value)) {
					return false;
				} else if (!checkName(inForm.name.value)) {
					return false;
				} else if (!checkEmail(inForm.email.value)) {
					return false;
                } else if (!checkPn(inForm.identity.value)) {
                    return false;
                }  else if (!isExist(inForm.bYear.value, "생년월일을 ")) {
					return false;
                } else if (!isExist(inForm.bMonth.value, "생년월일을 ")) {
                    return false;
                } else if (!isExist(inForm.bDate.value, "생년월일을 ")) {
					return false;
				} else if (!checkInterest()) {a
					return false;
                } else if (!isExist(inForm.introduce.value, "자기소개를 ")) {
					return false;
                } else if(!isExist(inForm.zipNo.value, "우편번호를")){
					return false;
				} else if(!isExist(inForm.addr1.value, "도로명주소를")){
					return false;
				} else if(!isExist(inForm.addr2.value, "상세주소를")){
					return false;
				}
                else return true;
			}
			function isExist(value, data) {	//데이터가 비어있는지 검사하는 함수
				if (value == "") {
					alert(data + " 입력해 주세요");
					return false;
				} 
                else return true;
            }
			function checkIdPw(id, pw, pwconf) {	//아이디, 비밀번호, 비밀번호 확인 검사하는 함수
				var idPwRegExp=/^[a-zA-Z0-9]{4,12}$/;
				if (!isExist(id, "아이디를")) {
					return false;
				} else if (!isExist(pw, "비밀번호를")) {
					return false;
				} else if (!idPwRegExp.test(id)) {
					alert("아이디를 4~12자의 영문 대소문자와 숫자로만 입력하세요");
					return false;
				} else if (!idPwRegExp.test(pw)) {
					alert("비밀번호를 4~12자의 영문 대소문자와 숫자로만 입력하세요");
					return false;
				} else if (id == pw) {
					alert("아이디와 비밀번호는 같을 수 없습니다.");
					return false;
				} else if (pw != pwconf) {
					alert("비밀번호를 확인하세요");
					return false;
				} 
                else return true;
			}

			function checkEmail(email) {
				var emailRegExp = /^[a-zA-Z0-9]+[@]{1}[a-zA-Z0-9]+[.]{1}[a-zA-Z]{2,3}$/;
				if (!isExist(email, "이메일을 ")) {
					return false;
				} else if (!emailRegExp.test(email)) {
					alert("이메일 형식을 확인하세요");
					return false;
				} else return true;
            }
			function checkName(name) {
                var nameRegExp = /^[가-힣]{2,4}$/;
				if (!isExist(name, "이름을")) {
					return false;
				} else if (!nameRegExp.test(name)) {
					alert("이름은 한글2~4자로 입력해주세요")
					return false;
                }
				else return true;
			}

            function goPopup() {
				new daum.Postcode({
					oncomplete: function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if(data.buildingName !== '' && data.apartment === 'Y'){
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if(extraRoadAddr !== ''){
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						inForm.zipNo.value = data.zonecode;
						inForm.addr1.value = roadAddr;
						
						inForm.addr2.focus();
					}
				}).open();
			}


			function checkPn(identity) {
				var pnRegExp = /^[0-9]{13}$/;
				var sum = 0;
                var plus = 2;
				
                for (var i = 0; i < 12; i++) {
					if (i >= 0 && i <= 7) {
						sum += identity[i] * plus;
                        plus++;
                        if (i == 7)
                            plus = 2;
                    } else {
                        sum += identity[i] * plus;
                        plus++;
                    }
				}
                var result = 11 - (sum % 11) % 10;
				if (!isExist(identity, "주민등록번호를")) {
					return false;
				} else if (!pnRegExp.test(identity)) {
					alert("주민등록번호는 13자리 숫자만 입력해주세요");
					return false;
                } else if (identity[6] != 1 && identity[6] != 2 && identity[6] != 3 && identity[6] != 4) { //주민번호 뒷자리 성별자리 검사
                    alert("주민등록 번호를 확인해주세요.");
                    return false;
                } else if (result != parseInt(identity.charAt(12))) { //주민등록번호가 유효하지 않은 경우
                    alert("유효하지않은 주민번호입니다.");
                    inForm.identity.value = "";
                    inForm.identity.focus();
                    return false;
                }
				else return true;
			}



			function putBirth(value) {

				if (value.charAt(6) == 1 || value.charAt(6) == 2) {//성별번호 1,2일경우 1900년대생 + 주민번호 1번째 2번째자리 숫자로 몇년생인지 지정
					inForm.bYear.value = "19" + value[0] + value[1];
                } else if (value.charAt(6) == 3 || value.charAt(6) == 4) {//성별번호 3,4일경우 2000년대생 + 주민번호 1번째 2번째자리 숫자로 몇년생인지 지정
                    inForm.bYear.value = "20" + value[0] + value[1];
				}
				inForm.bMonth.value = value[2] + value[3];	//form의 생년월일의 월부분의 날짜를 주민번호 3번째 4번째 자리숫자로 지정
                inForm.bDate.value = value[4] + value[5];	//form의 생년월일의 일부분의 날짜를 주민번호 5번째 6번째 자리숫자로 지정
			}

			function checkInterest() {
				var checkBox = inForm.interest;

				for (var i = 0; i < checkBox.length; i++) {
					if (checkBox[i].checked) {
						return true;
                    }
				}
				alert("관심분야를 1개이상 체크하세요");
				return false;
            }
		



		</script>
		<title>회원가입</title>
		<style>
			td{ border:1px solid #AADBFF;}
			table{ border:1px solid #AADBFF;}
   		</style>
	</head>
	<body>
		<FORM method="post" name="inForm">
			<table width="900" height="400" Cellspacing="0" align="center">

				<tr Align="center">
					<!--첫번째 줄 시작-->
					<td Colspan="2" bgcolor="#C8D7FF"><BIG>회원 기본 정보</BIG></td>
				</tr><!--첫번째 줄 끝-->

				<tr>
					<!--두번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF" >아이디 :</td>
					<td>
						<INPUT type="text" name="id" minlength="4" maxlength="12" />
						&nbsp<FONT color="gray">4~12자의 영문 대소문자와 숫자로만 입력</FONT>
					</td>
				</tr><!--두번째 줄 끝-->

				<tr>
					<!--세번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">비밀번호 :</td>
					<td>
						<INPUT type=password name="password" minlength="4" maxlength="12" />
						&nbsp<FONT color="gray">4~12자의 영문 대소문자와 숫자로만 입력</FONT>
					</td>
				</tr><!--세번째 줄 끝-->

				<tr>
					<!--네번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">비밀번호확인 :</td>
					<td><INPUT type=password name="passwordConf" minlength="4" maxlength="12"></td>
				</tr><!--네번째 줄 끝-->

				<tr>
					<!--다섯번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">메일주소 :</td>
					<td>
						<INPUT type="email" name="email" size="30">
						&nbsp<FONT color="gray">예) id@domain.com</FONT>
					</td>
				</tr><!--다섯번째 줄 끝-->

				<tr>
					<!--여섯번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">이름 :</td>
					<td><INPUT type="text" name="name" size="30"></td>
				</tr><!--여섯번째 줄 끝-->

				<tr align="center">
					<!--일곱번째 줄 시작-->
					<td colspan="2" bgcolor="#C8D7FF"><BIG>개인 신상 정보</BIG></td>
				</tr><!--일곱번째 줄 끝-->

				<tr>
					<th bgcolor="#DCEBFF">우편번호</th>
					<td>
						<input type="text" id="zipNo" name="zipNo" readonly style="width:100px">
						<input type="button" value="주소검색" onclick="goPopup()" >
					</td>
				</tr>
				<tr>
					<th bgcolor="#DCEBFF">도로명주소</th>
					<td><input type="text" id="addr1" name="addr1" style="width:85%"></td>
				</tr>
				<tr>
					<th bgcolor="#DCEBFF">상세주소</th>
					<td>
						<input type="text" id="addr2" name="addr2" style="width:40%" value="">
					</td>
				</tr>

				<tr>
					<!--여덟번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">주민등록번호</td>
					<td><input type="text" name="identity" maxlength="13" onchange="putBirth(this.value)"></td>
				</tr><!--여덟번째 줄 끝-->

				<tr>
					<!--아홉번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">생일 :</td>
					<td>
						<input type="text" name="bYear" maxlength="4" size="5">년
						<select name="bMonth">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>월
						<select name="bDate">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">12</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>일
					</td>
				</tr><!--아홉번째 줄 끝-->

				<tr>
					<!--열번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">관심분야 :</td>
					<td>
						<input type="checkbox" name="interest" value="컴퓨터">컴퓨터
						<input type="checkbox" name="interest" value="인터넷">인터넷
						<input type="checkbox" name="interest" value="여행">여행
						<input type="checkbox" name="interest" value="영화감상">영화감상
						<input type="checkbox" name="interest" value="음악감상">음악감상
					</td>
				</tr><!--열번째 줄 끝-->

				<tr>
					<!--열한번째 줄 시작-->
					<td Align="center" bgcolor="#DCEBFF">자기소개 :</td>
					<td>
						<TEXTAREA name="introduce" cols="90" rows="5"></TEXTAREA>
					</td>
				</tr><!--열한번째 줄 끝-->
				<tr align="center">
					<td colspan="2">
						<!-- <INPUT type="button" value="post" onclick="post();"> -->
						<button onclick="post();">회원가입</button>
						<!-- <INPUT type="button" value="get" onclick="get();"> -->
						<INPUT type="reset" value="다시 입력">
					</td>
				</tr>
			</table>
		
		</FORM>
	</body>
</html>
