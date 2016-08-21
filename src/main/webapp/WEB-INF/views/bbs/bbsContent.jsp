<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="bbsReplyForm.bow" var="replyForm">
  <c:param name="board_idx">${dto.board_idx}</c:param>
  <c:param name="ref">${dto.ref}</c:param>
  <c:param name="lev">${dto.lev}</c:param>
  <c:param name="subject">${dto.subject}</c:param>
  <c:param name="sunbun">${dto.sunbun}</c:param>
  <c:param name="fromWhere">${option_cp}</c:param>
</c:url>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bow-content</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

 
  <link rel="stylesheet" type="text/css" href="http://googleapis.com/css?family=Roboto:400,700">  
  <link rel="stylesheet" href="font-awesome-4.6.3/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/comment.css">
    
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
  
<script type="text/javascript" src="javascript/validCharacter.js"></script>   
<script type="text/javascript" src="javascript/byteCheck.js"></script>	
<script type="text/javascript" src="javascript/httpRequest.js"></script>	
<script type="text/javascript" src="javascript/httpRequest_Json.js"></script>	
<script type="text/javascript" src="javascript/isAvaliableBOM.js"></script>	
<script type="text/javascript" src="Script_trouble_solver/jsonPlugIn/json2.js" ></script>

  <script>
  function check(name,progid){
	  
	  var installed;
	  var msg;
	  
	  if(window.ActiveXObject) 
	  {
			 
      try{
		    var axObj = new ActiveXObject(progid);
			 
			  if(axObj)
			  {
				 installed = true;
			  }else
			  {
				 installed =false;
			  }
				 
		 }catch(e)
		 {
		    installed =false;
		 }
					 if(installed)
					 {
						msg = '설치됨';
					 }else
					 {
					   msg= name+'미설치';
					 }
	  
        return msg;
     }
  }
	 var ex =check('Adobe PDF Link Helper','AcroIEHelperShim.AcroIEHelperShimObj');
  
    	 /*value =board_idx , key = deleteorupdate , id_key */
  function sendSubmit(value,key,id_key)
  {
	   var  board_idx=value 
	       ,cmt_idx=0 
	       ,command_option
	 	   ,pwd = document.getElementById("passwordV")
	 	   ,pwdValue=pwd.value;
 	       
 	      pwdValue = pwdValue.substring(0,9);		 
 		 
 	     console.log(typeof(value));
    		 
    if(typeof(value)=="number")
   	{
    	console.log("typeof number");
   	    board_idx = value;
   	}
    else if(typeof(value)=="object")
   	{
   	    console.log("typeof object");
   	    cmt_idx = value.cmt_idx;
   	    key=value.command_option;
   	    pwd=document.getElementById(value.index_password);
   	    pwdValue=pwd.value;
   	  
   	    var target_elem = value.target_tr;
   	    
   	    console.log("comment 관련\n cmt_idx: "+cmt_idx+ " key: "+key+"  pwdValue: "+pwdValue +"target_element ="+target_elem);
   	}
	
	var delOrUpdate =key;
	
	if(pwdValue.replace(/\s/g,"")=="" || pwdValue==null || pwdValue==undefined)
	{
		     pwd.value="";
		     alert('값을 입력하세요.');
	    	 return;
	}
	
	var checkCmtCommand="bbsCmtPwdCheck.bow"
	   ,checkCommand="checkPwdNormal.bow"
	
	   , deleteCommand ="bbsDeleteNormal.bow"
	   , updateCommand ="bbsUpdateFormNormal.bow"
	
	   , cmtUpdate_command="bbsCommentUpdateNormal.bow"
	   , cmtListShow=""
	   , params;
	
	
	pwdValue=pwdValue.replace(/\D/g,""); 
	
	if(cmt_idx!="")
		{
		      params="password="+pwdValue+"&comment_board_idx="+cmt_idx;
		      checkCommand=checkCmtCommand;
		      console.log("param information: "+params);
		}
	else
		{
		      params="password="+pwdValue+"&board_idx="+board_idx;
		}
	    
 	 sendRequest(checkCommand, params, getResult, 'POST'); 
	  
 		function getResult()
 		{
		 	 if(XHR.readyState==4)
			 {
			    if(XHR.status==200)
		    	{
		            var ajaxReturn = XHR.responseText; 
		                ajaxReturn =JSON.parse(ajaxReturn); 
		       
		            var result =ajaxReturn.result;   
                 
			              if(result && delOrUpdate=='delete')
			              {
				           	     if(confirm('정말로 삭제 하시겠습니까?'))
				           		 {
				           	    	 if(cmt_idx!=0)
				           	    	 {
				           	    		 
				            		   params+="&option=delete";
				            		   method="POST";
				            		   console.log("params: "+params+" method: "+method);
					            	   
				            		   sendRequest(cmtUpdate_command, params, delete_cmt_element, method);  
				            		  
				            		   function delete_cmt_element()
				            		   {
				            			   if(XHR.readyState==4 && XHR.status==200)
			            				   {

				            				   var data =JSON.parse(XHR.responseText);
			            				       console.log("parsing 전  data.result 결과 입니다 :"+data.result);
			            				      
			            				       if(data.result==true)
		            				    	   {
			            				    	   var target =document.getElementById(target_elem),
 			            				    	       forJQuery="#"+target.id;
			            				    	  
			            				    	   $(forJQuery).fadeOut(1000,function(){ $(this).remove(); });
		            				    	   }
			            				       else
		            				    	   {
		            				    	       alert("고객센터 문의바람 ERR_CODE: ASYNC_0001");
		            				    	   }
			            				   }
				            		   }
				            		   
				           	    	 }
				           	    	 else
				           	    	 {
				           	    	    resultSend(deleteCommand,board_idx,pwdValue,'POST');
				           	    	 }	 
				           	    	 
				           		 }
				           	     else
				           	     {
				           	    	$("#collapse-1").collapse("hide"); 
				           	    	
				           	    		pwd.value="";
					           	    	pwd.placeholder='수정&삭제 비밀번호';
				           	    	
				           	    	    return;
				           	     }
			              }
			              else if(result && delOrUpdate=='update')
			              {
			            	  pwdValue=pwdValue.replace(/\s/g,"");
			            	 
			            	  if(cmt_idx!="")
		            		  {
		            		           alert("코멘트 업데이트 입니다.");
		            		           var nodeInfo = document.getElementById(target_elem);
		            		           var child =nodeInfo.childNodes;
		            		           
		            		           alert(nodeInfo.nodeName);
		            		           
		            		           /* SPAN  writer_span_id */
		            		           /* DIV   content_id */
		            		           var writer_id =value.writer_span_id,
		            		               content_id = value.content_id;

		            		              
				            		           console.log("writer_span_id : "+writer_id); 
				            		           console.log("content_id : "+content_id); 
			            		           
			            		       /* 작성 내용 제목과 컨텐츠 내용을 받음  */
		            		           var writer_span_tag = document.getElementById(writer_id),
		            		               content_id_tag = document.getElementById(content_id),
		            		                  writer_span_id_value = document.getElementById(writer_id).innerHTML,
		            		                  content_id_value   = document.getElementById(content_id).innerHTML;
		            		 alert(writer_span_tag);
			            		       writer_span_tag.tagName = "INPUT";
			            		           
            		               /* input tag & textArea 로 변경 시킨다.  */
		            		         
   /*   var changeTagWrtier  =   document.createElement("INPUT"), 
         changeTagContent =   document.createElement("TEXTAREA");            		                
		            		               
         changeTagWrtier.setAttribute( "value", writer_span_id_value);		            		               
         changeTagWrtier.setAttribute( "name", "writer");
         
         writer_span_tag.
         
         changeTagContent.setAttribute("value", content_id_value);
         changeTagWrtier.setAttribute( "name", "content"); */
         
         
            
        
        
		            		           alert(writer_span_id);
		            		           alert(content_id);
		            		           
		            		           
		            		           
		            		        /*    params+="&option=update&writer="+writer+"&content="+content; */
		            		           method="POST";
		            		           console.log(params+" method="+method);
					            	  
		            		           
		            		           
		            		           
		            		           
		            		           /* sendRequest(cmtUpdate_command, params, cmtUpdate_command, method); */
		            		           /* 삭제 하고나서 코멘트 div에 ajax로 코멘트 리스트를 다시 뿌려준다*/
		            		  }
			            	  else
			            	  {
			            		   /* alert(result); */
				            	   /* alert(pwd.value); */
				            	  resultSend(updateCommand, board_idx, pwdValue,'POST'); 
			            	  }	  
			              }
			              else
		            	  {
			            	  if(isIE){
			            		  
			            		   alert('비밀번호가 틀립니다.');
			            		   document.getElementById("p").innerText=0;
			            		   pwd.value="";
			            	   
			            	  }
			            	  else
			            	  {
			            		  pwd.value="";
				                  pwd.placeholder="비밀번호가 틀립니다.";  
				                  document.getElementById("p").innerText=0;
				                  alert('비밀번호가 틀립니다.');
				                   /*   pwd.focus(); */
			            	  }
		            	  }
		    	}
		 	}
 		} 
 	
 	 function resultSend(commandURL ,board_idx, password,method)
     {
 		  
 	  var form = document.createElement("FORM");  
 		
	 		    form.setAttribute("action",commandURL);
	 	        form.setAttribute("method", method); 
 	            
	      var pwd = document.createElement("INPUT");
	            pwd.setAttribute("type", "hidden");
		 	    pwd.setAttribute("name", "password");
		 	    pwd.setAttribute("value", password); 

		 	    form.appendChild(pwd);   
		 	    
		 	var inp1 = document.createElement("INPUT");
		 	    inp1.setAttribute("type", "hidden");
		 	    inp1.setAttribute("name", "board_idx");
		 	    inp1.setAttribute("value", board_idx);

 	            form.appendChild(inp1);
 		 
 	     window.document.body.appendChild(form);  
 	    
 		  form.submit();
 	 }
  }
    	 
 	/* 코멘트 수정  hidden DIV<-(1.패스워드 입력  2.수정  버튼 3.삭제 버튼 ) 활성화 위한  함수 
 	   param = target DIV ID value
 	*/
 	function comment_modify(hidden_div_id)
 	{
 		console.log("**************** function comment_modify(hidden_div_id) *****************")
 		console.log("parameter *hidden_div_id* Value : "+hidden_div_id)
 		
 		var target = document.getElementById(hidden_div_id),
 		    target_style =target.style;
 		
        console.log("*hidden_div_id* display status :"+target_style.display);
 		
        if(target_style.display=='none')
		{
		   target_style.display= 'block';
		}
 		else
		{
		   target_style.display= 'none';
		}
 	}
  </script>

