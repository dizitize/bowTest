<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>BBS write</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="javascript/byteCheck.js"></script>
  <link rel="stylesheet" href="css/commons.css">
<script>
    
   function validWrite(){
	   
 	    var isOk=false;
 	        
 	       var inputArr =document.getElementsByTagName("INPUT");
 	       var txtArea =document.getElementsByTagName("TEXTAREA")[0];
 	       
 	    	   var txtTemp =txtArea.value;
 	    	   
 	    	  txtTemp=  txtTemp.replace(/^\s*/g,"");
 	    	    console.log("첫번째 replace"+txtTemp);
              
 	    	  txtTemp=  txtTemp.replace(/\s*$/g,"");
                console.log("두번째 replace"+txtTemp);
              
                if(txtTemp=='')
           	  {
           	     txtArea.placeholder="필수 입력사항 입니다.";
           	  }else
      		  {
           		 txtArea.value=txtTemp;
           		 isOk=true;
      		  }
    	
 	       /* 0=writer 1=subject  2=password */
 	        for(var a =0 ,temp; a< 3 ; a++)
        	{
        	       temp= inputArr[a].value;
        	    /*  alert(temp); */
        	       temp=  temp.replace(/^\s*/g,"");
	               temp=  temp.replace(/\s*$/g,"");
	               temp=  temp.replace(/\s+/g," ");
	               
	               inputArr[a].setAttribute("attributevalue",temp);
        	    
        	     if(temp==''|| temp==null)
       	    	 {
        	    	 var inputAttrName =inputArr[a].attributes[0].name;
        	    	/*  alert(inputAttrName); */
        	    	 inputArr[a].value='';
       	    	     inputArr[a].placeholder='필수 입력 사항 입니다.';
       	    	     isOk=false;
       	    	 }
        	     else
       	    	 {
       	    	   inputArr[a].value=temp;
       	    	 }
        	}
 	       
 	     if(isOk==true)
  	     {
  	    	 window.document.writeOk.submit(); 
  	     } 
   } 
</script>
  
</head>
<body>
   <div class="container">
     <h1>BOW-TECH_BBS_WRITE</h1>
	<form action="bbsWriteNormal.bow" name="writeOk" method="post" onsubmit="return false;" enctype="multipart/form-data">
		<table class="table table-bordered" style="width: 1100px;">
			<tr>
				<td><span>작성자 : </span><input type="text" class="input-writer"  name="writer" oninput="fnChkByte(this,'30',null,null)" required  onkeypress="if(event.keyCode==13)validWrite();"></td>
			</tr>
			<tr>
				<td><span>제&nbsp;&nbsp;&nbsp;목 : </span><input type="text" class="input-subject" name="subject" maxlength="61" size="80" oninput="fnChkByte(this,'60',null,null)" onkeypress="if(event.keyCode==13)validWrite();" required >
				</td>
			</tr>
			<tr>
				<td><textarea rows="40" cols="60" style="width: 100%; height: 700px;" class="txtarea-content" name="content"oninput="fnChkByte(document.getElementsByTagName('textarea')[0],4000,'t')" required ></textarea>
			    </td>
			</tr>
			<tr>
				<td><span id="t">0</span>/4000</td>
			</tr>
		
			<tr>
				<td><span>비밀번호 : </span><input type="password" name="password" oninput="fnChkByte(this,'9','p','num')" maxlength="10" onkeypress="if(event.keyCode==13)validWrite();" required placeholder="숫자 9자리 입력">
				 &nbsp;<span id="p">0</span>/9
				</td>
			</tr>
		    <tr>
			    <td><input type="file" name="file" multiple></td>
			</tr>
			<tr>
				<td><input type="button" value="작성" name="write" onclick="validWrite();"> 
				    <input type="button" value="취소" onclick="location.href='bbsListNormal.bow'">
			   </td>
			</tr>
		</table>
	</form>
	</div>
</body>

</html>