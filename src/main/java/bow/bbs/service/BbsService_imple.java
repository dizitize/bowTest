package bow.bbs.service;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import bow.bbs.BbsDAO_interface;
import bow.bbs.BbsDTOnorm;


public class BbsService_imple implements BbsService {
    
	@Autowired
	BbsDAO_interface bbsDao;
	
	public BbsService_imple() {
		// TODO Auto-generated constructor stub
	}
	
	/* text area doesn't need to HTML style */
	public BbsDTOnorm content_for_edit(int board_idx) 
	{
		return bbsDao.bbsContent_normal(board_idx);
	}
	
	/* HTML style need to HTML style protocol */
	public BbsDTOnorm content_for_show(int board_idx) 
	{
		BbsDTOnorm dto =bbsDao.bbsContent_normal(board_idx);
		
		dto.setContent(dto.getContent().replaceAll("<", "&lt;"));
		dto.setContent(dto.getContent().replaceAll(">", "&gt;"));
		dto.setContent(dto.getContent().replaceAll("/r/n","<br>"));
		
		dto.setSubject(dto.getSubject().replaceAll("<", "&lt;"));
		dto.setSubject(dto.getSubject().replaceAll(">", "&gt;"));

		dto.setWriter(dto.getWriter().replaceAll("<", "&lt;"));
		dto.setWriter(dto.getWriter().replaceAll(">", "&gt;"));
		
		return dto;
	}
	
	/*define the key=board_idx & value=password*/
	
	public int passwordCheck(String board_idx, String password) {
		// TODO Auto-generated method stub
		
		int result =0;
		
		if((!board_idx.equals("") || board_idx!=null) && ((!password.equals("")) || password!=null))
		{
			  Map<String, Integer> map = new HashMap<String, Integer>();
	
			   try{	
				    Integer board_idx_s =Integer.parseInt(board_idx=board_idx.trim());
					map.put("board_idx", board_idx_s);
					System.out.println("board_idx try after");
					
					if( password.equals("")||password==null)
					{
						System.out.println("**password null or \"\" **");
					}
					 

				    Integer password_s =Integer.parseInt(password);	
                 
                    System.out.println(password_s);
					
                    map.put("password", password_s);
					System.out.println("password try after");
					
					System.out.println(board_idx);
					System.out.println(password);
				  }
				  catch(Exception e)
				  {
					  System.out.println("==============================catch the exception=========================================");
					  System.out.println("*BbsService_imple ERR* \"password check for parsing String to Integer\"");
					  System.out.println("board_idx:"+board_idx+":");
					  System.out.println("password:"+password+":");
					  System.out.println("===============================catch the exception========================================");
					  e.printStackTrace();
					  
					  result= REQ_DATA_PARSE_ERR;
					  System.out.println("ex:"+board_idx+password);
					  return result;
				  }
			        System.out.println("pwd 체크하고 dao 들어갑니다");
		            result=bbsDao.pwdCheck(map)==1? SQL_GET_DATA_OK : SQL_GET_NO_DATA;
		            System.out.println("pwdcheck 결과 입니다:"+result);
		}
		else
		{
			result= REQ_DATA_NULL;
		}
		   
		System.out.println("최종 return 할 result 결과 ="+result);
		return result;
	}
	
	
	public List<Object> getAllObjects(String target,HttpServletRequest req) throws UnsupportedEncodingException {
	
			List<Object> excelList =null;
			String fileName="";
		
		if(target.equals("article")) return null;
		if(target.equals("comment")) return null;
		if(target.equals("file"))
		{	
				if(req.getParameter("option")!=null)
				{
						String option       =  req.getParameter("option");
						String option_value =  req.getParameter("option_value");
						int option_cp       =  Integer.parseInt(req.getParameter("option_cp"));
				         
						 System.out.println("검색 엑셀");
						 System.out.println("검색:"+option);
						 System.out.println("검색 조건:"+option_value);
						 System.out.println("페이지:"+option_cp);
		  
			 /*swit 1=제목으로 검색,  0=작성자로 검색*/
			   int swit = option.equals("subject")?1:0;
			  switch(swit)
			  {
			  case 1:  fileName="Bow-tech_게시판_"+option_value+"으로_제목_검색_결과_"; break;
			  case 0:  fileName="Bow-tech_게시판_"+option_value+"으로_작성자_검색_결과_"; break;
			  default: fileName="Bow-tech_게시판_검색_조건_페이지";
			  }
						 
				    /* 0 : 현재 페이지  1: 현재부터 끝까지  2 : 전체페이지 */	
		            int excel_opt =Integer.parseInt(req.getParameter("excel_opt"));
		  
					switch(excel_opt)
				    {
				       case 0: excelList = bbsDao.list_option_src_Excel(option , option_value , option_cp); 
				               fileName+=option_cp+"페이지"; break;	
				       case 1: excelList = bbsDao.list_option_src_to_end_Excel(option , option_value , option_cp); 
				       		   fileName+=option_cp+"페이지부터_전체"; break;
				       case 2: excelList = bbsDao.list_option_src_All_Excel(option , option_value , option_cp); 
				               fileName+="전체"; break;
				       default: excelList = null;
				    }
		            
					  
				}     
				else
				{
				    int cp = Integer.parseInt(req.getParameter("cp"));
				    
	      /* 0 : 현재 페이지  1: 현재부터 끝까지  2 : 전체페이지 */		
		 int excel_opt =Integer.parseInt(req.getParameter("excel_opt"));	
				
	    switch(excel_opt)
	    {
	       case 0: excelList=  bbsDao.bbsListForExcel(cp);  fileName ="Bow-tech_Board_게시판_"+cp+"_페이지"; break;
	       case 1: excelList = bbsDao.bbsListForExcelToEnd(cp); fileName ="Bow-tech_Board_게시판_검색_"+cp+"_페이지부터_전체"; break;
	       case 2: excelList = bbsDao.bbsListForAll(cp); fileName ="Bow-tech_Board_게시판_전체페이지"; break;
	       default: excelList = null;
	    }
					
					 System.out.println("그냥검색 엑셀");
					 System.out.println("그냥 검색 페이지:"+cp);
				}
		}
		 req.setAttribute("fileName",fileName);
		 
		 return  excelList;
	}
}
