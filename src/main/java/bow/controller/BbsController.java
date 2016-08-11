package bow.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



import bow.bbs.BbsDAO_imple;
import bow.bbs.BbsDTO;
import bow.bbs.CommentDTO;



@Controller
public class BbsController {
	
	@Autowired
	BbsDAO_imple bbsDao;
		
     @RequestMapping(value="/bbsList.bow",method=RequestMethod.GET)
	public String list(@RequestParam (value="cp_s", defaultValue="1") String cp_s)
	{	 
    	 
    	 return "redirect:/welcome.bow";
		/*	ModelAndView mav = new ModelAndView();		
			System.out.println("listShow~");
		 String url ="bbsList.bow";
		 int ls=bow.bbs.BbsDAO_interface.ls;
		 int ps=bow.bbs.BbsDAO_interface.ps;
		 int totalCnt=bbsDao.totalCnt();
		 int totalP=totalCnt%ls==0?totalCnt/ls:totalCnt/ls+1;
		
		 int cp=0;
		 
				 try
				 {
			       cp = Integer.parseInt(cp_s);
		           cp = totalP<cp?1:cp;	      
		         
				 }
				 catch(NumberFormatException e)
				 {
				     cp=1;
				     System.out.println("catch");
				 }
				     	 	 
		 String pagination = new Paging().pagination(url, cp, ps, ls, totalCnt,totalP);
	     
	     List<BbsDTO> list =bbsDao.bbsList(cp);		 
		 mav.addObject("cp", cp);
		 mav.addObject("bbsList",list);
		 mav.addObject("pagination",pagination);
		 mav.setViewName("bbs/bbsList");	
		 	 
	   return mav;*/
	}
	
