
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.qdcdata.JDBCConnection"%>
<%@page import="com.qdcdata.SimpleDb2CsvExporter"%>
<%@page import="au.com.bytecode.opencsv.CSVWriter"%>
<%@page import="java.io.FileWriter"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
 <link href="./assets/css/paper-dashboard.css" rel="stylesheet" type="text/css"/>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Evolve</title>
<style>
.btnimg {
  background-color: #2596be;
  border: none;
  color: white;
  padding: 12px 12px;
  cursor: pointer;
  font-size: 15px;
}

/* Darker background on mouse-over */
.btn:hover {
  background-color: RoyalBlue;
}
</style>


<style>

.card {
    background-color: #fff;
    border-radius: 10px;
    border: none;
    position: relative;
     /* height: 20vh;  */
    margin-bottom: 30px;
    box-shadow: 0 0.46875rem 2.1875rem rgba(90,97,105,0.1), 0 0.9375rem 1.40625rem rgba(90,97,105,0.1), 0 0.25rem 0.53125rem rgba(90,97,105,0.12), 0 0.125rem 0.1875rem rgba(90,97,105,0.1);
}
.card-text {
    word-wrap: break-word;
}
.l-bg-grey-dark {
    background: linear-gradient(to right, #2596be, #2596be) !important;
    color: #fff;
}


.l-bg-blue-dark {
    background: linear-gradient(to right, #373b44, #4286f4) !important;
    color: #fff;
}

.l-bg-blue-dark-card2 {
    background: linear-gradient(to right, #373b44, #4286f4) !important;
    color: #fff;
    width:120px;
}
.l-bg-cherry {
    background: linear-gradient(to right, #493240, #f09) !important;
    color: #fff;
}
.red {
  background-color: #D5DBDB;

}
</style>

<style>

.row{
width:100%;

}
.column{
float:left;
margin-left:35px;
/* padding-right:5px; */
height:auto;
}

.right{
float:right;
margin-left:10px;
padding:0px;
height:auto;
}
</style>

<style>
ul.tab {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    border: 1px solid #ccc;
    background-color: #f1f1f1;
}

/* Float the list items side by side */
ul.tab li {float: left;}

/* Style the links inside the list items */
ul.tab li a {
    display: inline-block;
    color: black;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    transition: 0.3s;
    font-size: 17px;
}

/* Change background color of links on hover */
ul.tab li a:hover {background-color: #ddd;}

/* Create an active/current tablink class */
ul.tab li a:focus, .active {background-color: #ccc;}

/* Style the tab content */
.tabcontent {
    display: none;
    padding: 6px 12px;
    border: 1px solid #ccc;
    border-top: none;
}
</style>

<script>
function openCity(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tabcontent.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}
</script>

	
</head>

<body>
<form>

<br>

	<!-- <div style="margin-top:0px" ><h6 align="center">Crosswalk View - Search Launchpad</h6></div> -->
	 

		<div style="margin-left:10px;margin-right:10px" > 
	
	
	
			<script>

					function refreshFunction() {
					<%
					
					System.out.println(" SuccessMsg *************** 1");
					
					
					    if(request.getParameter("btnview")!=null) 
					    {
					    	java.sql.Statement stmt;
					    	java.sql.ResultSet resulttotal;
					    	//JDBCConnection jcon = new JDBCConnection();
					    	java.sql.Connection conn; 
					    	String prdidcnet="";
					    	conn = JDBCConnection.getConnection("QDC");
					    	stmt = conn.createStatement();
					    	
					    	resulttotal = stmt.executeQuery(" SELECT FORMAT(QPC_Evolve_Origin, 'N0', 'en-au') as QPC_Evolve_Origin, " +
					    			" FORMAT(QPC_Evolve_Active, 'N0', 'en-au') as QPC_Evolve_Active,"+

					    			" FORMAT(RequestedToCNET, 'N0', 'en-au') as RequestedToCNET ," +

					    			" FORMAT(QDC, 'N0', 'en-au') as QDC," +

					    			" FORMAT(Origin_CNET, 'N0', 'en-au') as Origin_CNET," +

					    			" FORMAT(Origin_QPC, 'N0', 'en-au') as Origin_QPC" +

					    			" from CrossWalkCounts;");
					    	
					       while (resulttotal.next())
					       {
					    	   
					    	   request.setAttribute("QPC_Evolve_Origin",resulttotal.getString("QPC_Evolve_Origin"));
					    	   request.setAttribute("QPC_Evolve_Active",resulttotal.getString("QPC_Evolve_Active"));
					    	   request.setAttribute("RequestedToCNET",resulttotal.getString("RequestedToCNET"));
					    	   request.setAttribute("QDC",resulttotal.getString("QDC"));
					    	   request.setAttribute("Origin_CNET",resulttotal.getString("Origin_CNET"));
					    	   request.setAttribute("Origin_QPC",resulttotal.getString("Origin_QPC"));
					    	   
					       }
					    	
					    	  conn.close();
					    }
					%>
					}
				</script>
				
				
				
	 <!-- <form name="cardformname" id="cardsformid" method="post" action="#" onsubmit="refreshFunction()" > -->
		<div class="card-deck"  >
	  
				   <!-- card 1  -->
				 
				  <div class="card l-bg-grey-dark" style="width:100px" >
				  <div class="card-header text-center "><h7 style="font:Calibri">QPC eVolve (Origin)</h7></div>
				<%--   <div class="card-body text-center">
				  
				  </div> --%>
				  <div class="card-footer" style="text-align:center"><p class="card-text">
				 
				   <% if (request.getAttribute("QPC_Evolve_Origin") != null)
      				{
				    	 %> 
				    	 
				    	  <%=request.getAttribute("QPC_Evolve_Origin") %> 
				    	  <%
				    }
				    	 %>
				   </p></div>
				  </div>
				 
			<img src="./images/rightarr1.png" width="50" height="50" style="margin-top:25px">
	  
	  				 <!-- card 2  -->
			   
			  <div class="card l-bg-grey-dark">
			  <div class="card-header text-center"><h7 style="font:Calibri">QPC Active (Origin)</h7></div>
			  <%-- <div class="card-body text-center">
			  
			  </div> --%>
			 <div class="card-footer" style="text-align:center" > <p class="card-text">
				   <% if (request.getAttribute("QPC_Evolve_Active") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("QPC_Evolve_Active") %> 
				    	  <%
				    }
				    	 %>
				   </p></div> 
		  </div>
		  
  		<img src="./images/rightarr1.png" width="50" height="50" style="margin-top:25px">
  				 <!-- card 3  -->
  
		  <div class="card l-bg-grey-dark" style="width:20rem;" >
			  <div class="card-header text-center"><h7 style="font:Calibri">QDC To CNET 	(Request)</h7></div>
			 <%--  <div class="card-body text-center">
			 
			  </div> --%>
			 <div class="card-footer" style="text-align: center"><p class="card-text">
				   <% if (request.getAttribute("RequestedToCNET") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("RequestedToCNET") %>
				    	  <%
				    }
				    	 %>
				   </p></div>
		  </div>
  
  		<img src="./images/rightarr1.png" width="50" height="50" style="margin-top:25px">
		   <!-- card 4  -->
		   
		  <div class="card l-bg-grey-dark" style="width:100px">
			  <div class="card-header text-center"><h7 style="font:Calibri">QDC Data (QPC+CNET)</h7></div>
			  <%-- <div class="card-body text-center">
			  
			  </div> --%>
			  <div class="card-footer" style="text-align: center"><p class="card-text">
				   <% if (request.getAttribute("QDC") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("QDC") %>
				    	  <%
				    }
				    	 %>
				   </p></div>
		  </div>

  			<img src="./images/equals.png" width="50" height="50" style="margin-top:25px">
			   <!-- card 5  -->
			   
			  	<div class="card l-bg-grey-dark" style="width:100px">
				  <div class="card-header text-center card-text word-wrap: break-word">
				  <p class="card-text"> <h7 style="font:Calibri">CNET (Origin)</h7></p></div>
				  <%-- <div class="card-body text-center">
				 
				  </div> --%>
					 <div class="card-footer" style="text-align: center"> <p class="card-text">
				   <% if (request.getAttribute("Origin_CNET") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("Origin_CNET") %>
				    	  <%
				    }
				    	 %>
				   </p></div>
				  </div>

 		 <img src="./images/plus.png" width="50" height="50" style="margin-top:25px">
			   <!-- card 6  -->
			   
			  	<div class="card l-bg-grey-dark" style="width:100px">
				  <div class="card-header text-center"><h7 style="font:Calibri">QPC (Origin)</h7></div>
				  <%-- <div class="card-body text-center">
				
				  </div> --%>
				<div class="card-footer" style="text-align: center"><p class="card-text">
				   <% if (request.getAttribute("Origin_QPC") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("Origin_QPC") %>
				    	  <%
				    }
				    	 %>
				   </p></div>
			  	</div>
	  
	  
	  <!-- Refresh QDC -->
	
	  <!-- <div class="card l-bg-grey-dark" style="width:100px">  -->
	   <!-- <div class="card-body text-center" style="text-align:center">  -->
	  <!-- <input type="submit" class="l-bg-grey-dark" name="btnview" style="width:auto;margin-top:37px" value="Refresh CNET"> --> 
	  
	     <div>
	   <!-- <button  class="l-bg-grey-dark"  name="btnview" style="width:auto;margin-top:37px"  onclick="refreshFunction()">Refresh CNET</button>  -->
	<button  name="btnview" style="width:60px;height:60px;margin-top:14px;background-color:#555555;text-align:center;color: white;"  onclick="refreshFunction()"><align>Refresh CNET</button> 
	<!--  <a href="javascript:refreshFunction();" id="linkval" class="l-bg-grey-dark"  name="btnview" style="width:auto;margin-top:37px" >Refresh CNET</a> -->
	  <!-- </div> -->
	 <!-- </div> -->
  </div>
  </div>
  
  </div>
  
  

<hr style="border-top:5px double #095484;">

 <div class="row" style="width:100%" >
 
 <div class="column" style="width:30%" >
 
 
 
 		
 
  		 <div style="width:100%;height:420px;overflow:auto">  
  		 
  		 <!--  <form name="searchformname" id="searchformid" method="post"  action="#" onsubmit="SearchFunction()">  -->
  		 <input type="search"  id="searchmfid" name="searchmfname" style="width:250px;height:40px" placeholder="Search by MFPN#"  >
  		 	
  		 <button class="btnimg" name="searchsubname" id="searchsubname" onclick="SearchFunction()" ><i class="fa fa-search"></i></button>
  		 	<!-- </form> -->
  		 	
  		 	<!-- <form name="downloadformname" id="downloadformid" method="post" action="#" onsubmit="downloadFunction();return false"> -->
  		 	  <button class="btnimg" id="downloadmfpn" name="downloadmfpn" onclick="downloadFunction()"><i class="fa fa-download"></i></button>
 			<!-- </form> -->
 		<br>
 			
 				
 	 	
  <script>
  		
  	
  		 function SearchFunction(){
  		  		 
		<% 
			if(request.getParameter("searchsubname")!=null)
			{
				
				System.out.println("MFPR " + request.getParameter("searchmfname"));		
				
				%> <input type="hidden" id="searchmprnid" name="searchmprname" value="<%=request.getParameter("searchmfname")%>"><%
				if (request.getParameter("searchmfname") != null)
				{
					request.setAttribute("searchmfnameinside",request.getParameter("searchmfname"));
			    	java.sql.ResultSet resultsearch;
			    	java.sql.CallableStatement cstmt;
			    	
			    	java.sql.Connection conn; 
			    	String searchvalue="";
			    	searchvalue=request.getParameter("searchmfname");
			    	conn = JDBCConnection.getConnection("QDC");
			    	//stmt = conn.createStatement();
			    	cstmt= conn.prepareCall("exec GetSKU_TableInfo @p_mfprn ='"+searchvalue+"'");
			    	resultsearch =cstmt.executeQuery();
			    	
			    	String universalprodid="";
			    	String universalMFPN="";
			    			    	
			    	while (resultsearch.next()){
			    					    		
			    		System.out.println("MFPR ProdID--" + resultsearch.getString("ProdID"));
			    		
			    		universalprodid=resultsearch.getString("ProdID").toString();
			    		universalMFPN=resultsearch.getString("MfPN").toString();
			    		
			    		request.setAttribute("ProdID",resultsearch.getString("ProdID"));
			    		request.setAttribute("CatID",resultsearch.getString("CatID"));
			    		request.setAttribute("MfPN",resultsearch.getString("MfPN"));
			    		request.setAttribute("Title",resultsearch.getString("Title"));
			    		request.setAttribute("UNSPSCSegment",resultsearch.getString("UNSPSCSegment"));
			    		request.setAttribute("UNSPSCFamily",resultsearch.getString("UNSPSCFamily"));
			    		request.setAttribute("UNSPSCClass",resultsearch.getString("UNSPSCClass"));
			    		request.setAttribute("UNSPSCCommodity",resultsearch.getString("UNSPSCCommodity"));
			    		request.setAttribute("ProductSource",resultsearch.getString("ProductSource"));
			    		request.setAttribute("short description",resultsearch.getString("short description"));
			    		
			    	}
			    	
			    	System.out.println("universalprodid 1---- " + universalprodid);
			    	
			    	request.setAttribute("universalprodid",universalprodid);
			    	request.setAttribute("universalMFPN",universalMFPN);
			    	
			    		conn.close();
				}
				
			}
		
			else{
				
			}
		%>

		
  		}
  		
		</script>
		
		
		<script>
		function downloadFunction() {
	
	<%
	 if(request.getParameter("downloadmfpn")!=null){ 
		//String val="1000165"; //request.getAttribute("ProdID");
		 //SimpleDb2CsvExporter.csvdownload(val);
		System.out.println(" searchmprnid " + request.getParameter("searchmprnid"));
		System.out.println(" searchmprname " + request.getAttribute("searchmprname"));
		
		
		 try{
			
			 
	    	java.sql.ResultSet resultsearch;
	    	java.sql.ResultSet resultprid;
	    	
	    	java.sql.CallableStatement cstmt;
	    	java.sql.Statement stmt1 ;
	    	
	    	java.sql.Connection conn; 
	    	/* String searchvalue=prodid; */
	    	/* String searchvalue= request.getParameter("searchmprname"); */
	    	
	    	String searchvalue=request.getParameter("searchmfname");
	    	System.out.println(" searchvalue " + searchvalue);
	    		
	    	/* String searchvalue= (String) request.getAttribute("universalMFPN");
	    	System.out.println(" universalMFPN " + searchvalue); */
	    	
	    	
	    	conn = JDBCConnection.getConnection("QDC");
	    	stmt1 = conn.createStatement(); 
	    	resultprid = stmt1.executeQuery(" select prodid from cds_prod where mfpn ='"+searchvalue+"'");
	    		
	    		String prodvalue = "";
	    		
	    		while(resultprid.next())
	    		{
	    			prodvalue =resultprid.getString("ProdID");
	    		}
	    		System.out.println(" prodvalue " + prodvalue);
	    		
	    	//cstmt= conn.prepareCall("exec GetSKU_Header @p_prodid ='"+searchvalue+"'");
	    	//cstmt= conn.prepareCall("exec GetSKU_TableInfo @p_mfprn ='"+searchvalue+"'");
	    	cstmt= conn.prepareCall("exec GetSKU_Header @p_prodid ='"+prodvalue+"'");
	    	
	    	resultsearch =cstmt.executeQuery();
	    	
	    	
	    	  //String filename = "C://Users/pravin/Downloads/"+searchvalue+".csv";
	    	 String filename = "C://Downloads/"+searchvalue+".csv"; 
	    	// String filename = searchvalue+".csv";
	    	  System.out.println("filename " + filename);
	            
	    	/*FileWriter my_csv=new FileWriter("D://out.csv");*/
	    	  FileWriter my_csv=new FileWriter(filename);
	    	CSVWriter my_csv_output=new CSVWriter(my_csv); //Create a writer object
	    	boolean includecolumnnames=true;
	    	my_csv_output.writeAll(resultsearch,includecolumnnames); //write output by directly reading the Resultset, include column names in report
	    	my_csv_output.close();
	            
	             
	           // cstmt.close();
	            //resultsearch.close();
	           // cstmt.close();
	            conn.close();
	            
	             
	        } catch (Exception e)
	        {
	        	e.printStackTrace();
	        }
	 }
		 
	%>

}
</script>		
		
		
		 <!--  Table 1  -->
 
 	 <br>
  		
  		<table style="width:100%;height:10px;font-family:calibri">
  		<tr style="width:40%">
  		<td style="font-size:18px"><b>Origin </b></td>
  		<td style="width:60%">
  				<% if (request.getAttribute("ProductSource") != null){ %>
  		 		<%= request.getAttribute("ProductSource")%>
  				<% } %> </td>
  		</tr>
  		</table>
  		
  		<table style="width:100%;height:40px;font-family:calibri">
  				
  				 <tr style="font-size:18px">
  					<th  style="width:40%"><b>MFG Product Code</b></th>
  				</tr>
  				<tr><td style="width:40%;font-size:14px">CNET</td>
  				<td style="width:60%">
  				<% if (request.getAttribute("MfPN") != null){ %>
  		 		<%= request.getAttribute("MfPN")%>
  				<% } %> </td>
  				</tr>
  				
  				<tr>
  				<td style="width:30%">QDC</td>
  				<td style="width:70%">
  				<% if (request.getAttribute("MfPN") != null){ %>
  		 		<%= request.getAttribute("MfPN")%>
  				<% } %> </td>
  				</tr>
  				
  				<tr>
  				<td style="width:30%">QPC eVolve</td>
  				<td style="width:70%">
  				<% if(request.getAttribute("MfPN") != null){ %>
  		 		<%= request.getAttribute("MfPN")%>
  				<% } %> </td>
  				</tr>
		  
			 </table>
			 
			 <br>
			 <table style="width:100%;height:40px;font-family:calibri">
			 <!-- <tr><font size="4"><b>QDC Origin (CNET)</b></font></tr> -->
			  <tr style="font-size:18px">
  					<th  style="width:40%"><b>QDC Origin (CNET)</b></th>
  				</tr>
  				<!-- <tr><td style="width:25%">Category</td></tr> -->
  				<tr><td style="width:30%">CNET Category</td>
  				<td style="width:70%">
  				<% if (request.getAttribute("CatID") != null){ %>
  		 		<%= request.getAttribute("CatID")%>
  				<% } %> </td>
  				</tr>
			 
				
  				<tr><td style="width:30%">QDC Category</td>
  				<td style="width:70%">
  				<% if (request.getAttribute("CatID") != null){ %>
  		 		<%= request.getAttribute("CatID")%>
  				<% } %> </td>
  				</tr>
			 
			 </table>
			 
			  <br>
			 <table style="width:100%;height:40px;font-family:calibri">
			 
			 <!-- <tr><font size="4"><b>QPC(eVolve)</b></font></tr> -->
			  <tr style="font-size:18px">
  					<th  style="width:40%"><b>QPC(eVolve)</b></th>
  				</tr>
			 <tr><td style="width:30%">Segment</td>
			 
			 <td style="width:70%">
  				<% if (request.getAttribute("UNSPSCSegment") != null){ %>
  		 		<%= request.getAttribute("UNSPSCSegment")%>
  				<% } %> </td></tr>
			 <tr><td style="width:30%">Family</td>
			 <td style="width:70%">
  				<% if (request.getAttribute("UNSPSCFamily") != null){ %>
  		 		<%= request.getAttribute("UNSPSCFamily")%>
  				<% } %> </td></tr>
			 <tr><td style="width:30%">Class</td>
			 <td style="width:70%">
  				<% if (request.getAttribute("UNSPSCClass") != null){ %>
  		 		<%= request.getAttribute("UNSPSCClass")%>
  				<% } %> </td></tr>
			 <tr><td style="width:30%">Commodity</td>
				 <td style="width:70%">
  				<% if (request.getAttribute("UNSPSCCommodity") != null){ %>
  		 		<%= request.getAttribute("UNSPSCCommodity")%>
  				<% } %> </td></tr>
			 </table>
			 </div>
	</div>
			 

  <div class="vr"></div>

 <!--  right column start -->
 
 <div  class="column right" style="width:60%">
 	 
 	
	 <!--  new tab layout -->
	 <% /* if (request.getParameter("btnprid")!=null )
 							{ */
 							
 							
 							/* String prodidname =request.getParameter("btnprid"); */
 							//String prodidname=  request.getParameter("prodidfromsearch");
 							String prodidname= (String)request.getAttribute("universalprodid");
 							System.out.println("prid !!!!!  " + prodidname );
 							
 							java.sql.Statement stmt2;
 							java.sql. CallableStatement calstms2;
 							
							java.sql.ResultSet title;
							java.sql.ResultSet resultmarketdesc;
							java.sql.ResultSet mainspec;
							java.sql.ResultSet extendedspec;
							java.sql.ResultSet attributeresult;
							java.sql.ResultSet resultheader;
							java.sql.ResultSet resultdesc;
							java.sql.ResultSet resultpdf;
							java.sql.ResultSet resultlogo;
							java.sql.ResultSet resultmultipleimage;
							java.sql.ResultSet resultfeature;
							
 							java.sql.Connection conn2; 
 							
 							
 							conn2 = JDBCConnection.getConnection("QDC");
 							
 							stmt2 = conn2.createStatement();
 						
 							
 							%>
 							
		<div style="height:400px;width:100%;overflow: auto">
 						<ul class="tab">
 					
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'headr')">Header</a></li>
 						 <!-- <li><a href="#" class="tablinks" onclick="openCity(event, 'tdes')">Title Description</a></li> -->
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'mainspec')">Main Specification</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'extspec')">Extended Specification</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'markdesc')">Marketing Description</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'feat')">Features</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'witb')">Whats's in the box</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'acce')">Accessories</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'mi')">Multiple Images</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'logo')">Logo</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'pdf')">Pdf's</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'attb')">Attributes</a></li>
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'enerl')">Energy Labels</a></li>
						</ul>
						
						
						
						
						<div id="headr" class="tabcontent"> 
						
						<%
								 
								calstms2= conn2.prepareCall("exec GetSKU_Header @p_prodid ='"+prodidname+"'");
								 resultheader =calstms2.executeQuery();
								 
								
								%>
								<table class="table table-bordered table-striped" >
								<% while(resultheader.next())
								{
									
								%>
								
								<tr><th> Header Details</th></tr>
								
								<tr> 
								
								<th>ProdID</th>
								<td><%= resultheader.getString("ProdID")%></td>
								
								<th>CatID</th>
								<td><%= resultheader.getString("CatID")%></td>
								
								</tr>
								
								
								<tr> 
								
								<th>ImgID</th>
								<td><%= resultheader.getString("ImgID")%></td>
								
								<th>UNSPSCSegment</th>
								<td><%= resultheader.getString("UNSPSCSegment")%></td>
								
								</tr>
								
								
									<tr> 
								
								<th>MfID</th>
								<td><%= resultheader.getString("MfID")%></td>
								
								<th>UNSPSCFamily</th>
								<td><%= resultheader.getString("UNSPSCFamily")%></td>
								
								</tr>
								
								
									<tr> 
								
								<th>MfPN</th>
								<td><%= resultheader.getString("MfPN")%></td>
								
								<th>UNSPSCClass</th>
								<td><%= resultheader.getString("UNSPSCClass")%></td>
								
								</tr>
								
									<tr> 
								
								<th>ReplacedByManufacturerID</th>
								<td><%= resultheader.getString("ReplacedByManufacturerID")%></td>
								
								<th>UNSPSCCommodity</th>
								<td><%= resultheader.getString("UNSPSCCommodity")%></td>
								
								</tr>
								
								
									<tr> 
								
								<th>Title</th>
								<td><%= resultheader.getString("short description")%></td>
								
								<th>long description</th>
								<td><%= resultheader.getString("long description")%></td>
								
								</tr>
								
									<tr> 
								
								<th>DateAdded</th>
								<td><%= resultheader.getString("DateAdded")%></td>
								
								<th>DateModified</th>
								<td><%= resultheader.getString("DateModified")%></td>
								</tr>
								
								<tr> 
								
								<th>QOIPRlicense</th>
								<td><%= resultheader.getString("QOIPRlicense")%></td>
								
								<th>IsBundle</th>
								<td><%= resultheader.getString("IsBundle")%></td>
								</tr>
								
								
								<tr> 
								
								<th>SendBundleItemMethod</th>
								<td><%= resultheader.getString("SendBundleItemMethod")%></td>
								
								<th>ProductLevelMargin</th>
								<td><%= resultheader.getString("ProductLevelMargin")%></td>
								</tr>
								
								
								<tr> 
								
								<th>ReplacedByProductID</th>
								<td><%= resultheader.getString("ReplacedByProductID")%></td>
								
								<th>Active</th>
								<td><%= resultheader.getString("Active")%></td>
								</tr>
								
								<tr> 
								
								<th>HSNCode</th>
								<td><%= resultheader.getString("HSNCode")%></td>
								
								<th>HSNdescription</th>
								<td><%= resultheader.getString("HSNdescription")%></td>
								</tr>
								
								<tr> 
								
								<th>Regulated</th>
								<td><%= resultheader.getString("Regulated")%></td>
								
								<th>ProductSource</th>
								<td><%= resultheader.getString("ProductSource")%></td>
								</tr>
								
								<tr> 
								
								<th>ReplacedByManufacturer</th>
								<td><%= resultheader.getString("ReplacedByManufacturer")%></td>
								
								<th>ProductStatus</th>
								<td><%= resultheader.getString("ProductStatus")%></td>
								</tr>
								
								<tr> 
								
								<th>IsFreightApplicable</th>
								<td><%= resultheader.getString("IsFreightApplicable")%></td>
								</tr>
								
								
								<%
								} 
								/* conn1.close(); */
								%>
						
							</table>
	
							<%-- <%} %> --%>
						
						</div><!-- header tab end -->
						
						<%-- <div id="tdes" class="tabcontent"> 
							<%
							title = stmt2.executeQuery(" select description from  cds_stdnee where ProdID ='"+request.getParameter("btnprid")+"'");
							 while (title.next()) { 
									%> 
									
									<p><%= title.getString("description") %></p> <%
									
									/*  System.out.println(" -----------------4444----------------title " + title.getString("description")); */
								}
							 
							%>
							
							</div> --%>
						
						<div id="mainspec" class="tabcontent">
							<table class="table table-bordered table-striped">
							<% 
							 calstms2= conn2.prepareCall("exec dbo.GetSKU_MainSpec @p_prodid ='"+prodidname+"'");
							mainspec =calstms2.executeQuery();
							
							
							 while(mainspec.next())
							 	
							 {
								 								 
								 %>
								 <tr>
								 <th><%= mainspec.getString("Header")%> </th>
								 <td><%= mainspec.getString("body")%></td>
								 </tr>
								 
							<%
							 }
							%>
							 </table>
							</div>
							
							<div id="extspec" class="tabcontent">
							
							<table class="table table-bordered table-striped" width=100%>
									
						<%
						
						calstms2= conn2.prepareCall("exec dbo.GetSKU_ExtendedSpec @p_prodid ='"+prodidname+"'");
						extendedspec =calstms2.executeQuery();
						
						while (extendedspec.next())
						{
						
								%>
								
								<tr>
								<th><%= extendedspec.getString("Sector")%></th>
								<th><%= extendedspec.getString("Header")%></th>
								<td><%= extendedspec.getString("Body")%></td>
								</tr>
								
								
								<%
							
						}	
						
						%> 
						</table>
						<div><br></div>
						
						
							 <!-- <p>Inside Extended Specification.</p> -->
							</div>
							
							
							<div id="markdesc" class="tabcontent">
							
							</div>
							
							<div id="feat" class="tabcontent">
							 <table class="table table-bordered table-striped" width=100%>
							<tr>
							<th>ContentGUID</th>
							<th>URL</th>
							<th>Mediatypeid</th>
							<th>Language Code</th>
							</tr>
							<% 
							calstms2= conn2.prepareCall("exec dbo.GetSKU_MarketingText @p_prodid ='"+prodidname+"'");
							resultfeature =calstms2.executeQuery();
								while (resultfeature.next())
								{
								
										%>
										
										<tr>
										<th><%= resultfeature.getString("contentguid")%></th>
										<th><%= resultfeature.getString("url")%></th>
										<td><%= resultfeature.getString("mediatypeid")%></td>
										<td><%= resultfeature.getString("languagecode")%></td>
										</tr>
										
										<%
									
								}	
								
								%>
							</table>
							</div>
							
							<div id="witb" class="tabcontent">
							 <p>No Data</p>
							</div>
							
							<div id="acce" class="tabcontent">
							 <p>No Data</p>
							</div>
							
							<div id="mi" class="tabcontent">
							  <table class="table table-bordered table-striped" width=100%>
							<tr>
							<th>ContentGUID</th>
							<th>URL</th>
							<th>Resolution</th>
							<th>Weight</th>
							</tr>
							
							<% 
							calstms2= conn2.prepareCall("exec dbo.GetSKU_ProductPrimaryImage @p_prodid ='"+prodidname+"'");
							resultmultipleimage =calstms2.executeQuery();
								while (resultmultipleimage.next())
								{
								
										%>
										
										<tr>
										<th><%= resultmultipleimage.getString("contentguid")%></th>
										<th><%= resultmultipleimage.getString("url")%></th>
										<td><%= resultmultipleimage.getString("Resolution")%></td>
										<td><%= resultmultipleimage.getString("Weight")%></td>
										</tr>
										
										<%
									
								}	
								
								%>
							</table>
							</div>
							
							<div id="logo" class="tabcontent">
							 <p></p>
							 <table class="table table-bordered table-striped" width=100%>
							<tr>
							<th>ContentGUID</th>
							<th>URL</th>
							<th>Resolution</th>
							
							</tr>
							
							<% 
							calstms2= conn2.prepareCall("exec dbo.GetSKU_ManufacturerLogo @p_prodid ='"+prodidname+"'");
							resultlogo =calstms2.executeQuery();
								while (resultlogo.next())
								{
								
										%>
										
										<tr>
										<th><%= resultlogo.getString("contentguid")%></th>
										<th><%= resultlogo.getString("url")%></th>
										<td><%= resultlogo.getString("Resolution")%></td>
										</tr>
										
										<%
									
								}	
								
								%>
							</table>
							</div>
							
							<div id="pdf" class="tabcontent">
							
							<table class="table table-bordered table-striped" width=100%>
							<tr>
							<th>ContentGUID</th>
							<th>URL</th>
							<th>Mediatypeid</th>
							<th>Language Code</th>
							</tr>
							
							<% 
							calstms2= conn2.prepareCall("exec dbo.GetSKU_PDFS @p_prodid ='"+prodidname+"'");
							resultpdf =calstms2.executeQuery();
								while (resultpdf.next())
								{
									
										%>
										
										<tr>
										<th><%= resultpdf.getString("contentguid")%></th>
										<th><%= resultpdf.getString("url")%></th>
										<td><%= resultpdf.getString("mediatypeid")%></td>
										<td><%= resultpdf.getString("languagecode")%></td>
										</tr>
										
										<%
									
								}	
								
								%>
							</table>
							 
							</div>
							

							<div id="attb" class="tabcontent">
							
							<table class="table table-bordered table-striped" width=100%>
							
							<tr>
								 <th>Atrid</th>
								 <th>Attribute</th>
								 <th>ValueID</th>
								 <th>UnitID</th>
								 <th>Unit</th>
								 <th>ValueUnit</th>
								 <th>nnv</th>
							</tr>
							<%
							
							calstms2= conn2.prepareCall("exec dbo.GetSKU_Attribute @p_prodid ='"+prodidname+"'");
							attributeresult =calstms2.executeQuery();
							
							while(attributeresult.next())
							 	
							 {
								 								 
								 %>
								<tr>
								 <td> <%= attributeresult.getString("atrid") %></td>
								 <td> <%= attributeresult.getString("Attribute") %></td>
								 <td> <%= attributeresult.getString("ValueID") %></td>
								 <td> <%= attributeresult.getString("UnitID") %></td>
								 <td> <%= attributeresult.getString("Unit") %></td>
								 <td> <%= attributeresult.getString("ValueUnit") %></td>
								 <td> <%= attributeresult.getString("nnv") %></td>
								 </tr>
							<%
							 }%>
		
							</table>
							 
							</div>
							
							<div id="enerl" class="tabcontent">
							  <p>No Data</p>
							</div>
							
							<%	
							
							conn2.close();
								/* }  */
							
						
							%>
							
							<!--   end of tabcontent -->
						
						
 </div>
					

 </div>  <!--  right column end -->
  </div> <!--  row end -->


 <br>
 
</form>

</body>
</html>