</head>
<body><div class="container">
  <h5>BOW-TECH_BBS_CONTENT</h5>
	<table class="table table-bordered">
		<thead>
			<tr>
	        	<td colspan="2"><span>조회수 : ${dto.readnum}</span></td>   
			</tr>
			<tr>
				<td><span>작성자 : ${dto.writer}</span></td>
				<td>작성일 :  ${dto.datechar}</td>		
			</tr>
			<tr>
			 <td colspan="2"><span>제&nbsp;&nbsp;&nbsp;목 : </span>${dto.subject}</td>
			</tr>
			<tr>
				<td colspan="3" class="col-md-2"><pre style="word-wrap: break-word;white-space: pre-wrap;white-space: -moz-pre-wrap;white-space: -pre-wrap;white-space: -o-pre-wrap;word-break:break-all;">${dto.content}</pre></td>
			</tr>
	    </thead>
	   
	    <tbody>	
			<tr>
			   <td colspan="3">
			         <c:choose>
					     <c:when test="${dto.password==1}">
					                <c:choose>
						                 <c:when test="${option_cp!=null&&option!=null&&option_cp!=null}">
							                 <input type="button" onclick="location.href='boardSrcNormal.bow?cp=${option_cp}&option=${option}&option_value=${option_value}&board_idx_animate=${dto.board_idx}'" value="검색 목록가기">   
							             </c:when>
							             <c:otherwise> 
								             <input type="button" onclick="location.href='bbsListNormal.bow?cp=${cp}&board_idx_animate=${dto.board_idx}'" value="목록가기">
								         </c:otherwise> 
						            </c:choose>
						    <input type="button" name="reply" value="답글 작성" onclick="location.href='${replyForm}'">
						  
						    <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#collapse-1" id="gate">수정 및 삭제</button>
		
				<form onsubmit="return false;" name="pwdCheck">     
							  <div id="collapse-1" class="collapse" align="left" >
							      <div>
							      <input type="password" id="passwordV" placeholder="수정&삭제 비밀번호" oninput="fnChkByte(this,'9','p','num')" required="required" maxlength="10"> 
							      <span id="p">0</span>/9
							      <br>
							      </div>
							      <div style="margin-top:5px;">
							      <input type="button" name="updateForm"  value="수정" onclick="sendSubmit(${dto.board_idx},'update','passwordV');">
						          <input type="button" name="del_content" value="삭제" onclick="sendSubmit(${dto.board_idx},'delete','passwordV');">
							      </div>
							  </div>
			    </form>  
					     </c:when>
					     <c:otherwise>	 
						        <c:choose>
						             <c:when test="${option_cp!=null&&option!=null&&option_cp!=null}">
						                 <input type="button" onclick="location.href='boardSrcNormal.bow?cp=${option_cp}&option=${option}&option_value=${option_value}&board_idx_animate=${dto.board_idx}'" value="검색 목록가기">   
						             </c:when>
						             <c:otherwise>
						                <input type="button" onclick="location.href='bbsListNormal.bow?cp=${cp}&board_idx_animate=${dto.board_idx}'" value="목록가기"> 
						             </c:otherwise>
						        </c:choose> 
					    </c:otherwise>
				</c:choose> 
             </td>
		  </tr>
	  </tbody>
    </table>
     
     
