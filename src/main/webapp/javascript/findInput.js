

/* input tag 정보 가져오는 모듈 */
     function inputTagFind(inputArr)
    {
        inputArr= inputArr || ['cp','ls','exam'];
    	 
       	var inputTags= document.getElementsByTagName("input");
        	     
               for(var a =0 ; a<inputTags.length; a++)
       		{
            	   var input_name =inputTags[a].name;
            	   
            	for(var b =0 ; b <inputArr.length ; b++)
           		{

            		 if(input_name===inputArr[b])
            			 {
            			   alert(inputArr[b]);
            			 }        		
           		}
       		} 
       	 
     } 