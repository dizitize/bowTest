package bow.bbs;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelView extends AbstractExcelView{

  private  HSSFSheet sheet;
  private  HSSFRow row;
  
 
 
  @Override
	protected void buildExcelDocument( Map<String, Object> modelMap, HSSFWorkbook workbook, HttpServletRequest request,HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
	 System.out.println("ExcelView에 들어옴");
	 
	 	String fileName =(String)request.getAttribute("fileName");
	 	
	   sheet = workbook.createSheet(fileName+"WorkSheet");
	   sheet.setColumnWidth(20,30); 
	 
	    String list[] = {"게시글 고유번호","작성자","제목","작성날짜","조회수","컨텐츠"};
	    int index[] ={0,2,5,9,11,13};
	  
	  row = sheet.createRow(0);
	  
	  for(int a = 0 ; a < list.length ; a++ )
	  {
		  row.createCell(index[a]).setCellValue(list[a]);
	  }
	  @SuppressWarnings("unchecked")
	  List<BbsDTOnorm> dtoList = (List<BbsDTOnorm>) modelMap.get("excelList");
	  
	  
	  for(int rownum = 1 ,b =0; b < dtoList.size(); b++)
	  {
          row = sheet.createRow(rownum++); 		  
		  row.createCell(index[0]).setCellValue(dtoList.get(b).getBoard_idx());
		  row.createCell(index[1]).setCellValue(dtoList.get(b).getWriter());
		  row.createCell(index[2]).setCellValue(dtoList.get(b).getSubject());
		  row.createCell(index[3]).setCellValue(dtoList.get(b).getDatechar());
		  row.createCell(index[4]).setCellValue(dtoList.get(b).getReadnum());
		  row.createCell(index[5]).setCellValue(dtoList.get(b).getContent());
		  row = sheet.createRow(rownum++);
		  
		  if(b+1 == dtoList.size())
		  {
			  row = sheet.createRow(rownum++);
			  row.createCell(0).setCellValue(fileName);
			  row = sheet.createRow(rownum++);
			  row.createCell(1).setCellValue("총 개시물 수 :"+dtoList.size());
		  }
	  }
	  response.setContentType("application/vnd.ms-excel; charset=UTF-8");
	  response.setCharacterEncoding("UTF-8");
	  response.setHeader("Content-Disposition","attachment; filename="+new String(fileName.getBytes("UTF-8"),"8859_1")+".xls");
	  response.setHeader("Content-Description", "JSP Generated Data"); 
	  
	}
}