<%--  COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START --%>
     
      <%--&lt; or &#60; Entity name Browsers may not support all entity names, but the support for numbers is good.--%> 
  	<div class="comments-container">
     <%--  <h1>&#60;&nbsp;덧글 영역&nbsp;&#62;</h1> --%>
      <ul id="comments-list" class="comments-list">
        
	  <c:choose>
	       <c:when test="${comments!=null}">
	          <c:forEach var="cmt" items="${comments}" varStatus="i">
	         
		          <li id="${i.index}_content">
		            
		            <c:if test="${cmt.lev eq 0}">
  <%--**** MAIN COMMENT AREA START ********************************************************************************--%>	  
		              <div class="comment-main-level">
		   <%--*---------  content 코멘트 문자 정보  box START  ----------------%>
		                 <div class="comment-box">
		       <%---*-1---  comment header  기능들  :  1.작성자  , 2.댓글에 답변 달기  , 3. 수정및 삭제  --- -----%>
		                     	<div class="comment-head">
			                      
			                       
			                        <span>No.&nbsp;${cmt.list_idx}&nbsp;&nbsp;</span>
			                        <span id="comment_writer${cmt.list_idx}">${cmt.writer}</span> 
			                       <%--  작성 후 경과 시간 작성  지금은 주석 처리 중    --%>
			                       <%--  <span>hace 20 minutes </span> --%>
			                       
			                        <%--  아래 글 수정 hidden area DIV id 값을 전달  보이게 해 주는 onClick event --%>   
			                        <i class="fa fa-cogs" aria-hidden="true" onclick="comment_modify('${i.index}_comment_modify')"></i>
			                   <!--      <i class="fa fa-commenting" aria-hidden="true"></i> -->
			                        
                       <%-- hidden 글 수정  hidden start default = display none & visibility hidden--%>
                          <div class="comment-modify-hidden" id="${i.index}_comment_modify" style="display: none;"> 
                            <input type="password"  oninput="validNumb(this);" required="required" maxlength="10" id="${i.index}_password" placeholder="password">
							<input type="button" value="수정" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'update', index_password : '${i.index}_password',target_tr :'${i.index}_content', writer_span_id : 'comment_writer${cmt.list_idx}' , content_id : 'comment-content${cmt.list_idx}' })">
							<input type="button" value="삭제" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'delete', index_password : '${i.index}_password',target_tr :'${i.index}_content'})">
                          </div>
	          		  <%-- hidden 글 수정 hidden start default = display none & visibility hidden--%>                     
		                        </div>
		        <%---*-1---  comment header  END  --------------------------------------- -----%>
		                   <%-- comment content 글 내용            ----------------------------------------%>  
                        		 <div class="comment-content" id="comment-content${cmt.list_idx}"> ${cmt.content} </div>
                          <%-- comment content 글 내용  END -----------------------------------------%>
		                  </div>
         <%--*------   content 코멘트 문자 정보  box END  ------------------%>  
		             </div>
 
		           </c:if>
		         </li>  
	     </c:forEach>
      </c:when>
 <%--**** MAIN COMMENT AREA END *************************************************************************************--%>      
    </c:choose>
    </ul>
    
      <c:if test="${comments!=null&&dto.password==1}">
             <%-- 삭제된 컨텐츠 일 경우 댓글 달기 버튼이 없음      dto.password==1 : 살아있는 게시물  --%>
            <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#comment-collapse" >코멘트 남기기</button>
      </c:if>
  </div>
