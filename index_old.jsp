
<%@page import="java.sql.CallableStatement"%>
<%@page import="com.qdcdata.JDBCConnection"%>
<%@page import="com.qdcdata.SimpleDb2CsvExporter"%>
<%@page import="au.com.bytecode.opencsv.CSVWriter"%>
<%@page import="java.io.FileWriter"%>
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
    	
    	resulttotal = stmt.executeQuery("select * from CrossWalkCounts");
    	
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

.card {
    background-color: #fff;
    border-radius: 10px;
    border: none;
    position: relative;
     /* height: 20vh;  */
    margin-bottom: 30px;
    box-shadow: 0 0.46875rem 2.1875rem rgba(90,97,105,0.1), 0 0.9375rem 1.40625rem rgba(90,97,105,0.1), 0 0.25rem 0.53125rem rgba(90,97,105,0.12), 0 0.125rem 0.1875rem rgba(90,97,105,0.1);
}

.l-bg-grey-dark {
    background: linear-gradient(to right, #D5DBDB, #CCD1D1) !important;
    color: #000000;
}

.red {
  background-color: #D5DBDB;

}
</style>

<style>

.row{
width:110%;
}
.column{
float:left;
width:45%;
margin-left:2px;
padding:0px;
height:900px;
}

.right{
float:left;
width:45%;
padding:0px;
height:1400px;
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


	<script>
		function downloadFunction() {
	
	<%
	 if(request.getParameter("downloadmfpn")!=null){ 
		String val="1000165"; //request.getAttribute("ProdID");
		 //SimpleDb2CsvExporter.csvdownload(val);
		 
		 try{
			
	    	java.sql.ResultSet resultsearch;
	    	java.sql.ResultSet resultprid;
	    	
	    	java.sql.CallableStatement cstmt;
	    	java.sql.Statement stmt1 ;
	    	//JDBCConnection jcon = new JDBCConnection();
	    	java.sql.Connection conn; 
	    	/* String searchvalue=prodid; */
	    	String searchvalue= request.getParameter("searchmprname");
	    	//String searchvalue=request.getParameter("searchmfname");
	    	System.out.println(" searchvalue " + searchvalue);
	    	
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
</head>
<body>
<!-- <form name="cardfileform" id="cardsform" method="post" > -->

<br>

	<div><h4 align="center">Crosswalk View - Search Launchpad</h4></div>
	 
	<form name="cardformname" id="cardsformid" method="post"> 
 <div class="container"> 


	<div class="card-deck">
	  
	  
	  
				   <!-- card 1  -->
				 
				  <div class="card l-bg-grey-dark" >
				  <div class="card-header text-center"><h6>QDC Evolve Origin</h6></div>
				  <div class="card-body text-center">
				  <p class="card-text">
				   <% if (request.getAttribute("QPC_Evolve_Origin") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("QPC_Evolve_Origin") %> 
				    	  <%
				    }
				    	 %>
				   </p>
				  </div>
				  </div>
				 
			
	  
	  				 <!-- card 2  -->
			   
			  <div class="card l-bg-grey-dark" >
			  <div class="card-header text-center"><h6>QDC Evolve Active Origin</h6></div>
			  <div class="card-body text-center">
			  <p class="card-text">
				   <% if (request.getAttribute("QPC_Evolve_Active") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("QPC_Evolve_Active") %> 
				    	  <%
				    }
				    	 %>
				   </p>
			  </div>
			<!--   <div class="card-footer">val</div> -->
		  </div>
		  
  
  				 <!-- card 3  -->
  
		  <div class="card l-bg-grey-dark">
			  <div class="card-header text-center"><h6>Requested to CNET</h6></div>
			  <div class="card-body text-center">
			  <p class="card-text">
				   <% if (request.getAttribute("RequestedToCNET") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("RequestedToCNET") %>
				    	  <%
				    }
				    	 %>
				   </p>
			  </div>
			 
		  </div>
  
  
		   <!-- card 4  -->
		   
		  <div class="card l-bg-grey-dark">
			  <div class="card-header text-center"><h6>QDC = QPC and CNET</h6></div>
			  <div class="card-body text-center">
			  <p class="card-text">
				   <% if (request.getAttribute("QDC") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("QDC") %>
				    	  <%
				    }
				    	 %>
				   </p>
			  </div>
			  
		  </div>

  
			   <!-- card 5  -->
			   
			  	<div class="card l-bg-grey-dark">
				  <div class="card-header text-center"><h6>Origin CNET</h6></div>
				  <div class="card-body text-center">
				  <p class="card-text">
				   <% if (request.getAttribute("Origin_CNET") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("Origin_CNET") %>
				    	  <%
				    }
				    	 %>
				   </p>
				  </div>
					 
				  </div>

  
			   <!-- card 6  -->
			   
			  	<div class="card l-bg-grey-dark">
				  <div class="card-header text-center"><h6>Origin QPC</h6></div>
				  <div class="card-body text-center">
				<p class="card-text">
				   <% if (request.getAttribute("Origin_QPC") != null)
      				{
				    	 %> 
				    	  <%=request.getAttribute("Origin_QPC") %>
				    	  <%
				    }
				    	 %>
				   </p>
				  </div>
				
			  	</div>
	  
	  
	  <!-- Refresh QDC -->
	
	  <div class="card l-bg-grey-dark">
	    <div class="card-header text-center">
	  <!--   <div class="card-header text-center"><h3></h3></div> -->
	     <!--  <p class="card-text"></p> --><br>
	    
	     <input type="submit" name="btnview" style="width:auto" value="Refresh CNET">
	    
	    </div>
	  </div>
	 </div>
  
  </div>
  </form>
  
<br><br>
<hr style="border-top: 3px double #095484;">
 
 <div class="container-fluid"> 


 <div class="row">
 
 <div class="column" >
 
 
 <form name="tableformname" id="tableformid" method="post">
  		 <div class="container-fluid">  
		<% 
			if(request.getParameter("searchsubname")!=null)
			{
				
				System.out.println("MFPR " + request.getParameter("searchmfname"));		
				%> <input type="hidden" id="searchmprnid" name="searchmprname" value="<%=request.getParameter("searchmfname")%>"><%
				if (request.getParameter("searchmfname") != null)
				{
					
			    	java.sql.ResultSet resultsearch;
			    	java.sql.CallableStatement cstmt;
			    	//JDBCConnection jcon = new JDBCConnection();
			    	java.sql.Connection conn; 
			    	String searchvalue="";
			    	searchvalue=request.getParameter("searchmfname");
			    	conn = JDBCConnection.getConnection("QDC");
			    	//stmt = conn.createStatement();
			    	cstmt= conn.prepareCall("exec GetSKU_TableInfo @p_mfprn ='"+searchvalue+"'");
			    	resultsearch =cstmt.executeQuery();
			    	
			    	while (resultsearch.next()){
			    					    		
			    		System.out.println("MFPR " + resultsearch.getString("ProdID"));
			    		
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
			    	
			    	conn.close();
				}
				
			
			}
		
		%>
		 <!--  Table 1  -->
 	<!-- <table id="dtBasicExample" class="table table-striped table-bordered table-sm w-auto" "> -->
  		<table class="table table-bordered">
 			<h3>QDC</h3>
 				<thead>
		        <tr>
		         <th>ProdID</th>
		          <th>MfPN</th>
		           <th>Title</th>
		     	<th>CAT ID</th>
		     	<th>ORIGIN</th>
		     	</tr>
		      </thead>
		      <tbody>
		      
		      <tr>
		      <!-- <td><input type="hidden" id="qdcid" name="dataname1" value="QDC"></td> -->
		      <td><input type="submit" name="btnprid" class="btn btn-success" value="<%= request.getAttribute("ProdID")%>"></td>
		       <%--   <td><%= request.getAttribute("ProdID")%></td> --%>
		          <td><%= request.getAttribute("MfPN")%></td>
		          <td><%= request.getAttribute("Title")%></td>
		     	<td><%= request.getAttribute("CatID")%></td>
		     	<td><%= request.getAttribute("ProductSource")%></td>
		     	</tr>
		      
		      </tbody>
 
			 </table>
			 
			 
			 <!--  Table 2  -->
			 <table class="table table-bordered" >
 			<h3>CNET</h3>
 				<thead>
		        <tr>
		         <th>ProdID</th>
		          <th>MfPN</th>
		           <th>Title</th>
		     	<th>CAT ID</th>
		     	
		     	</tr>
		      </thead>
		      <tbody>
		      
		      <tr>
		      <!-- <td><input type="hidden" id="cnetid" name="dataname1" value="CNET"></td> -->
		      <td><input type="submit" name="btnprid" class="btn btn-success" value="<%= request.getAttribute("ProdID")%>"></td>
		      
		        <%--  <td><%= request.getAttribute("ProdID")%></td> --%>
		          <td><%= request.getAttribute("MfPN")%></td>
		          <td><%= request.getAttribute("Title")%></td>
		     	<td><%= request.getAttribute("CatID")%></td>
		   
		     	</tr>
		      
		      </tbody>
 
			 </table>
			 
			 <!--  Table 3  -->
			 <table class="table table-bordered" >
 			<h3>QPC EVOLVE</h3>
 				<thead>
		        <tr>
		         <th>ProdID</th>
		          <th>MfPN</th>
		           <th>Title</th>
		     	<th>UNSPSC Segment</th>
		     	<th>UNSPSC Family</th>
		     	<th>UNSPSC Class</th>
		     	<th>UNSPSC Commodity</th>
		     	</tr>
		      </thead>
		      <tbody>
		      
		      <tr>
		     <!--  <td><input type="hidden" id="qpcid" name="dataname1" value="QPC"></td> -->
		      <td><input type="submit" name="btnprid" class="btn btn-success" value="<%= request.getAttribute("ProdID")%>"></td>
		      
		        <%--  <td><%= request.getAttribute("ProdID")%></td> --%>
		          <td><%= request.getAttribute("MfPN")%></td>
		          <td><%= request.getAttribute("short description")%></td>
		     	<td><%= request.getAttribute("UNSPSCSegment")%></td>
		     	<td><%= request.getAttribute("UNSPSCFamily")%></td>
		     	<td><%= request.getAttribute("UNSPSCClass")%></td>
		     	<td><%= request.getAttribute("UNSPSCCommodity")%></td>
		     	
		     	</tr>
		      
		      </tbody>
 
			 </table>
			 
			 </div>
			 </form>
 </div>
 
 <!--  right column start -->
 
 <div class="column right" style="background-color:#ccc;">
 	 <!-- <form  id="dataform" name="dataformname" > -->
 	<div> <input type="text" id="searchmfid" name="searchmfname" style="width:250px" placeholder="Search by MFPN#">
 
	
	 <input type="submit" name="searchsubname" class="btn btn-success" value="Search">
	<!-- <input type="button"   name="searchsubname" class="btn btn-success" value="Search"></button> -->
	<input type="submit" id="downloadmfpn" name="downloadmfpn" class="btn btn-success" value="Download" onclick="downloadFunction()">
	<!-- <input type="submit" name="downloadall" class="btn btn-success" value="Download All"> -->
	
	</div>
	
	
	<div class="container">
	<%
	
	
	if (request.getParameter("btnprid") != null)
	{
			
		System.out.println(" product " + request.getParameter("table1"));
		
	java.sql.Statement stmt1;
	java.sql.ResultSet resultheader;
	java.sql.ResultSet resultdesc;
	java.sql.Connection conn1; 
	java.sql. CallableStatement calstms;
	 
	conn1 = JDBCConnection.getConnection("QDC");
	stmt1 = conn1.createStatement();
	String prid=request.getParameter("btnprid");
	/* resultheader = stmt1.executeQuery(" select * from in_cds_prod_tmp where ProdID ='"+request.getParameter("btnprid")+"'"); */
	/* resultheader = stmt1.executeQuery(" select * from cds_Prod where ProdID ='"+request.getParameter("btnprid")+"'"); */
	
	/* resultheader = stmt1.executeQuery(" select prd.*,descr.* from cds_Prod prd, [dbo].[cds_Prod_description] "+
	                   " descr where descr.prodid ='"+request.getParameter("btnprid")+"' and prd.prodid='"+request.getParameter("btnprid")+"'");
	 */
	 
	 calstms= conn1.prepareCall("exec GetSKU_Header @p_prodid ='"+prid+"'");
	 resultheader =calstms.executeQuery();
	 
	
	%>
	<table class="table table-bordered">
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
	conn1.close();
	%>
	</table>
	
		<%} %>
	</div>
	
	<div><br></div>
	
	
	<div class="container">
 						
 						<%if (request.getParameter("btnprid")!=null )
 							{
 							java.sql.Statement stmt;
 							String prodidname =request.getParameter("btnprid");
							java.sql.ResultSet title;
							java.sql.ResultSet resultmarketdesc;
							java.sql.ResultSet mainspec;
							java.sql.ResultSet extendedspec;
							java.sql.ResultSet attributeresult;
 							java.sql.Connection conn2; 
 							
 							java.sql. CallableStatement calstms2;
 							 
 							conn2 = JDBCConnection.getConnection("QDC");
 							
 							stmt = conn2.createStatement();
 						
 							 
 							/* calstms2= conn2.prepareCall("exec GetSKU_Header @p_prodid ='"+prodidname+"'");
 							 resultheader =calstms1.executeQuery(); */
 							
 							%>
 						
 						<ul class="tab">
 						 <li><a href="#" class="tablinks" onclick="openCity(event, 'tdes')">Title Description</a></li>
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
 						
 						<div id="tdes" class="tabcontent"> 
							<%
							title = stmt.executeQuery(" select description from  cds_stdnee where ProdID ='"+request.getParameter("btnprid")+"'");
							 while (title.next()) { 
									%> 
									
									<p><%= title.getString("description") %></p> <%
									
									/*  System.out.println(" -----------------4444----------------title " + title.getString("description")); */
								}
							 
							%>
							
							</div>
						
						<div id="mainspec" class="tabcontent">
							<table border="1">
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
							
							<table border="1" width=100%>
									
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
							<table border="1" width=100%>
							<tr>
							<th>ContentGUID</th>
							<th>URL</th>
							<th>Mediatypeid</th>
							<th>Language Code</th>
							</tr>
							<% 
							calstms2= conn2.prepareCall("exec dbo.GetSKU_MarketingText @p_prodid ='"+prodidname+"'");
						resultmarketdesc =calstms2.executeQuery();
								while (resultmarketdesc.next())
								{
								
										%>
										
										<tr>
										<th><%= resultmarketdesc.getString("contentguid")%></th>
										<th><%= resultmarketdesc.getString("url")%></th>
										<td><%= resultmarketdesc.getString("mediatypeid")%></td>
										<td><%= resultmarketdesc.getString("languagecode")%></td>
										</tr>
										
										<%
									
								}	
								
								%>
							</table>
							</div>
							
							<div id="feat" class="tabcontent">
							 <table>
							<tr>
							<th>Key Selling Points </th>
							</tr>
							<tr>
							<td>There is no data<td>
							</tr>
							<tr>
							<th>Product features </th>
							</tr>
							<tr>
							<td>no data<td>
							</tr>
							
							</table>
							</div>
							
							<div id="witb" class="tabcontent">
							 <p>No Data</p>
							</div>
							
							<div id="acce" class="tabcontent">
							 <p>No Data</p>
							</div>
							
							<div id="mi" class="tabcontent">
							 <p>No Data</p>
							</div>
							
							<div id="logo" class="tabcontent">
							 <p>No Data</p>
							</div>
							
							<div id="pdf" class="tabcontent">
							 <p>No Data</p>
							</div>
							

							<div id="attb" class="tabcontent">
							
							<table border="1" width=100%>
							
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
								} 
							
						
							%>
							
							<!--   end of tabcontent -->
						
						 	
						 	</div> <!-- container div -->					
 						
 						
 						<!-- <div class="tab">
								<button class="tablinks" onclick="openCity(event, 'tdes')">Title Description</button>
							  <button class="tablinks" onclick="openCity(event, 'mainspec')">Main Specification</button>
							  <button class="tablinks" onclick="openCity(event, 'extspec')">Extended Specification</button>
							  <button class="tablinks" onclick="openCity(event, 'markdesc')">Marketing Description</button>
							  <button class="tablinks" onclick="openCity(event, 'feat')">Features</button>
							  <button class="tablinks" onclick="openCity(event, 'witb')">Whats's in the box</button>
							  <button class="tablinks" onclick="openCity(event, 'acce')">Accessories</button>
							  <button class="tablinks" onclick="openCity(event, 'mi')">Multiple Images</button>
							  <button class="tablinks" onclick="openCity(event, 'logo')">Logo</button>
							  <button class="tablinks" onclick="openCity(event, 'pdf')">Pdf's</button>
							  <button class="tablinks" onclick="openCity(event, 'attb')">Attributes</button>
							  <button class="tablinks" onclick="openCity(event, 'enerl')">Energy Labels</button>
							</div>
							<div id="tdes" class="tabcontent"> 
							<p>inside tab content</p>
							</div>
 							</div> -->
					
<!--   </form> -->
 </div>  <!--  right column end -->
 

 </div>
 
</div>
 </form> 


</body>
</html>
