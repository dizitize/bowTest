package bow.bbs;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class Excel extends AbstractExcelView {


  private  String excelName;
  private  HSSFSheet sheet;
  private  HSSFRow row;
  
  
  
  @Override
	protected void buildExcelDocument( Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
      sheet = workbook.createSheet(model.get("target")+"WorkSheet");
	  
	  String list[] = {"게시글 고유번호","작성자","제목","작성날짜","조회수"} ;
	  row = sheet.createRow(0);
	  
	  for(int a = 0 ; a < list.length ; a++ )
	  {
		  row.createCell(a).setCellValue(list[a]);
	  }
	  
	  @SuppressWarnings("unchecked")
	  List<BbsDTOnorm> dtoList = (List<BbsDTOnorm>)model.get("excelList");
	  
	  for(int a = 0 ; a< dtoList.size() ; a++)
	  {
          row = sheet.createRow(a+1); 		  
		  row.createCell(0).setCellValue(dtoList.get(a).getBoard_idx());
		  row.createCell(1).setCellValue(dtoList.get(a).getWriter());
		  row.createCell(2).setCellValue(dtoList.get(a).getSubject());
		  row.createCell(3).setCellValue(dtoList.get(a).getWritedate());
		  row.createCell(4).setCellValue(dtoList.get(a).getReadnum());
		  
		  row = sheet.createRow(a+2);
		  row.createCell(5).setCellValue(dtoList.get(a).getContent());
		  
		  row = sheet.createRow(a+3);
	  }
	  
	  response.setContentType("application/Msexcel");
	  response.setHeader("Content-Disposition", "Attachment; Filename="+excelName+"-excel"); 
	  
  }
}