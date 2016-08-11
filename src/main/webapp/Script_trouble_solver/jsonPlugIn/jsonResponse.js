

 function listShow(command,params,callback,method){

	   var resultJson =null;
	   
		sendRequest(command, params, respText, method);	
	  	    
	   function respText()
	   {  	
	  	 if(XHR.readyState == 4 )
	  	 {
	  	    if(XHR.status == 200)
	      	{ 
	  	    	 var text = XHR.responseText;
	             resultJson=JSON.parse(text);  
	             
	      	}
	  	 } 
	   }
	   
	  
   }