<%-- COMMENT-LIST AREA FINISH   COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH --%>

       <%--   <c:choose>
           <c:when test="${comments!=null}">
              <c:forEach var="cmt" items="${comments}" varStatus="i">
				    <tr id="${i.index}_content">
				        <td colspan="2" >
				        <span >&nbsp;No. ${cmt.list_idx}&nbsp;&nbsp;&nbsp;<b>${cmt.writer}</b></span>     
				        <br>
					    <pre style=" word-wrap: break-word; white-space: pre-wrap; white-space: -moz-pre-wrap; white-space: -pre-wrap; white-space: -o-pre-wrap;word-break:break-all;">${cmt.content}</pre>			
				        <div style="display: inline-block;"> 
				            <label style="font-size: 10px;">Password:</label>
				            <input type="password"  oninput="validNumb(this);" required="required" maxlength="10" id="${i.index}_password">
							<input type="button" value="수정" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'update', index_password : '${i.index}_password',target_tr :'${i.index}_content'})">
							<input type="button" value="삭제" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'delete', index_password : '${i.index}_password',target_tr :'${i.index}_content'})">
					   </div>
				       </td>
				    </tr>
                </c:forEach>   
                <c:if test="${dto.password==1}">
                   <tr>
                      <td colspan="2">
                        <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#comment-collapse">코멘트 남기기</button>
                       </td>
                    </tr>
                </c:if>
             </c:when>
	         <c:when test="${comments==null&&dto.password==1}">
				    <tr>
				  	    <td colspan="2">덧글없음</td>
				    </tr>
				    <tr>
                      <td>
                        <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#comment-collapse">코멘트 남기기</button>
                       </td>
                    </tr>
	         </c:when>
	   </c:choose>
