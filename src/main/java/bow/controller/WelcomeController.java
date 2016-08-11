package bow.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class WelcomeController {
	
    @RequestMapping("welcome.bow")
	public String index(){	
    	
    	 return "welcome";
	}
}
