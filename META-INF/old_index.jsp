
<%@page import="com.qdcdata.JDBCConnection"%>


<%

System.out.println(" SuccessMsg *************** 1");


    if(request.getParameter("btn_check")!=null) //check button click event not null button name is "btn_check"
    { 
        
    	/* sampletest mc=new sampletest(); //create a java class and this class contain calling return type "check()" function 
        
        String validate=mc.hello(); //put "mc" object in "check()" function and recieve string message and store created "validate" variable
        
        request.setAttribute("SuccessMsg",validate); */
        	
        
        
       /*  if(validate.equals("Java Class Call Successfully")) //check calling "check() function" receive "Java Class Call Successfully" string message and they are match after redirect to "welcome.jsp" page
        {
            request.setAttribute("SuccessMsg",validate); //send successfully message through "SuccessMsg" object
           //RequestDispatcher rd=request.getRequestDispatcher("welcome.jsp"); //redirect to welcome.jsp page
            rd.forward(request, response);
        } */
        System.out.println(" SuccessMsg *************** 2");
    }
    
    if(request.getParameter("btnview")!=null) 
    {
    	java.sql.Statement stmt;
    	java.sql.ResultSet resultcnet;
    	java.sql.ResultSet resultqdc;
    	java.sql.ResultSet resultqpc;
    	//JDBCConnection jcon = new JDBCConnection();
    	java.sql.Connection conn; 
    	String prdidcnet="";
    	conn = JDBCConnection.getConnection("QDC");
    	stmt = conn.createStatement();
    	 resultcnet = stmt.executeQuery("select count(*)prodid  from cds_Prod where ProductSource='CNET' and ProductStatus='ORGN'"); 
    	/* resultcnet = stmt.executeQuery("select count(*)prodid  from cds_Prod where ProductSource='CNET' and ProductStatus='ORGN'"); */
    	System.out.println(" btnview  ***************  " + request.getParameter("btnview"));
    	
    	  while (resultcnet.next()) { 
		    	 System.out.println("resultcnet $$$$$$$$$$$ " +resultcnet.getString("ProdID"));
    	 
		    	/*  prdidcnet = resultcnet.getString("ProdID").toString();
		    	 System.out.println("Prodid$$$$$$$$$$$ second " + prdidcnet); */
		    	 request.setAttribute("cnet",resultcnet.getString("ProdID"));
		    	 
    }
    	  
    	  
    	  
    	resultqpc = stmt.executeQuery("select count(*)prodid from cds_Prod where ProductSource='QOIPR' and ProductStatus='SRC'"); 
    	  
    	 /*  resultqpc = stmt.executeQuery("select count(*)prodid from cds_Prod where ProductSource='QOIPR' and ProductStatus='SRC'");*/
    	  
    	  while (resultqpc.next()) { 
    		  
    		  System.out.println("resultqpc $$$$$$$$$$$ " +resultqpc.getString("ProdID"));
    		  request.setAttribute("qpc",resultqpc.getString("ProdID"));
    		  
    	  }
    	  
    	  
    	  resultqdc= stmt.executeQuery("select count(*) prodid  from cds_Prod"); 
    	  
    	  /* resultqdc= stmt.executeQuery("select count(*) prodid  from cds_Prod");*/
    	  while (resultqdc.next()) { 
    		  System.out.println("resultqdc $$$$$$$$$$$ " +resultqdc.getString("ProdID"));
    		  request.setAttribute("qdc",resultqdc.getString("ProdID"));
    		  
    	  }
    	  
    	  conn.close();
    }
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
 <link href="./assets/css/paper-dashboard.css" rel="stylesheet" type="text/css"/>
<title>Evolve</title>
<style>
.rectangle {
  height: 50px;
  width: 100px;
  background-color: #4CAF50;
}
</style>

<style>

