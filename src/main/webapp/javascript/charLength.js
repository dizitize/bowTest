/**
 * 
 */

                   
function charLength(from_method_installed, maxLength, status_target)
{
	
  /*이벤트가 발생하는 지점 oninput 걸은 곳*/
   
	var target = from_method_installed,
        target_char=target.value,
   	    target_length = target_char.length,
   	    status =0,
   	    status_target_tag=document.getElementById(status_target);
       
	/*입력시 문자열의 길이*/
	
/*  for(var a = 0 ; a < length ; a++)
  {*/
	  status_target_tag.innerText=target_length;
	  
	  if(target_length >= maxLength)
	  { 
		 alert("입력값 허용범위 :"+maxLength+"입니다.");
		 
		 target_char = target_char.substring(0,maxLength-1);  
		  
		 charLength(from_method_installed, maxLength, status_target)
	     
	  }
	  
	 
  }	  
	  
   
  
  
  

