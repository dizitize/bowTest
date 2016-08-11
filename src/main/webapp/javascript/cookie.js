 
 function confirmCookie(key,value)
 {
	 var ck =getCookie(key);
	 
	 var isCookie =ck==value?true:false;
	
	 return isCookie;
 }



 function getCookie(key)
 {
	 console.log("=======================================Start getCookie()=========================================");
	 /*key문자열=value 식의 문자열에서 value만 뽑아 내기위해서 기본 key값을 찾는 문자열을 key= 형식으로 맞춰준다.*/
	 var ckKey=key+"=";
	 
	 /* 브라우져가 가지고 있는 전체 쿠키 값들을 불러온다.  반환값은 배열이 아닌 **하나의 문자열로 반환 받는다** */
	 var ck =document.cookie;
	 /*받은 문자열을 문자배열로 만들어 하나씩 찾기위해 split을 활용하여쿠키 값들의 경계를 나타내는 세미콜론을 이용해 배열로 변화*/
	 var ck =ck.split(";");
	 
    for(var a = 0 ; a<ck.length ; a++)
	{
	    	     var ckTemp = ck[a];
	
	    	     console.log("cookie name is >>> "+ckTemp);
	    	     console.log("cookie charAt[0] >>>"+ckTemp.charAt(0));
	    	     console.log("cookie substring(1) >>>"+ckTemp.substring(1));
	    	    
	    	 /* 맨 앞자리에 공백이 있다면잘라내고 0번째 자리에 공백이 없는 쿠기 key=value 값을 만든다 */
	    	     while(ckTemp.charAt(0)==' ')
	   	    	 {
	    	    	  /*start : 인덱스1부터 시작해서  end: start부터 시작해서 지정한 자리수가 없으니 끝까지 잘라낸다*/
	   	    	      ckTemp = ckTemp.substring(1);
	   	    	      console.log("쿠키들 >>>"+a+"번째 쿠키 값::"+ckTemp);
	   	         }
	    	 /* 잘라낸 문자열에 내가 찾고자하는 ex) "cookieKey=" 가 맨앞에 keyValue로 가지고 있는 검증을 한다.
	    	    indexOf 는 한 문장에 대한 단위로 문장열 안에 몇 번째 존재 하는가 찾는것 이다.
	    	     또한 indexOf("원하는단어",5); <== 찾고자하는 target 문장열에서 6번재 이후에 발생 되는 
	    	     index 결과 값을 반환 한다.
	    	 */
		    	 if(ckTemp.indexOf(ckKey) == 0 )
	    		 {
	    		    console.log("key값에 indexOf(키값)"+ckTemp.indexOf(ckKey));
	    		 
	    		    /* key값에 대한 value 값을 리턴한다 */    
	    		    console.log("key값의 길이:"+ckKey.length+"& ckTemp의 길이:"+ckTemp.length);
	    		    
	    		    console.log("찾은 쿠키 값.substring(\"ckKey=\"의 길이 이후 부터 ,쿠키 key=value마지막 까지)>> "+ckTemp.substring(ckKey.length,ckTemp.length));
	    		     
	    		    /* This method extracts the characters in a string between "start" and "end", 
	    		   
	    		    NOT INCLUDING "END" ITSELF.
	    		    
	    		    If "start" is greater than "end", this method will swap the two arguments, 
	    		    meaning str.substring(1,4) == str.substring(4,1). */
	    		    var result = ckTemp.substring(ckKey.length,ckTemp.length);
	    		    console.log("결과 입니다="+result);
	    		    
	    			 console.log("=======================================End getCookie()=========================================");
                    /*결과값을 함수에서 받은 key에 대한 value을 반환한다*/	    		    
	    		    return result;
	    		 }
		    	 
	    }
 }
 
 /* 사실 아래 나와 있는 식으로 해도 쿠키를 심을 수 있다. 그리고 쿠키를 심을 때 expires 를 명시 하지 않을 시에는
  * 세션과 같이 브라우져가 닫을 때 까지 살아있는 쿠키 생명주기로 default 설정이 들어가게 된다. 
  *     
  * 1) document.cookie="ie_test=value_test";
  * 
  * 2) document.cookie = "username=John Doe; expires=Thu, 18 Dec 2013 12:00:00 UTC";
  * 
  * With a path parameter, you can tell the browser what path the cookie belongs to. 
  * By default, the cookie belongs to the current page.
  * 
    3) document.cookie = "username=John Doe; expires=Thu, 18 Dec 2013 12:00:00 UTC; path=/";
  * 
  * */
 
 function setCookie(key,value,expired_day)
	{
	 console.log("=======================================Start setCookie()=========================================");
	    var duration = new Date();
	
	    duration.setTime(duration.getTime()+(expired_day*24*60*60*1000));

	    var expires="expires"+duration.toUTCString();
	    
	    console.log("setCookie.expires="+expires);
	
       /* 세미콜론 뒤에 한칸 띄어야 한다 그래야 인식을 할 수 있다. 쿠키를 만들어낼대 값의;\s 로 이루어진 문자열을 가지게 된다@@@ */
	     document.cookie=key+"="+value+"; "+expires;
	     
	 console.log("=======================================End setCookie()=========================================");
	}

   /*  Deleting a cookie is very simple. Just set the expires parameter to a passed date:

	   document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC";*/
 
 
 
 
 function modifyCookie(key,value,dayPlus){
	 console.log("=======================================Start modifyCookie()=========================================");
	    var cks = document.cookie;
        var keyV= key+"=";
	    var isCookieLive_Dead=false;
	    
	    cks=cks.split(";");
	    
	    for(var a = 0 ; a < cks.length; a++)
    	{
    	   var temp = cks[a];
    	   
    	   temp = temp.charAt(0)==' '?temp.substring(1):temp;
    	   
    	   if(temp.indexOf(key)==0)
		   {
    		   var isExist =value==temp.substring(keyV.length,temp.length)?true:false;
		       
    		   if(isExist)
			   {
    			    console.log("modify cookie value : "+value);
	   		        var duration = new Date();
	   		      
	   		       if(day==null)duration.setTime(duration.getTime()-(1000*60*60));
	   		       if(day!=null)duration.setTime(duration.getTime()+(day*24*60*60*1000));
	   		       
	   		        var expires="expires"+duration.toUTCString();
	   		        
	   		        console.log( +"AFTER expires :"+expires);
	   		        
	   		        document.cookie=key+"="+value+"; "+expires;
   		       
	   		        isCookieLive_Dead=true;
			   }
		   }
    	     return isCookieLive_Dead;
    	}
	    
	console.log("=======================================End modifyCookie()=========================================");  
 }
 