/**
 * 
 */

function list_trigger(target_class,eventOrigin,li_number)
{
	
	console.log("************list_trigger()*************");
	
	
	console.log("parameter value :"+target_class);
    
	var target =document.getElementsByClassName(target_class);
	console.log("숨겨야 하는 class 명 :"+target);
	
	
	/*hidden 일때는 "열기" & show 일때는 "닫기" 표시 span id*/
	var trigger_font = target_class+"_trigger_font";
	console.log("parameter id value :"+trigger_font);
	
	console.log("display status of target class :"+target[0].style.display);
	/*태그 정보로 변경*/   
	    trigger_font =document.getElementById(trigger_font);
	  
	/*    var x=document.getElementsByTagName('li');
	        x.className="whatever";*/
	
	if(target[0].style.display =='none')
	{
		console.log("none 일 경우");
	   for(var a =0 ; a < target.length; a++)
	   {
			target[a].style.display= 'block';
	   }
		
	   
	   if(li_number>0)
		{
		   trigger_font.innerText="< 닫기 >";
		}
		else
		{
			 trigger_font.innerText="더이상 표시할 코멘트가 없습니다"; 
		}
	   
	   
	    /*eventOrigin.className="fa-angle-double-up";*/
	   /* alert(eventOrigin.children[1].nodeName);*/
	   
	}
	else if(target[0].style.display=='block')
	{
		console.log("block 일 경우");
		for(var b =0 ; b < target.length; b++)
		   {
			 target[b].style.display='none';
			 console.log("b:"+b);
		   }
		
		if(li_number>0)
		{
		    trigger_font.innerText=li_number+"개의 코멘트 더 보기..";	
		}
		else
		{
			 trigger_font.innerText="더이상 표시할 코멘트가 없습니다"; 
		}
		
		
	}

	
}