package bow.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bow.bbs.BbsDAO_interface;
import bow.bbs.BbsDTOnorm;
import bow.bbs.CommentDTO;
import bow.bbs.Paging;
import bow.bbs.service.BbsService;

@Controller
public class BbsControllerNormal {
	
//	페이징 처리를 위해 한 페이지에 뿌려줄 리스트 사이즈  및 페이징 리스트 규격을 정함 
    private final int ls=bow.bbs.BbsDAO_interface.ls;
	private final int ps=bow.bbs.BbsDAO_interface.ps;
/*	private static String srcStr;*/
	
//	DI 방식 주입 받는다.
	
	@Autowired
	BbsDAO_interface bbsDao;
	
	@Autowired
	BbsService bbsService;

	//	어떤 페이지에서도 정적변수 current page 정보를 파라미터값으로 불러들일 수 있도록 modelAttribute 설정
/*	@ModelAttribute("cp")
	public int currentPage()
	{		
		return currPage;
	}	*/
//	처음 리스트 보여주기
    @RequestMapping(value="/bbsListNormal.bow")
	public ModelAndView list(HttpServletRequest req )
	{	 
 //     페이징 및 리스트목록 처리요소 currentPage 정보를 입력 받는다. 
 //   	만약 값을 입력 못 받거나, 
 //   	입력값이 int형으로 파싱 불가, 총게시물 갯수 ls ,ps   
    	
    	ModelAndView mav = new ModelAndView();		
		
    	 int currPage=1;
    	 
    String currPageStr=req.getParameter("cp");
    
     String url ="bbsListNormal.bow"; 
	 int totalCnt=bbsDao.totalCnt();
	 int totalP=totalCnt%ls==0?totalCnt/ls:totalCnt/ls+1;
    
    
    if(currPageStr!=null)
    	 {
		    	 try
				 {
				   System.out.println("try 안에 cp="+currPageStr);
			       currPage = Integer.parseInt(currPageStr);
			       System.out.println("cp 처리까지 괜찮음 ");
		           currPage = totalP<currPage?1:currPage;
		           System.out.println("cp totalpage 검사 ok ");
		          
		           String board_idx_animate =req.getParameter("board_idx_animate");
		           System.out.println("board_idx_animate"+board_idx_animate);
		           mav.addObject("board_idx_animate",board_idx_animate);
		      	 
		           System.out.println("bbsList currpage after:"+currPage);
				 }
				 catch(NumberFormatException e)
				 {
					      System.out.println("catch");
					      System.out.println("catch currPage:>"+currPage);
				 }
    	 }
				     	 	 
		 String pagination = new Paging().pagination(url, currPage, ps, ls, totalCnt,totalP,null,null);
	     
	     List<BbsDTOnorm> dtoList =bbsDao.bbsList_normal(currPage);		
	     
	     mav.addObject("pagination",pagination);
		 mav.addObject("bbsList",dtoList);
		 mav.addObject("option_value", null);
		 mav.setViewName("bbs/bbsList");	
		
	   return mav;
	}
    
    @RequestMapping("/bbsWriteformNormal.bow")
   	public String writeForm()
   	{ 
   		return "bbs/bbsWriteform";
   	}
    
