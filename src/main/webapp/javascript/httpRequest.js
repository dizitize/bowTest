
var XHR = null;

var isIE=window.ActiveXObject?true:false;
console.log('Is this browser Internet Explore ? '+isIE);

 function getXHR()
 {
	 if(window.ActiveXObject) 
	 {
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
   XHR.setRequestHeader('Content-type','application/x-www-form-urlencoded;');
   XHR.onreadystatechange = callback;
   XHR.send(httpMethod == 'POST' ? httpParams : null);
 }
 