
  /* obj       = 입력값이 들어 있는 Tag Element 
   * maxbyte   = 입력 byte값의 최대 범위
   * writeByte = 입력된 문자열 byte정보를 표시 할 TagId 정보 
   * num       = 숫자입력만 받는 검증시 num = not null */

function fnChkByte(obj, maxByte, writeByte, num){

	console.log("===========================start fnChkByte===========================");
	
	// 문자열 	
	var str = obj.value;
	console.log("파라미터로 받은 object의 value 값 str\n str :"+str);
	
	// 문자 갯수  ex) 김 => 1  , l =1  
	var str_len = str.length;
	console.log("파라미터로 받은 object의 value 값 str의 길이 \n str_len :"+str_len);

	
	//	****** 여기서부터 byte 계산 들어감 *********

	// 입력 받은 문자열의 총 바이트 합을 담아 둘 변수
	var rbyte = 0;
	//  입력 받은 문자열의 갯수를 담고 있는 변수
	var rlen = 0;
	// 검증을 통해 가능한 문자열을 담아둘 마지막 컨테이너
	var str2 = "";
	
   /*	test용 ex */
	var rbyte_ex = 0 ,
	    rlen_ex  = 0 ,
	    str2_ex  = 0 ;
	    
	
    
	/*입력 받은 문자열의 총 바이트를 적어 줄 tag 정보가 없다면 writebyte null*/
	writeByte = writeByte||null;
	console.log("사용된 바이트수를 적어줄 Tag ID가 담긴 변수명: writebyte\n writebyte : "+writeByte);
  
	/*입력 받는 문자열이 숫자 검증일 경우에 num 은 not null*/
	num=num||null;
    console.log("숫자 체크 해야하면 num은 not null\n num : "+num);
    
    /* 만약 숫자검증 이면서 숫자가 아닌 난수값이 들어가 있다면 if문을 거치게 된다. */
    if( num!=null && /\D/g.test(str))
	{
    	 console.log("**** 숫자 검증에서 숫자 이외의 값이 들어왔습니다. ****");
    	 
         //숫자검증을 다시 시작하기 위해서
    	 //입력 필드의 값을 빈문자열로 채우고 & 입력 byte 정보를 보여줄 필드 역시 0 입력
    	 obj.value="";
    	 document.getElementById(writeByte).innerText = 0; 
	     
	  obj.placeholder="공백 및 문자입력 불가";
      alert("공백 및 문자 입력 불가");
	    
	     console.log("숫자 검증을 마치고 return 합니다.")
	     return;
	}
  
    
//문자열 하나씩 쪼개서 각문자 byte 계산 for 문을 통해서 가용 가능한 문자열 갯수 까지만 저장
    
     /*각각의 문자 byte 계산을 위해 만든 임의 변수*/
      var one_char = "";		
    
                           /*onechar_ex 는 ex 실험용*/
                for(var i=0 ,onechar_ex ; i<str_len; i++)
				{
                	 /*쪼갠 temp*/
					  one_char = str.charAt(i);
						
					  /*byte 계산을 한다 deprecated => escape() 
					    encodeURIComponent
					     아스키값이 없을 경우엔 유니코드 값을 변경하여 읽기 시작한다.*/ 
				     	
					/*  onechar_ex=str[i].charCodeAt();*/
					  
					  /* 데스트용 code 값을 확인하기 위해서 콘솔 만들었음 확인용으로만 사용
					   * console.log("onechar_ex : "+ onechar_ex);*/
					/*  if(onchar_ex>=0x80 && onchar_ex<=0xFF)
					  {
						  rbyte+=2;
						  console.log("문자 "+str[i]+"은 "+2+"byte 입니다.");
					  }
					  else if(onchar_ex >=u0800 && onchar_ex <= uFFFF)
					  {
					      rbyte+=3;
					      console.log("문자 "+str[i]+"은 "+3+"byte 입니다.");
					  }
					  else if(onechar_ex >= u10000 && onechar_ex <= u1FFFF)
					  {
					      rbyte+=4;
					      console.log("문자 "+str[i]+"은 "+4+"byte 입니다.");
					  }
					  else
					  {
					      rbyte++;
					      console.log("문자 "+str[i]+"은 "+1+"byte 입니다.");
					  }
						  */
					  
					  
					  if((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi.test(one_char)))
					  {
							  rbyte +=3;
					  }
					  else if(encodeURIComponent(one_char)=='%0A')
				 	  {
					          rbyte += 2;          
				 	  }
					  else
					  {
					          rbyte++;             //영문 등 나머지 1Byte
					  }
								
					   //쌓인 byte가 총byte 한도를 넘지 않는다면 검사된 길이만큼을 유효처리한다
						if(rbyte <= maxByte)
						{
						    rlen = i+1;             //return할 문자열 갯수
						}
				}

                
			if(rbyte > maxByte)
			{
					if(num!=null)
					{ 
						 
						    //유효 처리된 rlen 문자의 갯수를 담아둔
						    str2 = str.substr(0,rlen);     
						    //허용된 문자열 길이 rlen 에서 원래 받은 문자열에서 rlen 까지 잘라서 파라미터를 제공한 tag에 인자를 리턴한다.
						    obj.value = str2;
						    
						    writeByte!=null?document.getElementById(writeByte).innerText = rbyte:'';
						    alert("숫자 "+maxByte+"자를 초과 입력할 수 없습니다.");
						   
						   fnChkByte(obj, maxByte,writeByte, num);
					}else
					{
						   
						    str2 = str.substr(0,rlen);                                  //문자열 자르기
						    obj.value = str2;
						    
						    writeByte!=null?document.getElementById(writeByte).innerText = rbyte:'';
						    alert("한글 "+parseInt(maxByte/3)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
						    fnChkByte(obj, maxByte,writeByte, null);
					}
			}
			else
			{
					if(writeByte!=null)
					{
				       document.getElementById(writeByte).innerText = rbyte;
					}
			} 
			
			console.log("===========================end fnChkByte===========================");
	}
