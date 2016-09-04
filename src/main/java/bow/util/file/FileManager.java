package bow.util.file;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
					
					 /*만약 확장자가 없다면 -1을 리턴한다 */
					 if(originName.lastIndexOf(".") == -1)
					 {
						   stored_name = CommonUtil.getRandomString();
					 }
					 else
					 {
						   stored_name =  CommonUtil.getRandomString()+originName.substring(originName.lastIndexOf("."));
					 }
					 
				 /*최종 리턴 결과물 : 데이터베이스에 적재 하기위한 List<FileDTO> 반환 */
			     FileDTO tempFileDto = new FileDTO();
						  tempFileDto.setBoard_idx(board_idx);
						  tempFileDto.setStored_file_name(stored_name);
					      tempFileDto.setOrigin_file_name((String)uploadz.get(a).getOriginalFilename());
					      tempFileDto.setFile_size((int) uploadz.get(a).getSize());
				      
				  /*파일 write 준비 : multipart file 을 byte로 만들어낸다*/    
			      byte[] tempByte =  uploadz.get(a).getBytes();
			      /*해당 경로에 빈 파일을 만든다*/   
				  File outFile = new File(path+stored_name);
				  
				     /*FileOutputStram 을 생성하여 local 저장소에 write하기 위해 준비된 tempWrite 바이트를 로컬에 뿌린다*/ 
				     FileOutputStream fos = new FileOutputStream(outFile);
									  fos.write(tempByte);
								    /*스트림 계열은 쓰고나서 자원을 닫아준다*/
									  fos.close();
			      /*for문이 돌면서 multiPart파일을 dto객체로만든 결과를 List<FileDTO> fileResult 에 담는다*/
			     fileResult.add(tempFileDto);
			 }
	System.out.println("FileManager 임무완수");
	 return fileResult;
 }
	
}
