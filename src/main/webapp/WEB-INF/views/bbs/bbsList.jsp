<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%--URI excel down  excel down  excel down  excel down  excel down --%>
  <c:choose>
      <c:when test="${!empty bbsList}">
         <c:url value="excelDown.bow" var="excelDownURI">
        <%-- s 리스트가 있으면서~ --%>
          <c:choose>
            <%-- 검색 조건 경우 --%>
              <c:when test="${!empty option_cp&&!empty option_value}">
                       <c:param name="option" value="${option}"/>
                       <c:param name="option_value" value="${option_value}"/>
                       <c:param name="option_cp" value="${option_cp}"/>
              </c:when>
               <%-- 일반 리스트 경우 --%>
               <c:otherwise>
                       <c:param name="cp" value="${cp}"/>
               </c:otherwise>
           </c:choose> 
     <%-- E 리스트가  있으면서 끝남~ --%>      
       </c:url>  
      </c:when>
  </c:choose> 
<%--URI excel down  excel down  excel down  excel down  excel down --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 </title>

<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  
  <script type="text/javascript" src="javascript/httpRequest.js"></script>
  <!-- BOM cookie -->
 	  <script type="text/javascript" src="javascript/cookie.js"></script>
  <!-- internetExplore version check -->
	  <script type="text/javascript" src="javascript/versionCheck_IE.js"></script>
	  <script type="text/javascript" src="javascript/isAvaliableBOM.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">

<link rel="stylesheet" href="css/commons.css">

<script>
   function bbsAjax(command,params,tagId,method){
	   
		sendRequest(command, params, respText, method);	
	  	    
	   function respText()
	   {  	
	  	 if(XHR.readyState == 4 )
	  	 {
	  	    if(XHR.status == 200)
	      	{ 
	  	    	 var text = XHR.responseText;
	             resultJson=JSON.parse(text);  
	             alert(resultJson);
	      	}
	  	 } 
	   }
   }

 function byteCheck(val,maxByte){
	 
	 /*input value*/
	
	 var bool = true;
	 var byteNum=0;
	 console.log('byteCheck_value.length:'+val.length);
	 for(var a = 0 ; a<val.length ; a++)
	 {
          var tempCheck = val.charAt(a);
     
		        if(/[ㄱ-ㅎㅏ-ㅣ가-힣]/g.test(tempCheck))
		       	{
		               byteNum+=3;
		               console.log('3:>'+tempCheck+':'+byteNum);
		       	}
		        else if(/\w|\s/g.test(tempCheck))
		       	{
		       	       byteNum+=1;
		       	       console.log('1:>'+tempCheck+':'+byteNum);
		       	}
		        
		   if(byteNum > maxByte)
		   {
	         	bool=false;   
		   }
     }
	 console.log('byteCheck:'+byteNum);
	 return bool;
 }
 
 function validation(){

	 /* input value */
	 var input =window.document.optionSrc.option_value;
	 /* subject or writer selection part */
	 var option =window.document.optionSrc.option;

	  if(input.value===null||input.value===''||/^\s+$/g.test(input.value))
	  {
		  if(isIE){
			 
			  alert("검색어를 입력하세요");
			  input.value="";
		  }
		  else
		  {
		     input.value="";
		     alert("검색어를 입력하세요");
		     input.placeholder="검색어를 입력하세요";
		  }
		    return;
	  }
	 
	 /* if choose src option ,set maxByte*/
	 var maxByte=option.value==="subject"?60:30;
	 /* isAvailable searching for keyword whether blank area exist*/
	 var val =input.value;
	 /* just use the keyword without blank  */
	 var noBlankVal = val.replace(/\s+/,""); 
	    /*  noBlankVal = noBlankVal.replace(/\s+$/,"");  */
	
	 /* byte check boolean value */    
	 var bool = byteCheck(noBlankVal,maxByte);
	 
	 if(bool)
	 {
		 console.log('searching keyword:'+noBlankVal);
		 input.value=noBlankVal;
		 window.document.optionSrc.submit();
	 }
	 else
	 {
		    input.value="";
	    input.placeholder="한글"+parseInt(maxByte/3)+"자/영문"+maxByte+"자 입력 가능.";
	   
	 }
 }
	 var option_value='${option_value}';
	 
	function onFocus(){
		
		if(option_value!='')
		{
	       window.document.optionSrc.option_value.focus();
		}
	}

	window.onkeydown = function( event )
	{
	
	    if ( option_value!='' && event.keyCode === 27 ) {
	      
	        location.href="bbsListNormal.bow";
	    }
	}
    	 if( isIE )
    	{
    	 var ckKey ="ie_test";
		 var ckValue="value_test";	
		 var version =get_version_of_IE(); 
		 var isCkAlive = confirmCookie(ckKey,ckValue);
		 
			 if(!isCkAlive)
			 {
				 confirm("해당 사이트는 원도우"+version+" 버전을 지원 하지 않습니다.\n 11 버전으로 업그레이드 하세요!\n 확인버튼을 누르시면 업데이트 페이지를 생성 합니다.")
				 ==true?window.open("https://support.microsoft.com/ko-kr/kb/949104"):"";
				 setCookie(ckKey, ckValue, 1); 
			 }
	   }
    	 
     var BOM = {
    		codeName : navigator.appCodeName,
    		name : navigator.appName,
    		version : navigator.appVersion,
    		online : navigator.onLine
     }
