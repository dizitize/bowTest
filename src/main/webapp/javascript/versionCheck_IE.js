

function get_version_of_IE() { 
	console.log("=======================Start!  get_version_of_IE() 익스플로어 버젼을 찾습니다.=======================");
	 var word; 
	 var version = "N/A"; 

	 var agent = navigator.userAgent.toLowerCase();
	/*  alert("agent:"+agent); */
	 var name = navigator.appName; 
     /* alert("name:"+name); */
	 // IE old version ( IE 10 or Lower ) 
	 if ( name == "Microsoft Internet Explorer" ) word = "msie "; 

	 else { 
		 // IE 11 
		 if ( agent.search("trident") > -1 ) word = "trident/.*rv:"; 

		 // Microsoft Edge  
		 else if ( agent.search("edge/") > -1 ) word = "edge/"; 
	 } 

	 var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" ); 

	/*  alert(agent); */
	 
	 if (  reg.exec( agent ) != null  ) version = RegExp.$1 + RegExp.$2; 
	
	 version = parseInt(version);
	 
	 var v =/[0-9]{1}/.test(version);
     
	 console.log("Internet Explore version = > "+version);
	 console.log("=======================End!  get_version_of_IE() 익스플로어 버젼을 찾습니다.======================="); 
	return version;
} 

