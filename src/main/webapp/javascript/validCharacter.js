
 /*빈 문자열 및 공백 체크 하는 bool test function  */

/*input 에서 maxLength= 입력 가능한범위 +1을 적는다 그래야 alert을 띄울수 있다.*/


  /* 파라미터 값으로 체크 할 node를 입력 받는다  값이 아닌 노드 정보를 받는당!!!!
     true는 문제 없음 false 문제 있음 */  
 /*valid method get inputTextElement and return boolean value after checking element validation of submit */
  function validNumb(chaNode,num)
    {
	    var length =chaNode.maxLength-1;
	    /* write information about inputText value into placeholder area  */
	    var lengthPlaceholder ='';
	    /* if num option value is not null, write information of character that korean & english value into placeholder area */
	   
	    
	    if(num!=null)
    	{
	    	if(isIE)
	    	{
      		  alert('한글 '+parseInt(length/3)+'자 / 영문 '+length+'자 허용');
      	    }else
      	    {
      		  lengthPlaceholder ='한글 '+parseInt(length/3)+'자 / 영문 '+length+'자 허용';
      	    }
    	}
	    else
    	{
	    	if(chaNode.value.length>length)
    		{
	    		console.log(chaNode.value.length);
    		    alert(length+"자리 숫자 허용");
    		    console.log(chaNode);
    		    var temp =chaNode.value;
    		    chaNode.value=temp.substring(0,length);
    		    
    		    console.log(chaNode.value);
    		    return;
    		}
	    	if(isIE)
	    	{
	    		 /* alert('공백 없는 숫자 '+chaNode.maxLength+'자 허용'); */
      		}
	    	else
    		{
	    		lengthPlaceholder =length+'자리 숫자 허용';
    		}
	    	
    	}
	    /* value */
	    var tst = chaNode.value;
	    /* result variable for testing */
	    var bool =true;
       
	    /* check space area in the value and return boolean value */
    	if(/[\D]/gmi.test(tst))
   		{
    		if(isIE)
	    	{
    		   	alert('공백 없는 숫자 '+length+'자 허용'); 
    			chaNode.value="";
    			bool=false; 
      		}
	    	else
    		{
	    		bool=false;
	    		chaNode.value="";	
	    		/*chaNode.placeholder=lengthPlaceholder;*/
	    		
	    		alert(lengthPlaceholder);
    		}
    		
    		
   		}else
   		{
   			bool=true;
   		}	
    	   
    	   return bool;
    }
    