    @RequestMapping("/bbsWriteNormal.bow")
   	public ModelAndView write(HttpServletRequest req, BbsDTOnorm dto, RedirectAttributes rt)
   	{
   		ModelAndView mav = new ModelAndView();
   		
   		if(req.getMethod().equals("POST"))
   		{
   				if(dto!=null)
   				{
   						if(bbsDao.bbsWrite_normal(dto)==1)
   						{
   						     mav.setViewName("redirect:/bbsListNormal.bow");
   						     mav.addObject("cp", 1);
   						     /* rt.addFlashAttribute("ddd", "hello");*/
   						     mav.addObject("board_idx_animate", bbsDao.afterWriteNavi(dto));
   						     return mav;
   						}
   						else
   						{
   							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER");
   						}
   				}
   				else
   				{
   					mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");
   				}
   		}else
   		{
   			 mav.addObject("msg", "허용되지 않은 접근방식 입니다.");
   		}
   		
   		 mav.addObject("location", "bbsListNormal.bow");
   		 mav.setViewName("bbs/bbsMsg");
   		
   		 return mav;
   	}
    
    
    @RequestMapping(value="/bbsContentNormal.bow",method=RequestMethod.GET)
	public ModelAndView content(HttpServletRequest req){
		
		ModelAndView mav = new ModelAndView();
     
		int board_idx=0;
	
		 String option_value =req.getParameter("option_value");
		 String option =req.getParameter("option");
		 String cp = req.getParameter("cp");
		 System.out.println("content cp값:"+cp);
		 BbsDTOnorm dto =null;
		 
		 
		
		 if(option_value!= null && option!=null )
		 {
			    mav.addObject("option_cp", cp);
             	mav.addObject("option_value", option_value);
             	mav.addObject("option",option);
		 }
		
				try {
					  board_idx= Integer.parseInt(req.getParameter("board_idx"));
					   
					  dto =bbsService.content_for_show(board_idx);
					  
					   System.out.println(dto.getBoard_idx());
					  
					   System.out.println("content.bow cp들어가기전");
					   mav.addObject("cp", bbsDao.pageNavi(board_idx));
					   System.out.println("cp들어간후");
					   System.out.println("board_idx"+dto.getBoard_idx());
				    } 
			   catch (NumberFormatException e)
				   {  
				      mav.setViewName("redirect:/bbsListNormal.bow");
				      return mav;
				   }
               System.out.println("dao 들어가기 전입니다");
			  
              
           /*   System.out.println("pwd:>>");
              System.out.println("pwd:"+dto.getPassword());
	          	
			  System.out.println("dao 들어간 후 입니다.");
			  System.out.println(board_idx);*/
			
			  List<CommentDTO> comments =bbsDao.commentList(board_idx);
			  
			  System.out.println("코멘트 dao 들어간 후 입니다.");
				
			  System.out.println("pagenavi:"+bbsDao.pageNavi(board_idx));
			  
			  
		         mav.addObject("dto",dto);
				 mav.addObject("comments",comments);
				 System.out.println("content cp값 끝무렵:");
			     mav.setViewName("bbs/bbsContent");
		    
					
		return mav;
		
	}

    
    @RequestMapping("/bbsUpdateFormNormal.bow")
    public ModelAndView contentUpdateForm(HttpServletRequest req , BbsDTOnorm dto){
    
    	ModelAndView mav = new ModelAndView();
    
    	System.out.println("updateForm>>>>>>>"+dto.getBoard_idx());
    /*    currPage=bbsDao.pageNavi(dto.getBoard_idx());*/
    	
    	if(req.getMethod().equals("POST"))
		{	
    		 mav.addObject("dto", bbsService.content_for_edit(dto.getBoard_idx()));		        	
        	 mav.setViewName("bbs/bbsUpdateForm");
		}
      return mav;
    }
    	
