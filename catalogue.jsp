<%@page import="com.qdcdata.JDBCConnection"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<% 

java.sql.Statement stmt;
java.sql.ResultSet resultcnet;
java.sql.ResultSet resultqdc;
java.sql.ResultSet resultqpc;
//JDBCConnection jcon = new JDBCConnection();
java.sql.Connection conn; 
String prdidcnet="";
conn = JDBCConnection.getConnection("QDC");
stmt = conn.createStatement();
java.sql.ResultSet result;

/* resultqpc = stmt.executeQuery("select top 10 * from in_cds_prod_tmp ");
 */
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <title>Evolve - QDC</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
   <link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
   <style>
body {font-family: Arial;}

/* Style the tab */
.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}
</style>
<style>
* {
  box-sizing: border-box;
}

.row {
  display: flex;
  margin-left:-5px;
  margin-right:-5px;
}

.column {
  flex: 50%;
  padding: 5px;
}

table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 16px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}
</style>
</head>
<body>
<form method="post">
<br>

	<h4 align="center"> QDC VIEW </h4>
	<br>
	
	<table>
	<tr>
	<td>
		<div class="container">
			<div class="table-responsive">
			<!-- <table class="table table-bordered" id="tableid"  > -->
			  <table id="dtBasicExample" class="table table-striped table-bordered table-sm w-auto" "> 
			<!-- <table class="table"> -->
			<h3>CNET</h3>
		    <!-- <table id="dtBasicExample" class="table table-striped table-bordered table-sm w-auto" "> -->
		    <thead>
		        <tr>
		         <th>ProdID</th>
		          <th>MfPN</th>
		           <th>Title</th>
		     	<th>CatID</th>
		     </tr>
		      </thead>
		    <tbody> 
		      <% 
		     /* resultcnet = stmt.executeQuery("select top 10 * from in_cds_prod_tmp where ProductSource='CNET' and ProductStatus='ORGN'"); */ 
		      
		      resultcnet = stmt.executeQuery(" select top 10 prd.*,descr.[short description] as title1 from cds_Prod prd,"+
		    		  " [dbo].[cds_Prod_description] descr where descr.prodid = prd.prodid " +
											" and prd.ProductSource='CNET' and prd.ProductStatus='ORGN'"); 
		      
		     /*resultcnet = stmt.executeQuery("select top 10 * from cds_Prod where ProductSource='CNET' and ProductStatus='ORGN'");*/
		      
		    while (resultcnet.next()) { 
		   	 /* System.out.println(resultcnet.getString("ProdID")+"  "+resultcnet.getString("CatID") + " " + resultcnet.getString("ImgID")); */
		    
		    %>
		    <tr>
		  
		    <td>
		     <input type="hidden" id="cnetid" name="dataname1" value="CNET">
		    <input type="submit" name="btnprid" class="btn btn-success" value="<%= resultcnet.getString("ProdID")%>">
		    </td>
		    <td> <%= resultcnet.getString("MfPN")%></td>
		    <td> <%= resultcnet.getString("title1")%></td>
		    <td> <%= resultcnet.getString("CatID")%></td>
		    
		    </tr>
		    <% 
		    }
		    %>
		    </tbody>
		    </table>
			</div>
		</div>
		</td>
		
	<!--  second table QDC  -->
	<td>
	<div class="container">
	 <div class="table-responsive"> 
			<!-- <table class="table table-bordered" id="tableid"  > -->
			  <table id="dtBasicExample" class="table table-striped table-bordered table-sm w-auto" "> 
			<!-- <table class="table"> -->
			<h3>QDC</h3>
		   <!--  <table id="dtBasicExample" class="table table-striped table-bordered table-sm w-auto" "> -->
		    <thead>
		        <tr>
		         <th>ProdID</th>
		          <th>MfPN</th>
		           <th>Title</th>
		     	<th>CatID</th>
		     	<th>Origin</th>
		     </tr>
		      </thead>
		    <tbody> 
		      <% 
		     /* resultqdc = stmt.executeQuery("select top 8 * from in_cds_prod_tmp ");  */
		     
		     resultqdc = stmt.executeQuery("select top 8 prd.*,descr.[short description] as title1 from cds_Prod prd,"+
		    		  "[dbo].[cds_Prod_description] descr where descr.prodid = prd.prodid ");
						
		    		 
		    		 /* select top 8 * from cds_Prod ");  */
		     /*resultqdc = stmt.executeQuery("select top 8 * from cds_Prod ");*/
		      
		    while (resultqdc.next()) { 
		   	 /* System.out.println(resultqdc.getString("ProdID")+"  "+resultqdc.getString("CatID") + " " + resultqdc.getString("ImgID")); */
		    
		    %>
		    <tr>
		  
		    <td>
		    <input type="hidden" id="qdcid" name="dataname2" value="QDC">
		    <input type="submit" name="btnprid" class="btn btn-success" value="<%= resultqdc.getString("ProdID")%>">
		    </td>
		    <td> <%= resultqdc.getString("MfPN")%></td>
		    <td> <%= resultqdc.getString("title1")%></td>
		    <td> <%= resultqdc.getString("CatID")%></td>
		    <td> <%= resultqdc.getString("ProductSource")%></td>
		    </tr>
		    <% 
		    }
		    %>
		    </tbody>
		    </table>
			 </div> 
			 <div><p> <input type="text" id="searchmfid" name="searchmfname" placeholder="Search by MFPN#"></p></div>
			 <div><input type="submit" name="searchsubname" class="btn btn-success" value="Search"></div>
	</div>
	  </td>
	  
	  <!--   Third table -->
	<td>
	<div class="container">
	<div class="table-responsive"> 
			<!-- <table class="table table-bordered" id="tableid"  > -->
			  <table id="dtBasicExample" class="table table-striped table-bordered table-sm w-auto" "> 
		<!-- 	<table class="table"> -->
			<h3>QPC</h3>
		   <!--  <table id="dtBasicExample" class="table table-striped table-bordered table-sm w-auto" "> -->
		    <thead>
		        <tr>
		         <th>ProdID</th>
		          <th>MfPN</th>
		           <th>Title</th>
		     	<th>CatID</th>
		     </tr>
		      </thead>
		    <tbody> 
		      <% 
		     /* resultqpc = stmt.executeQuery("select top 10 * from in_cds_prod_tmp where ProductSource='QOIPR' and ProductStatus='SRC'"); */
		     
		    resultqpc = stmt.executeQuery("select top 10 prd.*,descr.[short description] as title1 from cds_Prod prd,"+
		    		  "[dbo].[cds_Prod_description] descr where descr.prodid = prd.prodid and prd.ProductSource='QOIPR' and prd.ProductStatus='SRC'");
		    		
		    		/* select top 10 * from cds_Prod where ProductSource='QOIPR' and ProductStatus='SRC'");  */
		      
		      while (resultqpc.next()) { 
		   	 /* System.out.println(resultqpc.getString("ProdID")+"  "+resultqpc.getString("CatID") + " " + resultqpc.getString("ImgID")); */
		    
		    %>
		    <tr>
		  
		    <td>
		    <input type="hidden" id="qpcid" name="dataname3" value="QPC">
		    <input type="submit" name="btnprid" class="btn btn-success" value="<%= resultqpc.getString("ProdID")%>">
		    </td>
		    <td> <%= resultqpc.getString("MfPN")%></td>
		   
		    <td> <%= resultqpc.getString("title1")%></td>
		  	
		    <td> <%= resultqpc.getString("CatID")%></td>
		    
		    </tr>
		    <% 
		    }
		    
		    conn.close();
		    %>
		    </tbody>
		    </table>
			 </div>
	</div>
	  </td>
	
	</tr>
	</table>
	</form>
	<div><br></div>
	<!-- Tab links -->
	
	<div class="container">
	<%
	
	
	if (request.getParameter("btnprid") != null)
	{
	java.sql.Statement stmt1;
	java.sql.ResultSet resultheader;
	java.sql.ResultSet resultdesc;
	java.sql.Connection conn1; 
	 
	conn1 = JDBCConnection.getConnection("QDC");
	stmt1 = conn1.createStatement();
	
	/* resultheader = stmt1.executeQuery(" select * from in_cds_prod_tmp where ProdID ='"+request.getParameter("btnprid")+"'"); */
	/* resultheader = stmt1.executeQuery(" select * from cds_Prod where ProdID ='"+request.getParameter("btnprid")+"'"); */
	
	resultheader = stmt1.executeQuery(" select prd.*,descr.* from cds_Prod prd, [dbo].[cds_Prod_description] "+
	                   " descr where descr.prodid ='"+request.getParameter("btnprid")+"' and prd.prodid='"+request.getParameter("btnprid")+"'");
	
	
	%>
	<table>
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
	
	<%-- <tr> 
	
	<th>ProdID</th>
	<td><%= resultheader.getString("ProdID")%></td>
	
	<th>CatID</th>
	<td><%= resultheader.getString("CatID")%></td>
	
	</tr>
	
	<tr>
	<th>ImgID</th>
	<td><%= resultheader.getString("ImgID")%></td>
	
	<th>MfID</th>
	<td><%= resultheader.getString("MfID")%></td>
	</tr>
	
	
	<tr>
	<th>MfPN</th>
	<td><%= resultheader.getString("MfPN")%></td>
	
	<th>ReplacedByManufacturerID</th>
	<td><%= resultheader.getString("ReplacedByManufacturerID")%></td>
	</tr>
	
	<tr>
	<th>Title</th>
	<td>
	
	<%= resultheader.getString("short description")%></td>
	
	<th>UNSPSCSegment</th>
	<td><%= resultheader.getString("UNSPSCSegment")%></td>
	</tr>
	
	<tr>
	<th>UNSPSCFamily</th>
	<td><%= resultheader.getString("UNSPSCFamily")%></td>
	
	<th>UNSPSCClass</th>
	<td><%= resultheader.getString("UNSPSCClass")%></td>
	</tr>
	
	<tr>
	<th>UNSPSCCommodity</th>
	<td><%= resultheader.getString("UNSPSCCommodity")%></td>
	
	 <th>DateAdded</th>
	<td><%= resultheader.getString("DateAdded")%></td>
	</tr> 
	
	
	<tr>
	<th>DateModified</th>
	<td><%= resultheader.getString("DateModified")%></td>
	
	<th>QOIPRlicense</th>
	<td><%= resultheader.getString("QOIPRlicense")%></td>
	</tr>
	
		<tr>
	<th>IsBundle</th>
	<td><%= resultheader.getString("IsBundle")%></td>
	
	<th>SendBundleItemMethod</th>
	<td><%= resultheader.getString("SendBundleItemMethod")%></td>
	</tr>
	
	<tr>
	<th>ProductLevelMargin</th>
	<td><%= resultheader.getString("ProductLevelMargin")%></td>
	
	<th>ReplacedByProductID</th>
	<td><%= resultheader.getString("ReplacedByProductID")%></td>
	</tr>
	
	<tr>
	<th>Active</th>
	<td><%= resultheader.getString("Active")%></td>
	
	<th>HSNCode</th>
	<td><%= resultheader.getString("HSNCode")%></td>
	</tr>
	
	<tr>
	<th>HSNdescription</th>
	<td><%= resultheader.getString("HSNdescription")%></td>
	
	<th>Regulated</th>
	<td><%= resultheader.getString("Regulated")%></td>
	</tr>
	
	<tr>
	<th>ProductSource</th>
	<td><%= resultheader.getString("ProductSource")%></td>
	
	<th>ReplacedByManufacturer</th>
	<td><%= resultheader.getString("ReplacedByManufacturer")%></td>
	</tr>
	
	<tr>
	<th>ProductStatus</th>
	<td><%= resultheader.getString("ProductStatus")%></td>
	
	<th>IsFreightApplicable</th>
	<td><%= resultheader.getString("IsFreightApplicable")%></td>
	</tr> --%>
	
	<%
	} 
	conn1.close();
	%>
	</table>
	
		<%} %>
	</div>
	
	<div><br></div>
	
	<div class="container">
	<%
	
	/* String datanameval="";
	if(request.getParameter("dataname1") != null)
		
	{
		System.out.println(" dataname1  " );
		datanameval = request.getParameter("dataname1");
	}
	if(request.getParameter("dataname2") != null)
	{
		System.out.println(" dataname2  " );
		datanameval = request.getParameter("dataname2");
	}
	if (request.getParameter("dataname3") != null)
	{
		System.out.println(" dataname3  " );
		datanameval = request.getParameter("dataname3");
	}
	System.out.println(" datanameval ***************  " + datanameval); */

	
	
	if (request.getParameter("btnprid")!=null )
								
		
	{
		conn = JDBCConnection.getConnection("CNET");
		stmt = conn.createStatement();
		
		String prodidname =request.getParameter("btnprid");
								java.sql.ResultSet title;
								java.sql.ResultSet resultmarketdesc;
								java.sql.ResultSet mainspec;
								java.sql.ResultSet extendedspec;
								java.sql.ResultSet attributeresult;
								String titleval="";
								
								/* System.out.println(" btnprid ***************  " +request.getParameter("btnprid")); */
								
								%>
								
								<%-- <H3><%= datanameval%></H3> --%>
	<!-- </div>
	
	
	<div class="container"> -->
	
							<div class="tab">
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
							mainspec =stmt.executeQuery("SELECT m.prodid,v.text AS Header,v2.text AS Body " +
						    		" FROM cds_Mspecee m " +
						    		" JOIN cds_mvocee v " +
						    		" ON m.hdrid = v.id " +
						    		" JOIN cds_mvocee v2 " +
						    		" ON m.bodyid  = v2.id " +
						    		" WHERE m.prodid  = '"+prodidname+"'" +  
						    		" ORDER BY m. prodid," +
						    		" m.displayorder");
						    /* System.out.println(" -----------------4444----------------mainspec " +mainspec); */
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
									<tr><th>General</th></tr>
						<%
						
						extendedspec=stmt.executeQuery("SELECT e. prodid,v.text   AS Sector,v2.text  AS Header,v3.text  AS Body "+
								" FROM   cds_especee e "+
								" JOIN cds_evocee  v "+
								" ON e .sectid = v .id "+
								" JOIN cds_evocee  v2 "+
								" ON e .hdrid = v2 .id "+
								" JOIN cds_evocee  v3 "+
								" ON  e.bodyid =  v3.id "+
								" WHERE  e .prodid = '"+prodidname+"'" +
								" ORDER  BY  e.prodid , "+
								" e .displayorder");
					    /* System.out.println(" -----------------5555----------------"); */
						while (extendedspec.next())
						{
						
							if( extendedspec.getString("Sector").equalsIgnoreCase("General"))
							{
								
								%>
								
								<tr>
								<th><%= extendedspec.getString("Header")%></th>
								<td><%= extendedspec.getString("Body")%></td>
								</tr>
								
								
								<%
								 /* System.out.println(" -----------------general----------------");
								 
								 System.out.println(extendedspec.getString("Header"));  */
							}
							
						}	
						
						%> 
						</table>
						<div><br></div>
						<table border="1" width=100%>
								<tr><th>Details</th></tr>
							<% 
							 java.sql.ResultSet extendedspecdetails;
							extendedspecdetails=stmt.executeQuery("SELECT e. prodid,v.text   AS Sector,v2.text  AS Header,v3.text  AS Body "+
									" FROM   cds_especee e "+
									" JOIN cds_evocee  v "+
									" ON e .sectid = v .id "+
									" JOIN cds_evocee  v2 "+
									" ON e .hdrid = v2 .id "+
									" JOIN cds_evocee  v3 "+
									" ON  e.bodyid =  v3.id "+
									" WHERE  e .prodid = '"+prodidname+"'" +
									" ORDER  BY  e.prodid , "+
									" e .displayorder");
								
							/* System.out.println(" -----------------6666----------------"); */
							while (extendedspecdetails.next())
							{
							
								/* System.out.println(" -----------------insed exten 1----------------"); */
								if (extendedspecdetails.getString("Sector").equalsIgnoreCase("Details"))
								{
									%> 
									<tr>
									<th><%= extendedspecdetails.getString("Header")%></th>
									<td><%= extendedspecdetails.getString("Body")%></td>
									</tr>
									<%
									
									/* System.out.println(" -----------------Details----------------");
									System.out.println(extendedspecdetails.getString("Header")); */
								}
								 
							}	
							
							%> 
							</table>
							<div><br></div>
							<table border="1" width=100%>
									<tr><th>Compatibility Information</th></tr>
									
							<%
							java.sql.ResultSet extendedspeccompinfo;
							extendedspeccompinfo=stmt.executeQuery("SELECT e. prodid,v.text   AS Sector,v2.text  AS Header,v3.text  AS Body "+
									" FROM   cds_especee e "+
									" JOIN cds_evocee  v "+
									" ON e .sectid = v .id "+
									" JOIN cds_evocee  v2 "+
									" ON e .hdrid = v2 .id "+
									" JOIN cds_evocee  v3 "+
									" ON  e.bodyid =  v3.id "+
									" WHERE  e .prodid = '"+prodidname+"'" +
									" ORDER  BY  e.prodid , "+
									" e .displayorder");
							/* System.out.println(" -----------------7777----------------"); */
							while (extendedspeccompinfo.next())
							{
								/* System.out.println(" -----------------insed exten 2----------------"); */
								if (extendedspeccompinfo.getString("Sector").equalsIgnoreCase("Compatibility Information"))
								{
									
									%> 
									<tr>
									<th><%= extendedspeccompinfo.getString("Header")%></th>
									<td><%= extendedspeccompinfo.getString("Body")%></td>
									</tr>
									
									<%
									/* System.out.println(" -----------------Compatibility Information----------------");
									System.out.println(extendedspeccompinfo.getString("Header")); */
								}
								
							}
							
							%>
							</table>
							 <!-- <p>Inside Extended Specification.</p> -->
							</div>
							
							
							<div id="markdesc" class="tabcontent">
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
							
							<div id="feat" class="tabcontent">
							 <p>No Data</p>
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
							attributeresult=stmt.executeQuery("SELECT a.atrid,v.text AS Attribute,a.valid AS ValueID,a.unitid AS UnitID,v3.text AS Unit,COALESCE( v2.text +  ' ' + v3. text, v2. text) AS ValueUnit ,a. nnv " +
						    		" FROM   cds_atr  a " +
						    		" JOIN cds_vocee  v " +
						    		" ON  a.atrid  = v. id " +
						    		" JOIN  cds_vocee v2 " +
						    		" ON  a.valid  = v2. id " +
						    		" LEFT  JOIN cds_vocee  v3 " +
						    		" ON a .unitid  = v3 .id " +
						    		" WHERE   a. prodid = '"+prodidname+"'" +
						    		" ORDER   BY a .atrid; ");
							/* System.out.println(" -----------------8888----------------"); */
							while(attributeresult.next())
							 	
							 {
								 /* System.out.println(" -----------------5----------------");
								 System.out.println("attribute " + attributeresult.getString("atrid")); */
								 
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
							
							conn.close();
								} 
							
						
							%>
							
							<!--   end of tabcontent -->
							
							
							</div>
							<script>
								function openCity(evt, cityName) {
								  var i, tabcontent, tablinks;
								  tabcontent = document.getElementsByClassName("tabcontent");
								  for (i = 0; i < tabcontent.length; i++) {
								    tabcontent[i].style.display = "none";
								  }
								  tablinks = document.getElementsByClassName("tablinks");
								  for (i = 0; i < tablinks.length; i++) {
								    tablinks[i].className = tablinks[i].className.replace(" active", "");
								  }
								  document.getElementById(cityName).style.display = "block";
								  evt.currentTarget.className += " active";
								}
								</script>
								
	
<div><br><br><br></div>
	  
	<!-- </form> -->
</body>
</html>