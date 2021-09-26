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
		if(request.getParameter("id").trim().length()==0|| request.getParameter("album").trim().length()==0||request.getParameter("des").trim().length()==0 ){
			response.sendRedirect("dashboard.jsp?empty=1");
		}
		else{ 
                    if(request.getParameter("id")== null){
                        response.sendRedirect("dashboard.jsp?empty=1");
                        
                        }
                    else{
                        String album = request.getParameter("album");
                        String id= request.getParameter("id");
                        String des = request.getParameter("des");
                        
                            try{
						
						Class.forName("com.mysql.jdbc.Driver");
						Connection cn =DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
						Statement st = cn.createStatement();
						ResultSet rs = st.executeQuery("select MAX(sn) from album");
                                                                        int sn=0;
									if(rs.next()){
									sn=rs.getInt(1);
									
									}
									sn++;
                                                LinkedList l = new LinkedList();
									for(int i=0; i<=9;i++){
										l.add(i+"");
									}
									for(char i='A';i<='Z';i++){
										l.add(i+"");
										
									}
									for(char i='a'; i<='z'; i++){
									l.add(i+"");
									}
									Collections.shuffle(l);
									String code="";
									for(int i=0; i<6; i++){
                                                                                                code = code+l.get(i);
                                                                                               }
									code = code+"_"+sn;
                                   PreparedStatement ps = cn.prepareStatement("insert into album values(?,?,?,?,?,?)");
                                    ps.setInt(1, sn);
                                    ps.setString(2, code);
                                    ps.setString(3, album);
                                    ps.setString(4, des);
                                    ps.setInt(5, 1);
                                    ps.setString(6, id);
                                    if(ps.executeUpdate()>0){
                                        response.sendRedirect("album_image.jsp?id="+id+"&album_code="+code);
                                    }
                                    else{
                                    response.sendRedirect("album.jsp?id="+id+"&try=1");
                                    
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