</script>
</head>
<body onload="onFocus()">
 <div class="container" style="width:1500px;">
   <h5>BOW-TECH_BBS_TEST_1</h5>
 
    <table class="table table-bordered" style="table-layout:fixed;">
	  <tr>
		  <th colspan="7" align="center" style="padding-top:10px;">
	           <form action="boardSrcNormal.bow" method="post" name="optionSrc" onsubmit="return false;">	       
		           <select name="option" style="height: 30px;">
					         <option value="subject">제목</option>
					         <option value="writer">작성자</option>
		            </select>
		            <input type="text" name="option_value" style="height:30px; width:300px;" onkeypress="if(event.keyCode==13)validation();" value="${option_value}" onfocus="this.value=this.value" placeholder="빈칸없는 keyword 검색">     
		            <input type="button" style="height:30px; width:70px;" id="submitBtn" value="검색" onclick="validation()">
		          
				    <c:if test="${option_value ne null}">
			            <span class="badge" style="background-color:red;font-size:15px;">
			                    <a href="bbsListNormal.bow"style="color:white;">검색 종료 </a>
			            </span> 
		           </c:if>
		          <%-- Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel --%>
				     <div style="display: inline-block; float: left;  ">
				      &nbsp;&nbsp;<a href="${excelDownURI}"><i class="fa fa-file-excel-o fa-2x" aria-hidden="true"></i>&nbsp;<span>DOWNLOAD</span></a>
				    </div>
				  <%-- Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel  Excel --%> 
		       </form>
		   </th>
	   </tr>
       <tr>
  	         <th class="col-md-1">No.</th>
  	         <th colspan="3" class="col-md-8">제목</th>
  	         <th class="col-md-2">작성자</th>
  	         <th class="col-md-1">조회수</th>
  	         <th class="col-md-1">작성일</th>
	   </tr>  
         <%-- START  list 가 없다면      START  list 가 없다면    START  list 가 없다면    START  list 가 없다면    START  list 가 없다면    START  list 가 없다면    START  list 가 없다면      --%>
<c:choose>	               
   <c:when test="${empty bbsList}">
 	  <tr>
         <td colspan="7" style="text-align:center;">검색 된 글이 없습니다.</td>
	  </tr>
   </c:when>
          <%-- END  list 가 없다면   END  list 가 없다면    END  list 가 없다면    END  list 가 없다면    END  list 가 없다면    END  list 가 없다면    END  list 가 없다면    END  list 가 없다면   --%>  
   <c:otherwise> 
