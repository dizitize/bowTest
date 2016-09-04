<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>EXCEL DOWN</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

</head>
<script>

 function init(parent_cp){
	 alert(parent_cp);
 }

 function passData()
 {
	 var checkBoxz = document.getElementsByTagName("INPUT");
	 var result = "";
	 
	   for(var a = 0 , ck=""; a<checkBoxz.length; a++)
	   {
		   if(checkBoxz[a].getAttribute("TYPE")=="radio")
			   {
			       if(checkBoxz[a].checked)result=checkBoxz[a].value;
			   
			   }
       }
	
	   if(result=="")
	   {
	      alert("옵션을 선택 해 주세요");
	   }
	   else
	   {
		   self.close();
		    window.opener.setValue(result); 
		   
	   }
 }	   

</script>
<body>
       <div style="text-align: center; margin: 50px;">
       <h3>EXCEL Download OPTION</h3>
        <i class="fa fa-file-excel-o fa-2x" aria-hidden="true"></i>
        <br>
        <form>
           <div style="width:200; text-align: left;" >
              <input type="radio" name ="exel_option" value="0">${cp} 페이지 다운로드
               <br>
		      <input type="radio" name ="exel_option" value="1">${cp} 페이지부터 전체 다운로드
		       <br>
		      <input type="radio" name ="exel_option" value="2">전체 페이지 다운로드
		       <br><br>
		      <div style="text-align: center;">
			      <input type="button" value="다운로드" name="downTrigger" onclick="javascript:passData();">
			      <input type="button" value="&nbsp;&nbsp;&nbsp; 취소 &nbsp;&nbsp;&nbsp;" onclick="self.close()">
              </div>
            </div>
       </form>
      </div>
</body>
</html>