<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
      <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="javascript/byteCheck.js"></script>
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> 
  
<title>Insert title here</title>
<script type="text/javascript" src="javascript/byteCheck.js"></script>
 <link rel="stylesheet" href="css/commons.css">
<script>

  /*다양한 버튼을 사용하며 submit 시키기  */
/*   
	function submitHandler(mode)
	{  
		var f = document.update;
		var requiredBoolean= requiredValidOK(f);
		

			if(mode.name == "update")
		   {
				 f.method = "POST"; 
				 f.action = "bbsUpdateNormal.bow";
				 
					if( requiredBoolean )
					{
					     f.submit();  
					}
					else
					{
						bgColorOnFocus(f.password); 
					}
				 
		   }
		   else if( mode.name == "delete" )
		   {
			 	f.method = "POST";
			 	f.action = "bbsDeleteNormal.bow";
			 	
			 		f.submit();  
		    }
	}

  function requiredValidOK(formArea){
	  
	   var pwd=formArea.password.value;
	   var booleanV=true;
	   if(pwd == null || pwd ==0)
      {
		    booleanV=false;
      }	  
	   return booleanV;
  }
  
  function bgColorOnFocus(target) 
  {
	   target.style.background = "yellow";
	   target.placeholder ="비밀 번호는 필수 입니다";
	   target.focus();
  } */

  function validWrite(){
  	     
  	    var isOk=false;
  	       
  	        
  	       var inputArr =document.getElementsByTagName("INPUT");
  	       var txtArea =document.getElementsByTagName("TEXTAREA")[0];
  	       
  	     
  	    	   var txtTemp =txtArea.value;
  	    	   
  	    	    txtTemp=  txtTemp.replace(/^\s*/g,"");
                txtTemp=  txtTemp.replace(/\s*$/g,"");
             
             if(txtTemp=='')
          	  {
          	     txtArea.placeholder="필수 입력사항 입니다.";
          	     txtArea.style.background="#61b0d5";
          	    
          	  }else
     		  {
          		 txtArea.value=txtTemp;
          		 isOk=true;
     		  }
             
   	
  	       /* 0=writer 1=subject  2=password */
  	        for(var a =0 ; a< 2 ; a++)
       	{
       	     var temp= inputArr[a].value;
       	     
       	           temp=  temp.replace(/^\s*/g,"");
  	               temp=  temp.replace(/\s*$/g,"");
  	               temp=  temp.replace(/\s+/g," ");
  	               
       	     if(temp==''|| temp==null)
      	    	 {
       	    	 inputArr[a].value='';
      	    	     inputArr[a].placeholder='필수 입력 사항 입니다.';
      	    	     inputArr[a].style.background="#61b0d5";
      	    	     isOk=false;
      	    	 }
       	     else
      	    	 {
      	    	   inputArr[a].value=temp;
      	    	 }
  	       
       	}
       	
  	     if(isOk==true)
  	     {
  	    	 window.document.update.submit(); 
  	     } 
  } 
  

   
  
  </script>
</head>
<body onload="fnChkByte(document.getElementsByTagName('textarea')[0],4000,'t')">


  <c:forEach var="file" items="${filez}" varStatus="i">
<form action="fileDown.bow" id="${i.index}_down">
   <input type="hidden" name="file_idx" value="${file.file_idx}">		      
   <input type="hidden" name="stored_file_name" value="${file.stored_file_name}">		      
   <input type="hidden" name="origin_file_name" value="${file.origin_file_name}">	
</form>
  </c:forEach>



   <div class="container">
     <h1>BOW-TECH_BBS_WRITE</h1>
<form action="bbsUpdateNormal.bow" name="update" method="POST" onsubmit="return false;" enctype="multipart/form-data">
  <table class="table table-bordered" style="width: 1100px;">
			<tr>
			  <td>	
				<span>작성자 : </span><input type="text" name="writer" value="${dto.writer}" oninput="fnChkByte(this,'30',null,null)" onkeypress="if(event.keyCode==13)validWrite();" required></td>
			</tr>
			<tr>
				<td><span>제&nbsp;&nbsp;&nbsp;목 :  </span><input type="text" name="subject" size="50" oninput="fnChkByte(this,'60',null,null)" value="${dto.subject}" onkeypress="if(event.keyCode==13)validWrite();" required >
				</td>
 			</tr>
