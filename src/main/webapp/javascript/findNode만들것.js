/**
 * 
 */         
       		              function findNodeValue(node,attr)
       		              {
       		                	 /*  */
       		                  var mother_node =node;
       		                  var type =typeof attr; 	  
       		                	 
       		            	/* var mom =document.getElementById("0_content"); */
							var el = mom.childNodes;
							
							for(var a =0 ; a < el.length ; a++)
								{
								  
								  console.log(el[a].nodeName);
								
									  if(el[a].hasChildNodes)
									  {
									    console.log("yes :"+a+"번째"+el[a].nodeName);
									    
									        var tempEl = el[a].childNodes;
									
									        for(var b = 0 ; a < tempEl.length; b++)
									        {
									
									          console.log(b+"번째 "+tempEl[b].nodeName);
									
									        }
									    
									  }
								  
								}
       		                	 
       		              }  
							