<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
     <%@taglib uri="/struts-tags" prefix="s" %>   
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
   
    
    <a href="/learnSSH/register.jsp"><s:text name="register.url"></s:text><br></a>
    <s:form action="Login" >
    	<s:textfield name="custname" key="custname.label"></s:textfield>
    	<s:password name="pwd" key="pwd.label"></s:password>
    	<s:submit key="login.button"></s:submit> 	
    </s:form>
    <s:actionerror/>
  </body>
</html>
