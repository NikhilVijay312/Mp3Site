

<%-- 
    Document   : add_category
    Created on : Dec 25, 2020, 2:55:20 PM
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
		if(request.getParameter("category").trim().length()==0){
			response.sendRedirect("dashboard.jsp?empty=1");
		}
		else{
                            try{
						String category = request.getParameter("category").trim();
						Class.forName("com.mysql.jdbc.Driver");
						Connection cn =DriverManager.getConnection("jdbc:mysql://localhost:3306/mp3","root","");
						Statement st = cn.createStatement();
						ResultSet rs = st.executeQuery("select * from album_category where category_name='"+category+"'");
						if(rs.next()==false){  
                                                                    Statement st1 = cn.createStatement();
									ResultSet rs1 = st1.executeQuery("select MAX(sn) from album_category");
									int sn=0;
									if(rs1.next()){
									sn=rs1.getInt(1);
									
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
                                                                                                
									PreparedStatement ps = cn.prepareStatement("insert into album_category values(?,?,?,?)");
												ps.setInt(1,sn);
												ps.setString(2,code);
												ps.setString (3,category);
												ps.setInt(4,1);
                                                                                               
                                                                                  if(ps.executeUpdate()>0){
													response.sendRedirect("dashboard.jsp?success=1");
													
												}
												else{
                                                                                            		response.sendRedirect("dashboard.jsp?error=1");
													
                                                                                                    }
												
																					
                                                                           }
                                                                        else{
                                                                            response.sendRedirect("dashboard.jsp?exist=1");
                                                                                
                                                                                }
                                                                     cn.close();
                                        }
                                        catch(Exception er){
                                                out.println(er.getMessage());
                                        }
                                        
                                        
                                        
			}
			
		}
        else{
            response.sendRedirect("index.jsp");
        }
	
	


%>