    @RequestMapping("/checkPwdNormal.bow")
    public @ResponseBody String pwdChek(String password,String board_idx){
    	
    	int pwd=0;
    	int board_idxs=0;
     try{
    	 System.out.println("패스워드 길이: "+password.length());
    	 
    	 if(password.equals("")||password==null)return  "{\"result\":false}";
    	   pwd=  Integer.parseInt(password);
     	   board_idxs = Integer.parseInt(board_idx);
    		
    	}catch(NumberFormatException e)
    	{
    	   e.printStackTrace();
    	   return "{\"result\":false}";
    	}
    	
    	int result =bbsDao.passwordConfirm(board_idxs,pwd);
    	
    	boolean resultB =result==1?true:false;
    	System.out.println("checkPwdNormal.bow_board_idx:"+board_idx+",password:"+password);
    	String returnValue="{\"result\":"+resultB+"}";
    	System.out.println(returnValue);
    	return returnValue ;
    }
    
    
    @RequestMapping("/bbsUpdateNormal.bow")
	public ModelAndView contentUpdate(HttpServletRequest req, BbsDTOnorm dto)
	{
		ModelAndView mav = new ModelAndView();
		
		                              
				if(req.getMethod().equals("POST"))
				{	
						if(dto!=null)
						{ 
							   mav.addObject("cp", bbsDao.pageNavi(dto.getBoard_idx()));
							   
									if(bbsDao.updateContent_normal(dto)==1)
									{
										mav.addObject("cp", bbsDao.pageNavi(dto.getBoard_idx()));
										mav.setViewName("redirect:/bbsContentNormal.bow?board_idx="+dto.getBoard_idx());										  
									}
									else
									{
										mav.setViewName("bbs/bbsMsg");
										mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER"); 
										mav.addObject("location", "bbsContentNormal.bow?board_idx="+dto.getBoard_idx());  
										  /*bbs sql error */ 
									}
						}
						else
						{
							mav.setViewName("bbs/bbsMsg");
							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");
							mav.addObject("location", "bbsListNormal.bow");  
						}
				}else
				{
					 mav.setViewName("bbs/bbsMsg");
					 mav.addObject("msg", "잘못된 접근방식 입니다.");
					 mav.addObject("location", "bbsListNormal.bow");  
				}

       return mav;
	}
    
    
    @RequestMapping("/bbsDeleteNormal.bow")
    public ModelAndView deleteContent(HttpServletRequest req){
    	
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("bbs/bbsMsg");
    	int board_idx = 0;
    	int password =0;
    	int result =0 ;
    	
    	if(req.getMethod().equals("POST"))
		{	
	      	     try {
					   board_idx= Integer.parseInt(req.getParameter("board_idx"));
					   password=Integer.parseInt(req.getParameter("password"));
				    
					   System.out.println("히릿:"+board_idx);
		        	   System.out.println("히릿피"+password);
	      	          }   
		    		    catch (NumberFormatException e)
					    {  
		    		      mav.addObject("msg", "긴급 고객센터 전화요망 err:NumEx");
					      
					      return mav;
					    }
		    	        catch (NullPointerException e1) 
      	                {
		    	          mav.addObject("msg", "고객센터 전화요망  err:NullEx");
		  			     
		  			      return mav;
						}
	      	     
	           if(bbsDao.passwordConfirm(board_idx, password)==1)
	           {
	        	  
	        	  result =bbsDao.deleteContent_normal(board_idx);
	        	  switch(result)
		          {
			          case 1 : mav.addObject("msg", "삭제가 완료 되었습니다."); 
			                   mav.addObject("location", "bbsListNormal.bow");
			                   break;

			          case 2 : mav.addObject("msg", "본문 삭제 완료"); 
			                   mav.addObject("location", "bbsContentNormal.bow?board_idx="+board_idx);
			                   break;
			          
			          case 0 : mav.addObject("msg", "삭제 실패"); 
			                   mav.addObject("location", "bbsContentNormal.bow?board_idx="+board_idx);
			                   break;
			                    
			          default: mav.addObject("msg", " 삭제 불가 고객센터 연락 요망");
		                       mav.addObject("location", "bbsContentNormal.bow?board_idx="+board_idx);
		          }
	           }
	           else
	           {
	        	   mav.addObject("msg", "비밀번호가 일치하지 않습니다.");
                   mav.addObject("location", "bbsContentNormal.bow?board_idx="+board_idx);
	           }
		}
	    else
		{
		    mav.addObject("msg", "잘못된 접근방식 입니다.");
		    mav.addObject("location", "bbsListNormal.bow");  
		}
    	return mav;
    }
    
