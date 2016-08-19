package bow.bbs;

public class Paging {

	
public String pagination(String url ,int cp, int ps, int ls, int totalCnt, int totalP ,String option ,String option_value) 
{
	
		int userG = cp % ps == 0 ? cp / ps - 1 : cp / ps;
		
		int maxUserG = totalP % ps == 0 ? (totalP / ps) - 1 : totalP / ps;

		StringBuffer sb = new StringBuffer();
		
        sb.append("<ul class=\"pagination\">");
        sb.append("<li>");
         
        if (maxUserG!=0) 
		{
			sb.append("<a href='" + url + "?cp=1");
				
			    if(option_value!=null && option!=null)
				{
			        sb.append("&option="+option+"&option_value="+option_value+"'>");					
				}
				else
				{
					sb.append("'>");
				}
            
			if(userG==0)
			{
				sb.append("&nbsp;Start&nbsp;&nbsp;");
			}
			else
			{
				sb.append("&lt;&lt;&nbsp;&nbsp;First page&nbsp;&nbsp;");
			}
			
			sb.append("</a>");
		}
        
        if (userG != 0) {
        	sb.append("<li>");
				sb.append("<a href='" + url + "?cp=" + (((userG - 1) * ps) + ps));
					if(option_value!=null && option!=null)
					{
				        sb.append("&option="+option+"&option_value="+option_value+"'>");					
					}
					else
					{
						sb.append("'>");
					}
			
			sb.append("&lt;&nbsp;previous&nbsp;");
			sb.append("</a>&nbsp;");
			sb.append("</li>");
		}

		if (totalP > 0) {
			for (int a = userG * ps + 1; (userG * ps) + ps >= a; a++) {
				sb.append("<li>");
				sb.append("<a href='" + url + "?cp=" + a);
				
					if(option_value!=null && option!=null)
					{
						  sb.append("&option="+option+"&option_value="+option_value);					
					}
				
							if(a==cp)
							 {
								 sb.append("' style='color:red;'>"+a);
							 }
							 else
							 {
								 sb.append("'>"+a);
							 }
			
				sb.append("</a>&nbsp;");
				sb.append("</li>");
				if (totalP == a)
					break;
			}
		}

		if (userG != maxUserG ) {
			sb.append("<li class=\"next\">");
			sb.append("<a href='" + url + "?cp=" + (((userG + 1) * ps) + 1));
			   
					if(option_value!=null && option!=null)
					{
						  sb.append("&option="+option+"&option_value="+option_value+"'>");						
					}
					else
					{
						sb.append("'>");
					}
					
			sb.append("next&nbsp;&gt;</a>&nbsp;");
			sb.append("</li>");
		}
		
		if(maxUserG !=0)
		{
			sb.append("<li>");
			sb.append("<a href='" + url + "?cp=" + totalP);
			    
					if(option_value!=null && option!=null)
					{
						  sb.append("&option="+option+"&option_value="+option_value+"'>");								
					}
					else
					{
						sb.append("'>");
					}
		
			if(userG==maxUserG)
			{
				sb.append("End&nbsp;");
			}
			else
			{
				sb.append("&nbsp;&nbsp;Last page&nbsp;&gt;&gt;");
			}
			sb.append("</a>&nbsp;");
			sb.append("</li>");
		}
		
		sb.append("</ul>");
		return sb.toString();
	}
}