.card {
    background-color: #fff;
    border-radius: 10px;
    border: none;
    position: relative;
    margin-bottom: 30px;
    box-shadow: 0 0.46875rem 2.1875rem rgba(90,97,105,0.1), 0 0.9375rem 1.40625rem rgba(90,97,105,0.1), 0 0.25rem 0.53125rem rgba(90,97,105,0.12), 0 0.125rem 0.1875rem rgba(90,97,105,0.1);
}
.l-bg-cherry {
    background: linear-gradient(to right, #493240, #f09) !important;
    color: #fff;
}

.l-bg-blue-dark {
    background: linear-gradient(to right, #373b44, #4286f4) !important;
    color: #fff;
}

.l-bg-green-dark {
    background: linear-gradient(to right, #0a504a, #38ef7d) !important;
    color: #fff;
}

.l-bg-orange-dark {
    background: linear-gradient(to right, #a86008, #ffba56) !important;
    color: #fff;
}

.card .card-statistic-3 .card-icon-large .fas, .card .card-statistic-3 .card-icon-large .far, .card .card-statistic-3 .card-icon-large .fab, .card .card-statistic-3 .card-icon-large .fal {
    font-size: 110px;
}

.card .card-statistic-3 .card-icon {
    text-align: center;
    line-height: 50px;
    margin-left: 15px;
    color: #000;
    position: absolute;
    right: -5px;
    top: 20px;
    opacity: 0.1;
}

.l-bg-cyan {
    background: linear-gradient(135deg, #289cf5, #84c0ec) !important;
    color: #fff;
}

.l-bg-green {
    background: linear-gradient(135deg, #23bdb8 0%, #43e794 100%) !important;
    color: #fff;
}

.l-bg-orange {
    background: linear-gradient(to right, #f9900e, #ffba56) !important;
    color: #fff;
}

.l-bg-cyan {
    background: linear-gradient(135deg, #289cf5, #84c0ec) !important;
    color: #fff;
}

</style>

</head>
<body>
<form method="post" >
<br>

	<div><h4 align="center"> QDC </h4></div>
	

<div class="container">
     
     <!-- <div style="width:950px;height:100px;"> -->
     
     <img src="./images/image7.jpg">
     
     
     
     </div>
     <!-- <div class="rectangle" >text </div> -->
    <div><br><br><br></div>
    
 <div class="container"> 

 <div class="card-deck">
  <div class="card bg-primary">
    <div class="card-body text-center">
  <!--   <div class="card-header text-center"><h3></h3></div> -->
     <!--  <p class="card-text"></p> --><br><br><br>
     <H3>  <input type="submit" name="btnview" class="btn btn-success" value="Refresh QDC"> </H3>
    </div>
  </div>
  <div class="card bg-warning">
  <div class="card-header text-center"><h3>CNET</h3></div>
    <div class="card-body text-center">
      <p class="card-text">
      <% if (request.getAttribute("cnet") != null)
      {
    	 %> <H5>Count:
    	  <%=request.getAttribute("cnet") %></H5>
    	  <%
      }
    	 %>
    
      </p>
    </div>
  </div>
  
  
  <div class="card bg-danger">
	  <div class="card-header text-center"><h3>QDC</h3></div>
	  <div class="card-body text-center">
	  <p class="card-text">
	  
	   <% if (request.getAttribute("qdc") != null)
      {
    	 %> <H5>Count:
    	  <%=request.getAttribute("qdc") %></H5>
    	  <%
      }
    	 %>
	  
	  </p>
	  </div>
	  <div class="card-footer">(Matching QOIPR and available in CNET)</div>
  </div>


 <!-- <div class="card bg-primary">
    <div class="card-body text-center">
      <p class="card-text"><h3>Inbound QDC</h3></p>
    </div>
  </div>

  	<div class="card bg-danger">
	   <div class="card-header text-center"><h3>QDC</h3></div>
	  <div class="card-body text-center">
	  <p class="card-text">COUNT</p>
	  </div>
	  <div class="card-footer">(Available in QOIPR and NOT IN in CNET)</div>
 	</div> -->
     
     
    <div class="card bg-success">
    <div class="card-header text-center"><h3>QPC</h3></div>
    <div class="card-body text-center">
      <p class="card-text">
      
       <% if (request.getAttribute("qpc") != null)
      {
    	 %> <H5>Count:
    	  <%=request.getAttribute("qpc") %></H5>
    	  <%
      }
    	 %>
      
      </p>
      <div class="card-footer">(Available in QOIPR and NOT IN in CNET)</div>
    </div>
  </div>
</div>
</div>

	<div class="container-fluid">
	<div class="container pt-3">
	
			
			
			 <div class="card-deck">
			<div class="card bg-warning">
			    <div class="card-body text-center">
			       
				 <p ><a href="catalogue.jsp"><h2>View Catalogue</h2></a></p> 
			    </div>
			</div>
			
		
		
		
		
		<div class="card bg-success">
		    <!-- <div class="card-header text-center"><h3>QPC</h3></div> -->
		    <div class="card-body text-center">
			    <table border="1" class="container-fluid container pt-3">
			    <tr>
			    <th>DB</th>
			    <td>QDC</td>
			    </tr>
			    
			    <tr>
			    <th>IP</th>
			    <!-- <td>164.52.218.134</td> -->
			    <td>NA</td>
			    </tr>
			    
			    <tr>
			    <th>Last Sync</th>
			    <td>NA</td>
			    </tr>
			    
			  
			    </table>
		      <!-- <p class="card-text">Count</p> -->
		    </div>
		    </div>
		</div>
	
		</div> 
	
		</div>
		
		</form>


</body>
</html>