<%--  LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START  --%>  
         <%--  LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START    LIST FOR EACH START  --%>  
     <c:forEach items="${bbsList}" var="dto" varStatus="mainIndex">
		 <tr id="${dto.board_idx}">
		  	<td style="text-align:center;">
		  	     <c:choose>
		  	          <c:when test="${dto.list_se_idx==0}">
		  	            <font style="font-size: 20px; color: #31b0d5;">${dto.list_idx}</font>
		  	          </c:when>
		  	          <c:otherwise>
		  	            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  	            <span class="glyphicon glyphicon-option-vertical" aria-hidden="true"></span>
		  	            <font style="font-size: 14px;">${dto.list_idx}-${dto.list_se_idx}</font>
		  	          </c:otherwise>
		  	     </c:choose>
		  	</td>

		<td colspan="3" class="overflow">
     <c:choose>
     <%--  START  검색 을 통해 보여주는 VIEW    START  검색 을 통해 보여주는 VIEW    START  검색 을 통해 보여주는 VIEW    START  검색 을 통해 보여주는 VIEW    START  검색 을 통해 보여주는 VIEW    START  검색 을 통해 보여주는 VIEW  --%>
            <c:when test="${!empty option_cp&&!empty option_value}">					  	             
	           <a href="bbsContentNormal.bow?board_idx=${dto.board_idx}&cp=${option_cp}&option=${option}&option_value=${option_value}"> 
	                 &nbsp;&nbsp;
	                   <c:choose>
                                <c:when test="${dto.lev!=0}">
                                   <c:choose>
                                      <c:when test="${dto.lev==1}">
                                      <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#FF3333; font-size: 15px;"></i>   
                                      </c:when>
                                      <c:when test="${dto.lev==2}">
                                        <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#33C7FF; font-size: 15px;"></i>
                                      </c:when>
                                      <c:when test="${dto.lev==3}">
                                      <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#9633FF; font-size: 15px;"></i>
                                      </c:when>
                                      <c:when test="${dto.lev==4}">
                                         <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#33FF33; font-size: 15px;"></i>
                                      </c:when>
                                      <c:otherwise>
                                          <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:gray; font-size: 15px;"></i>
                                      </c:otherwise>
                                   </c:choose>
	                            </c:when>
                    </c:choose>
                     <c:choose>
                           <c:when test="${dto.news>0}">
                           <span style="font-size: 17px;" class="subject_after" id="${dto.news}">
                                    ${dto.subject}
                                  <c:choose>
                                    <c:when test="${dto.files eq 1}">
                                    &nbsp;&nbsp;<i class="fa fa-file-o" aria-hidden="true" style="color: red;"></i>
                                    </c:when>
                                    <c:when test="${dto.files > 1}">
                                     &nbsp;&nbsp;<i class="fa fa-files-o" aria-hidden="true" style="color: red;"></i>
                                    </c:when>
                                 </c:choose>
                           </span>
                           </c:when>
                           <c:otherwise>
                              <span style="font-size: 17px;">
                                   ${dto.subject}
                                 <c:choose>
                                    <c:when test="${dto.files eq 1}">
                                    &nbsp;&nbsp;<i class="fa fa-file-o" aria-hidden="true" style="color: red;"></i>
                                    </c:when>
                                    <c:when test="${dto.files > 1}">
                                     &nbsp;&nbsp;<i class="fa fa-files-o" aria-hidden="true" style="color: red;"></i>
                                    </c:when>
                                 </c:choose>
                           </span>
                           </c:otherwise>
                  </c:choose>
	          </a>
      </c:when>
<%--  END  검색 을 통해 보여주는 VIEW    END  검색 을 통해 보여주는 VIEW    END  검색 을 통해 보여주는 VIEW    END  검색 을 통해 보여주는 VIEW    END  검색 을 통해 보여주는 VIEW    END  검색 을 통해 보여주는 VIEW  --%>
      <c:otherwise>
               <a href="bbsContentNormal.bow?board_idx=${dto.board_idx}" style="width:100%;">
                <span style="width:90%; display: inline-block;" class="overflow" >
                   <c:forEach begin="0" end="${dto.lev}" varStatus="i">&nbsp;&nbsp;&nbsp;</c:forEach> 
	                     
	                     <c:choose>
	                          <c:when test="${dto.list_se_idx==0 && dto.lev==0}">
	                              
