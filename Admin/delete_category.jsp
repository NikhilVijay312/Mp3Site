<%-- 
    Document   : delete_category
    Created on : Jan 7, 2021, 4:21:11 PM
    Author     : Nikhil Vijay
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<% 
    Cookie c[] =request.getCookies();
    String email = null;
    for(int i=0; i<c.length; i++){
          if(c[i].getName().equals("user")){
                    email = c[i].getValue();
                    break;

             }
    }
    if(email != null && session.getAttribute(email)!= null ){
        if(request.getParameter("id")!=null){
        String code = request.getParameter("id");
          try{

                     Class.forName("com.mysql.jdbc.Driver");
                     Connection cn =DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
                     Statement st = cn.createStatement();
                     if(st.executeUpdate("update album_category set status = 0 where code='"+code+"'")>0){
                          Statement st1 = cn.createStatement();
                         st1.executeUpdate("update album set status = 0 where category_code='"+code+"'");
                          
                         out.print("success");
                         
                         
                     }
                     else{
                     out.print("again");
                     }
                     cn.close();
                     
                     }
           catch(Exception er){
                        out.print(er.getMessage());
               }
    }
    }
    else{
        response.sendRedirect("index.jsp");
    }

    
%>