    @RequestMapping("/bbsReplyForm.bow")
   	public ModelAndView bbsReplyForm(BbsDTOnorm dto,HttpServletRequest req)
   	{ 
    	ModelAndView mav = new ModelAndView("bbs/bbsReplyForm");
    	
    	String fromWhere =req.getParameter("fromWhere");
    	if( !(fromWhere.equals("")) || fromWhere!=null)
    	{
    		mav.addObject("fromWhere", fromWhere);
    	}
    	
   		mav.addObject("dto",dto);
    	
    	return mav;
   	}
    
    
    @RequestMapping("/replyWriteOkNormal.bow")
    public ModelAndView replyWriteNormal(HttpServletRequest req, BbsDTOnorm dto){
    	
        ModelAndView mav = new ModelAndView();

   		
   		if(req.getMethod().equals("POST"))
   		{
   			
   			System.out.println("@@@@@"+dto.getSubject());
   				if(dto!=null)
   				{
   					try{
    					   bbsDao.sunbunUp(dto.getRef(), dto.getSunbun());
	   					}
	   					catch(Exception e)
	   					{
	   						e.printStackTrace();
	   						mav.addObject("msg", "고객 센터 문의 valueEXCEP");
	   						mav.addObject("location", "bbsListNormal.bow");
	   						return mav;
	   					}
   				
   						if(bbsDao.writeReply_normal(dto)==1)
   						{
   						
   							int afterWriteBoard_idx =bbsDao.afterRewriteNavi(dto.getRef(), dto.getSunbun());
   							 
   							mav.addObject("cp",bbsDao.pageNavi(afterWriteBoard_idx));
   							mav.addObject("board_idx_animate",afterWriteBoard_idx);
   							mav.setViewName("redirect:/bbsListNormal.bow");
   							return mav;
   						}
   						else
   						{
   							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER");
   						}
   				}
   				
   		}else
   		{
   			 mav.addObject("msg", "잘못된 접근방식 입니다.");
   		}
   		
   		 mav.addObject("location", "bbsListNormal.bow");
   		 mav.setViewName("bbs/bbsMsg");
   		
   		 return mav;
   
 }
    @RequestMapping("/boardSrcNormal.bow")
    public ModelAndView boardSrc(@RequestParam (value="cp",defaultValue="1") String cp, String option_value ,String option,HttpServletRequest req)
    {
    	ModelAndView mav = new ModelAndView();
    	
    	
     	if(option_value==null || option == null || option.equals("") || option_value.equals(""))
     	{
                mav.setViewName("redirect:/bbsListNormal.bow"); 
                return mav;
    	}
    	System.out.println("==========================boardSrc들어옴===========================");
    	
    	   int src_cp =0; 
    	   try
    	   {
    		   src_cp=  Integer.parseInt(cp);
    	   }
    	   catch(Exception e)
    	   {
    		   mav.addObject("location","bbsList.bow");
    		   mav.addObject("msg", e);
    		   mav.setViewName("bbs/bbsMsg");
    		   return mav;
    	   }
    	   
    	   String board_idx_animate=req.getParameter("board_idx_animate");
    	   if(board_idx_animate!=null)
    	   {
    		   mav.addObject("board_idx_animate", board_idx_animate);
    	   }
    	   
    	   
    	   int totalCnt =bbsDao.srcTotalCnt(option,option_value);
    	   
    	   System.out.println("srcTotalCnt: "+totalCnt);
    	  
    	   int totalP=totalCnt%ls==0?totalCnt/ls:totalCnt/ls+1;
    	   
    	   System.out.println("src_cp:"+src_cp);
    	   
    	   String pagination = new Paging().pagination("boardSrcNormal.bow", src_cp, ps,ls, totalCnt, totalP,option,option_value);
    	   
    	   List<BbsDTOnorm>dtoList =bbsDao.searchingContents_normal(option,option_value,src_cp);
    	   
    	   mav.addObject("bbsList",dtoList);
    	   mav.addObject("pagination", pagination);
    	   mav.addObject("option_value", option_value);
    	   mav.addObject("option", option);
    	   mav.addObject("option_cp", cp);
    	   mav.setViewName("bbs/bbsList");   
            	   
    	return mav;
    }
    
