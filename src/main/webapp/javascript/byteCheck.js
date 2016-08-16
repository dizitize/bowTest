

// num = 숫자 writeByte = 적을 곳
function fnChkByte(obj, maxByte, writeByte, num){

	/*obj.style.background='white';*/
	
	// 문자열 	
	var str = obj.value;
	
	// 문자 갯수  ex) 김 => 1  , l =1  
	var str_len = str.length;
	/*alert(str_len);*/
//	여기서부터 byte 계산 들어감

	// 문자열의 총 바이트 합을 담아 둘 변수
	var rbyte = 0;
	// return 문자열 갯수 
	var rlen = 0;
	var one_char = "";
	
	// 검증을 통해 가능한 문자열을 담아둘 마지막 컨테이너
	var str2 = "";
    
	writeByte = writeByte||null;
    num=num||null;
   
    
     
    
    if( num!=null && /\D/g.test(str))
	{
    	 alert("공백 및 문자 입력 불가");
    	 document.getElementById(writeByte).innerText = 0; 
	  obj.placeholder="공백 및 문자입력 불가";
	  obj.value="";
	  return;
	  /* fnChkByte(obj, maxByte,writeByte, num);*/
	   
	}
   else if(num!==null && /\D/g.test(str))
	{
       obj.value="";
       document.getElementById(writeByte).innerText = 0;
  	   obj.placeholder="문자나 공백입력 불가 입니다.";
  	   alert("공백 입력 불가");
  	   return;
	}
    
//                문자열 하나씩 쪼개서 각문자 byte 계산 for 문을 통해서 가용 가능ㄹ한 문자열 갯수 까지만 저장
			
                for(var i=0; i<str_len; i++)
				{
//                	  쪼갠 temp
					  one_char = str.charAt(i);
						
					  /*byte 계산을 한다 deprecated => escape() 
					    encodeURIComponent
					     아스키값이 없을 경우엔 유니코드 값을 변경하여 읽기 시작한다.*/ 
				     	  
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
	}
