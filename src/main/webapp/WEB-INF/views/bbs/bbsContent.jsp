<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:url value="bbsReplyForm.bow" var="replyForm">
  <c:param name="board_idx">${dto.board_idx}</c:param>
  <c:param name="ref">${dto.ref}</c:param>
  <c:param name="lev">${dto.lev}</c:param>
  <c:param name="subject">${dto.subject}</c:param>
  <c:param name="sunbun">${dto.sunbun}</c:param>
  <c:param name="fromWhere">${option_cp}</c:param>
</c:url>
<!DOCTYPE html>
<html lang="ko">
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
  
<script type="text/javascript" src="javascript/charLength.js"></script>   
<script type="text/javascript" src="javascript/cmt_list_hide_show_trigger.js"></script>   
<script type="text/javascript" src="javascript/validCharacter.js"></script>   
<script type="text/javascript" src="javascript/byteCheck.js"></script>	
<script type="text/javascript" src="javascript/httpRequest.js"></script>	
<script type="text/javascript" src="javascript/httpRequest_Json.js"></script>	
<script type="text/javascript" src="javascript/isAvaliableBOM.js"></script>	
<script type="text/javascript" src="Script_trouble_solver/jsonPlugIn/json2.js" ></script>

  <script>
  
  /* 코멘트 삭제시 몇개 남아 있는지 보여주기 위한 스태틱 변수 입니다. */
  static_commenting_num = 0;
  
  
  
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
			            				    	   /* 지우는 태그  */
			            				    	   var target =document.getElementById(target_elem),
 			            				    	       forJQuery="#"+target.id;
			            				    	   
			            				    	   $(forJQuery).fadeOut(1000,function(){ $(this).remove(); });
			            				    	   
			            				    	   /* 삭제후 숨겨지는 태그의 갯수 static 변수에 담아둔 수로 측정을 한다.  */
			            				    	   static_commenting_num  = static_commenting_num-1,
           				    	                   
			            				    	   hideTarget = document.getElementById("hidden-list_trigger_font");
			            				    	   
			            				    	   if(static_commenting_num !=0)
		            				    		   {
		            				    		       hideTarget.innerText=static_commenting_num+"개의 코멘트 더 보기..";
		            				    		   }
			            				    	   else
		            				    		   {
			            				    		   hideTarget.innerText="";
		            				    		   }
			            				    	   
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
	/* *** 코멘트 업데이트 진입  *********************/		            	 
			            	  if(cmt_idx!="")
		            		  {
					              /* SPAN   writer_span_id
						          /* DIV   content_id 
						           cmt_idx == 실제 comment_idx 값 */       		           
		            		           
		   /* li 태그  최상위 노드 nodeInfo */    
         		                var nodeInfo  = document.getElementById(target_elem),
         		                    child     = nodeInfo.childNodes;
           		         
              /* 기존 span 및 div 에 담긴 내용물을 가져오기 위해 node 방식으로 접근 하여 내용물 추출  */
           		
                                var writer_id  = value.writer_span_id,
           		                    content_id = value.content_id;
        		               
             /*content & writer DOM info  */
   		                        
           		                var writer_id_dom  = document.getElementById(writer_id),
   		                            content_id_dom = document.getElementById(content_id);
   		                  
        	/*content & writer DOM attribute.innerText  */
   		                   
           		                var writer_id_value  = writer_id_dom.innerText;
           		                    content_id_value = content_id_dom.innerText;
           		               
           /*content & writer parent NODE */
           		                    
           		                var writer_id_motherNode =writer_id_dom.parentNode,
           		                    content_id_motherNode = content_id_dom.parentNode;
		            		               
		            		                   
      /* start* 기존 value 값을 담은 새로운input & textArea field CREATE */       
		            		          
		         /* 정보가 담길   form으로 바로 동기식 처리해 버릴꺼임    */  
		            		           var newForm = document.createElement("FORM");
		            		               newForm.setAttribute("action",cmtUpdate_command);
		            		               newForm.setAttribute("method", "POST");
		            		               
		        /* hidden 에  comment_board_idx */
		            		               var comment_board_idx = document.createElement("INPUT");
		            		                   comment_board_idx.setAttribute("type","hidden");
		            		                   comment_board_idx.setAttribute("name","comment_board_idx");
		            		                   comment_board_idx.setAttribute("value",cmt_idx);
		            		               newForm.appendChild(comment_board_idx);
		            		             
          	   /* hidden 에  option update */
		            		               var option_cmt= document.createElement("INPUT");
		            		                   option_cmt.setAttribute("type","hidden");
		            		                   option_cmt.setAttribute("name","option");
		            		                   option_cmt.setAttribute("value","update");
		            		              newForm.appendChild(option_cmt);
		            		               
		            		               
		              /* 작성자 Input   기존  writer 정보가 담긴 span 을 input 으로 */
		            		           var new_writer_input = document.createElement("INPUT");
		            		               new_writer_input.setAttribute("name", "writer");
		            		               new_writer_input.setAttribute("maxlength", 10);
		            		               new_writer_input.setAttribute("oninput", "fnChkByte(this,30,'ci',null)"); 
		            		               new_writer_input.setAttribute("value", writer_id_value);
		            		               
		            		               /* 작성자 부분 글자수 체크  */
		            		               var writer_span =document.createElement("SPAN");
		            		                   writer_span.setAttribute("id","ci");
		            		                   writer_span.setAttribute("value",writer_id_value);
		            		               
		            		                   var writer_span_after_txt =document.createTextNode("/30");
		            		               
            		               /*  새로만든 input은 부모노드의 자식으로 들어감  */
            		               writer_id_motherNode.insertBefore(new_writer_input, writer_id_dom);
		            		              
		            		               /*childNode  text 노드를 무시한다  */  
		            		               /*children   text 노드를 포함한다.  */  
		            		               
		            		      /*기존   input password 및   span 태그  writer 정보를 삭제  */
		            		                writer_id_motherNode.children[2].remove(); 
		            		                writer_id_motherNode.children[3].children[0].remove();
		            		     
		            		     /*기존   input 버튼 2개를  취소=location.reload  및  수정 완료 버튼 submit 으로 만듬  */          
		            		                writer_id_motherNode.children[3].children[0].value="수정 완료";
		            		                writer_id_motherNode.children[3].children[0].setAttribute("type","submit");
		            		                writer_id_motherNode.children[3].children[0].removeAttribute("onclick");
			            		                writer_id_motherNode.children[3].children[1].value="취소";
			            		                writer_id_motherNode.children[3].children[1].setAttribute("type","button");
			            		                writer_id_motherNode.children[3].children[1].setAttribute("onclick","window.location.reload();");
		            		               
		            		               
		            		   /* 컨텐츠  Textarea 위와 같은 형태의 작업  value 뽑아 버린 tag 버리고 바꿈  */     
		            		           var new_txtArea = document.createElement("TEXTAREA");
		            		               new_txtArea.setAttribute("name", "content"); 
		            		               new_txtArea.setAttribute("style", "width:100%"); 
		            		               new_txtArea.setAttribute("oninput", "fnChkByte(this,100,'ct',null)");
		            		               new_txtArea.value=content_id_value;
		            		               
		            		               var br =document.createElement("BR");
		            		           
		            		           var txt_span =document.createElement("SPAN");
			            		           txt_span.setAttribute("id","ct");
			            		           txt_span.innerText=content_id_value.length; 
			            		          
			            		           var span_after_txt =document.createTextNode("/100");
			            		           
		            		           
           		           content_id_dom.firstChild.remove();
           		           content_id_dom.appendChild(new_txtArea);
           		           content_id_dom.appendChild(br);
           		           content_id_dom.appendChild(txt_span);
           		           content_id_dom.appendChild(span_after_txt);
       		            
       		             newForm.appendChild(nodeInfo.childNodes[1]);
       		             nodeInfo.appendChild(newForm);
       		            
		            		  }
			            	  else
			            	  {
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
 	
/*  	$("a[name='file']").on("click",function(e){
 		
 		e.preventDefault();
 		alert();
 		file_down_anchor($(this));
 	});
 	
 	function file_down_anchor(obj)
 	{
 		  
 		   alert(obj.nextSibling.nodeName);
	   var down_submit = new down_submit();
	       down_submit.setUrl("download_file.bow");
	       down.submit.addParam("file_idx",idx);
	       
 			
 	}
 	 */
 	 
 	 
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
<%-- File File File File File File File File File File File File File File File File File File   --%>			
			<c:choose>
			   <c:when test="${empty filez}">
			     <tr>
				    <td colspan="3">
				       <span>첨부파일 : 등록 된 파일이 없습니다.</span>
				    </td>
				 </tr>
			   </c:when>
			   <c:when test="${!empty filez}">
			      <tr>
				    <td colspan="3">    
				      <c:forEach var="file" items="${filez}" varStatus="i">
				      
				       <form action="fileDown.bow" id="${i.index}_down">
				        <c:if test="${i.index == 0}">첨부파일:</c:if>
				          <a href="#" onclick="javascript:document.getElementById('${i.index}_down').submit()">
	                         <span>${file.origin_file_name}</span>				      
	                          <span>${file.file_size} byte</span>		
                          </a>
                          <input type="hidden" name="file_idx" value="${file.file_idx}">		      
                          <input type="hidden" name="stored_file_name" value="${file.stored_file_name}">		      
                          <input type="hidden" name="origin_file_name" value="${file.origin_file_name}">		      
				      </form>
				      </c:forEach>
				   </td> 
				</tr>
			   </c:when>
			</c:choose>
<%-- File File File File File File File File File File File File File File File File File File  --%>
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
<%-- *START* COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE --%>
     
      <%--&lt; or &#60; Entity name Browsers may not support all entity names, but the support for numbers is good.--%> 
  	<div class="comments-container">
  	
  	     <c:if test="${comments!=null&&dto.password==1}">
             <%-- 삭제된 컨텐츠 일 경우 댓글 달기 버튼이 없음      dto.password==1 : 살아있는 게시물  --%>
           <div style="text-align: center;">
            <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#comment-collapse">코멘트 남기기</button>
           </div>
        </c:if>
  	      <div id="comment-collapse" class="collapse" align="left">
		   <c:choose>
			    <c:when test="${dto.password==1}">
			       <form action="bbsCommentWriteNormal.bow" method="post" name="comment_area">
			              <div class="comment-main-level">
		   <%--*---------  content 코멘트 문자 정보  box START  ----------------%>
		                 <div class="comment-box">
		                     	<div class="comment-head">
			                         <input type="text" class="input-writer" name="writer" oninput="fnChkByte(this,30,null,null)" placeholder="작성자" required>
			                         <input type="password" name="password" oninput="fnChkByte(this,'9',null,'num')" maxlength="10" required style="display: block;"  placeholder="9 자리 숫자 암호 입력">
		                        </div>
                        		<div class="comment-content">
                        		   <textarea name="content" style="width: 100%; height: 50px;" oninput="fnChkByte(this,'100','t',null)" required></textarea>
						           <br><span id="t" style="display: inline-block;">0</span>/2000
                        		  <div style="text-align: center;">
                        		      <input type="submit" value="덧글입력">
                        		  </div>
                        		</div>
		                  </div>
         <%--*------   content 코멘트 문자 정보  box END  ------------------%>
                          <input type="hidden" name="board_idx" value="${dto.board_idx}">  
		             </div>
			    </form>
  	       </c:when>
		  </c:choose>
	  </div>   
<%-- * END * COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE  COMMENT WRITE AND TOGGLE --%>  	
<%--  COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START COMMENT-LIST AREA START --%>  	
  	
     <%--  <h1>&#60;&nbsp;덧글 영역&nbsp;&#62;</h1> --%>
      <ul id="comments-list" class="comments-list">
        
	  <c:choose>
	       <c:when test="${comments!=null}">
	          <c:forEach var="cmt" items="${comments}" varStatus="i">
	        <c:if test="${cmt.lev eq 0 && i.index <= 4}">
		          <li id="${i.index}_content">
  <%--**** MAIN COMMENT AREA START ********************************************************************************--%>	  
		              <div class="comment-main-level">
		   <%--*---------  content 코멘트 문자 정보  box START  ----------------%>
		                 <div class="comment-box">
		       <%---*-1---  comment header  기능들  :  1.작성자  , 2.댓글에 답변 달기  , 3. 수정및 삭제  --- -----%>
		                     	<div class="comment-head">
			                      
			                        <span>No.&nbsp;${cmt.list_idx}&nbsp;&nbsp;</span>
			                        <span id="comment_writer${cmt.list_idx}">${cmt.writer}</span> 
			                       
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
          <input type="hidden" name="board_idx" value="${dto.board_idx}">    
		             </div>
		           </li>  
		           </c:if>
		         
<%-- Start* list 5개 이상이라면 HIDE --%>
	         <c:if test="${i.index>4}">
	           <li class="hidden-list" id="${i.index}_content" style="display: none;">
	                  <div class="comment-main-level">
		                 <div class="comment-box">
		                     	<div class="comment-head" style="height:30px;">
			                      
			                        <span>No.&nbsp;${cmt.list_idx}&nbsp;&nbsp;</span>
			                        <span id="comment_writer${cmt.list_idx}">${cmt.writer}</span> 
			                        <i class="fa fa-cogs" aria-hidden="true" onclick="comment_modify('${i.index}_comment_modify')"></i>
			                        
                          <div class="comment-modify-hidden" id="${i.index}_comment_modify" style="display: none;"> 
                            <input type="password"  oninput="validNumb(this);" required="required" maxlength="10" id="${i.index}_password" placeholder="password">
							<input type="button" value="수정" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'update', index_password : '${i.index}_password',target_tr :'${i.index}_content', writer_span_id : 'comment_writer${cmt.list_idx}' , content_id : 'comment-content${cmt.list_idx}' })">
							<input type="button" value="삭제" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'delete', index_password : '${i.index}_password',target_tr :'${i.index}_content' ,comment_length : '${i.index}'})">
                          </div>
		                        </div>
                        		 <div class="comment-content" id="comment-content${cmt.list_idx}"> ${cmt.content} </div>
                        		     <input type="hidden" name="board_idx" value="${dto.board_idx}">   
		                  </div>
		             </div>
	            </li>
	         </c:if>
	     </c:forEach>
<%-- END* list HIDE 영역 --%>	     
	 <%-- 코멘트 수가 5개 이상일때 숨기고 보여주는 trigger --%> 
	     <c:set var="cmt_length" value="${fn:length(comments)}"/>
	     <%-- 코멘트 총 갯수 스크립트 전역변수에 담아둔다 ajax 처리로 인한 카운팅 목적 static_commenting_num --%>
	     <script>
	     static_commenting_num=${cmt_length-5};
	     </script>
	       <c:if test="${cmt_length-5>0}">    
		           <li class="hidden-list-trigger" style="text-align: center;"  onclick="list_trigger('hidden-list',this,'${cmt_length-5}')">
	               
                  <%-- hidden 일때는"열기" & show 일때는 "닫기" 표시 span --%>
                      <span id="hidden-list_trigger_font">${cmt_length-5}개의 코멘트 더 보기..</span>
	               </li>
          </c:if>  
      </c:when>
    </c:choose>
    </ul>
  </div>
<%-- COMMENT-LIST AREA FINISH   COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH --%>
</div>
</body>
</html>