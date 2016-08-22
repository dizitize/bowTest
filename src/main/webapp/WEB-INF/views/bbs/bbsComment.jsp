<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     
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
		            <%--------- 작성자 아이콘     -----------------------%>
		                   <div class="comment-avatar"><img src="image/vent2.jpg" alt="node"></div>
		   <%--*---------  content 코멘트 문자 정보  box START  ----------------%>
		                 <div class="comment-box">
		       <%---*-1---  comment header  기능들  :  1.작성자  , 2.댓글에 답변 달기  , 3. 수정및 삭제  --- -----%>
		                     	<div class="comment-head">
			                      
			                        <h6 class="comment-name by-author" id="${cmt.writer}">No. ${cmt.list_idx}</h6>
			                      
			                       <%--  작성 후 경과 시간 작성  지금은 주석 처리 중    --%>
			                       <%--  <span>hace 20 minutes </span> --%>
			                       
			                        <%--  아래 글 수정 hidden area DIV id 값을 전달  보이게 해 주는 onClick event --%>   
			                        <i class="fa fa-cogs" aria-hidden="true" onclick="comment_modify('${i.index}_comment_modify')"></i>
			                        <i class="fa fa-commenting" aria-hidden="true"></i>
			                        
                       <%-- hidden 글 수정  hidden start default = display none & visibility hidden--%>
                          <div class="comment-modify-hidden" id="${i.index}_comment_modify" style="display: none;"> 
                            <input type="password"  oninput="validNumb(this);" required="required" maxlength="10" id="${i.index}_password" placeholder="password">
							<input type="button" value="수정" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'update', index_password : '${i.index}_password',target_tr :'${i.index}_content'})">
							<input type="button" value="삭제" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'delete', index_password : '${i.index}_password',target_tr :'${i.index}_content'})">
                          </div>
	          		  <%-- hidden 글 수정 hidden start default = display none & visibility hidden--%>                     
		                        </div>
		        <%---*-1---  comment header  END  --------------------------------------- -----%>
		                   <%-- comment content 글 내용            ----------------------------------------%>  
                        		<div class="comment-content"> ${cmt.content} </div>
                          <%-- comment content 글 내용  END -----------------------------------------%>
		                  </div>
         <%--*------   content 코멘트 문자 정보  box END  ------------------%>  
		             </div>
  <%--**** MAIN COMMENT AREA END *************************************************************************************--%>
		           </c:if>
  <%--*******( SUB AREA START ) in MAIN AREA ********************************************************************************************************--%>	             
		    
				         <ul class="comments-list reply-list">
				              <c:if test="${cmt.lev ne 0 }">
				               <li id="${i.index}_content">
				                    <%---------   코멘트  작성자 아이콘     -----------------------%>
				                   <div class="comment-avatar"><img src="image/vent2.jpg" alt="node"></div>
	    <%---------  SUB box START  -----------------------------------------%>
				                   <div class="comment-box">
					      <%--- SUB header  기능들  :  1.작성자  , 2.수정및 삭제  --- -----%>
					                     	<div class="comment-head">
						                      
							                   <h6 class="comment-name by-author" id="${cmt.writer}">No. ${cmt.list_idx}</h6>
							                      
							                       <%--  작성 후 경과 시간 작성  지금은 주석 처리 중    --%>
							                       <%--  <span>hace 20 minutes </span> --%>
							                       
							                   <%--  아래 글 수정 hidden area 열어주는  onClick event --%>  
							                   <i class="fa fa-cogs" aria-hidden="true" onclick="comment_modify('${i.index}_comment_modify')"></i>
				      
				         <%-- 글 수정 hidden default = display none & visibility hidden--%>            
							          <div class="comment-modify-hidden" id="${i.index}_comment_modify" style="display:none; "> 
			                            <input type="password"  oninput="validNumb(this);" required="required" maxlength="10" id="${i.index}_password" placeholder="password">
										<input type="button" value="수정" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'update', index_password : '${i.index}_password',target_tr :'${i.index}_content'})">
										<input type="button" value="삭제" onclick="sendSubmit( {cmt_idx : '${cmt.comment_board_idx}' ,command_option : 'delete', index_password : '${i.index}_password',target_tr :'${i.index}_content'})">
			                          </div>
							                   
					                        </div>
					      <%--- SUB header  END  --------------------------------------- -----%>
					         <%--  SUB content 글 내용            ----------------------------------------%>  
					                       <div class="comment-content">  ${cmt.content}  </div>
						                        
					                      
			                <%--  SUB content 글 내용  END -----------------------------------------%>
				                  </div>
		 <%---------  SUB box END  ------------------------------------------------%>  
				             </li> 
				            </c:if> 
		                </ul>
   <%--******( SUB AREA END ) in MAIN AREA ************************************************************************************************************--%>		             
		         </li>  
	     </c:forEach>
    
         <c:if test="${dto.password==1}">
             <%-- 삭제된 컨텐츠 일 경우 댓글 달기 버튼이 없음      dto.password==1 : 살아있는 게시물  --%>
         </c:if>
   </c:when>
	      <c:when test="${comments==null&&dto.password==1}">
	               <%-- 코멘트 없음 --%>
	      </c:when>
	 </c:choose>
    </ul>
  </div>
<%-- COMMENT-LIST AREA FINISH   COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH  COMMENT-LIST AREA FINISH --%>
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
                        		   <textarea name="content" style="width: 600px;" oninput="fnChkByte(this,'2000','t',null)" required></textarea>
						           <br><span id="t" style="display: inline-block;">0</span>/2000
                        		</div>
                          <%-- comment content 글 내용  END -----------------------------------------%>
		                  </div>
         <%--*------   content 코멘트 문자 정보  box END  ------------------%>
                          <input type="hidden" name="board_idx" value="${dto.board_idx}">  
		             </div>
			      </form>
              </c:when>
	     </c:choose>
	</div>   
	
	
	
	
	
	
	<!-- 아래 콜랩스 버튼과 코멘트 입력 폼   -->
	
	    <c:if test="${comments!=null&&dto.password==1}">
             <%-- 삭제된 컨텐츠 일 경우 댓글 달기 버튼이 없음      dto.password==1 : 살아있는 게시물  --%>
            <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#comment-collapse" >코멘트 남기기</button>
        </c:if>
	
	
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
	  
	
	
	
	