--%>

          <div id="comment-collapse" class="collapse" align="left">
		   <c:choose>
			    <c:when test="${dto.password==1}">
			       <form action="bbsCommentWriteNormal.bow" method="post" name="comment_area">
			              <div class="comment-main-level">
		            <%--------- 작성자 아이콘     -----------------------%>
		   <%--*---------  content 코멘트 문자 정보  box START  ----------------%>
		                 <div class="comment-box">
		       <%---*-1---  comment header  기능들  :  1.작성자  , 2.댓글에 답변 달기  , 3. 수정및 삭제  --- -----%>
		                     	<div class="comment-head">
			                         <input type="text" class="input-writer" name="writer" oninput="fnChkByte(this,30,null,null)" required>
			                         <input type="password" name="password" oninput="fnChkByte(this,'9',null,'num')" maxlength="10" required style="display: block;">
				                     <input type="submit" value="덧글입력">
                                           
		                        </div>
		        <%---*-1---  comment header  END  --------------------------------------- -----%>
		                   <%-- comment content 글 내용            ----------------------------------------%>  
                        		<div class="comment-content">
                        		   <textarea name="content" style="width: 100%;" oninput="fnChkByte(this,'2000','t',null)" required></textarea>
						           <br><span id="t" style="display: inline-block;">0</span>/2000
                        		</div>
                          <%-- comment content 글 내용  END -----------------------------------------%>
		                  </div>
         <%--*------   content 코멘트 문자 정보  box END  ------------------%>
                          <input type="hidden" name="board_idx" value="${dto.board_idx}">  
		             </div>
			    </form>
			    
			    
				   <%--  <form action="bbsCommentWriteNormal.bow" method="post" name="comment_area">
				      <div class="container" align="left">
					       <div align="left">
						      <span style="display: block;">제목 :</span><input type="text" class="input-writer" name="writer" oninput="fnChkByte(this,30,null,null)" required>
						   </div>
						   <div align="left">
						      <textarea name="content" style="width: 600px;" oninput="fnChkByte(this,'2000','t',null)" required></textarea>
						      <br><span id="t" style="display: inline-block;">0</span>/2000
						   </div>    
						   <div align="left">
						       <span>비밀번호</span>
						        <input type="password" name="password" oninput="fnChkByte(this,'9',null,'num')" maxlength="10" required style="display: block;">
				                <input type="submit" value="덧글입력">
						   </div>  
						<input type="hidden" name="board_idx" value="${dto.board_idx}">
					 </div>	
				    </form> --%>
		      </c:when>
		  </c:choose>
	  </div>   
	  
	  
  </div>
  
  <script>
     
    var arr = new Array();
  
    arr['DIV'] = "Korea";
    
    console.log(arr['DIV']);
  
    
    var mother = document.documentElement;
                 /* 
                  docuement.documentElement 

  Tip: The difference between this property and the document.body property, 
       is that the document.body element returns the <body> element, 
       while the document.documentElement returns the <html> element.
                  
        mother.body;
    
      console.log(mother.children.length);
      console.log(mother.children.firstChild.nodeName);
      */
    
    
  
  </script>
  
  
</body>
</html>