package bow.bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository("boardDAO")

public class BbsDAO_imple implements BbsDAO_interface {

	private SqlSessionTemplate sqlMap;

	
	public BbsDAO_imple(SqlSessionTemplate sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}


	public List<BbsDTO> bbsList(int cp) {
		Map<String, Integer> cp_ls = new HashMap<String, Integer>();

		cp_ls.put("cp", cp);
		cp_ls.put("ls", ls);

		return sqlMap.selectList("bbsList", cp_ls);
	}

	public BbsDTO bbsContent(int board_idx) {
		
		return sqlMap.selectOne("bbsContent", board_idx);
	}

	public int bbsWrite(BbsDTO dto) {
		
		return sqlMap.insert("bbsWrite", dto);
	}

	
//	peace area peace area peace area peace area peace area
	
	
	public int sunbunUp(int ref,int sunbun) {

		Map<String,Integer> ref_sunbun = new HashMap<String, Integer>();
		
		ref_sunbun.put("ref",ref);
		ref_sunbun.put("sunbun",sunbun);
		
		return sqlMap.update("sunbunUp",ref_sunbun);
	}
	
	public int totalCnt() {
		return sqlMap.selectOne("totalCnt");
	}
	
	public List<CommentDTO>commentList(int board_idx) {
		
		List<CommentDTO> comments = sqlMap.selectList("commentList",board_idx);
	
		for(CommentDTO i :comments)
		{
			 i.setContent(i.getContent().replaceAll("<","&lt;"));
	         i.setContent(i.getContent().replaceAll(">","&gt;"));
	         i.setContent(i.getContent().replaceAll("\r\n","<br>"));
	       
	         i.setWriter(i.getWriter().replaceAll("<","&lt;"));
	         i.setWriter(i.getWriter().replaceAll(">","&gt;"));
	         i.setWriter(i.getWriter().replaceAll("\r\n","<br>"));
		}
		
		
		return comments;
	}
	public int commentInsert(CommentDTO dto) {
  
		return sqlMap.insert("commentInsert",dto);
	}
	public int commentUpdate(CommentDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.update("commentUpdate",dto);
	}
	
	public int commentDelete(int cmt_idx) {
		// TODO Auto-generated method stub
		return sqlMap.delete("commentDelete",cmt_idx);
	}
	
    public int cmtPwdCheck(Long cmt_idx, Long password) {
		
		Map<String,Long>map = new HashMap<String, Long>();
		map.put("comment_board_idx", cmt_idx);
		map.put("password", password);
		
		return sqlMap.selectOne("cmtPwdCheckNormal",map);
	}
	
	
	
	
	
//	peace area peace area peace area peace area peace area	
	
	
	
//	normal version
	
	public BbsDTOnorm bbsContent_normal(int board_idx) {
		
	     System.out.println("dao 들어왔습니닫 boarad_idx:"+board_idx);
		 sqlMap.selectOne("updateReadnumNormal",board_idx);
		 System.out.println("dao update readnum 완료 boarad_idx:"+board_idx);
		 
		 BbsDTOnorm dto = sqlMap.selectOne("bbsContentNormal", board_idx);
		 dto.setSubject(dto.getSubject().replaceAll("<","&lt;"));
		 dto.setSubject(dto.getSubject().replaceAll(">","&gt;"));
	
		 dto.setWriter(dto.getWriter().replaceAll("<","&lt;"));
		 dto.setWriter(dto.getWriter().replaceAll(">","&gt;"));
		return dto;
	}
	
	public List<BbsDTOnorm> bbsList_normal(int cp) {
		
		Map<String, Integer> cp_ls = new HashMap<String, Integer>();

		cp_ls.put("cp", cp);
		cp_ls.put("ls", ls);
		
		List<BbsDTOnorm> dtoList =sqlMap.selectList("bbsListNormal", cp_ls);
		
		for(BbsDTOnorm e: dtoList)
	     {
             e.setSubject(e.getSubject().replaceAll("<","&lt;"));
             e.setSubject(e.getSubject().replaceAll(">","&gt;"));
             e.setSubject(e.getSubject().replaceAll("\r\n","<br>"));
            
             e.setWriter(e.getWriter().replaceAll("<","&lt;"));
             e.setWriter(e.getWriter().replaceAll(">","&gt;"));
             e.setWriter(e.getWriter().replaceAll("\r\n","<br>"));
	     }
		
		return dtoList;
	}
	
