<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>alert</title>
</head>
<script>
           alert("${msg}");
       
       <%if(request.getAttribute("location")!=null)
           {%> 
                location.replace("${location}");
         <%}%>
        
</script>
</html>