	@RequestMapping(value="/bbsList.bow", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> bbsList(@RequestParam (value="cp_s", defaultValue="1") String cp_s,HttpServletRequest req)
	{	 
			Map<String,Object> objResult = new HashMap<String, Object>();
			Map<String,Integer> pageInfo = new HashMap<String,Integer>();	
			
		 int ls=bow.bbs.BbsDAO_interface.ls;
		 int ps=bow.bbs.BbsDAO_interface.ps;
		 int totalCnt=bbsDao.totalCnt();
		 int totalP=totalCnt%ls==0?totalCnt/ls:totalCnt/ls+1;
			
		 String url ="bbsList.bow";
		 
		 int cp=0;
				 
				 try
				 {
			       cp = Integer.parseInt(cp_s);
		           cp = totalP<cp?1:cp;	      
		         
				 }
				 catch(NumberFormatException e)
				 {
				     cp=1;
				     System.out.println("catch");
				 }
							 
			pageInfo.put("cp", cp); 
	  		pageInfo.put("ls", ls);
			pageInfo.put("ps", ps);
			pageInfo.put("totalCnt", totalCnt);
           
		  /*Date tempd =bbsDao.bbsList(cp).get(0).getWritedate();
           System.out.println(tempd);*/
	     
          /* String pagination = new Paging().pagination(url, cp, ps, ls, totalCnt,totalP); */         
         
           ArrayList<BbsDTO> boardList = (ArrayList<BbsDTO>)bbsDao.bbsList(cp);
                   
           BbsDTO dtoV  = new BbsDTO();
           
           for(int a = 0 ; a  < boardList.size() ; a++)
           {
        	   dtoV = boardList.get(a);       
        	   dtoV.setCommentDto( bbsDao.commentList( dtoV.getBoard_idx())); 
        	   boardList.set(a,dtoV);       	   
           }                    
            
          objResult.put("listDto", boardList);
           
       /*  objResult.put("pageInfo", pagination);*/
		 objResult.put("pageInfo",pageInfo);
	     objResult.put("command", url);
		 		
		 	 
	   return objResult;
	}
/*    private void commentList(int board_idx) {
		// TODO Auto-generated method stub
		
	}*/

/*	@RequestMapping(value="/bbsContent.bow",method=RequestMethod.POST)
	public @ResponseBody List<CommentDTO>content(){
		
		
		return null;
	}*/
	
	
	
    
	@RequestMapping("/bbsWriteform.bow")
	public String writeForm()
	{ 
		return "bbs/bbsWriteform";
	}
	
	
/*	@RequestMapping("/bbsWrite.bow")
	public @ResponseBody Map<String, String> write(HttpServletRequest req, BbsDTO dto)
	{
		ModelAndView mav = new ModelAndView();
			Map<String, String> msg = new HashMap<String,String>();
			
		if(req.getMethod().equals("POST"))
		{
				if(dto!=null)
				{
					 dto.setContent(dto.getContent().replaceAll("\n\r", "<br>"));
					
						if(bbsDao.bbsWrite(dto)==1)
						{
							mav.setViewName("redirect:/bbsList.bow");	
							msg.put("msg", "ok");
						}
						else
						{
							mav.setViewName("bbsMsg");
							mav.addObject("redirect","bbsList.bow");
							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER");   
							  bbs sql error  
							msg.put("msg", "고객센터 문의바람");
						}
				}
				else
				{
					mav.setViewName("bbsMsg");
					mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");
					msg.put("msg", "고객센터 문의바람");
				}
		}else
		{
			msg.put("msg", "잘못 된 접근방식");
			 mav.setViewName("bbsMsg");
			 mav.addObject("msg", "잘못된 접근방식 입니다.");
		}
		
		return msg;
	}
	*/
	@RequestMapping("/bbsWrite.bow")
	public @ResponseBody Map<String, String> write(HttpServletRequest req, BbsDTO dto)
	{
		/*ModelAndView mav = new ModelAndView();*/
		Map<String, String> msg = new HashMap<String,String>();
		
		if(req.getMethod().equals("POST"))
		{
			if(dto!=null)
			{
				/* dto.setContent(dto.getContent().replaceAll("\n\r", "<br>"));*/
				
				if(bbsDao.bbsWrite(dto)==1)
				{
					/*mav.setViewName("redirect:/bbsList.bow");	*/
					msg.put("msg", "ok");
				}
				else
				{
					/*mav.setViewName("bbsMsg");
							mav.addObject("redirect","bbsList.bow");
							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER");   */
					/*bbs sql error */ 
					msg.put("msg", "고객센터 문의바람");
				}
			}
			else
			{
				/*mav.setViewName("bbsMsg");
					mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");*/
				msg.put("msg", "고객센터 문의바람");
			}
		}else
		{
			msg.put("msg", "잘못 된 접근방식");
			/* mav.setViewName("bbsMsg");
			 mav.addObject("msg", "잘못된 접근방식 입니다.");*/
		}
		
		return msg;
	}
/*	@RequestMapping("/bbsWrite.bow")
	public ModelAndView write(HttpServletRequest req, BbsDTO dto)
	{
		ModelAndView mav = new ModelAndView();
		
		if(req.getMethod().equals("POST"))
		{
			if(dto!=null)
			{
				 dto.setContent(dto.getContent().replaceAll("\n\r", "<br>"));
				
				if(bbsDao.bbsWrite(dto)==1)
				{
					mav.setViewName("redirect:/bbsList.bow");	
				}
				else
				{
					mav.setViewName("bbsMsg");
					mav.addObject("redirect","bbsList.bow");
					mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER");   
					bbs sql error  
				}
			}
			else
			{
				mav.setViewName("bbsMsg");
				mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");
			}
		}else
		{
			mav.setViewName("bbsMsg");
			mav.addObject("msg", "잘못된 접근방식 입니다.");
		}
		
		return mav;
	}
*/	
	@RequestMapping("/bbsUpdate.bow")
	public ModelAndView update(HttpServletRequest req, BbsDTO dto)
	{
		ModelAndView mav = new ModelAndView();
		
				if(req.getMethod().equals("POST"))
				{	
						if(dto!=null)
						{
									if(bbsDao.bbsWrite(dto)==1)
									{
										mav.setViewName("redirect:/bbsList.bow");	
									}
									else
									{
										mav.setViewName("bbsMsg");
										mav.addObject("redirect","bbsList.bow");
										mav.addObject("msg", "고객센터 문의바람   errcode:BBSwSQER");   
										  /*bbs sql error */ 
									}
						}
						else
						{
							mav.setViewName("bbsMsg");
							mav.addObject("msg", "고객센터 문의바람   errcode:BBSwMOER");
						}
				}else
				{
					 mav.setViewName("bbsMsg");
					 mav.addObject("msg", "잘못된 접근방식 입니다.");
				}

       return mav;
	}
	
	@RequestMapping("/bbsDelete")
	public ModelAndView delete(int idx)
	{
		
		return null;
	}
		
	@RequestMapping(value="/bbsComment.bow")
	public ModelAndView reWrite(CommentDTO dto, HttpServletRequest req)
	{
		ModelAndView mav = new ModelAndView();
		int result=0;
	
		if(req.getMethod().equals("POST"))
		{
				if(dto!=null){
				
					result=bbsDao.commentInsert(dto);
					
					if(result==1)
					{
					       mav.addObject("cp", req.getAttribute("cp"));
					       mav.addObject("msg", "작성완료");
					}else
					{
						 mav.addObject("msg", "실패");
					}
				}
				else
				{
					mav.addObject("msg", "입력값오류");
				}
		}
		else
		{			 
			 mav.addObject("msg", "잘못된 접근방식 입니다.");	
		}
		
		mav.setViewName("bbsMsg");
		mav.addObject("url", "bbsList.bow");	
		
		return mav;
	}
	
	@RequestMapping("/commentUpdate.bow")
	public ModelAndView commentUpdate(CommentDTO dto)
	{
		
		
		return null;
	}
	
	@RequestMapping("/commentDelete.bow")
	public ModelAndView Commentdelete(int idx)
	{
		
		return null;
	}
	
	
	
}