<%-- START 첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면  --%>
			 <c:choose>
			   <c:when test="${!empty filez}">
			      <tr>
				    <td colspan="3"  id="file_td">
				      <c:forEach var="file" items="${filez}" varStatus="i">
				          <span>첨부파일 : </span>
				          <a href="#"  onclick="javascript:document.getElementById('${i.index}_down').submit()">
	                          <span>${file.origin_file_name}</span>	 			      
	                          &#09;	
                          </a>
                          <div id="file_delete" style="display: inline-block;"><i class="fa fa-times" aria-hidden="true" style="color: red;"></i></div>
                          <input type="hidden" id="file_idx" name="file_idx" value="${file.file_idx}">		      
				      </c:forEach>
				   </td> 
				</tr>
			   </c:when>
			   <c:otherwise>
			     <tr>
				    <td colspan="3" >
			          <input type="file" name="file">
			        </td>
			     </tr>
			   </c:otherwise>
			</c:choose>  
<%-- END 첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면   첨부 했던 파일 이 있다면  --%>
			<tr>
				<td><textarea rows="40" cols="60" rows="40" cols="60" style="width: 100%; height: 700px;" class="txtarea-content" name="content" oninput="fnChkByte(document.getElementsByTagName('textarea')[0],4000,'t');" required>${dto.content}</textarea>
			<tr>
				<td colspan="2" style="text-align: right;"><span id="t">0</span>/4000</td>
			</tr>
			<tr>
	       <td colspan="2" style="text-align: center;">
	           <input type="button" value="수정" name="update" onclick="validWrite();">
	           <input type="button" value="뒤로" onclick="history.go(-1)">
	       </td>
	    </tr>
  </table>  
   <input type="hidden" name="board_idx" value="${dto.board_idx}">
</form>
</div>
</body>

<script>
			
		$("#file_delete").on("click",function(e){
			
			e.preventDefault();
			
			/*삭제 의사를 물어봄 true or false  */
			var bool =confirm("첨부 파일을 삭제 하시겠습니까?");
			
			if(bool)
			{
				var momNode =document.getElementById("file_td");
				var idx = document.getElementById("file_idx").value;
				 
				
			  while(momNode.hasChildNodes())
			  {
				  momNode.removeChild(momNode.firstChild); 
			  }
				
		       var fileUploadNode = document.createElement("INPUT");
		           fileUploadNode.setAttribute("name","file");
		           fileUploadNode.setAttribute("type","file");
		     
		           var deleted_idx = document.createElement("INPUT");
		           deleted_idx.setAttribute("name","deleted_file_idx");
		           deleted_idx.setAttribute("type","hidden");
		           deleted_idx.setAttribute("value",idx);
		          
		           momNode.appendChild(fileUploadNode);
		           momNode.appendChild(deleted_idx);
			}
          			
		});	  
			
</script>

 <script>
	    /*길이~~~  */
         /*  var length = document.getElementById("dd").attributes.length; */
	    
	  /*     var formData =document.getElementById("update")
	
	      formData.addEventListener("click", function checkForm(){
	    	 /*  var xyz = document.getElementsByName("xyz");
	    	  xyz[0].style.color="red"; // make the first one red */
		   /* var writer =document.getElementsByTagName("INPUT")[0].name; */
		   /* var writer =document.getElementsByTagName("INPUT")[0].value; */
		/*    var writer =document.getElementsByTagName("INPUT");
		   var contentText =document.getElementsByTagName("TEXTAREA")[0];

		   var booleanCard =true;
		   
		   if(contentText.value===null || contentText.value==='')
		   {
		       booleanCard=false;		  
		       contentText.style.borderColor="red";
		   }
	   
		    for(var a = 0 ;a <=2; a++)
		    {		    		    	
               if(writer[a].value===null || writer[a].value==='')
	           {
	               writer[a].style.borderColor="red";	    
            	   booleanCard=false;
	           }			    	
		    }
		        if(booleanCard===true)
			   {
			       document.writeOk.submit();	   
			   }
		  
	   });     */
	</script>
</html>