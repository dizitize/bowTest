package bow.bbs;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



/* @Component("fileUtils") 
   @Component 어노테이션을 이용하여 이 객체의 관리를 스프링이 담당하도록 할 계획이다.*/

public class FileUtil {

	 /*나중에 이 부분은 properties를 이용하여 로컬과 서버의 저장위치를 따로따로 관리할 예정*/
	private static final String filePath="C:\\Users\\USER\\Desktop\\filez\\";
	
	public List<Map<String,Object>>parseInsertFileInfo( HttpServletRequest req , int board_idx)throws Exception
	{
		MultipartHttpServletRequest  multipartHttpServletRequest = (MultipartHttpServletRequest)req;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		
		MultipartFile multipartFile   = null;
		String originalFileName       = null;
		String originalFileExtension  = null;
		String storedFileName         = null;
		
		List<Map<String ,Object>> list  = new ArrayList<Map<String,Object>>();
		Map<String,Object> listMap    = null;
		
		File file = new File(filePath);
		
			if(file.exists() == false)
			{
				file.mkdirs();
			}
		
		while(iterator.hasNext())
		{
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			
			if(multipartFile.isEmpty() == false )
			{
				originalFileName      =  multipartFile.getOriginalFilename();
				originalFileExtension =  originalFileName.substring(originalFileName.lastIndexOf("."));
			                                     /* getRandomString() 메서드를 이용하여
			                                      * 32자리의 랜덤한 파일이름을 생성하고 원본파일의 확장자를 다시 붙여주었다. */				
				storedFileName        =  CommonUtil.getRandomString() + originalFileExtension;
			
				file    =  new File(filePath);
				
			/*	서버에 실제 파일을 저장하는 부분이다. 
				multipartFile.transferTo() 메서드를 이용 
				지정된 경로에 파일을 생성하는것을 알 수 있다.*/ 
				multipartFile.transferTo(file);
				
					listMap =  new HashMap<String, Object>();
						listMap.put("board_idx", board_idx);
						listMap.put("origin_file_name", originalFileName);
						listMap.put("stored_file_name", storedFileName);
						listMap.put("file_size", multipartFile.getSize());
			    
				list.add(listMap);
			}
		}
		
		return list;
	}
}