<%--***  SUBJECT-LEV0  start line ***** 답글이 아닌 LEV=0 SUBJECT 만약 코멘트 글일 있다면 해당 코멘트 갯수를 달기위한  if statement ****--%>
	                                   <c:choose>
		                             <%-- lev=0 이면서 답글이  있다면 --%>
		                                   <c:when test="${dto.news>0}">
				                                 <span style="font-size: 17px;" class="subject_after" id="<c:if test="${dto.news>=1}">${dto.news}</c:if>">
				                                       ${dto.subject}
				                                        <c:choose>
					                                         <c:when test="${dto.files eq 1}">
					                                         &nbsp;&nbsp;<i class="fa fa-file-o" aria-hidden="true" style="color: red;"></i>
					                                         </c:when>
					                                         <c:when test="${dto.files > 1}">
					                                          &nbsp;&nbsp;<i class="fa fa-files-o" aria-hidden="true" style="color: red;"></i>
					                                         </c:when>
				                                       </c:choose>
				                                 </span>
		                                   </c:when>
		                             <%-- lev=0 이면서 답글이 없다면 --%>
		                                   <c:otherwise>
			                                     <span style="font-size: 17px;">
				                                       ${dto.subject}
				                                       <c:choose>
					                                         <c:when test="${dto.files eq 1}">
					                                         &nbsp;&nbsp;<i class="fa fa-file-o" aria-hidden="true" style="color: red;"></i>
					                                         </c:when>
					                                         <c:when test="${dto.files > 1}">
					                                          &nbsp;&nbsp;<i class="fa fa-files-o" aria-hidden="true" style="color: red;"></i>
					                                         </c:when>
				                                       </c:choose>
				                                 </span>
		                                   </c:otherwise>
	                                   </c:choose>
<%--***  SUBJECT-LEV0  end line ***** 답글이 아닌 LEV=0 SUBJECT 만약 코멘트 글일 있다면 해당 코멘트 갯수를 달기위한  if statement ****--%>
	                            </c:when>
	                          <c:when test="${dto.list_se_idx==0 && dto.lev!=0}">
                                  <font style="font-size: 19px;">&nbsp;&nbsp;${dto.subject}</font>
                                      <c:choose>
	                                          <c:when test="${dto.files eq 1}">
	                                          &nbsp;&nbsp;<i class="fa fa-file-o" aria-hidden="true" style="color: red;"></i>
	                                          </c:when>
	                                          <c:when test="${dto.files > 1}">
	                                          &nbsp;&nbsp;<i class="fa fa-files-o" aria-hidden="true" style="color: red;"></i>
	                                          </c:when>
				                      </c:choose>
	                          </c:when>
	                     </c:choose>
	           
                        <c:if test="${dto.list_se_idx!=0}">
                              <c:choose>
                                <c:when test="${dto.lev!=0}">
                                   <c:choose>
	                                      <c:when test="${dto.lev==1}">
	                                         <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#FF3333; font-size: 15px;"></i>   
	                                      </c:when>
	                                      <c:when test="${dto.lev==2}">
	                                         <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#33C7FF; font-size: 15px;"></i>
	                                      </c:when>
	                                      <c:when test="${dto.lev==3}">
	                                         <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#9633FF; font-size: 15px;"></i>
	                                      </c:when>
	                                      <c:when test="${dto.lev==4}">
	                                         <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:#33FF33; font-size: 15px;"></i>
	                                      </c:when>
	                                      <c:otherwise>
	                                         <i class="glyphicon glyphicon-registration-mark" aria-hidden="true" style="color:gray; font-size: 15px;"></i>
	                                      </c:otherwise>
                                   </c:choose>
                                     
                                   <font style="font-size: 13px; color: gray;"><b>${dto.list_idx_pointer}</b>번 답글&nbsp;&nbsp;</font> 
                                     <%--***  SUBJECT-LEV0  start line ***** 답글이 아닌 LEV=0 SUBJECT 만약 코멘트 글일 있다면 해당 코멘트 갯수를 달기위한  if statement ****--%>
	                                   <c:choose>
		                             <%-- lev!=0 이면서 답글이 있다면 --%>
		                                   <c:when test="${dto.news>=1}">
				                                 <span style="font-size: 17px;" class="subject_after" id="<c:if test="${dto.news>=1}">${dto.news}</c:if>">
															:&nbsp;&nbsp;${dto.subject}
													  <c:choose>
														  <c:when test="${dto.files eq 1}">
			                                                &nbsp;&nbsp;<i class="fa fa-file-o" aria-hidden="true" style="color: red;"></i>
													      </c:when>
														  <c:when test="${dto.files > 1}">
			                                                &nbsp;&nbsp;<i class="fa fa-files-o" aria-hidden="true" style="color: red;"></i>
													      </c:when>
													  </c:choose> 
											    </span>
											         
		                                   </c:when>
		                            <%-- lev!=0  답글이 없다면 --%>
		                                   <c:otherwise>
			                                     <span style="font-size: 17px;">
				                                       :&nbsp;&nbsp;${dto.subject}
				                                        <c:choose>
														  <c:when test="${dto.files eq 1}">
			                                                &nbsp;&nbsp;<i class="fa fa-file-o" aria-hidden="true" style="color: red;"></i>
													      </c:when>
														  <c:when test="${dto.files > 1}">
			                                                &nbsp;&nbsp;<i class="fa fa-files-o" aria-hidden="true" style="color: red;"></i>
													      </c:when>
													  </c:choose>
				                                 </span>
				                                 
		                                   </c:otherwise>
	                                   </c:choose>
