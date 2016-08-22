package bow.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="multipleUpload")
public class FileProcessController {

	
	@RequestMapping(method =RequestMethod.POST)
	public String index(){
		
		return "";
		
	}
	
	
	 @RequestMapping(value="/process", method=RequestMethod.POST)
	 public String save (HttpServletRequest req)
	 {
		 
		 String path =req.getRealPath("/upload");
		 
		 path=path.substring(0,path.indexOf("\\build"));
		 path=path+"\\web\\upload\\";
		 
		 
		 return "success";
	 }
	
	
}
