var XHR = null;

 function getXHR()
 {
	 if(window.ActiveXObject) 
	 {
		 alert('Explore 11버젼 사용을 권장 합니다./n 입력 창에 사용자의 길잡이 문구를 보시지 못 할 수 있습니다.');
         return new ActiveXObject("Msxml2.XMLHTTP");	 
	 }
	 else if(window.XMLHttpRequest)
	 {
		 return new XMLHttpRequest();
	 }	 
	 else 
	 {
		 return null;
	 }	 
 }
 
 function sendRequest(url,params,callback,method)
 {
	 XHR= getXHR();
	 
	 var httpMethod= method?method:'GET';
	 
	     if(httpMethod!='POST' && httpMethod!='GET')
		 {
		   httpMethod = 'GET';
		 }
	 
	 var httpParams= (params==null || params =='')?null : params;
	 
	 var httpUrl =url;
	 
    	 if(httpMethod=='GET' && httpParams != null)
		 {
	       httpUrl=httpUrl+'?'+httpParams;	 
		 }
   XHR.open(httpMethod ,httpUrl , true);	 
   XHR.setRequestHeader('Content-type','application/json;');
   XHR.onreadystatechange = callback;
   XHR.send(httpMethod == 'POST' ? httpParams : null);
 }
 