<%--***  SUBJECT-LEV0  end line ***** 답글이 아닌 LEV=0 SUBJECT 만약 코멘트 글일 있다면 해당 코멘트 갯수를 달기위한  if statement ****--%>    
                                </c:when>
                             </c:choose>
                        </c:if> 
                   </span> 
           	    
                </a>	
  	         </c:otherwise>
  	    </c:choose>
		</td> 
        <td style="text-align:center;" class="overflow">${dto.writer}</td>
        <td style="text-align: center;" class="overflow"> ${dto.readnum}</td>
        <td style="text-align: center;" class="overflow"><span style="font-size: 10px;">${dto.datechar}</span></td>
	</tr>
    </c:forEach>
<%--  END  LIST FOR EACH    LIST FOR EACH END    LIST FOR EACH END    LIST FOR EACH END    LIST FOR EACH END    LIST FOR EACH END   LIST FOR EACH END --%>  
   <%--  END  LIST FOR EACH END    LIST FOR EACH END    LIST FOR EACH END    LIST FOR EACH END    LIST FOR EACH END    LIST FOR EACH END   LIST FOR EACH END --%> 
    <tr>
       <th colspan="7" style="text-align: center;" align="center">${pagination}</th>
    </tr>
  </c:otherwise>
</c:choose>
			  <tr>
			     <td colspan="7" style="text-align:center;">
			         <input type="button" class="btn btn-info active" value="글쓰기" onclick="location.href='bbsWriteformNormal.bow'">
			     </td>
			  </tr>
			 </table>
		 </div>
		 <input type="hidden" id="board_idx_animate_value" value="${board_idx_animate}">
	   </body>
				    <script>
				            /* animation idx 표시 해 줌 ~  load시 작동   */
				    
					   var idx_anima = document.getElementById("board_idx_animate_value");
					
					if(idx_anima!=null || idx_anima.value!='')
					{
						 $('#'+idx_anima.value).fadeOut('6000', function()
						 {
					        $('#'+idx_anima.value).fadeIn('6000');
						 });
				    }
				   </script>
		 
    
 </html>