    @RequestMapping("/bbsCommentWriteNormal.bow")
   	public ModelAndView commentWrite(HttpServletRequest req, CommentDTO dto)
   	{
   		ModelAndView mav = new ModelAndView();
   		
   		if(req.getMethod().equals("POST"))
   		{
   				if(dto!=null)
   				{
   						if(bbsDao.commentInsert(dto)==1)
   						{
   							System.out.println("있는가?"+dto.getBoard_idx());
   						     mav.setViewName("redirect:/bbsContentNormal.bow?board_idx="+dto.getBoard_idx());
   						     /*System.out.println("write.bow_Currp:"+currentPage());*/
   						     return mav;
   						}
   						else
   						{
   							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER");
   						}
   				}
   				else
   				{
   					mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");
   				}
   		}else
   		{
   			 mav.addObject("msg", "잘못된 접근방식 입니다.");
   		}
   		
   		 mav.addObject("location", "bbsListNormal.bow");
   		 mav.setViewName("bbs/bbsMsg");
   		
   		 return mav;
   	}
    
    
    @RequestMapping("/bbsCommentUpdateNormal.bow")
   	public ModelAndView commentUpdate(HttpServletRequest req, CommentDTO dto)
   	{
   		ModelAndView mav = new ModelAndView();
   		System.out.println("bbsCommentUpdateNormal.bow 진입 입니다.");
   	
   				if(req.getMethod().equals("POST"))
   				{	
   					String option =req.getParameter("option");
   					System.out.println("option :"+option);
   					System.out.println("dto :"+dto);
   						if(dto!=null && option!=null)
   						{
	   							if(option.equals("delete"))
	   							{
	   								System.out.println("delete 진입");
				   							 if(bbsDao.commentDelete(dto.getComment_board_idx())==1)
												{
											
													/*mav.setViewName("redirect:/bbsContentNormal.bow?board_idx="+dto.getBoard_idx());	*/	
				   								      mav.addObject("result",true);
				   								      mav.setViewName("bbs/cmtResult");
												}
												else
												{
													mav.setViewName("bbs/bbsMsg");
													mav.addObject("msg", "값이 일치하지않습니다. 삭제 불가   errcode:BBSwSQER"); 
													mav.addObject("result","false");
													/*mav.addObject("location", "bbsContentNormal.bow?board_idx="+dto.getBoard_idx());*/  
													  /*bbs sql error */ 
												}
	   							}
	   							else if(option.equals("update"))
	   							{
			   	   								
			   	   							 if(bbsDao.commentUpdate(dto)==1)
			   									{
			   	   							        mav.addObject("result","true");
			   	   							        mav.setViewName("bbs/bbsMsg");
			   										/*mav.setViewName("redirect:/bbsContentNormal.bow?board_idx="+dto.getBoard_idx());*/										  
			   									}
			   									else
			   									{
			   										mav.setViewName("bbs/bbsMsg");
			   										mav.addObject("result","false");
			   										mav.addObject("msg", "값이 일치하지않습니다. 수정불가   errcode:BBSwSQER"); 
			   										/*mav.addObject("location", "bbsContentNormal.bow?board_idx="+dto.getBoard_idx());*/  
			   										  /*bbs sql error */ 
			   									}
	   							}
   						}
   						else
   						{
   							mav.setViewName("bbs/bbsMsg");
   							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");
   							mav.addObject("location", "bbsListNormal.bow?cp="+bbsDao.pageNavi(dto.getBoard_idx()));  
   						}
   				}else
   				{
   					 mav.setViewName("bbs/bbsMsg");
   					 mav.addObject("msg", "잘못된 접근방식 입니다.");
   					 mav.addObject("location", "bbsListNormal.bow?cp="+bbsDao.pageNavi(dto.getBoard_idx()));  
   				}

          return mav;
   	} 
    
    @RequestMapping("/bbsCmtPwdCheck.bow")
    public @ResponseBody String cmt_pwd_check(HttpServletRequest req) throws  IOException
    {
    	Long pwd=0L;
    	Long cmt_idx=0L;
       
     try{
    	       ObjectMapper mapper = new ObjectMapper();
    	   
			    String pwd_s =mapper.writeValueAsString(req.getParameter("password"));
	    	    System.out.println("패스워드 길이: "+pwd_s.length());
	    	  
	    	   String cmt =mapper.writeValueAsString(req.getParameter("comment_board_idx"));
	    	   System.out.println("cmt_idx 길이: "+cmt.length());
	    	   
	    	   
	    	   System.out.println("pwd json before:>"+pwd_s);
	    	   pwd_s=pwd_s.substring(1, pwd_s.length()-1);
	    	   System.out.println("pwd json after:>"+pwd_s);
	    	   System.out.println("파싱 후 pwd 길이: "+pwd_s.length());
	    	   
	    	   System.out.println("cmt before parsing json :>>"+cmt);
	           cmt=cmt.substring(1, cmt.length()-1);
	           System.out.println("cmt before parsing json :>>"+cmt);
	           System.out.println("파싱 후 cmt_idx 길이: "+cmt.length());
           
           
	    	   if(pwd_s.equals("")||pwd_s==null)return "{\"result\":false}";
	    	       
	    	   pwd= Long.parseLong(pwd_s);
	    	   cmt_idx = Long.parseLong(cmt);
    		
    	}catch(NumberFormatException e)
    	{
    	   e.printStackTrace();
    	   return "{\"result\":false}";
    	}
    	
    	   int result =bbsDao.cmtPwdCheck(cmt_idx, pwd);
    	
    	boolean resultB =result==1?true:false;
    	System.out.println("bbsCmtPwdCheck.bow?comment_idx:"+cmt_idx+",password:"+pwd);
    	String returnValue="{\"result\":"+resultB+"}";
    	System.out.println(returnValue);
    	return returnValue ;
    	
    }
    
  
    
}