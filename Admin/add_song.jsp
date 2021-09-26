<%-- 
    Document   : add_album
    Created on : Dec 29, 2020, 1:58:38 PM
    Author     : Nikhil Vijay
--%>

<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
	String email = null;
	for(int i=0; i<c.length; i++){
		if(c[i].getName().equals("user")){
			email=c[i].getValue();
			break;
		
		}
	
	}
	if(email!=null && session.getAttribute(email) != null){
		if(request.getParameter("title").trim().length()==0|| request.getParameter("des").trim().length()==0 ){
			response.sendRedirect("dashboard.jsp?empty=1");
		}
		else{ 
                    if(request.getParameter("album_code")== null){
                        response.sendRedirect("dashboard.jsp?empty=1");
                        
                        }
                    else{
                        String title = request.getParameter("title");
                        String album_code= request.getParameter("album_code");
                        String des = request.getParameter("des");
                        
                            try{
						
						Class.forName("com.mysql.jdbc.Driver");
						Connection cn =DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
						Statement st = cn.createStatement();
						ResultSet rs = st.executeQuery("select MAX(sn) from song where album_code='"+album_code+"'");
                                     int sn=0;
									if(rs.next()){
									sn=rs.getInt(1);
									
									}
									sn++;
                                             
                                   PreparedStatement ps = cn.prepareStatement("insert into song values(?,?,?,?,?)");
                                    ps.setInt(1, sn);
                                    ps.setString(2, title);
                                    ps.setString(3, des);
                                   ps.setString(4, album_code);
                                    ps.setInt(5, 1);
                                   
                                    if(ps.executeUpdate()>0){
                                        response.sendRedirect("upload_song.jsp?id="+sn+"&album_code="+album_code);
                                    }
                                    else{
                                    response.sendRedirect("song.jsp?album_code="+album_code+"&err=1");
                                    
                                    }
                                    cn.close();
                                    
                               }
                            catch(Exception e){
                                out.print(e.getMessage());
                            }
                        }
                    }
                }
        else{
        response.sendRedirect("index.jsp");
        }


%>