	public int bbsWrite_normal(BbsDTOnorm dto) {
		// TODO Auto-generated method stub
		return sqlMap.insert("bbsWriteNormal", dto);
	}
	
	public int passwordConfirm(Integer board_idx , Integer password) {
		// TODO Auto-generated method stub
		Map<String,Integer>  temp = new HashMap<String, Integer>();
		temp.put("password",  password );
		temp.put("board_idx", board_idx);
		
		return sqlMap.selectOne("passwordConfirm",temp);
	}
	
	public int updateContent_normal(BbsDTOnorm dto) {

		return sqlMap.update("updateContentNormal", dto);
	}
	
	public int deleteContent_normal(int board_idx) {
	
    	int result =sqlMap.selectOne("lookForCommentsReply",board_idx);
    	
		System.out.println("lookforcomments : "+result);
		
			if(result>0 )
			{
			   result= sqlMap.update("boardHasComment_del",board_idx);
			   result++;
			System.out.println("hasComments : "+result);
			}
			else
			{
				result=sqlMap.update("afterDeleteNormal",board_idx);
	            System.out.println("afterdelete  : "+result);
				result= sqlMap.delete("deleteContentNormal",board_idx);
				System.out.println("delete : "+result);
		    }
			
			return result;
	}
	
	public int writeReply_normal(BbsDTOnorm dto) {
		
  	       System.out.println("dto idx:"+dto.getBoard_idx());
   return sqlMap.insert("replyWriteNormal",dto);
	}

	
	public List<BbsDTOnorm> searchingContents_normal(String option,String option_value, int cp) 
	{
		
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("option", option);
		map.put("cp", cp);
		map.put("ls", ls);
		map.put("option_value", option_value);
		
		List<BbsDTOnorm>dtoList =sqlMap.selectList("boardSrcListNormal",map);
		
		  for(BbsDTOnorm e: dtoList)
	  	     {
	               e.setSubject(e.getSubject().replaceAll("<","&lt;"));
	               e.setSubject(e.getSubject().replaceAll(">","&gt;"));
	               e.setSubject(e.getSubject().replaceAll("\r\n","<br>"));
	              
	               e.setWriter(e.getWriter().replaceAll("<","&lt;"));
	               e.setWriter(e.getWriter().replaceAll(">","&gt;"));
	               e.setWriter(e.getWriter().replaceAll("\r\n","<br>"));
	  	     }
		
		return dtoList;
	
	}
	
	public int srcTotalCnt(String option, String option_value) {
		// TODO Auto-generated method stub
		Map<String,String> srcVO = new HashMap<String, String>();
		System.out.println("srcCnt option:"+option);
		
		System.out.println("srcCnt option_src:"+option_value);
		srcVO.put("option",option);
		srcVO.put("option_value",option_value);
		
		return sqlMap.selectOne("boardSrcCntNormal",srcVO);
	}

	public int pwdCheck(Map<String,Integer>map){
		
		return sqlMap.selectOne("pwdCheckNormal",map);
	}

	public int pageNavi(int board_idx) {
     
      Map<String,Integer>map = new HashMap<String, Integer>();
      map.put("ls", ls);
      map.put("board_idx",board_idx);
      
		return sqlMap.selectOne("pageNaviNormal",map);
	}
	
	public int afterRewriteNavi(int ref, int sunbun) {
	
	  Map<String,Integer>map = new HashMap<String, Integer>();
		
	  map.put("ref", ref);
	  map.put("sunbun", sunbun+1);
	  
		return sqlMap.selectOne("afterRewriteNaviNormal", map);
	}
	
	public int afterWriteNavi(BbsDTOnorm dto) {
		// TODO Auto-generated method stub
		return sqlMap.selectOne("afterWriteNaviNormal",dto);
	}
	
	public void inserFile(Map<String, Object> map) throws Exception {
	
		 sqlMap.insert("file_insert",map);
	}
	
	public List<FileDTO> selectFile(int board_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("file_select",board_idx);
	}
	
}
