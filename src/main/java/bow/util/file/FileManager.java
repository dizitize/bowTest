package bow.util.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import bow.bbs.CommonUtil;
import bow.bbs.FileDTO;

/*@Component("fileUtil")*/
public class FileManager{

public List<FileDTO> fileUpload(List< MultipartFile >uploadz , int board_idx) throws IOException{
	
	System.out.println("FileManager 임무착수");
	
	 List<FileDTO> fileResult = new ArrayList<FileDTO>(); 
	 String path ="C:\\filez\\";
	 File file = new File(path);
	 
	 if(file.exists() == false)
		{
		  file.mkdirs();
		}
	 
	 System.out.println("FILE-manager 1 단계");
	 
			 for(int a = 0 ; a < uploadz.size(); a++)
			 {
					 String  originName  = uploadz.get(a).getOriginalFilename();
					 String  stored_name = "";
					
					 if(originName.lastIndexOf(".") == -1)
					 {
						   stored_name = CommonUtil.getRandomString();
					 }
					 else
					 {
						   stored_name =  CommonUtil.getRandomString()+originName.substring(originName.lastIndexOf("."));
					 }
					 
				 
			     FileDTO tempFileDto = new FileDTO();
				 
					  tempFileDto.setBoard_idx(board_idx);
					  tempFileDto.setStored_file_name(stored_name);
				      tempFileDto.setOrigin_file_name((String)uploadz.get(a).getOriginalFilename());
				      tempFileDto.setFile_size((int) uploadz.get(a).getSize());
			      
				      
			      byte[] tempByte =  uploadz.get(a).getBytes();
			         
				  File outFile = new File(path+stored_name);
				     
				     FileOutputStream fos = new FileOutputStream(outFile);
									  fos.write(tempByte);
								      fos.close();
			      
			     fileResult.add(tempFileDto);
			 }
	System.out.println("FileManager 임무완수");
	 return fileResult;
 }
	
}
