<%@ page language="java" import="java.sql.*, java.io.IOException, java.lang.*,java.text.*,java.util.*,java.awt.*,javax.naming.*,java.util.*,javax.sql.*,java.io.InputStream"%>
<%
String WeeklyPAXQuery = "";
String weekly_XAxis = "";
int weekelyArrPaxCount = 0;
int weekelyDepPaxCount = 0;

String WeeklyFlightsQuery = "";
String weeklyFlightXAxis = "";
int weekelyArrFlightCount = 0;
int weekelyDepFlightCount = 0;

String arrHourlyQuery = "";
String hourlyXAxis = "";
int hourlyArrFlightCount = 0;
int hourlyArrPaxCount = 0;
int hourlyArrActiveCounter = 0;

String depHourlyQuery = "";
String hourlyDepXAxis = "";
int hourlyDepFlightCount = 0;
int hourlyDepPaxCount = 0;
int hourlyDepActiveCounter = 0;
int displayHours = 8;
%>
		<!DOCTYPE html>
		<html>
		<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>IndexForm</title>
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/style1.css" rel="stylesheet" type="text/css">
		<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/all.min.css" media="all">
<link rel="stylesheet" href="css/style.css" media="all">
<script src="bar.js" type="text/javascript"></script>
<script src="js/Charts.js"></script>

<style>
canvas {
   
    background: linear-gradient(to bottom, #ffffff 40%, #fff9b0 100%);
}


.canvasArrPAXFltActCount 
{
    background: linear-gradient(to bottom, #ffffff 40%, #99ccff 100%);
	
}

.tableDesign {
	border-collapse: separate;
	border-spacing: 0;
	
}
<%//.tableDesign tr:hover {background-color: coral;}%>




.tableDesign tr th, .tableDesign tr td {
	border-right: 1px solid #bbb;
	border-bottom: 1px solid #bbb;
	padding: 5px;
}

.tableDesign tr th:first-child, .tableDesign tr td:first-child {
	border-left: 1px solid #bbb;
}

.tableDesign tr th {
	background: #eee;
	border-top: 1px solid #bbb;
	text-align: left;
}

/* top-left border-radius */
.tableDesign tr:first-child th:first-child {
	border-top-left-radius: 10px;
}

/* top-right border-radius */
.tableDesign tr:first-child th:last-child {
	border-top-right-radius: 10px;
}

/* bottom-left border-radius */
.tableDesign tr:last-child td:first-child {
	border-bottom-left-radius: 10px;
}

/* bottom-right border-radius */
.tableDesign tr:last-child td:last-child {
	border-bottom-right-radius: 10px;
}


</style>

<script>
		function compare_report()
		{
			
			
				document.entryfrm.target="_self";
				document.entryfrm.action="im_icp_dashboard_00.jsp?&icp="+document.entryfrm.compare_icp.value;
				document.entryfrm.submit();
				return true;

		}
</script>

		</head>
		<body onload="apex_search.init();">
		<div class="wrapper">
		<div class="flag-strip"></div>
		<header class="bg-white py-1">
		  <div class="container">
			<div class="row">
			  <div class="col-sm-4">
				<a href="../OCI-html/index.html"><h1><span>IVFRT (I)</span><br/>National Informatic Centre</h1></a>
			  </div>
			  <!--<div class="col-sm-8">
				<table border="0" cellpadding="0" cellspacing="0">
		<input type="text" size="30" maxlength="1000" value="" id="S" onkeyup="apex_search.search(event);" /> &nbsp <input type="button" value=" Search" onclick="apex_search.lsearch();"/> 
		</table>
			  </div>
			  -->
			  <div class="col-sm-4"></div>
			  <div class="col-sm-4 search">
				<input class="form-control me-2" type="text" id="S" onkeyup="apex_search.search(event);" placeholder="Search" />
				<button class="btn btn-primary" type="button" onclick="apex_search.lsearch();"> Search </button>&nbsp;&nbsp;&nbsp;
				<button class="btn btn-primary" type="button" onClick="apex_reload();"> Refresh </button>
			  </div>
			</div> 
		  </div>
		</header>
		<div class="menu">
		  <nav class="navbar navbar-expand-sm">
			<div class="container"> 
			  <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#collapsibleNavbar"> <span class="navbar-toggler-icon"></span> </button>
			  <div class="collapse navbar-collapse" id="collapsibleNavbar">
				<ul class="navbar-nav">
				  <li class="nav-item"><a href="#Home" class="scrollLink nav-link">Home</a></li>
				  <li class="nav-item dropdown"><a href="ICS_0" class="scrollLink nav-link dropdown-toggle" data-toggle="dropdown">Immigration Clearance</a>
				  <ul class="dropdown-menu">
				  <li> <a class="scrollLink dropdown-item" href="#ICS_1">Arrival and Departure Immigration Clearance in last 7 days</a> </li>
				  <li> <a class="scrollLink dropdown-item" href="#ICS_2">Arrival : PAX Clearance, Active Flights and Active Counters in last <%=displayHours%> hours</a> </li>
				  <li> <a class="scrollLink dropdown-item" href="#ICS_3">Departure : PAX Clearance, Active Flights and Active Counters in last <%=displayHours%> hours</a> </li>
				  <li> <a class="scrollLink dropdown-item" href="#ICS_4">Hourly Clearance of Arrival/Departure Flights in last <%=displayHours%> hours</a></ul></li>

				  <li class="nav-item dropdown"><a href="#biometric_0" class="scrollLink nav-link dropdown-toggle" data-toggle="dropdown">Biometrics</a>
				  <ul class="dropdown-menu">
				  <li> <a class="scrollLink dropdown-item" href="#biometric_1">Enrollment/Verification/Exemption Statistics in last 7 days</a> </li>
				  <li> <a class="scrollLink dropdown-item" href="#biometric_2">Enrollment/Verification/Exemption Statistics in last <%=displayHours%> hours</a></ul></li>

				  <li class="nav-item dropdown"><a href="#visa_0" class="scrollLink nav-link dropdown-toggle" data-toggle="dropdown">Visa</a>
				  <ul class="dropdown-menu">
				  <li> <a class="scrollLink dropdown-item" href="#visa_1">Arrival : Visa Clearance in last 7 days</a> </li>
				  <li> <a class="scrollLink dropdown-item" href="#visa_2">Arrival : Visa Clearance in last <%=displayHours%> hours</a></ul></li>

				  <li class="nav-item dropdown"><a href="#biometric_0" class="scrollLink nav-link dropdown-toggle" data-toggle="dropdown">Centralised Dashboard</a>
				   <ul class="dropdown-menu">
					<li> <a class="scrollLink dropdown-item" href="http://10.248.168.222:8080/dashboard/" target="_blank">Immigration Control System</a> </li>
					<li> <a class="scrollLink dropdown-item" href="http://10.248.168.222:8080/dashboard/index_apis.jsp" target="_blank">Advanced Passenger Information System</a> </li>
					<li> <a class="scrollLink dropdown-item" href="http://10.248.168.222:8080/dashboard/index_epassport.jsp" target="_blank">e-Passport Statistics</a> </li>
				  <li> <a class="scrollLink dropdown-item" href="http://10.248.168.222:8080/dashboard/index_evisa.jsp" target="_blank">e-Visa Statistics</a></ul></li>


			   </ul>
			  </div>
			</div>
		  </nav>
		</div>
		</div>
		




		<!--   ************************START HOME DIV*******************HOME DIV*****************START HOME DIV****************START HOME DIV********  -->
		<div class="aboutsection">
		<section id="Home">
		<div class="pt-4" id="home">
		<table id = "auto-index" class="table table-sm table-striped">
		   <thead>
			<tr id='head1'>
					<th colspan=9 bgcolor="green">HOME</th>
				</tr>
				<tr id='head' name='home'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th colspan=6>Description</th>
				</tr>
			</thead>

</table><br>
		<%!
		// Function to Print numbers in Indian Format

		public String getIndianFormat(int num){

			String convertedNumber = "";
			int digitCount = 1;
			
			do{
				int currentDigit = num%10;
				num = num /10;
				if( digitCount%2 ==0 && digitCount!=2)
					convertedNumber = currentDigit + "," + convertedNumber;
				else
					convertedNumber = currentDigit + convertedNumber;
				digitCount++;
			
			}while(num>0);
			
			return convertedNumber;
		}


%>

<%!
		// Function to reverse time attributes in graph

		    public static String reverseOnComma(String input){

			String parts[] = input.split(",");
			StringBuilder reversed = new StringBuilder();

			for(int i = parts.length - 1; i >= 0; i--){
			reversed.append(parts[i]);
			if(i>0){
				reversed.append(",");
			}
		}
		return reversed.toString();
	}
%>

	<%
	Connection con = null;
try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	con = DriverManager.getConnection("jdbc:oracle:thin:@10.248.168.201:1521:ICSSP", "imigration", "nicsi123");

	/*Context ctx = null;
	Connection con = null;

	ctx = new InitialContext();
	Context envCtx = (Context)ctx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/im_pax_ds");
	con = ds.getConnection();*/

	PreparedStatement psMain = null;
	PreparedStatement psTemp = null;
	Statement st_icp = con.createStatement();

	ResultSet rs_icp = null;
	ResultSet rsMain = null;
	ResultSet rsTemp = null;


	String dashQuery = "";
	String depQuery = "";
	int today_Arrival_Count = 0;
	int total_Arrival_Flights = 0;
	int dep_Passenger_Flights = 0;
	int daily_Dep_Count = 0;
	int total_Dep_Flights = 0;
	int total_Arrival_Count = 0;
	int yesterday_Arrival_Count = 0;
	int total_Dep_Count = 0;
	int arr_Flight_Count = 0;
	int yest_Flight_Count = 0;
	
////////////////////	Arrival/Departure PAX Count	Tabs	/////////////////////////

		// DateFormat vDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		 DateFormat vDateFormatYes = new SimpleDateFormat("dd MMM");
		 java.util.Date current_Server_Time = new java.util.Date();
		 String today_date = vDateFormatYes.format(current_Server_Time);
		
		
		 java.util.Date yesterday_date_in_millis = new java.util.Date(System.currentTimeMillis()-1*24*60*60*1000);
		 String yesterday_date = vDateFormatYes.format(yesterday_date_in_millis);

		 String filter_icp = request.getParameter("icp") == null ? "004" : request.getParameter("icp");
		 //out.println("kuhkihfayfdjhj" + filter_icp);
   	 	 if(filter_icp.equals("")) filter_icp = "" + filter_icp + "";

//=================================================

	%>
<form name="entryfrm" method="post">
	<table align="center" width="80%" cellspacing="0"  cellpadding="4" border="0">
		<tr bgcolor="#D0DDEA">
			<td align="center">
		   
			</select><font face="Verdana" color="#347FAA" size="2"><b>&nbsp;&nbsp;ICP&nbsp;&nbsp;</b><select name="compare_icp">
			<option value="All" <%if(filter_icp.equals("All")){%> selected<%}%>>All ICPs</option>
<%
			rsTemp = st_icp.executeQuery("select ICP_SRNO,ICP_DESC from IM_ICP_LIST where ICP_SRNO in ('022', '010', '006', '033', '023', '007', '094', '012', '019', '021', '092', '026', '003', '016', '032', '002', '008', '" + filter_icp + "', '001', '041', '085', '024', '077', '095', '025', '015', '096', '084', '005', '030', '029', '017') order by ICP_DESC");
			while(rsTemp.next())
			{
%>
				<option value="<%=rsTemp.getString("ICP_SRNO")%>" <%if(filter_icp.equals(rsTemp.getString("ICP_SRNO"))){%> selected<%}%>><%=rsTemp.getString("ICP_DESC")%></option>
<%
			}
			 rsTemp.close();  
			 int div_hgt = 200; 
			 if(filter_icp.equals("All")) {
				 div_hgt = 600;
			 }
%> 
			</select>&nbsp;&nbsp;
			&nbsp;&nbsp;<input type="button" class="Button" value="Generate" onclick=" compare_report();" style=" font-family: Verdana; font-size: 9pt; color:#000000; font-weight: bold"></input>
			</td>
		</tr>
	</table>
</form>
<br>

<%//================================================


	try {
		dashQuery = "select distinct GRAND_TOTAL_PAX_ARR as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

	total_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}

	try {
		dashQuery = "select distinct DAILY_ARRIVAL_PAX_COUNT as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate-1)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

	yesterday_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}
	try {
		dashQuery = "select distinct DAILY_ARRIVAL_PAX_COUNT as arr_Passenger_Count from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

	today_Arrival_Count = rsTemp.getInt("arr_Passenger_Count");

		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}

	//String test_no = getIndianFormat(total_Arrival_Count);
%>
<div class="row">
	<div class="column2" style="border-radius: 20px;">
		<div class="box_main red" style="border-radius: 20px;">
			<div class="d_flex">
				<div class="icon">
					<i class="fa-solid fa-plane-arrival"></i>
				</div>
				<div>
					<table>
						<tr>
							<td><h2 id="countArr"></h2></td>
							<td>Total Arrival Footfall</td>
						</tr>
						<tr class="red_faded">
							<td><h2 id="countArrY"></h2></td>
							<td><%=yesterday_date%></td>
						</tr>
						<tr>
							<td><h2 id="countArrT"></td>
							<td>Today's Footfall</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>



	<%
	/////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////
int today_Dep_Count = 0;
int yest_Dep_Count = 0;
int total_PAX_Count = 0;
int total_Yest_Count = 0;
int total_Today_PAX_Count = 0;;

try {
	dashQuery = "select distinct GRAND_TOTAL_PAX_DEP as dep_Passenger from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
	psTemp = con.prepareStatement(dashQuery);
	rsTemp = psTemp.executeQuery();
	if (rsTemp.next()) {

		total_Dep_Count = rsTemp.getInt("dep_Passenger");

		total_PAX_Count = total_Arrival_Count + total_Dep_Count;

	}
	rsTemp.close();
	psTemp.close();
} catch (Exception e) {
	out.println("Arrival Exception");
}

try {
	dashQuery = "select distinct DAILY_DEPARTURE_PAX_COUNT as dep_Passenger_Count from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate - 1)";
	psTemp = con.prepareStatement(dashQuery);
	rsTemp = psTemp.executeQuery();
	if (rsTemp.next()) {

		yest_Dep_Count = rsTemp.getInt("dep_Passenger_Count");

		total_Yest_Count = yest_Dep_Count + yesterday_Arrival_Count;

	}
	rsTemp.close();
	psTemp.close();
} catch (Exception e) {
	out.println("Arrival Exception");
}

try {
	dashQuery = "select distinct DAILY_DEPARTURE_PAX_COUNT as dep_Passenger_Count from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
	psTemp = con.prepareStatement(dashQuery);
	rsTemp = psTemp.executeQuery();
	if (rsTemp.next()) {

		today_Dep_Count = rsTemp.getInt("dep_Passenger_Count");

		total_Today_PAX_Count = today_Arrival_Count + today_Dep_Count;

	}
	rsTemp.close();
	psTemp.close();
} catch (Exception e) {
	out.println("Arrival Exception");
}
%>

	<div class="column2" style="border-radius: 20px;">
		<div class="box_main blue" style="border-radius: 20px;">
			<div class="d_flex">
				<div class="icon">
					<i class="fa-solid fa-plane-departure"></i>
				</div>
				<div>
					<table>
						<tr>
							<td><h2 id="count_total_Dep_Count"></h2></td>
							<td>Total Departure Footfalls</td>
						</tr>
						<tr class="blue_faded">
							<td><h2 id="count_total_Dep_CountY"></h2></td>
							<td><%=yesterday_date%></td>
						</tr>
						<tr>
							<td><h2 id="count_total_Dep_CountT"></h2></td>
							<td>Today's Footfall</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	



	<div class="column2" style="border-radius: 20px;">
		<div class="box_main orange" style="border-radius: 20px;">
			<div class="d_flex">
				<div class="icon">
					<i class="fa-solid fa-plane-up"></i>
				</div>
				<div>
					<table>
						<tr>
							<td><h2 id="total_PAX"></h2></td>
							<td>Total Footfalls</td>
						</tr>
						<tr class="orange_faded">
							<td><h2 id="total_PAX_Y"></h2></td>
							<td><%=yesterday_date%></td>
						</tr>
						<tr>
							<td><h2 id="total_PAX_T"></h2></td>
							<td >Today's Total Footfall</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<%




////////////////////	Arrival/Departure Flights Count	Tabs	/////////////////////////


try {
		dashQuery = "select distinct GRAND_TOTAL_CNT_FLT_ARR as total_Arrival_Flights from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

			total_Arrival_Flights = rsTemp.getInt("total_Arrival_Flights");

		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}

	try {
		dashQuery = "select distinct DAILY_ARRIVAL_FLIGHT_COUNT as arr_Flights from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

			arr_Flight_Count = rsTemp.getInt("arr_Flights");

		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}

	try {
		dashQuery = "select distinct DAILY_ARRIVAL_FLIGHT_COUNT as arr_Flights from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate-1)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

			yest_Flight_Count = rsTemp.getInt("arr_Flights");

		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}
	%>
	<div class="row">

	<div class="column2" style="border-radius: 20px;">
		<div class="box_main red" style="border-radius: 20px;">
			<div class="d_flex">
				<div class="icon">
					<i class="fa-solid fa-plane-arrival"></i>
				</div>
				<div>
					<table>
						<tr>
							<td><h2 id="countArrFlt"></h2></td>
							<td>Total Arrival Flights</td>
						</tr>
						<tr class="red_faded">
							<td><h2 id="countArrFltY"></h2></td>
							<td><%=yesterday_date%></td>
						</tr>
						<tr>
							<td><h2 id="countArrFltT"></h2></td>
							<td>Today's Flights</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<%
	
	int yest_Dep_Flights = 0;
	int today_Dep_Flights = 0;
	int total_Flights_Count = 0;
	int total_Flights_Count_Yest = 0;
	int total_Flights_Count_Today = 0;
	
	try {
		dashQuery = "select distinct GRAND_TOTAL_CNT_FLT_DEP as total_Dep_Flights from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

			total_Dep_Flights = rsTemp.getInt("total_Dep_Flights");
			total_Flights_Count =  total_Dep_Flights + total_Arrival_Flights;

		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}

	try {
		dashQuery = "select distinct DAILY_DEPARTURE_FLIGHT_COUNT as dep_Flights from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate - 1)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

			yest_Dep_Flights = rsTemp.getInt("dep_Flights");
			total_Flights_Count_Yest = yest_Flight_Count + yest_Dep_Flights;
			
		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}

	try {
		dashQuery = "select distinct DAILY_DEPARTURE_FLIGHT_COUNT as dep_Flights from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and PAX_BOARDING_DATE = trunc(sysdate)";
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		if (rsTemp.next()) {

			today_Dep_Flights = rsTemp.getInt("dep_Flights");
			total_Flights_Count_Today = arr_Flight_Count + today_Dep_Flights;
		}
		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Arrival Exception");
	}
	%>
	<div class="column2" style="border-radius: 20px;">
		
			<div class="box_main blue" style="border-radius: 20px;">
				<div class="d_flex">
					<div class="icon">
						<i class="fa-solid fa-plane-departure"></i>
					</div>
					<div>
						<table>
							<tr>
								<td><h2 id="count_total_Dep_Flights"></h2></td>
								<td>Total Departure Flights</td>
							</tr>
							<tr class="blue_faded">
								<td><h2 id="count_total_Dep_FlightsY"></h2></td>
							<td><%=yesterday_date%></td>
							</tr>
							<tr>
								<td><h2 id="count_total_Dep_FlightsT"></h2></td>
							<td>Today's Flights</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		
	</div>

	<div class="column2" style="border-radius: 20px;">
		<div class="box_main orange" style="border-radius: 20px;">
			<div class="d_flex">
				<div class="icon">
					<i class="fa-solid fa-plane-up"></i>
				</div>
				<div>
					<table>
						<tr>
							<td><h2 id="total_Flights"></h2></td>
							<td>Total Flights</td>
						</tr>
						<tr class="orange_faded">
							<td><h2 id="total_Flights_Y" ></h2></td>
							<td><%=yesterday_date%></td>
						</tr>
						<tr>
							<td><h2 id="total_Flights_T"></h2></td>
							<td>Today's Total Flights</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>


</div>


	
		</div>
		</section>
		<!--   ************************END HOME DIV*******************HOME DIV*****************END HOME DIV****************END HOME DIV********  -->
		<!--   ************************START ICS DIV*******************ICS DIV*****************START ICS DIV****************START ICS DIV********  -->
		<section id="ICS_1"><br><br><br><br><br>
		<div class="pt-4" id="ICS_1">
		<table id = "auto-index1" class="table table-sm table-striped" >
			<thead>
				<tr id='head1'>
					<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Arrival and Departure Immigration Clearance in last 7 days</th>
				</tr>
				
			</thead>
			
		</table><br>



<%////////////////////////	Arrival and Departure Immigration Clearance in last 7 days - Start	///////////////////////

StringBuilder weekDays = new StringBuilder();
StringBuilder weekArrPax = new StringBuilder();
StringBuilder weekDepPax = new StringBuilder();

boolean flagPaxCount = false;
try {
	WeeklyPAXQuery = "select distinct  to_char(pax_boarding_date,'Mon-dd') as show_date,pax_boarding_date,icp_description,DAILY_ARRIVAL_PAX_COUNT,DAILY_DEPARTURE_PAX_COUNT from im_dashboard_combined where table_type = 'IM_TRANS_DEP_TOTAL' and ICP_SRNO = '" + filter_icp + "' and pax_boarding_date >= trunc(sysdate-7) and pax_boarding_date <= trunc(sysdate) order by pax_boarding_date";
	psTemp = con.prepareStatement(WeeklyPAXQuery);
	rsTemp = psTemp.executeQuery();
	while (rsTemp.next()) {

		weekly_XAxis = rsTemp.getString("show_date");
		//out.println(weekly_XAxis);
		weekelyArrPaxCount = rsTemp.getInt("DAILY_ARRIVAL_PAX_COUNT");
		weekelyDepPaxCount = rsTemp.getInt("DAILY_DEPARTURE_PAX_COUNT");
		//out.println(weekelyArrPaxCount+weekelyDepPaxCount);

		if (flagPaxCount == true) {
	weekDays.append(",");
	weekArrPax.append(",");
	weekDepPax.append(",");
		} else
	flagPaxCount = true;

		weekDays.append("\"");
		weekDays.append(weekly_XAxis);
		weekDays.append("\"");
		weekArrPax.append(weekelyArrPaxCount);
		weekDepPax.append(weekelyDepPaxCount);
	}
	rsTemp.close();
	psTemp.close();

} catch (Exception e) {
	out.println("Arr/Dep PAX Count  Exception");
}

//String str1 = str_Hours.toString();
//String str2 = str_Hours_Flight_Count.toString();
String strWeekDays = weekDays.toString();
String strweekArrPax = weekArrPax.toString();
String strweekDepPax = weekDepPax.toString();
//out.println(strWeekDays);
%>

<%////////////////	Table -  Arrival and Departure Immigration Clearance in last 7 days - Start	///////////////////////%>
<div class="container-fluid">
<div class="row">
	<div class="col-sm-2">
		<table class="tableDesign">
			<!--<caption style="font-size: 22px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Arrival and Departure Immigration Clearance in last 7 days</caption>-->
			<tr style="font-size: 16px;  text-align: right; color:white; border-color: #6929c4;height:20px;">
					<th style="text-align: center;background-color:#6929c4;border-color: #6929c4;width:33.33%;">&nbsp;</th>
					<th colspan = "2" style="text-align: center;background-color:#6929c4;border-color: #6929c4;width:66.66%; text-align: center;">Total Footfall</th>
				</tr>
			<tr style="font-size: 16px;  text-align: right; color:white; border-color: #6929c4;height:20px; ">
				<th style="text-align: center;background-color:#6929c4;border-color: #6929c4;width:33.33%;text-align: center;">Date</th>
				<th style="text-align: center;background-color:#6929c4;border-color: #6929c4;width:33.33%; text-align: right;">Arrival</th>
				<th style="text-align: center;background-color:#6929c4;border-color: #6929c4;width:33.33%; text-align: right;">Departure</th>
			</tr>
		<% 

			/*String strWeekDays = weekDays.toString();
			String strweekArrPax = weekArrPax.toString();
			String strweekDepPax = weekDepPax.toString();*/
			

			String[] weekListPAX = strWeekDays.toString().replace("\"", "").split(",");
			String[] weeklyArrPAX = strweekArrPax.split(",");
			String[] weeklyDepPAX = strweekDepPax.split(",");
			for (int i = 0; i < weekListPAX.length; i++) {
							
				/*out.println( weekList[i]);
				if (Integer.parseInt( weekList[i].substring(11,13)) >= 0 & Integer.parseInt( weekList[i].substring(11,13)) <= 11)
				v_date_Format = weekList[i].substring(8,10) + "/" + weekList[i].substring(5,7) + "/" + weekList[i].substring(0,4) + " " + weekList[i].substring(11,13) + " AM" ;
						

			if (Integer.parseInt( weekList[i].substring(11,13)) >= 12 & Integer.parseInt( weekList[i].substring(11,13)) <= 23)
				v_date_Format = weekList[i].substring(8,10) + "/" + weekList[i].substring(5,7) + "/" + weekList[i].substring(0,4) + " " + weekList[i].substring(11,13) + " PM" ;*/

	

			%>
			<tr style="font-size: 14px; font-family: 'Arial', serif; text-align: center; border-color: #6929c4;height:18px;">
				<td style="background-color:#be95ff;border-color: #6929c4;width:33.33%; font-weight: bold;text-align: center;"><%=weekListPAX[i]%></td>
				<td style="background-color:#d4bbff;border-color: #6929c4;width:33.33%; font-weight: bold; text-align: right;"><%=weeklyArrPAX[i]%>&nbsp;</td>
				<td style="background-color:#e8daff;border-color: #6929c4;width:33.33%; font-weight: bold; text-align: right;"><%=weeklyDepPAX[i]%>&nbsp;</td>

			</tr>
<%
			}
			%>
		</table>
		</div>
	<%///////////////////////	Table -  Arrival and Departure Immigration Clearance in last 7 days - End	////////////////////////%>

	<div class="col-sm-4">
		<h1
			style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif; background-color: #ffffff">Arrival
			and Departure Immigration Clearance in last 7 days</h1>

		<canvas id="canvasPAX" class="chart" style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #b1d2d8 100%);"></canvas>
	</div>
	<script>
		// Data define for bar chart

		var myData = {
			labels: [<%=strWeekDays%>],
			datasets: [{ 
				  label: "Arrival Footfalls",
			      backgroundColor: "#00dcb0",
			      borderColor: "MediumSeaGreen",
			      borderWidth: 1,
			      data: [<%=strweekArrPax%>]
			}, { 
				  label: "Departure Footfalls",
			      backgroundColor: "#BEADFA",
			      borderColor: "Violet",
			      borderWidth: 1,
			      data: [<%=strweekDepPax%>]
			}]
		};
		 	

		// Options to display value on top of bars

		var myoptions = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes y axis values in  bar graph 
				            }
				        }]
				    },
					 title: {
					        fontSize: 14,		
					      },
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "black";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 7px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metas = chartInstances.controller.getDatasetMeta(i);
						metas.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y);
							
						});
					});
				}
			},
			
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('canvasPAX').getContext('2d');
		var myCharts = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoptions 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>

	<%
	///////////////////////////	  Arrival and Departure Immigration Clearance in last 7 days - End	///////////////////////////////
	%>


<!--<hr style="height: 20px; border-width:5;  background-color:slateblue;">-->

<!--<div class="heading">
<br><h1 style="font-family: Arial;background-color: #D0DDEA; color: #347FAA; font-size: 25px;text-align: left;">Arrival and Departure Immigration Flights Clearance in last 7 days
</h1><br>
</div>-->
	<%
	//////////////////////////////////	Arrival and Departure Flights in last 7 days - Start	////////////////////////////////////

	StringBuilder weekDaysFlights = new StringBuilder();
	StringBuilder weekArrFlights = new StringBuilder();
	StringBuilder weekDepFlights = new StringBuilder();

	boolean flagFlightCount = false;
	try {
		WeeklyFlightsQuery = "select distinct  to_char(pax_boarding_date,'Mon-dd') as show_date,pax_boarding_date,icp_description,DAILY_ARRIVAL_FLIGHT_COUNT,DAILY_DEPARTURE_FLIGHT_COUNT from im_dashboard_combined where table_type = 'IM_TRANS_DEP_TOTAL' and ICP_SRNO = '" + filter_icp + "' and pax_boarding_date >= trunc(sysdate-7) and pax_boarding_date <= trunc(sysdate) order by pax_boarding_date";
		psTemp = con.prepareStatement(WeeklyFlightsQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			weeklyFlightXAxis = rsTemp.getString("show_date");
			//out.println(weeklyFlightXAxis);
			weekelyArrFlightCount = rsTemp.getInt("DAILY_ARRIVAL_FLIGHT_COUNT");
			weekelyDepFlightCount = rsTemp.getInt("DAILY_DEPARTURE_FLIGHT_COUNT");
			//out.println(weekelyArrFlightCount+weekelyDepFlightCount);

			if (flagFlightCount == true) {
		weekDaysFlights.append(",");
		weekArrFlights.append(",");
		weekDepFlights.append(",");
			} else
		flagFlightCount = true;

			weekDaysFlights.append("\"");
			weekDaysFlights.append(weeklyFlightXAxis);
			weekDaysFlights.append("\"");
			weekArrFlights.append(weekelyArrFlightCount);
			weekDepFlights.append(weekelyDepFlightCount);

		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Arr/Dep Flight Count  Exception");
	}

	String strWeekDaysFlights = weekDaysFlights.toString();
	String strweekArrFlights = weekArrFlights.toString();
	String strweekDepFlights = weekDepFlights.toString();
	%>
<%////////////////	Table -  Arrival and Departure Flights in last 7 days - Start	///////////////////////%>
<div class="col-sm-2">
		<table class="tableDesign">
			<!--<caption style="font-size: 22px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Arrival and Departure Flights in last 7 days</caption>-->
			
			<tr style="font-size: 16px; font-family: 'Arial', serif;color: white; font-weight: bold; text-align: center;border-color: #ed3e12;height:20px;">
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:33.33%;">&nbsp;</th>
				<th colspan = "2" style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:66.66%; text-align: center;">Total Flights</th>
			</tr>
			<tr style="font-size: 16px; font-family: 'Arial', serif;color: white; font-weight: bold; text-align: center;border-color: #ed3e12;height:20px;">
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:33.33%;">Date</th>
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:33.33%; text-align: right;">Arrival</th>
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:33.33%; text-align: right;">Departure</th>
			</tr>
		<% 
			String[] weekListFlights = strWeekDaysFlights.toString().replace("\"", "").split(",");
			String[] weeklyArrFlights = strweekArrFlights.split(",");
			String[] weeklyDepFlights = strweekDepFlights.split(",");
			for (int i = 0; i < weekListFlights.length; i++) {
		%>
			<tr style="font-size: 14px; font-family: 'Arial', serif; text-align: center;height:18px;border-color: #ed3e12">
				<td style="background-color:#f4896f;border-color: #ed3e12;width:33.33%; font-weight: bold;text-align: center;"><%=weekListFlights[i]%></td>
				<td style="background-color:#f8b8a9;border-color: #ed3e12;width:33.33%;font-weight: bold;  text-align: right;"><%=weeklyArrFlights[i]%>&nbsp;&nbsp;&nbsp;</td>
				<td style="background-color:#fcddd5;border-color: #ed3e12;width:33.33%; font-weight: bold; text-align: right;"><%=weeklyDepFlights[i]%>&nbsp;&nbsp;&nbsp;</td>
			</tr>
<%
			}
			%>
		</table>
		</div>
	<%///////////////////////	Table -  Arrival and Departure Flights in last 7 days - End	////////////////////////%>

	<div class="col-sm-4">
		<h1
			style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif; background-color: #ffffff">Arrival
			and Departure Flights in last 7 days</h1>

		<canvas id="canvasFlights" style="max-width: 100%;background: linear-gradient(to bottom, #ffffff 35%, #faaca8 100%);"></canvas>

</div>
	<script>

		// Data define for bar chart

		var myData = {
			labels: [<%=strWeekDaysFlights%>],
			datasets: [{ 
				  label: "Arrival Flights Count",
			      backgroundColor: "#F6635C",
			      borderColor: "Tomato",
			      borderWidth: 1,
			      data: [<%=strweekArrFlights%>]
			}, { 
				  label: "Departure Flights Count",
			      backgroundColor: "#ffa600",
			      borderColor: "Orange",
			      borderWidth: 1,
			      data: [<%=strweekDepFlights%>]
			}]
		};

		// Options to display value on top of bars

		var myoption = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes x axis values in  bar graph 
				            }
				        }]
				    },
				 title: {
				        fontSize: 14,		
				      },
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 1
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstance = this.chart,
					ctx = chartInstance.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 8px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var meta = chartInstance.controller.getDatasetMeta(i);
						meta.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y);

						});
					});
				}
			}
		};

		//Code to drow Chart

		var ctx = document.getElementById('canvasFlights').getContext('2d');
		var myChart = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoption 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>
</div>
</div>
<br>


<%///////////////////////////////	Arrival and Departure Flights in last 7 days - End	/////////////////////////////////////////%>





		</div>
		</section>
		<!--   ************************END ICS DIV*******************END ICS DIV*****************END ICS DIV****************END ICS DIV********  -->
		<!--   ************************START pax DIV*******************START pax DIV*****************START pax DIV****************START pax DIV********  -->
		<section id="ICS_2" ><br><br><br><br><br>
		<div class="pt-4" id="ICS_2">
		<table id = "auto-index2" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
				<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Arrival : PAX Clearance, Active Flights and Active Counters in last <%=displayHours%> hours</th>
				</tr>
			</thead>
		</table><br>
	<%////////////////////	Arrival : PAX, Flight and Active Counters for last 7 hours - Start	////////////////////////

StringBuilder hourlyTime = new StringBuilder();
StringBuilder hourlyPax = new StringBuilder();
StringBuilder hourlyFlight = new StringBuilder();
StringBuilder hourlyActiveCounter = new StringBuilder();

	String hourSet_Arrpfa = "";
	java.util.Date v_hourSet_Arrpfa = null;
	//DateFormat vArrDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	DateFormat vArrDateFormat = new SimpleDateFormat("MMM-dd HH");

 flagPaxCount = false;
try {
	arrHourlyQuery = "select * from (select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_flight_count,active_counter_count,pax_boarding_date,hourly_pax_count  from im_dashboard_combined where pax_boarding_date = trunc(sysdate) and table_type = 'IM_TRANS_ARR_TOTAL' and icp_srno = '" + filter_icp + "' order by pax_boarding_date,HOURS desc ) where rownum<= "+displayHours;
	psTemp = con.prepareStatement(arrHourlyQuery);
	rsTemp = psTemp.executeQuery();
	while (rsTemp.next()) {
			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 0 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 11)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" AM" ;
				hourlyXAxis =  rsTemp.getString("hours").substring(0,2) +" AM" ;

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 12 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 23)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" PM" ;
				hourlyXAxis = rsTemp.getString("hours").substring(0,2) +" PM" ;			


		hourlyArrFlightCount = rsTemp.getInt("hourly_flight_count");
		hourlyArrPaxCount = rsTemp.getInt("hourly_pax_count");
		hourlyArrActiveCounter = rsTemp.getInt("active_counter_count");
		//out.println(hourlyArrActiveCounter);

		if (flagPaxCount == true) {
	hourlyTime.append(",");
	hourlyPax.append(",");
	hourlyFlight.append(",");
	hourlyActiveCounter.append(",");
		} else
	flagPaxCount = true;

		hourlyTime.append("\"");
		hourlyTime.append(hourlyXAxis);
		hourlyTime.append("\"");
		hourlyPax.append(hourlyArrPaxCount);
		hourlyFlight.append(hourlyArrFlightCount);
		hourlyActiveCounter.append(hourlyArrActiveCounter);
	}
	rsTemp.close();
	psTemp.close();

} catch (Exception e) {
	out.println("Arr PAX, Flight and Active Count  Exception");
}
String strHourlyTime = hourlyTime.toString();
String strHourlyArrPax = hourlyPax.toString();
String strHourlyArrFlight = hourlyFlight.toString();
String strHourlyArrActiveCounter = hourlyActiveCounter.toString();
%>

<%////////////////	Table - Arrival Clearance in last 7 hours - Start	///////////////////////%>
<div class="container-fluid">
<div class="row">
	<div class="col-sm-4">
	<table class="tableDesign">
		<!--<caption style="font-size: 22px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Arrival Clearance in last 7 hours</caption>-->
			
				<tr style="font-size: 16px;  text-align: right; color:white; border-color: #003a6d;height:40px;">
					<th style="text-align: center; width:25%; background-color:#B93160;border-color: #B93160;width:25%; text-align: center;">Time</th>
					<th style="text-align: center; width:25%; background-color:#B93160;border-color: #B93160;width:25%; text-align: right;">PAX&nbsp;Clearance&nbsp;&nbsp;&nbsp;</th>
					<th style="text-align: center; width:25%; background-color:#B93160;border-color: #B93160;width:25%; text-align: right;">Active&nbsp;Flights&nbsp;&nbsp;&nbsp;</th>
					<th style="text-align: center; width:25%; background-color:#B93160;border-color: #B93160;width:25%; text-align: right;">Active&nbsp;Counters&nbsp;&nbsp;&nbsp;</th>
				</tr>
		<% 
			String[] weekList = strHourlyTime.toString().replace("\"", "").split(",");
			String[] arrPax = strHourlyArrPax.split(",");
			String[] arrFlight = strHourlyArrFlight.split(",");
			String[] arrCounter = strHourlyArrActiveCounter.split(",");
			String v_date_Format  = "";
			for (int i = weekList.length - 1; i >= 0 ; i--) {
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; height:20px;">
				<td style="background-color:#dc799b; width:25%; border-color: #B93160;width:25%; font-weight: bold; text-align: center;"><%=weekList[i]%></td>
				<td style="background-color:#e497b2; width:25%; border-color: #B93160;width:25%; font-weight: bold; text-align: right;"><%=arrPax[i]%>&nbsp;&nbsp;&nbsp;</td>
				<td style="background-color:#ecb6c8; width:25%; border-color: #B93160;width:25%; font-weight: bold; text-align: right;"><%=arrFlight[i]%>&nbsp;&nbsp;&nbsp;</td>
				<td style="background-color:#f4d7e1; width:25%; border-color: #B93160;width:25%; font-weight: bold; text-align: right;"><%=arrCounter[i]%>&nbsp;&nbsp;&nbsp;</td>
			</tr>
<%
			}
			%>
		</table>
		</div>
	<%///////////////////////	Table - Arrival : PAX, Flight and Active Counters for last 7 hours - End	////////////////////////%>

	<div class="col-sm-8">
		<h1 style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif; background-color: #ffffff">Arrival : PAX Clearance, Active Flights and Active Counters in last <%=displayHours%> hours</h1>

		<canvas id="canvasArrPAXFltActCount" class="chart"
			style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #e5a4ba 100%);
			"></canvas>
	</div>
	</div>
	</div>
	<br>
	<script>
		// Data define for bar chart

		var myData = {
			labels: [<%=reverseOnComma(strHourlyTime)%>],
			datasets: [{ 
				  label: "Arrival Footfalls",
			      backgroundColor: "#B93160",
			      borderColor: "red",
			      borderWidth: 1,
			     
			      data: [<%=reverseOnComma(strHourlyArrPax)%>]
			}, { 
				  label: "Arrival Flights",
			      backgroundColor: "#FF5C8D",
			      borderColor: "#B93160",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyArrFlight)%>]
			},
			{ 
				  label: "Arrival Active Counters",
			      backgroundColor: "#FFCCCC",
			      borderColor: "#B93160 ",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyArrActiveCounter)%>]
			}]
		};
		 	
		// Options to display value on top of bars

		var myoptions = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes y axis values in  bar graph 
				            }
				        }]
				    },
					 title: {
					        fontSize: 14,		
					      },
			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 8px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metas = chartInstances.controller.getDatasetMeta(i);
						metas.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y - 1);
							
						});
					});
				}
			}
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('canvasArrPAXFltActCount').getContext('2d');
		var myCharts = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoptions 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>


	<%////////////////////	Arrival : PAX, Flight and Active Counters for last 7 hours - End	////////////////////////%>


		</section>
		<!--   ************************END pax DIV*******************END pax DIV*****************END pax DIV****************END pax DIV********  -->
		<!--   ************************START Pax-Images DIV************************START Pax-Images DIV****************START Pax-Images DIV********  -->
		
		
		<section id="ICS_3"><br><br><br><br><br>
		<div class="pt-4" id="ICS_3">    
		<table id = "auto-index3" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Departure : PAX Clearance, Active Flights and Active Counters in last <%=displayHours%> hours</th>
				</tr>
				<!--<tr id='head' name='pax-image'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>-->
			</thead>
		</table><br>

	<%//////////////////	Departure : PAX, Flight and Active Counters for last 7 hours - Start	///////////////////////

	StringBuilder hourlyDepTime = new StringBuilder();
	StringBuilder hourlyDepPax = new StringBuilder();
	StringBuilder hourlyDepFlight = new StringBuilder();
	StringBuilder hourlyDepDepActiveCounter = new StringBuilder();


	String hourSet_Deppfa = "";
	java.util.Date v_hourSet_Deppfa = null;
	//DateFormat vDepDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	DateFormat vDepDateFormat = new SimpleDateFormat("MMM-dd HH");

	flagPaxCount = false;
	try {
		depHourlyQuery = "select * from (select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_flight_count,active_counter_count,pax_boarding_date,hourly_pax_count  from im_dashboard_combined where pax_boarding_date = trunc(sysdate) and table_type = 'IM_TRANS_DEP_TOTAL' and icp_srno = '" + filter_icp + "' order by pax_boarding_date,HOURS desc ) where rownum<="+displayHours;
		psTemp = con.prepareStatement(depHourlyQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 0 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 11)
				//hourlyDepXAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" AM" ;
				hourlyDepXAxis =  rsTemp.getString("hours").substring(0,2) +" AM" ;

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 12 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 23)
				//hourlyDepXAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" PM" ;
				hourlyDepXAxis = rsTemp.getString("hours").substring(0,2) +" PM" ;		

			hourlyDepFlightCount = rsTemp.getInt("hourly_flight_count");
			hourlyDepPaxCount = rsTemp.getInt("hourly_pax_count");
			hourlyDepActiveCounter = rsTemp.getInt("active_counter_count");

			if (flagPaxCount == true) {
		hourlyDepTime.append(",");
		hourlyDepPax.append(",");
		hourlyDepFlight.append(",");
		hourlyDepDepActiveCounter.append(",");
			} else
		flagPaxCount = true;

			hourlyDepTime.append("\"");
			hourlyDepTime.append(hourlyDepXAxis);
			hourlyDepTime.append("\"");
			hourlyDepPax.append(hourlyDepPaxCount);
			hourlyDepFlight.append(hourlyDepFlightCount);
			hourlyDepDepActiveCounter.append(hourlyDepActiveCounter);
		}

		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Dep PAX, Flight and Active Count Exception");
	}

	strHourlyTime = "";
	strHourlyTime = hourlyDepTime.toString();
	String strHourlyDepPax = hourlyDepPax.toString();
	String strHourlyDepFlight = hourlyDepFlight.toString();
	String strHourlyDepActiveCounter = hourlyDepDepActiveCounter.toString();
	%>

<%////////////////////	Table - Departure : PAX, Flight and Active Counters for last 7 hours - Start	/////////////////////////%>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-4">
		<table class="tableDesign">
			<!--<caption style="font-size: 22px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Departure Clearance in last 7 hours</caption>-->
			
				<tr style="font-size: 16px; font-family: 'Arial', serif;color: white; font-weight: bold; text-align: center;border-color: #1192e8;height:40px;">
					<th style="text-align: center;background-color:#005d5d;border-color: #005d5d;width:25%; font-weight: bold; text-align: center;">Time</th>
					<th style="text-align: center;background-color:#005d5d;border-color: #005d5d;width:25%; font-weight: bold; text-align: right;">PAX&nbsp;&nbsp;Clearance&nbsp;&nbsp;</th>
					<th style="text-align: center;background-color:#005d5d;border-color: #005d5d;width:25%; font-weight: bold; text-align: right;">Active&nbsp;&nbsp;Flights&nbsp;&nbsp;</th>
					<th style="text-align: center;background-color:#005d5d;border-color: #005d5d;width:25%; text-align: right;">Active&nbsp;&nbsp;Counters&nbsp;&nbsp;</th>
				</tr>

			<%
			//strHourlyTime = hourlyDepTime.toString();
			//String strHourlyDepPax = hourlyDepPax.toString();
			//String strHourlyDepFlight = hourlyDepFlight.toString();
			//String strHourlyDepActiveCounter = hourlyDepDepActiveCounter.toString();
			//out.println(hourlyTime.toString().replace("\"",""));

			String[] depWeekList = strHourlyTime.toString().replace("\"", "").split(",");
			String[] depPax = strHourlyDepPax.split(",");
			String[] depFlight = strHourlyDepFlight.split(",");
			String[] depCounter = strHourlyDepActiveCounter.split(",");

			for (int i = depWeekList.length - 1; i >= 0 ; i--) {
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; text-align: center;height:20px;">
				<td style="background-color:#08bdba;border-color: #005d5d;width:25%; font-weight: bold;text-align: center;"><%=depWeekList[i]%></td>
				<td style="background-color:#3ddbd9;border-color: #005d5d;width:25%; font-weight: bold; text-align: right;"><%=depPax[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#9ef0f0;border-color: #005d5d;width:25%; font-weight: bold; text-align: right;"><%=depFlight[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#d9fbfb;border-color: #005d5d;width:25%; font-weight: bold; text-align: right;"><%=depCounter[i]%>&nbsp;&nbsp;</td>
			</tr>

			<%
			}
			%>
		</table>
</div>	
<% /////////////////	Table - Departure : PAX, Flight and Active Counters for last 7 hours - End	/////////////////////%>

	<div class="col-sm-8">
		<h1 style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif; background-color: #ffffff">Departure : PAX Clearance, Active Flights and Active Counters in last <%=displayHours%> hours</h1>

		<canvas id="canvasDepPAXFltActCount" class="chart" style="max-width: 100%;      background: linear-gradient(to bottom, #ffffff 35%, #75ebff 100%);"></canvas>
	</div>
</div>
</div>
</div>

<script>
		// Data define for bar chart

		var myData = {
			labels: [<%=reverseOnComma(strHourlyTime)%>],
			datasets: [{ 
				  label: "Departure Footfalls",
			      backgroundColor: "#006778",
			      borderColor: "#045D5D",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyDepPax)%>]
			}, { 
				  label: "Departure Flights",
			      backgroundColor: "#39AEA9",
			      borderColor: "#006778",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyDepFlight)%>]
			},
			{ 
				  label: "Departure Active Counters",
			      backgroundColor: "#CCF3EE",
			      borderColor: "#006778",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyDepActiveCounter)%>]
			}]
		};
		 	

		// Options to display value on top of bars

		var myoptions = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes y axis values in  bar graph 
				            }
				        }]
				    },
					 title: {
					        fontSize: 14,		
					      },
			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 8px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metas = chartInstances.controller.getDatasetMeta(i);
						metas.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y);
							
						});
					});
				}
			}
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('canvasDepPAXFltActCount').getContext('2d');
		var myCharts = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoptions 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>



<%
/////////////////////////	Departure : PAX, Flight and Active Counters for last 7 hours - End	////////////////////////////
%>




		</div>
		</section>
		<!--   ************************END Pax-Images DIV************************END  Pax-Images DIV****************END  Pax-Images DIV********  -->
		<!--   ************************START APIS DIV*******************START APIS DIV*****************START APIS DIV****************START APISE DIV********  -->
		<section id="ICS_4"><br><br><br><br><br>
		<div class="pt-4" id="ICS_4"> 
		<table id = "auto-index4" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
				<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Hourly Clearance of Arrival/Departure Flights in last <%=displayHours%> hours</th>
				</tr>
				<!--<tr id='head' name='apis'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>-->
			</thead>
		</table>
		<%////////////////////////////////////////////	Hourly Clearance of Arrival Flights - Start	////////////////////////////////////////////////////

	String hours_Axis = "";
	String hourly_flight_count_Axis = "";

	StringBuilder hourlyArrAxis = new StringBuilder();
	StringBuilder hourlyArrFlt = new StringBuilder();

	//String hourSet = "";

	boolean zero_entry_Arr = false;
	try {
		dashQuery = "select * from (select to_date(hours,'HH24mi') as date_time, icp_description, hours,hourly_flight_count,active_counter_count,hourly_pax_count from im_dashboard_combined where table_type = 'IM_TRANS_ARR_TOTAL' and ICP_SRNO = '" + filter_icp + "' and pax_boarding_date = trunc(sysdate) order by HOURS desc ) where rownum <= "+displayHours;
		psTemp = con.prepareStatement(dashQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {


			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 0 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 11)
				//hours_Axis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" AM" ;
				hours_Axis =  rsTemp.getString("hours").substring(0,2) +" AM" ;

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 12 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 23)
				//hours_Axis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" PM" ;
				hours_Axis = rsTemp.getString("hours").substring(0,2) +" PM" ;

			hourly_flight_count_Axis = rsTemp.getString("hourly_flight_count");

			if (zero_entry_Arr == true) {
				hourlyArrAxis.append(",");
				hourlyArrFlt.append(",");
			} else
		zero_entry_Arr = true;
			hourlyArrAxis.append("\"");
			hourlyArrAxis.append(hours_Axis);
			hourlyArrAxis.append("\"");
			hourlyArrFlt.append(hourly_flight_count_Axis);
		}

		rsTemp.close();
		psTemp.close();
	} catch (Exception e) {
		out.println("Hourly Count of Arrival Flights Exception");
	}

	String strhours_Axis = hourlyArrAxis.toString();
	String strhourly_flight_count_Axis = hourlyArrFlt.toString();
	//out.println(str1);
	%>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-2">
	<%////////////////	Table - Hourly Clearance of Arrival Flights - Start	///////////////////////%>
<table class="tableDesign">
		<tr style="font-size: 14px; font-family: 'Arial', serif;color: white; font-weight: bold; text-align: center;border-color: #1192e8;height:5%;">
				<th style="text-align: center;background-color:#da1e28;border-color: #da1e28;width:50%; text-align: center;">Time</th>
				<th style="text-align: center;background-color:#da1e28;border-color: #da1e28;width:50%; text-align: right;">Arrival&nbsp;Flights&nbsp;&nbsp;</th>

			</tr>									
		<% 
			/*String strhours_Axis = hourlyArrAxis.toString();
				String strhourly_flight_count_Axis = hourlyArrFlt.toString();*/
			String[] hourListArrFlt = strhours_Axis.toString().replace("\"", "").split(",");
			String[] hourListArrFltCount = strhourly_flight_count_Axis.split(",");
			

			for (int i = hourListArrFlt.length-1; i >= 0; i--) {
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; text-align: center;height:5%;">
				<td style="background-color:#ffb3b8;border-color: #da1e28;width:25%; font-weight: bold; text-align: center;"><%=hourListArrFlt[i]%></td>
				<td style="background-color:#ffd7d9;border-color: #da1e28;width:25%; font-weight: bold; text-align: right;"><%=hourListArrFltCount[i]%>&nbsp;&nbsp;</td>


			</tr>
<%
			}
			%>
		</table>
		</div>
	<%///////////////////////	Table - Hourly Clearance of Arrival Flights - End	////////////////////////%>


	<div class="col-sm-4" >
		<h1
			style="font-size: 22px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif; background-color: #ffffff">Hourly Clearance of Arrival Flights</h1>
		<canvas id="myPlot1" class="chart" style="max-width: 100%;background: linear-gradient(to bottom, #ffffff 35%, #ffd8d8 100%);"></canvas>
		</div>
		<script>
		// Data define for bar chart

		var myDataaaaaa = {
			labels: [<%=reverseOnComma(strhours_Axis)%>],
			datasets: [{ 
				  label: "Arrival Flights",
			      backgroundColor: "#FF6363",
			      borderColor: "red",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strhourly_flight_count_Axis)%>]
			}]
		};
		 	
		// Options to display value on top of bars

		var myoptionsssssss = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes y axis values in  bar graph 
				            }
				        }]
				    },

					 title: {
					        fontSize: 18,		
					      },
			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 11px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metasssssss = chartInstances.controller.getDatasetMeta(i);
						metasssssss.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x , bar._model.y );
							
						});
					});
				}
			}
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('myPlot1').getContext('2d');
		var myChartsssssss = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myDataaaaaa,    	// Chart data
			options: myoptionsssssss 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>

	<%	////////////////////////////////////////////	Hourly Clearance of Arrival Flights - End	////////////////////////////////////////////////////%>







	
	<%////////////////////////////////////////////	Hourly Clearance of Departure Flights - Start	////////////////////////////////////////////////////

	String hours_Axis_Dep = "";
	String hourly_flight_count_Axis_Dep = "";

	StringBuilder hourlyDepAxis = new StringBuilder();
	StringBuilder hourlyDepFlt = new StringBuilder();

	String hourSet_Dep = "";
	java.util.Date v_hourSet_Dep = null;
	//DateFormat vDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	DateFormat vDateFormat = new SimpleDateFormat("MMM-dd HH");

	boolean zero_entry2 = false;
	try {
		depQuery = "select * from (select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24miss') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_flight_count,active_counter_count,pax_boarding_date,hourly_pax_count from im_dashboard_combined where table_type = 'IM_TRANS_DEP_TOTAL' and ICP_SRNO = '" + filter_icp + "' and pax_boarding_date = trunc(sysdate) order by HOURS desc ) where rownum <= "+displayHours;
		psTemp = con.prepareStatement(depQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {
			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 0 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 11)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" AM" ;
				hours_Axis_Dep =  rsTemp.getString("hours").substring(0,2) +" AM" ;

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 12 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 23)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" PM" ;
				hours_Axis_Dep = rsTemp.getString("hours").substring(0,2) +" PM" ;			

			hourly_flight_count_Axis_Dep = rsTemp.getString("hourly_flight_count");

			if (zero_entry2 == true) {
				hourlyDepAxis.append(",");
				hourlyDepFlt.append(",");
			} else
		zero_entry2 = true;
			hourlyDepAxis.append("\"");
			hourlyDepAxis.append(hours_Axis_Dep);
			hourlyDepAxis.append("\"");
			hourlyDepFlt.append(hourly_flight_count_Axis_Dep);

		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		e.printStackTrace();
	}

	String strhours_Axis_Dep = hourlyDepAxis.toString();
	String strhourly_flight_count_Axis_Dep = hourlyDepFlt.toString();
	//out.println(str1);
	%>

<%////////////////	Table - Hourly Clearance of Departure Flights - Start	///////////////////////%>

	<div class="col-sm-2">
		<table class="tableDesign" >
			<tr style="font-size: 14px; color:white; border-color: #006778;height:40%;">
					<th style="text-align: center;background-color:#006778;border-color: #006778;width:50%;text-align: center;">Time</th>
					<th style="text-align: center;background-color:#006778;border-color: #006778;width:50%; text-align: right;">Departure&nbsp;Flights&nbsp;&nbsp;</th>
				</tr>
		<% 
			/*String strhours_Axis_Dep = hourlyDepAxis.toString();
			String strhourly_flight_count_Axis_Dep = hourlyDepFlt.toString();*/
			String[] hourListDepFlt = strhours_Axis_Dep.toString().replace("\"", "").split(",");
			String[] hourListDepFltCount = strhourly_flight_count_Axis_Dep.split(",");
			for (int i = hourListDepFlt.length - 1; i >= 0 ; i--) {
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; text-align: center;height:20px;">
				<td style="background-color:#5be8ff;border-color: #006778;width:50%; font-weight: bold;text-align: center;"><%=hourListDepFlt[i]%></td>
				<td style="background-color:#b7f5ff;border-color: #006778;width:50%; font-weight: bold; text-align: right;"><%=hourListDepFltCount[i]%>&nbsp;&nbsp;</td>

			</tr>
<%
			}
			%>
		</table>
		</div>
	<%///////////////////////	Table - Hourly Clearance of Departure Flights - End	////////////////////////%>

	<div class="col-sm-4">
		<h1
			style="font-size: 22px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif; background-color: #ffffff">Hourly Clearance of Departure Flights</h1>

		<canvas id="myPlot2" class="chart" style="max-width: 100%;  background: linear-gradient(to bottom, #ffffff 35%, #c4f2fa 100%);"></canvas>
		</div>
			</div>
		</div>
		<script>
		// Data define for bar chart

		var myDataaaaa = {
			labels: [<%=reverseOnComma(strhours_Axis_Dep)%>],
			datasets: [{ 
				  label: "Departure Flights",
			      backgroundColor: "#79E0EE",
			      borderColor: "#3AA6B9",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strhourly_flight_count_Axis_Dep)%>]
			}]
		};
		 	
		// Options to display value on top of bars

		var myoptionssssss = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes y axis values in  bar graph 
				            }
				        }]
				    },
			 title: {
			        fontSize: 14,		
			      },
			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 11px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metassssss = chartInstances.controller.getDatasetMeta(i);
						metassssss.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x + 2 , bar._model.y );
							
						});
					});
				}
			}
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('myPlot2').getContext('2d');
		var myChartssssss = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myDataaaaa,    	// Chart data
			options: myoptionssssss 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>
<%
///////////////////////////////////////	Hourly Clearance of Departure Flights - End	/////////////////////////////////////////////%>

		</div>
		</section>
		<!--   ************************END APIS DIV*******************END APIS DIV*****************END APIS DIV****************END APIS DIV********  -->
		<!--   ************************START Custom APIS DIV*******************START Custom APIS DIV*****************START Custom APIS DIV****************START UCF DIV********  -->
		<section id="visa_1"><br><br><br><br><br>
		<div class="pt-4" id="visa_1">    
		<table id = "auto-index5" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Arrival : Visa Clearance in last 7 days</th>
				</tr>
				<!--<tr id='head' name='custom-apis'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>-->
			</thead>
		</table>

		<%//////////////////////////////////////////////	Types of Visa in last 7 days - Start	////////////////////////////////////////////////////
	String WeeklyVisaQuery = "";
	String weeklyVisaXAxis = "";
	int weekelyEVisaCount = 0;
	int weekelyVOACount = 0;
	int weeklyRegularCount = 0;
	int weeklyOCICount = 0;
	

	StringBuilder weekDaysVisa = new StringBuilder();
	StringBuilder weekEVisa = new StringBuilder();
	StringBuilder weekVOA = new StringBuilder();
	StringBuilder weekRegular = new StringBuilder();
	StringBuilder weekOCI = new StringBuilder();

	  flagFlightCount = false;
	try {
		WeeklyVisaQuery = "select icp_description,to_char(pax_boarding_date,'Mon-dd') as pax_boarding_date_2, pax_boarding_date,ICP_SRNO,sum(hourly_evisa_count) as sum_evisa_count, sum(hourly_voa_count) as sum_hourly_voa_count, sum(hourly_regular_visa_count) as hourly_regular_visa_count, sum(hourly_visa_exempted_count),sum(hourly_oci_count) as sum_hourly_oci_count,sum(hourly_foreigner_count), table_type from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and pax_boarding_date >= trunc(sysdate-6) and pax_boarding_date <= trunc(sysdate) and table_type='IM_TRANS_ARR_TOTAL'  group by pax_boarding_date,table_type,icp_description,ICP_SRNO order by pax_boarding_date";
		psTemp = con.prepareStatement(WeeklyVisaQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			weeklyVisaXAxis = rsTemp.getString("pax_boarding_date_2");
			//out.println(weeklyVisaXAxis);
			weekelyEVisaCount = rsTemp.getInt("sum_evisa_count");
			weekelyVOACount = rsTemp.getInt("sum_hourly_voa_count");
			weeklyRegularCount = rsTemp.getInt("hourly_regular_visa_count");
			weeklyOCICount = rsTemp.getInt("sum_hourly_oci_count");
			//out.println(weeklyOCICount);

			if (flagFlightCount == true) {
				weekDaysVisa.append(",");
				weekEVisa.append(",");
				weekVOA.append(",");
				weekRegular.append(",");
				weekOCI.append(",");
				} 
			else
			flagFlightCount = true;

			weekDaysVisa.append("\"");
			weekDaysVisa.append(weeklyVisaXAxis);
			weekDaysVisa.append("\"");
			
			weekEVisa.append(weekelyEVisaCount);
			weekVOA.append(weekelyVOACount);
			weekRegular.append(weeklyRegularCount);
			weekOCI.append(weeklyOCICount);

		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Weekly Visa Exception");
	}

	String strWeekDaysVisa = weekDaysVisa.toString();
	String strweekEVisa = weekEVisa.toString();
	String strweekVOA = weekVOA.toString();
	String strweekRegular = weekRegular.toString();
	String strweekOCI = weekOCI.toString();
	//out.println(strweekOCI);
	
	%>
<%////////////////	Table - Types of Visa in last 7 days - Start	///////////////////////%>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-4">
	<table class="tableDesign">
		<!--<caption style="font-size: 22px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Types of Visa in last 7 days</caption>-->
			
				<tr style="font-size: 16px;  text-align: right; color:white; border-color: #003a6d;height:40px;">
					<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%;">Date</th>
					<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">e-Visa&nbsp;&nbsp;</th>
					<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">OCI&nbsp;&nbsp;</th>
					<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">Regular&nbsp;&nbsp;</th>
					<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">VOA&nbsp;&nbsp;</th>
				</tr>
		<% 
			String[] weekListWeekly = strWeekDaysVisa.toString().replace("\"", "").split(",");
			String[] eVisaWeekly = strweekEVisa.split(",");
			String[] OCIWeekly = strweekOCI.split(",");
			String[] RegularWeekly = strweekRegular.split(",");
			String[] VOAWeekly = strweekVOA.split(",");
			//String v_date_Format  = "";
			for (int i = 0; i < weekListWeekly.length; i++) {
							
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; text-align: center;height:20px;">
				<td style="background-color:#f16d4c;border-color: #ed3e12;width:20%; font-weight: bold;text-align: center;"><%=weekListWeekly[i]%></td>
				<td style="background-color:#f4896f;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=eVisaWeekly[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#f69e89;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=OCIWeekly[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#f8b7a7;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=RegularWeekly[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#fcddd5;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=VOAWeekly[i]%>&nbsp;&nbsp;</td>
			</tr>
<%
			}
			%>
		</table>	
		</div>
	<%///////////////////////	Table - Types of Visa in last 7 days - End	////////////////////////%>
	

		<div class="col-sm-8">
	<h1 style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif;
	 background-color: #ffffff">Arrival : Visa Clearance in last 7 days</h1>

		<canvas id="canvasWeeklyVisa" class="chart" style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #f79bbe 100%);"></canvas>
	</div>
	</div>
	</div>
	<script>
		// Data define for bar chart

		var myData = {
			labels: [<%=strWeekDaysVisa%>],
			datasets: [{ 
				  label: "e-Visa",
			      backgroundColor: "#FF5733",
			      borderColor: "red",
			      borderWidth: 0,
			     
			      data: [<%=strweekEVisa%>]
			},{ 
				  label: "OCI",
			      backgroundColor: "#ffa600",
			      borderColor: "orange",
			      borderWidth: 1,
			     
			      data: [<%=strweekOCI%>]
			},{ 
				  label: "Regular",
			      backgroundColor: "#900C3F",
			      borderColor: "red",
			      borderWidth: 1,
			     
			      data: [<%=strweekRegular%>]
			}, { 
				  label: "VOA",
			      backgroundColor: "#511845",
			      borderColor: "#0E21A0",
			      borderWidth: 1,
			      data: [<%=strweekVOA%>]
			}]};
		 	

		// Options to display value on top of bars

		var myoptions = {
				 title: {
				        fontSize: 14,		
				      },
					 scales: {
					        yAxes: [{
					            ticks: {
					                display: false //removes y axis values in  bar graph 
					            }
					        }]
					    },
			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 8px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metas = chartInstances.controller.getDatasetMeta(i);
						metas.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y - 1);
							
						});
					});
				}
			}
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('canvasWeeklyVisa').getContext('2d');
		var myCharts = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoptions 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});
	</script>

<%//////////////////////////////////////	Types of Visa in last 7 days - End	/////////////////////////////////%>

		</section>
		<!--   ************************END Paarijaat_APIS_Manual_Nov_2017*****************END Paarijaat_APIS_Manual_Nov_2017***************END Paarijaat_APIS_Manual_Nov_2017 DIV**************** -->
		<!--   ************************START UCF DIV*******************START UCF DIV*****************START S_Form DIV****************START UCF DIV********  -->
		<section id="visa_2"><br><br><br><br><br>
		<div class="pt-4" id="visa_2">    
		<table id = "auto-index7" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
				<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Arrival : Visa Clearance in last <%=displayHours%> hours</th>
				</tr>
				<!--<tr id='head' name='ucf'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>-->
			</thead>
		</table>
		<%	//////////////////////////////////////////////	Types of Visa in last 7 hours - Start	////////////////////////////////////////////////////
	String hourlyVisaQuery = "";
	String hourlyVisaXAxis = "";
	int hourlyEVisaCount = 0;
	int hourlyVOACount = 0;
	int hourlyRegularCount = 0;
	int hourlyOCICount = 0;
	

	StringBuilder hourlyVisa = new StringBuilder();
	StringBuilder hourlyEVisa = new StringBuilder();
	StringBuilder hourlyVOA = new StringBuilder();
	StringBuilder hourlyRegular = new StringBuilder();
	StringBuilder hourlyOCI = new StringBuilder();

	String hourSet_hourlyVisa = "";
	java.util.Date v_hourSet_hourlyVisa = null;
	//DateFormat vVisaDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	DateFormat vVisaDateFormat = new SimpleDateFormat("MMM-dd HH");


	 flagFlightCount = false;
	try {
		hourlyVisaQuery = "select * from (select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,hourly_evisa_count,hourly_voa_count,hourly_regular_visa_count,hourly_visa_exempted_count,hourly_oci_count,hourly_foreigner_count, table_type from im_dashboard_combined where pax_boarding_date =trunc(sysdate) and table_type='IM_TRANS_ARR_TOTAL' and icp_srno = '" + filter_icp + "' order by pax_boarding_date,HOURS desc ) where rownum<="+displayHours;
		psTemp = con.prepareStatement(hourlyVisaQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			//hourlyVisaXAxis = rsTemp.getString("date_time");
			//out.println(hourlyVisaXAxis);
			
			/*	v_hourSet_hourlyVisa = rsTemp.getTimestamp("date_time");
			if (v_hourSet_hourlyVisa != null) hourlyVisaXAxis = vDateFormat.format(v_hourSet_hourlyVisa); else hourlyVisaXAxis = "";
					//out.println(hourlyVisaXAxis.substring(7,9));
				
			if (Integer.parseInt(hourlyVisaXAxis.substring(7,9)) >= 0 & Integer.parseInt(hourlyVisaXAxis.substring(7,9)) <= 11)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" AM" ;
				hourlyVisaXAxis =  hourlyVisaXAxis +" AM" ;

			if (Integer.parseInt(hourlyVisaXAxis.substring(7,9)) >= 12 & Integer.parseInt(hourlyVisaXAxis.substring(7,9)) <= 23)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" PM" ;
				hourlyVisaXAxis =  hourlyVisaXAxis +" PM" ;*/

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 0 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 11)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" AM" ;
				hourlyVisaXAxis =  rsTemp.getString("hours").substring(0,2) +" AM" ;

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 12 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 23)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" PM" ;
				hourlyVisaXAxis = rsTemp.getString("hours").substring(0,2) +" PM" ;

			hourlyEVisaCount = rsTemp.getInt("hourly_evisa_count");
			hourlyVOACount = rsTemp.getInt("hourly_voa_count");
			hourlyRegularCount = rsTemp.getInt("hourly_regular_visa_count");
			hourlyOCICount = rsTemp.getInt("hourly_oci_count");
			//out.println(hourlyOCICount);

			if (flagFlightCount == true) {
				hourlyVisa.append(",");
				hourlyEVisa.append(",");
				hourlyVOA.append(",");
				hourlyRegular.append(",");
				hourlyOCI.append(",");
				} 
			else
			flagFlightCount = true;

			hourlyVisa.append("\"");
			hourlyVisa.append(hourlyVisaXAxis);
			hourlyVisa.append("\"");
			
			hourlyEVisa.append(hourlyEVisaCount);
			hourlyVOA.append(hourlyVOACount);
			hourlyRegular.append(hourlyRegularCount);
			hourlyOCI.append(hourlyOCICount);

		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Hourly Visa Exception");
	}

	String strHourlyVisa = hourlyVisa.toString();
	String strHourlyEVisa = hourlyEVisa.toString();
	String strHourlyVOA = hourlyVOA.toString();
	String strHourlyRegular = hourlyRegular.toString();
	String strHourlyOCI = hourlyOCI.toString();
	//out.println(strHourlyOCI);
	
	%>
<%////////////////////	Table - Types of Visa in last 7 hours - Start	/////////////////////////%>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-4">
		<table class="tableDesign">
			<!--<caption style="font-size: 22px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Types of Visa in last 7 hours</caption>-->
			
				<tr style="font-size: 16px; font-family: 'Arial', serif;color: white; font-weight: bold; text-align: center;border-color: #1192e8;height:40px;">
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%;">Time</th>
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">e-Visa&nbsp;&nbsp;</th>
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">OCI&nbsp;&nbsp;</th>
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">Regular&nbsp;&nbsp;</th>
				<th style="text-align: center;background-color:#ed3e12;border-color: #ed3e12;width:20%; text-align: right;">VOA&nbsp;&nbsp;</th>
			</tr>
			<%

			
			/*String strHourlyVisa = hourlyVisa.toString();
			String strHourlyEVisa = hourlyEVisa.toString();
			String strHourlyVOA = hourlyVOA.toString();
			String strHourlyRegular = hourlyRegular.toString();
			String strHourlyOCI = hourlyOCI.toString();*/


			String[] WeekListVisaHourly = strHourlyVisa.toString().replace("\"", "").split(",");
			String[] eVisa = strHourlyEVisa.split(",");
			String[] OCIVisaHourly = strHourlyOCI.split(",");
			String[] RegularVisaHourly = strHourlyRegular.split(",");
			String[] VOAVisaHourly = strHourlyVOA.split(",");

			//String d_date_Format  = "";

			for (int i = WeekListVisaHourly.length - 1; i >= 0 ; i--) {

				/*if (Integer.parseInt( depWeekList[i].substring(11,13)) >= 0 & Integer.parseInt( depWeekList[i].substring(11,13)) <= 11)
				d_date_Format = depWeekList[i].substring(8,10) + "/" + depWeekList[i].substring(5,7) + "/" + depWeekList[i].substring(0,4) + " " + depWeekList[i].substring(11,13) + " AM" ;

			if (Integer.parseInt( depWeekList[i].substring(11,13)) >= 12 & Integer.parseInt( depWeekList[i].substring(11,13)) <= 23)
				d_date_Format = depWeekList[i].substring(8,10) + "/" + depWeekList[i].substring(5,7) + "/" + depWeekList[i].substring(0,4) + " " + depWeekList[i].substring(11,13) + " PM" ;
*/
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; text-align: center;height:20px;">
				<td style="background-color:#f16d4c;border-color: #ed3e12;width:20%; font-weight: bold;text-align: center;"><%=WeekListVisaHourly[i]%></td>
				<td style="background-color:#f4896f;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=eVisa[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#f69e89;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=OCIVisaHourly[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#f8b7a7;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=RegularVisaHourly[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#fcddd5;border-color: #ed3e12;width:20%; font-weight: bold; text-align: right;"><%=VOAVisaHourly[i].equals("0") ? "&nbsp;" : VOAVisaHourly[i]%>&nbsp;&nbsp;</td>
			</tr>

			<%
			}
			%>
		</table>
		</div>
<% /////////////////	Table - Types of Visa in last 7 hours - End	/////////////////////%>



	<div class="col-sm-8">
	<h1 style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif;
	 background-color: #ffffff">Arrival : Visa Clearance in last <%=displayHours%> hours</h1>

		<canvas id="canvasHourlyVisa" class="chart" style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #ffa5bf 100%);"></canvas>
	</div>
	</div>
	</div>
	<script>
		// Data define for bar chart

		var myData = {
			labels: [<%=reverseOnComma(strHourlyVisa)%>],
			datasets: [{ 
				  label: "e-Visa",
			      backgroundColor: " #FF5733",
			      borderColor: "orange",
			      borderWidth: 1,
			     
			      data: [<%=reverseOnComma(strHourlyEVisa)%>]
			},{ 
				  label: "OCI",
			      backgroundColor: "#ffa600",
			      borderColor: "orange",
			      borderWidth: 1,
			     
			      data: [<%=reverseOnComma(strHourlyOCI)%>]
			},{ 
				  label: "Regular",
			      backgroundColor: "#900C3F",
			      borderColor: "red",
			      borderWidth: 1,
			     
			      data: [<%=reverseOnComma(strHourlyRegular)%>]
			}, { 
				  label: "VOA",
			      backgroundColor: "#511845",
			      borderColor: "#0E21A0",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyVOA)%>]
			}]};
		 	

		// Options to display value on top of bars

		var myoptions = {
				 title: {
				        fontSize: 12,		
				      },
					 scales: {
					        yAxes: [{
					            ticks: {
					                display: false //removes y axis values in  bar graph 
					            }
					        }]
					    },
			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 8px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metas = chartInstances.controller.getDatasetMeta(i);
						metas.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y - 1);
							
						});
					});
				}
			}
		};
		
		//Code to drow Chart

		var ctx = document.getElementById('canvasHourlyVisa').getContext('2d');
		var myCharts = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoptions 	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>
<%//////////////////////////////////////	Types of Visa in last 7 hours - End	/////////////////////////////////%>
<%//////////////VISA Portion Ends/////////////////////////%>

		</section>
		<!--   ************************END UCF DIV*******************END UCF DIV*****************END UCF DIV****************END UCF DIV********  -->
		<!--   ************************START TSC DIV************************START TSC DIV****************START TSC DIV********  -->
		<section class="aboutsection" id="biometric_1"><br><br><br><br><br>
		<div class="pt-4" id="biometric_1">    
		<table id = "auto-index8" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
				<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Biometric Enrollment/Verification/Exemption Statistics in last 7 days</th>
				</tr>
				<!--<tr id='head' name='tsc'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>-->
			</thead>
		</table>
		
<%//////////////////////	Biometric Enrollment/Verification/Exemption in last 7 days - Start	/////////////////////////////////
	String WeeklyBioQuery = "";
	String weeklyBioXAxis = "";
	int weekelyBioEnrolledCount = 0;
	int weekelyBioVerifiedCount = 0;
	int weeklyBioExemptedCount = 0;
	

	StringBuilder weekDaysBio = new StringBuilder();
	StringBuilder weekBioEnrolled = new StringBuilder();
	StringBuilder weekBioVerified = new StringBuilder();
	StringBuilder weekBioExempted = new StringBuilder();

	 boolean flagFlightCountb = false;
	try {
		WeeklyBioQuery = "select icp_description,to_char(pax_boarding_date,'Mon-dd') as pax_boarding_date_3, pax_boarding_date,ICP_SRNO,sum(HOURLY_BIO_ENROLLED) as sum_HOURLY_BIO_ENROLLED, sum(HOURLY_BIO_VERIFIED) as sum_HOURLY_BIO_VERIFIED, sum(HOURLY_BIO_EXEMPTED) as sum_HOURLY_BIO_EXEMPTED, table_type from im_dashboard_combined where ICP_SRNO = '" + filter_icp + "' and pax_boarding_date >= trunc(sysdate-6) and pax_boarding_date <= trunc(sysdate) and table_type='IM_TRANS_ARR_TOTAL'  group by pax_boarding_date,table_type,icp_description,ICP_SRNO order by pax_boarding_date";
		psTemp = con.prepareStatement(WeeklyBioQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {

			weeklyBioXAxis = rsTemp.getString("pax_boarding_date_3");
			//out.println(weeklyVisaXAxis);
			weekelyBioEnrolledCount = rsTemp.getInt("sum_HOURLY_BIO_ENROLLED");
			weekelyBioVerifiedCount = rsTemp.getInt("sum_HOURLY_BIO_VERIFIED");
			weeklyBioExemptedCount = rsTemp.getInt("sum_HOURLY_BIO_EXEMPTED");
			//out.println(weeklyOCICount);

			if (flagFlightCountb == true) {
				weekDaysBio.append(",");
				weekBioEnrolled.append(",");
				weekBioVerified.append(",");
				weekBioExempted.append(",");
				} 
			else
				flagFlightCountb = true;

			weekDaysBio.append("\"");
			weekDaysBio.append(weeklyBioXAxis);
			weekDaysBio.append("\"");
			
			weekBioEnrolled.append(weekelyBioEnrolledCount);
			weekBioVerified.append(weekelyBioVerifiedCount);
			weekBioExempted.append(weeklyBioExemptedCount);
			
		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Weekly Bio Exception");
	}

	String strWeekDaysBio = weekDaysBio.toString();
	String strWeekBioEnrolled = weekBioEnrolled.toString();
	String strWeekBioVerified = weekBioVerified.toString();
	String strWeekBioExempted = weekBioExempted.toString();
	
	%>

	<%////////////////	Table -  Biometric Enrollment/Verification/Exemption in last 7 days - Start	///////////////////////%>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-4">

		<table class="tableDesign">
		<!--	<caption style="font-size: 19px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Biometric Enrollment/Verification/Exemption in last 7 days</caption>-->
			
			<tr style="font-size: 16px; font-family: 'Arial', serif;color: white; font-weight: bold; text-align: center;border-color: #1192e8;height:40px;">
				<th style="text-align: center;background-color:#da1e28;border-color: #da1e28;width:20%; text-align: center;">Date</th>
				<th style="text-align: center;background-color:#da1e28;border-color: #da1e28;width:20%; text-align: right;">Enrollment&nbsp;&nbsp;</th>
				<th style="text-align: center;background-color:#da1e28;border-color: #da1e28;width:20%; text-align: right;">Verification&nbsp;&nbsp;</th>
				<th style="text-align: center;background-color:#da1e28;border-color: #da1e28;width:20%; text-align: right;">Exempted&nbsp;&nbsp;</th>
			</tr>
		<% 

			/*String strWeekDaysBio = weekDaysBio.toString();
			String strWeekBioEnrolled = weekBioEnrolled.toString();
			String strWeekBioVerified = weekBioVerified.toString();
			String strWeekBioExempted = weekBioExempted.toString();*/
			

			String[] weekListBioDays = strWeekDaysBio.toString().replace("\"", "").split(",");
			String[] weeklyBioEnrolledDays = strWeekBioEnrolled.split(",");
			String[] weeklyBioVerifiedDays = strWeekBioVerified.split(",");
			String[] weeklyBioExemptedDays = strWeekBioExempted.split(",");

			for (int i = 0; i < weekListBioDays.length; i++) {
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; text-align: center;height:20px;">
				<td style="background-color:#fb666e;border-color: #da1e28;width:25%; font-weight: bold;text-align: center;"><%=weekListBioDays[i]%></td>
				<td style="background-color:#ff888e;border-color: #da1e28;width:25%; font-weight: bold; text-align: right;"><%=weeklyBioEnrolledDays[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#ffb3b8;border-color: #da1e28;width:25%; font-weight: bold; text-align: right;"><%=weeklyBioVerifiedDays[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#ffd7d9;border-color: #da1e28;width:25%; font-weight: bold; text-align: right;"><%=weeklyBioExemptedDays[i]%>&nbsp;&nbsp;</td>

			</tr>
<%
			}
			%>
		</table>
		</div>
	<%///////////////////////	Table - Biometric Enrollment/Verification/Exemption in last 7 days - End	////////////////////////%>


	<div class="col-sm-8">
	<h1 style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif;
	 background-color: #ffffff">Biometric Enrollment/Verification/Exemption in last 7 days</h1>

		<canvas id="canvasWeeklyBio" class="chart" style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #f79bbe 100%);"></canvas>
	</div>
	</div>	
	</div>
	<script>
		// Data define for bar chart

		var myData = {
			labels: [<%=strWeekDaysBio%>],
			datasets: [{ 
				  label: "Bio Enrolled",
			      backgroundColor: "#FF6D60",
			      borderColor: "red",
			      borderWidth: 0,
			     
			      data: [<%=strWeekBioEnrolled%>]
			},{ 
				  label: "Bio Verified",
			      backgroundColor: "#F7D060",
			      borderColor: "#FC7300",
			      borderWidth: 1,
			     
			      data: [<%=strWeekBioVerified%>]
			},{ 
				  label: "Bio Exempted",
			      backgroundColor: "#B3005E",
			      borderColor: "red",
			      borderWidth: 1,
			     
			      data: [<%=strWeekBioExempted%>]
			}]};
		 	

		// Options to display value on top of bars

		var myoptions = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes y axis values in  bar graph 
				            }
				        }]
				    },
				 title: {
				        fontSize: 14,		
				      },

			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstances = this.chart,
					ctx = chartInstances.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 8px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metas = chartInstances.controller.getDatasetMeta(i);
						metas.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y);
							
						});
					});
				}
			}
		};
		
		//Code to draw Chart

		var ctx = document.getElementById('canvasWeeklyBio').getContext('2d');
		var myCharts = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myData,    	// Chart data
			options: myoptions	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>

<%///////////////////	Biometric Enrollment/Verification/Exemption in last 7 days - End	///////////////////%>

		</section>
		<!--   ************************END TSC DIV************************END  TSC DIV****************END  TSC DIV********  -->
		<!--   ************************START BIOMETRIC DIV*******************START BIOMETRIC DIV*****************START BIOMETRIC DIV****************START BIOMETRIC DIV********  -->
		<section id="biometric_2"><br><br><br><br><br>
		<div class="pt-4" id="biometric_2">
		<table id = "auto-index9" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 style="font-family: Arial;background-color: #1192e8; color: white; font-size: 22px;text-align: left;">Biometric Enrollment/Verification/Exemption Statistics in last <%=displayHours%> hours</th>
				</tr>
				<!--<tr id='head' name='biometric'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>-->
			</thead>	
		</table>
		<%////////////////////////////	Biometric Enrollment/Verification/Exemption in last 7 hours - Start	/////////////////
	String hourlyBioQuery = "";
	String hourlyBioYAxis = "";
	int hourlyBioEnrolledCount = 0;
	int hourlyBioVerifiedCount = 0;
	int hourlyBioExemptedCount = 0;
	

	StringBuilder hourlyBio = new StringBuilder();
	StringBuilder hourlyBioEnrolled = new StringBuilder();
	StringBuilder hourlyBioVerified = new StringBuilder();
	StringBuilder hourlyBioExempted = new StringBuilder();

	flagFlightCount = false;
	try {
		hourlyBioQuery = "select * from (select to_date(to_char(pax_boarding_date,'dd/mm/yyyy')||':'||hours,'dd/mm/yyyy:HH24mi') as date_time, to_char(pax_boarding_date,'Mon-dd') as show_date,icp_description,hours,HOURLY_BIO_ENROLLED,HOURLY_BIO_VERIFIED,HOURLY_BIO_EXEMPTED, table_type from im_dashboard_combined where pax_boarding_date >= trunc(sysdate-1) and table_type='IM_TRANS_ARR_TOTAL' and icp_srno = '" + filter_icp + "' order by pax_boarding_date desc,HOURS desc ) where rownum<="+displayHours;
		psTemp = con.prepareStatement(hourlyBioQuery);
		rsTemp = psTemp.executeQuery();
		while (rsTemp.next()) {			
			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 0 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 11)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" AM" ;
				hourlyBioYAxis =  rsTemp.getString("hours").substring(0,2) +" AM" ;

			if (Integer.parseInt(rsTemp.getString("hours").substring(0,2)) >= 12 & Integer.parseInt(rsTemp.getString("hours").substring(0,2)) <= 23)
				//hourlyBioYAxis = rsTemp.getString("show_date") + " : " + rsTemp.getString("hours").substring(0,2) +" PM" ;
				hourlyBioYAxis = rsTemp.getString("hours").substring(0,2) +" PM" ;


			//out.println(hourlyVisaXAxis);
			hourlyBioEnrolledCount = rsTemp.getInt("HOURLY_BIO_ENROLLED");
			hourlyBioVerifiedCount = rsTemp.getInt("HOURLY_BIO_VERIFIED");
			hourlyBioExemptedCount = rsTemp.getInt("HOURLY_BIO_EXEMPTED");
			//out.println(hourlyOCICount);

			if (flagFlightCount == true) {
				hourlyBio.append(",");
				hourlyBioEnrolled.append(",");
				hourlyBioVerified.append(",");
				hourlyBioExempted.append(",");
				} 
			else
				flagFlightCount = true;

			hourlyBio.append("\"");
			hourlyBio.append(hourlyBioYAxis);
			hourlyBio.append("\"");
			
			hourlyBioEnrolled.append(hourlyBioEnrolledCount);
			hourlyBioVerified.append(hourlyBioVerifiedCount);
			hourlyBioExempted.append(hourlyBioExemptedCount);

		}
		rsTemp.close();
		psTemp.close();

	} catch (Exception e) {
		out.println("Hourly Bio Exception");
	}

	String strHourlyBio = hourlyBio.toString();
	String strHourlyBioEnrolled = hourlyBioEnrolled.toString();
	String strHourlyBioVerified = hourlyBioVerified.toString();
	String strHourlyBioExempted = hourlyBioExempted.toString();
	//out.println(strHourlyOCI);
	
////////////////	Table - Biometric Enrollment/Verification/Exemption in last 7 hours - Start	///////////////////////%>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-4">
		<table class="tableDesign">
		<!--	<caption style="font-size: 15px; color: grey; line-height: 50px; text-align: center; padding-top: 5px;font-weight: bold; font-family: 'Arial', serif;">Biometric Enrollment/Verification/Exemption in last 7 hours</caption>-->
			
				<tr style="font-size: 16px;  text-align: right; color:white; border-color: #003a6d;height:40px;">
					<th style="text-align: center;background-color:#00539a;border-color: #00539a;width:25%;">Time</th>
					<th style="text-align: center;background-color:#00539a;border-color: #00539a;width:25%; text-align: right;">Enrollment&nbsp;&nbsp;</th>
					<th style="text-align: center;background-color:#00539a;border-color: #00539a;width:25%; text-align: right;">Verification&nbsp;&nbsp;</th>
					<th style="text-align: center;background-color:#00539a;border-color: #00539a;width:25%; text-align: right;">Exempted&nbsp;&nbsp;</th>
				</tr>
		<% 
			String[] hourListBio = strHourlyBio.toString().replace("\"", "").split(",");
			String[] hourBioEnrolled = strHourlyBioEnrolled.split(",");
			String[] hourBioVerified = strHourlyBioVerified.split(",");
			String[] hourBioExempted = strHourlyBioExempted.split(",");
			//String v_date_Format  = "";
			/*String strHourlyBio = hourlyBio.toString();
			String strHourlyBioEnrolled = hourlyBioEnrolled.toString();
			String strHourlyBioVerified = hourlyBioVerified.toString();
			String strHourlyBioExempted = hourlyBioExempted.toString();*/

			for (int i = hourListBio.length - 1; i >= 0; i--) {
			%>
			<tr style="font-size: 16px; font-family: 'Arial', serif; text-align: center;height:20px;">
				<td style="background-color:#38acff;border-color: #00539a;width:25%; font-weight: bold; text-align: center;"><%=hourListBio[i]%></td>
				<td style="background-color:#50b6ff;border-color: #00539a;width:25%; font-weight: bold; text-align: right;"><%=hourBioEnrolled[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#86cdff;border-color: #00539a;width:25%; font-weight: bold; text-align: right;"><%=hourBioVerified[i]%>&nbsp;&nbsp;</td>
				<td style="background-color:#cceaff;border-color: #00539a;width:25%; font-weight: bold; text-align: right;"><%=hourBioExempted[i]%>&nbsp;&nbsp;</td>
			</tr>
<%
			}
			%>
		</table>
		</div>
	<%///////////////////////	Table - Biometric Enrollment/Verification/Exemption in last 7 hours - End	////////////////////////%>

	
	<div class="col-sm-8">
	<h1 style="font-size: 15px; color: grey; line-height: 35px; text-align: center; padding-top: 5px; font-family: 'Arial', serif;
	 background-color: #ffffff">Biometric Enrollment/Verification/Exemption in last <%=displayHours%> hours</h1>

		<canvas id="canvasHourlyBio" class="chart" style="max-width: 100%;    background: linear-gradient(to bottom, #ffffff 35%, #8ecddd 100%);"></canvas>
	</div>
			</div>
		</div>

	<script>
		// Data define for bar chart

		var myDatabb = {
			labels: [<%=reverseOnComma(strHourlyBio)%>],
			datasets: [{ 
				  label: "Bio Enrolled",
			      backgroundColor: "#22668D",
			      borderColor: "#26577C",
			      borderWidth: 1,
			     
			      data: [<%=reverseOnComma(strHourlyBioEnrolled)%>]
			}, { 
				  label: "Bio Verified",
			      backgroundColor: "#8ECDDD",
			      borderColor: "#26577C",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyBioVerified)%>]
			},
			{ 
				  label: "Bio Exempted",
			      backgroundColor: "#0C134F",
			      borderColor: "#26577C ",
			      borderWidth: 1,
			      data: [<%=reverseOnComma(strHourlyBioExempted)%>]
			}]
		};
		 	

		// Options to display value on top of bars

		var myoptionsbb = {
				 scales: {
				        yAxes: [{
				            ticks: {
				                display: false //removes y axis values in  bar graph 
				            }
				        }]
				    },
				 title: {
				        fontSize: 14,		
				      },
			      
			tooltips: {
				enabled: true
			},
			hover: {
				animationDuration: 2
			},
			animation: {
			duration: 1,
			onComplete: function () {
				var chartInstancesbb = this.chart,
					ctx = chartInstancesbb.ctx;
					ctx.textAlign = 'center';
					ctx.fillStyle = "rgba(0, 0, 0, 1)";
					ctx.textBaseline = 'bottom';
					ctx.font = "bold 8px Verdana";

					this.data.datasets.forEach(function (dataset, i) {
						var metasbb = chartInstancesbb.controller.getDatasetMeta(i);
						metasbb.data.forEach(function (bar, index) {
							var data = dataset.data[index];
							ctx.fillText(data, bar._model.x, bar._model.y);
							
						});
					});
				}
			}
		};
		//Code to drow Chart

		var ctx = document.getElementById('canvasHourlyBio').getContext('2d');
		var myChartsbb = new Chart(ctx, {
			type: 'bar',    	// Define chart type
			data: myDatabb,    	// Chart data
			options: myoptionsbb	// Chart Options [This is optional paramenter use to add some extra things in the chart].
		});

	</script>
<%//////////////////////////	Biometric Enrollment/Verification/Exemption in last 7 hours - End	/////////////////////////////////%>

		</section>
		<!--   ************************END BIOMETRIC DIV*******************END BIOMETRIC DIV*****************END BIOMETRIC DIV****************END BIOMETRIC DIV********  -->
		<!--   ************START e-VISA DIV*******************START e-VISA DIV**************START START e-VISA DIV****************START e-VISA DIV********  -->
		<section id="EVISA">
		<div class="container pt-4" id="evisa">
		<table id = "auto-index10" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green">Section_8</th>
				</tr>
				<tr id='head' name='evisa'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
		
		</table>
		</div>
		</section>
		<!--   *********************END e-VISA DIV*******************END e-VISA DIV*****************END e-VISA DIV****************END e-VISA DIV********  -->
		<!--   ************START E-PRM DIV*******************START E-PRM DIV*************************START E-PRM DIV********  -->
		<section id="EPRM">
		<div class="container pt-4" id="e-prm">
		<table id = "auto-index11" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green">Section_9</th>
				</tr>
				<tr id='head' name='e-prm'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
		
		
		</table>
		</div>
		</section>
		<!--   *********************END E-PRM DIV*******************END E-PRM DIV*****************END E-PRM DIV****************END E-PRM DIV********  -->
		<!--   ************START ETA DIV*******************START ETA DIV**************START ETA DIV****************START ETA DIV********  -->
		<section id="ETA">
		<div class="container pt-4" id="eta">
			<table id = "auto-index12" class="table table-sm table-striped">
				<thead>
					<tr id='head1'>
						<th colspan=9 bgcolor="green">Section_10</th>
					</tr>
					<tr id='head' name='eta'>
						<th>S.No.</th>
						<th>Date</th>
						<td>&nbsp;&nbsp;&nbsp;</td>
						<th colspan=6>Description</th>
					</tr>
				</thead>
				
			</table>
		</div>
		</section>
		<!--   *********************END ETA DIV*******************END ETA DIV*****************END ETA DIV****************END ETA DIV********  -->
		<!--   ************************START E-Gate DIV************************START E-Gate DIV****************START E-Gate DIV********  -->
		<section class="aboutsection" id="e-gate">
		<div class="container pt-4" id="e-gate">    
		<table id = "auto-index13" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green"> Section_11 </th>
				</tr>
				<tr id='head' name='e-gate'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
					</table>
		</div>
		</section>
		<!--   ************************END E-Gate DIV************************END  E-Gate DIV****************END  E-Gate DIV********  -->

		<!--   ************************START Boarding DIV************************START Boarding DIV****************START Boarding DIV********  -->
		<section class="aboutsection" id="boarding">
		<div class="container pt-4" id="boarding">    
		<table id = "auto-index14" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green">Section_12</th>
				</tr>
				<tr id='head' name='boarding'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			
		</table>
		</div>
		</section>
		<!--   ************************END Boarding DIV************************END  Boarding DIV****************END Boarding DIV********  -->
		
		<!--   *********START TTP_14_15_Jul_2016 DIV**************START TTP_14_15_Jul_2016 DIV*********************START TTP_14_15_Jul_2016 DIV********  -->
		<section id="TTP-Jul-2016">
		<div class="container pt-4" id="TTP_14_15_Jul_2016">
		<table id = "auto-index15" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green">Section_13</th>
				</tr>
				<tr id='head' name='TTP_14_15_Jul_2016'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			
		</div>
		</section>
		<!--   *********START TTP_15_16_Dec_2016 DIV************START TTP_15_16_Dec_2016 DIV***********START TTP_15_16_Dec_2016 DIV***********START TTP_15_16_Dec_2016 DIV******* -->
		<section id="TTP-Dec-2016">
		<div class="container pt-4" id="TTP_15_16_Dec_2016">
		<table id = "auto-index16" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
				<th colspan=4 bgcolor="green">Section_14</th>
				</tr>
				<tr id='head' name='TTP_15_16_Dec_2016'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			
		</table>
		</div>
		</section>
		<!--   ************START E_LandingCard DIV*******************START E_LandingCard DIV**************START E_LandingCard DIV****************START E_LandingCard DIV********  -->
		<section id="E-Landing-Card">
		<div class="container pt-4" id="eLandingCard">
		<table id = "auto-index17" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green">Section_15</th>
				</tr>
				<tr id='head' name='eLandingCard'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			
		</div>
		</section>
		<!--   ************************END E_LandingCard DIV*******************END E_LandingCard DIV*****************END E_LandingCard DIV****************END E_LandingCard DIV********  -->
		<!--   ************************START S_Form DIV*******************START S_Form DIV*****************START S_Form DIV****************START S_Form DIV********  -->
		<section id="S_Form" class="aboutsection">
		<div class="container pt-4" id="S_Form">
		<table id = "auto-index18" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green"> Section_17</th>
				</tr>
				<tr id='head' name='S_Form'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			
		</table>
		</div>
		</section>
		<!--   ************************END mouli_user_manual DIV************************END  mouli_user_manual DIV****************END  mouli_user_manual DIV********  -->
		<!--   ************************START STICKER DIV************************START STICKER DIV****************START STICKER DIV********  -->
		<section class="aboutsection" id="sticker">
		<div class="container pt-4" id="sticker">    
		<table id = "auto-index20" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green"> Section_18</th>
				</tr>
				<tr id='head' name='sticker'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			
		</table>
		</div>
		</section>
		<!--   ************************END STICKER DIV************************END STICKER DIV****************END  STICKER DIV********  -->
		<!--   ************************START AEP-FORM DIV************************START AEP-FORM DIV****************START AEP-FORM DIV********  -->
		<section class="aboutsection" id="aepform">
		<div class="container pt-4" id="aepform">    
		<table id = "auto-index21" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green"> Section_19 </th>
				</tr>
				<tr id='head' name='aepform'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			
		</div>
		</section>
		<!--   ************************END AEP-FORM DIV************************END  AEP-FORM DIV****************END  AEP-FORM DIV********  -->

		<!--   ************************START Office-Order DIV******************Office-Order DIV*****************START Office-Order DIV****************START Office-Order DIV********  -->

	<section class="aboutsection" id="Office-Order">
	<div class="container pt-4" id="Office-Order">
	<table id = "auto-index22" class="table table-sm table-striped">
	   <thead>
		<tr id='head1'>
				<th colspan=4 bgcolor="green">Section_20</th>
			</tr>
			<tr id='head' name='Office-Order'>
				<th>S.No.</th>
				<th>Date</th>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<th>Description</th>
			</tr>
		</thead>
		
	</table>
	</div>
	</section>
	<!--   ************************END HOME DIV*******************HOME DIV*****************END HOME DIV****************END HOME DIV********  -->

	<!--   ************************ START IVFRT-OFFICE-ORDERS DIV*******************HOME DIV***********START IVFRT-OFFICE-ORDERS DIV************START IVFRT-OFFICE-ORDERS DIV********  -->

	<section class="aboutsection" id="IVFRT-OFFICE-ORDERS">
	<div class="container pt-4" id="IVFRT-OFFICE-ORDERS">
	<table id = "auto-index23" class="table table-sm table-striped">
	   <thead>
		<tr id='head1'>
				<th colspan=4 bgcolor="green">Section_21</th>
			</tr>
			<tr id='head' name='IVFRT-OFFICE-ORDERS'>
				<th>S.No.</th>
				<th>Date</th>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<th>Description</th>
			</tr>
		</thead>
		
	</table>
	</div>
	</section>
	<!--   ***********END IVFRT-OFFICE-ORDERS DIV************IVFRT-OFFICE-ORDERS DIV************END IVFRT-OFFICE-ORDERS DIV*************END IVFRT-OFFICE-ORDERS DIV***** ->

	<!--   ********** START ANTIDATING-OFFICE-ORDERS DIV***************START ANTIDATING-OFFICE-ORDERS DIV************START ANTIDATING-OFFICE-ORDERS DIV********  -->
		<section class="aboutsection" id="ANTIDATING-OFFICE-ORDERS">
		<div class="container pt-4" id="ANTIDATING-OFFICE-ORDERS">
		<table id = "auto-index24" class="table table-sm table-striped">
	   <thead>
		<tr id='head1'>
				<th colspan=4 bgcolor="green">Section_22</th>
			</tr>
			<tr id='head' name='ANTIDATING-OFFICE-ORDERS'>
				<th>S.No.</th>
				<th>Date</th>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<th>Description</th>
			</tr>
		</thead>
		
	</table>
	</div>
	</section>
	<!--   ***********END ANTIDATING-OFFICE-ORDERS DIV************ANTIDATING-OFFICE-ORDERS DIV************END ANTIDATING-OFFICE-ORDERS DIV*************END ANTIDATING-OFFICE-ORDERS DIV***** ->

	<!--   ************************ START AINOA-OFFICE-ORDERS DIV***********************START AINOA-OFFICE-ORDERS DIV************START AINOA-OFFICE-ORDERS DIV********  -->
		<section class="aboutsection" id="AINOA-OFFICE-ORDERS">
		<div class="container pt-4" id="AINOA-OFFICE-ORDERS">
		<table id = "auto-index25" class="table table-sm table-striped">
	   <thead>
		<tr id='head1'>
				<th colspan=4 bgcolor="green">AINOA OFFICE ORDERS</th>
			</tr>
			<tr id='head' name='AINOA-OFFICE-ORDERS'>
				<th>S.No.</th>
				<th>Date</th>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<th>Description</th>
			</tr>
		</thead>
		<tbody id="data">
		   <tr>
				<td></td>
				<td>03/01/2023</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Ainoa/[Untitled]-8_AINOA.pdf')" style="cursor: pointer;">Minutes of Central Executive Body (CEB) Meeting of AINOA Held on 20160610</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>14/12/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/AINOA_MASTER_LIST_AS_ON_DATE_14_December.xls')" style="cursor: pointer;">AINOA Master List</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>20/12/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/DoPPW_OM_dated_20th_September_2021_regrading_submission_of_Annual_Life_Certificate.pdf')" style="cursor: pointer;">Submission of Annual Life Certificate</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>31/05/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/DoE_OM_dt_31.05.2021.pdf')" style="cursor: pointer;">Central Civil Services (Implementation of National Pension Scheme)</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>03/01/2023</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Ainoa/[Untitled]-18_AINOA.pdf')" style="cursor: pointer;">All India NIC S&T Officers Association 20161004</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>03/01/2023</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Ainoa/[Untitled]-14_AINOA.pdf')" style="cursor: pointer;">Minutes of Meeting held with DG, NIC and AINOA CEB Members on 20160905</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>03/01/2023</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Ainoa/[Untitled]-10_AINOA.pdf')" style="cursor: pointer;">Minutes of Central Executive Body (CEB) Meeting of AINOA Held on 20160809</a></td> 
			</tr>
		   <tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Ainoa/5_6210555098364380343.pdf')" style="cursor: pointer;">Sagolsem Ramesh Singh & PRS.(Opp. Party )</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>14/07/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/All_India_NIC_S&T_Officers.pdf')" style="cursor: pointer;">All India NIC S&T Officers Association & Anr Versus Union of India & Ors</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>30/05/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Ainoa/AINOA_CEB_MoM_30052021.pdf')" style="cursor: pointer;">Minutes of the CEB Meeting, AINOA</a></td> 
			</tr>
			
			<tr>
				<td></td>
				<td>25/05/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Ainoa/List_of_AINOA_members_and_their_membership_fees_details_till_year_2021-22.pdf')" style="cursor: pointer;">Annual Membership Fees Due</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>21/06/2020</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Leave_Encashment_and_Gratuity_for_Pensioners.pdf')" style="cursor: pointer;">Central Goernment Employees Retired during the period from January 2020</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>22/06/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/DoPPWs_O.M._dated_22.06.2021_regarding_Issue_of_Pension_slip_by_Banks.pdf')" style="cursor: pointer;">Issue of Pension Slip By Pension Disbursing Banks On Monthly Basis</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>09/07/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Inspection_by_Honble_Minister.pdf')" style="cursor: pointer;">Inspection by Hon'ble Minister</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/07/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/NIC-Compassionate.pdf')" style="cursor: pointer;">Compassionate Apointment Relative Marit Point System and Revised Procedure For Selection in NIC</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>13/06/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/OM_dated_13.06.2022.pdf')" style="cursor: pointer;">Clarification Whether Ipad Comes Under The Definition Of Personal Computer For The Purpose Of Grant Of Computer Advance</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>16/06/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/OM_dated_16_June_2021.pdf')" style="cursor: pointer;"> Suspension Of Family Pension To A Person Charged With The Offence Of Murdering Or Abetting In The Murder Of The Government Servant– Allowing Family Pension To Other Eligible Family Member.</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>03/01/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/OM_Finance_Ministry.pdf')" style="cursor: pointer;">Dearness Allowance and Dearness Relief to Central Government Employees till July 2022</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/08/2017</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/office_memorandum-streamlining_and_standardizing_of_the_recruitment_process.pdf')" style="cursor: pointer;">Streamlining and Standardizing of the Recruitment Process</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>14/05/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/NICSI_Engagement_of_Retired_Government_officials.pdf')" style="cursor: pointer;">Inviting Applications For Engagement Of Retired Governmen Officers From Central Ministries/Departments & Their Organizations In Related Domains As "Consultant” On Monthly Basis And “Domain Expert" On Full/Half Day Basis On Contract In NICSI.</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>10/02/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/streamlining_and_standardising_of_the_recruitment_process_-_scientist_c_and_above-2021.pdf')" style="cursor: pointer;">Streamlining And Standardising Of The Recruitment Process Scientist C And Above</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>31/12/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/air_travel_instructions_1.pdf')" style="cursor: pointer;">Modification o{ Instructions Regarding Booking Of Air Tickets On Government Account.</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2019</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Streamlining_Recruitment_Process-2019.pdf')" style="cursor: pointer;">Streamlining Recruitment Process</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>16/06/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Grant-of-Benefit-of-one-notional-increment-DOPT-OM-24-06-2021.pdf')" style="cursor: pointer;">Grant Ofbenefjt Ofone Notional Increment (As Due On July) For The Pensionary Benefits To Those Employees Who Had Retires On 30 Ofjune Before Drawing TheSarne. </a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/5_6316593898122642808.pdf')" style="cursor: pointer;">All India NIC S & T Officer’S Association</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td>AINOA Master List(CEB) Updated As On Date<a onClick="add_task('Ainoa/AINOA_MASTER_LIST_14TH_JANUARY.xls')" style="cursor: pointer;"> 30/12/2021,</a>
				<a onClick="add_task('Ainoa/AINOA_master_list_4th_February.xls')" style="cursor: pointer;"> 04/02/2021,</a>
				<a onClick="add_task('OfficeOrder/AINOA_MASTER_LIST_AS_ON_DATE_14_December.xls')" style="cursor: pointer;"> 14/12/2021</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>30/07/2019</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/MoM_ceb_meeting_July_2021.pdf')" style="cursor: pointer;">Minutes of the CEB Meeting of All India NIC S & T Officer's Association (AINOA)</a></td> 
			</tr>
		</tbody>
	</table>
	</div>
	</section>
	<!--   ***********END AINOA-OFFICE-ORDERS DIV********************END AINOA-OFFICE-ORDERS DIV*************END AINOA-OFFICE-ORDERS DIV***** ->

	<!--   ************************ START MISCELLANEOUS DIV*********************START MISCELLANEOUS DIV************START MISCELLANEOUS DIV********  -->
		<section class="aboutsection" id="MISCELLANEOUS-ORDERS">
		<div class="container pt-4" id="MISCELLANEOUS-ORDERS">
		<table id = "auto-index26" class="table table-sm table-striped">
	   <thead>
			<tr id='head1'>
			<th colspan=4 bgcolor="green">MISCELLANEOUS ORDERS</th>
			</tr>
			<tr id='head' name='MISCELLANEOUS-ORDERS'>
				<th>S.No.</th>
				<th>Date</th>
				<td>&nbsp;&nbsp;&nbsp;</td>
				<th>Description</th>
			</tr>
		</thead>
		<tbody id="data">
			<tr>
				<td></td>
				<td>03/01/2023</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/criteria_for_output_indicators_under_group_a_policy_for_S_and_T.pdf')" style="cursor: pointer;">Criteria for Output Indicators Under Group a policy for S and T</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>03/01/2023</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/[Untitled]-13.pdf')" style="cursor: pointer;">Minutes of Meeting chaired by Depty Director Regarding e-Landing Card, e-Visa (Medical, Tourist, Business) and e-Services </a></td> 
			</tr>
			<tr>
				<td></td>
				<td>31/05/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/2021-05-31_NIC.pdf')" style="cursor: pointer;">Appointments Commitee Of The Cabinet Has Approved The Proposal The Ministry Of Electronics</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>23/07/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/2307-FRRO-TVM.pdf')" style="cursor: pointer;">Report on Use of VISA With Special Reference to POE Clearance Required</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Annexure-I_application_form_for_visa_on_arrival.pdf')" style="cursor: pointer;">Annexure-I Application Form For Visa On Arrival</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/5_6316593898122642808.pdf')" style="cursor: pointer;">All India NIC S&T Officer’S Association</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>02/08/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/8th-Pay-Commission-Official-Update.pdf')" style="cursor: pointer;">Shri Narayan Bhai J. Rathwa</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>06/02/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Adobe_Scan_6_Feb_2022.pdf')" style="cursor: pointer;">Wireless Message/ Crash</a></td> 
			</tr>		
			<tr>
				<td></td>
				<td>17/06/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/CMD_Banks.pdf')" style="cursor: pointer;">CMDs of all Pension Disbursing Banks</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>20/01/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/consultants-NIC.pdf')" style="cursor: pointer;">Engagement of 23 Consultants</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>01/01/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/DA_increase.pdf')" style="cursor: pointer;">Hike in Pension Per Month, From 1st January 2022, Due To Increase in 3% DA</a></td> 
			</tr>
			
			
			<tr>
				<td></td>
				<td>01/07/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/GuidelinesforInternationalarrivalsupdatedon10thFebruary2022.pdf')" style="cursor: pointer;">(In Supersession Of All Guidelines Issued On The Subject On And After 20 January 2022)</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>13/08/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Help_needed_on_immigration_status.pdf')" style="cursor: pointer;">Help Needed On Immigration Status</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>01/07/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/HRA_MATTER_W.E.F_01.07.2021.pdf')" style="cursor: pointer;">Implementation of Recommendations of 7th CPC Relating to the Grant of House Rent Allowance</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Important_initiatives_under_NPS.pdf')" style="cursor: pointer;">Important Initiatives For Central Government Employees Covered Under NPS:</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>13/12/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/issues (1).pdf')" style="cursor: pointer;">Survey of Arrival and Evisa counters as on 13 December (Shift D):</a></td> 
			</tr>		
			<tr>
				<td></td>
				<td>01/08/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Letter_dt_1-8-2022.pdf')" style="cursor: pointer;">Restructuring of NIC to Make it Future Ready</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>14/06/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Mandatory utilization_Mety_14062022_220619_084419.pdf')" style="cursor: pointer;">Union Cabinet for the Revival of BSNL/MTNL in Oct 2019</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>01/04/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/New_Doc_07_11_2022_16.35_2.pdf')" style="cursor: pointer;">Augmentation of Staff in BOI</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/NPS_TerminalBenefits_InServiceDeath.pdf')" style="cursor: pointer;">Benefits available in the case of death of a Central Government Employee covered under National Pension System during service</a></td> 
			</tr>		
			<tr>
				<td></td>
				<td>08/06/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/OMonPPODigitization08062021.pdf')" style="cursor: pointer;">Digitization of Pension Process and Discontinuation of Physical PPO</a></td> 
			</tr>
			
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Retirement_Benefits_in_One_Click.pdf')" style="cursor: pointer;">Retirement Benefits in One Click</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/07/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Salary_hike_from_July_2021by_Govt_Employees_News_YouTube_Channel.pdf')" style="cursor: pointer;">Hike In Salary Per Month From July 2021 Due To Increase In DA</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/SB_MAINLIST_DEC_21.pdf')" style="cursor: pointer;">National Institute of Electronics and Information Technology</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>15/07/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Scanned Document.pdf')" style="cursor: pointer;">Appointment of CISO (Chief Information Security Officer) and Dy. CISO</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>01/06/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Scrap.pdf')" style="cursor: pointer;">Scrapping of Tender for "Facility Management Service for NICNET, NKN and other Network Service"</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>15/12/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/TN-IVFRT-FINAL-1.pdf')" style="cursor: pointer;">The Project Review Visit by Mrs Alka Mishra DDG & HOG IVFRT Project At Tamilnadu</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Travel_to_restricted_countries.pdf')" style="cursor: pointer;">Travel to Restricted Countries</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>03/08/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/VRS.pdf')" style="cursor: pointer;">Committee to Counsel/Interact with the Officers Seeking Voluntary Retirement Scheme in NIC</a></td> 
			</tr>
		
			<tr>
				<td></td>
				<td>01/01/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/DA_increase.pdf')" style="cursor: pointer;">Hike in Pension Per Month, From 1st January 2022, Due To Increase in 3% DA</a></td> 
			</tr>
			
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/8th-Pay-Commission-Official-Update.pdf')" style="cursor: pointer;">8th Pay Commission Official Update</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>27/10/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/5_6325400101497865460.pdf')" style="cursor: pointer;">Air Travel on official Account Stoppage of Credit Facility by Air India</a></td> 
			</tr>
		
			<tr>
				<td></td>
				<td>27/05/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Promotion/605e8f87039c26f764fba32d0ac1fda3-Represerntation recevied granting (1).pdf')" style="cursor: pointer;">Representations Received from S&T Officials/Officers for Granting Promotion date of Eligibility</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>06/07/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('Promotion/ivfrt_tgr_boi_cap_16072021.pdf')" style="cursor: pointer;">A Refresher Training On IVFRT and Its Service Deliveries With Special Focus on Immigration Control System (ICS)</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>04/05/2017</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('miscellaneous/IVFRT-Staff_Project_Details_5226.doc')" style="cursor: pointer;">IVFRT Staff Project Details (DOC)</a>
				<a onClick="add_task('miscellaneous/IVFRT-Staff_Project_Details_5226.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
			</tr>
			</tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td>List of Officers as on 11th April<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April,222.doc')" style="cursor: pointer;">J222-1 (DOC)</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April,222.pdf')" style="cursor: pointer;">&nbsp;[pdf],&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_222_1.doc')" style="cursor: pointer;">J222-2 (DOC)</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_222_1.pdf')" style="cursor: pointer;">&nbsp;[pdf],&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222.doc')" style="cursor: pointer;">J222-3 (DOC)</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222.pdf')" style="cursor: pointer;">&nbsp;[pdf],&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-1.doc')" style="cursor: pointer;">J222-4 (DOC)</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-1.pdf')" style="cursor: pointer;">&nbsp;[pdf],&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-2.doc')" style="cursor: pointer;">J222-5 (DOC)</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-2.pdf')" style="cursor: pointer;">&nbsp;[pdf],&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-3.doc')" style="cursor: pointer;">J222-6 (DOC)</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-3.pdf')" style="cursor: pointer;">&nbsp;[pdf],&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-4.doc')" style="cursor: pointer;">J222-7 (DOC)</a>
				<a onClick="add_task('MISCELLANEOUS/List_of_Officers_as_on_11th_April_J222-4.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td> 
			</tr>
		</tbody>
	</table>
	</div>
	</section>
	<!--   ***********END MISCELLANEOUS-ORDERS DIV*******************END MISCELLANEOUS-ORDERS DIV*************END MISCELLANEOUS-ORDERS DIV***** ->
		
		<!--******************START miscellaneous**************START miscellaneous*************START miscellaneous**************START miscellaneous*******  -->
		<section class="aboutsection" id="miscellaneous">
		<div class="container pt-4" id="Miscellaneous">
		<table id = "auto-index27" class="table table-sm table-striped">
			<thead>
			<tr id='head1'>
					<th colspan=4 bgcolor="green"> Miscellaneous</th>
				</tr>
				<tr id='head' name='miscellaneous'>
					<th>S.No.</th>
					<th>Date</th>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<th>Description</th>
				</tr>
			</thead>
			<tbody id="data">
				<tr>
					<td></td>
					<td>09/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/PAK_New_Arrival_PTS_Form.jpg')" style="cursor: pointer;">PAK New National Arrival PTS Form</a></td>
				</tr>
				<tr>
					<td></td>
					<td>09/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/ccs_conduct_rules_1964_details_Hindi_complete.pdf')" style="cursor: pointer;">CCS Conduct Rules 1964 Details Hindi Complete</a></td>
				</tr>
				<tr>
					<td></td>
					<td>09/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/RFP_MeghRaj.pdf')" style="cursor: pointer;">Selection of Indian Cloud Partner for Managing NIC Cloud Solution – MeghRaj 2.0</a></td>
				</tr>
				<tr>
					<td></td>
					<td>09/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/RFP_for_organizational_restructuring_of_nic_to_make_it_future_ready_20221009.pdf')" style="cursor: pointer;">Request for Proposal (RFP) Selection of a Consultant for Organizational Restructuring of NIC</a></td>
				</tr>
				<tr>
					<td></td>
					<td>09/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/RFP_FMS.pdf')" style="cursor: pointer;">Request for proposal for Selection of Facility Management Service Operator for Operations and Management of Core Infrastructure of NICNET/NKN </a></td>
				</tr>
				<tr>
					<td></td>
					<td>09/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/sparsh_intro.pdf')" style="cursor: pointer;">Sparsh Introduction</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/International_Flight_Count.pdf')" style="cursor: pointer;">International Flights Arriving to India from 16/02/2017 to 23/02/2017</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/imm_activities.doc')" style="cursor: pointer;">Immigration Activities (DOC)</a>
					<a onClick="add_task('miscellaneous/imm_activities.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Image_Details_Updation_new.ppt')" style="cursor: pointer;">Image Details Updation New "Upon clicking on the link, User is being redirected to central PAX testing interface, where he/she can enter the testing PAX details and verify the PAX data against LOC, which is same as the real PAX Application" (PPT)</a>
					<a onClick="add_task('miscellaneous/Image_Details_Updation_new.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Image_Details_Updation_mod.ppt')" style="cursor: pointer;">Image Details Updation Mod "Upon clicking on the link, User is being redirected to central PAX testing interface, where he/she can enter the testing PAX details and verify the PAX data against LOC, which is same as the real PAX Application" (PPT)</a>
					<a onClick="add_task('miscellaneous/Image_Details_Updation_mod.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Image_Correction_Help.jpg')" style="cursor: pointer;">Image Correction Help (Image Search Form Image Server)</a></td>
				</tr>
					<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/20170701_new_immigration_rule_no_departure_card.jpg')" style="cursor: pointer;">New Immigration Rule No Departure Card</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/20180203TOI_14L_gold_in_bag_hooks_seized_at_IGI.jpg')" style="cursor: pointer;">Toi 14L Gold In Bag Hooks Seized at IGI</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/Almost_2bn_data_records_breached.jpg')" style="cursor: pointer;">Almost 2bn Data Records Breached</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/Face_reading_software_not_good_court_told.jpg')" style="cursor: pointer;">Face Reading Software Not Good Court Told</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/The_five_dirtiest_spots_inside_a_plane.jpg')" style="cursor: pointer;">The Five Dirtiest Spots Inside A Plane</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('OfficeOrder/How_to_add_any_application_to_the_windows_desktop_right-click_menu.jpg')" style="cursor: pointer;">How To Add Any Application To The Windows Desktop Right Click Menu</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/5_6296318195036848978.pdf')" style="cursor: pointer;">A Booklet on Modus Operandi of Financial Fraudsters</a></td> 
			</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/iLO_configuration_on_HP_server.pdf')" style="cursor: pointer;">iLO Configuration on HP Server</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Entry_Exit_Loop_Close_Manual.pdf')" style="cursor: pointer;">Automatic/Manual Entry–Exit Matching For Foreigner's Departure</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Disable_IE_F12_Developer_Tools.reg')" style="cursor: pointer;">Disable IE F12 Developer Tools Reg.</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/covid-sdf.doc')" style="cursor: pointer;">Covid SDF Server Arrival (DOC)</a>
					<a onClick="add_task('miscellaneous/covid-sdf.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/coron_alert.mic')" style="cursor: pointer;">Coron Alert MIC</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td>APHO Registration data<a onClick="add_task('miscellaneous/apho-registration-data 11 -12 Aug94.xls')" style="cursor: pointer;"> 11/Aug/1994 (XLS),</a>
					<a onClick="add_task('miscellaneous/apho_registration_data_11_12_Aug94.xls')" style="cursor: pointer;"> 12/Aug/1994 (XLS),</a>
					<a onClick="add_task('miscellaneous/apho_registration_637330183584082958_14aug.xls')" style="cursor: pointer;"> 14/Aug/1994 (XLS)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>22/02/2016</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/VA_Audit_Test_Report_IVFRT_22Feb.pdf')" style="cursor: pointer;">VA Audit Test Report IVFRT</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/unedifact_20160922093812_00_IN_MI0488_SIN_CCU.txt')" style="cursor: pointer;">Unedifact 20160922093812 00 IN MI0488 SIN CCU</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/unedifact_20160922093745_00_IN_MI0474_SIN_HYD.txt')" style="cursor: pointer;">Unedifact 20160922093745 00 IN MI0474 SIN HYD</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/test_expand_click.html')" style="cursor: pointer;">Test Expand Click</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/test_collapse.html')" style="cursor: pointer;">Test Collapse</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/SQL_Condition_Based_on_Flags.jpg')" style="cursor: pointer;">SQL Condition Based on Flags</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/server_details.doc')" style="cursor: pointer;">Server Details (DOC)</a>
					<a onClick="add_task('miscellaneous/server_details.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/scrshot_purpose_of_visit_final_destination.jpg')" style="cursor: pointer;">Scrshot Purpose of Visit Final Destination</a></td>
				</tr>
				<tr>
				<td></td>
				<td>21/06/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/FSIS-v-2-4-3.pdf')" style="cursor: pointer;">Foreign Students Information System (FSIS)</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>21/06/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/FSIS-v-2-4-3-Changes.pdf')" style="cursor: pointer;">Foreign Students Information System (FSIS) Changes</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>21/06/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/FSIS-v-2-4-d-31-01-2022.pdf')" style="cursor: pointer;">Integration Of Identity Proof Entry In Fsis In Lieu Of Passport Entry For Countries Nepal And Bhutan</a></td> 
			</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Screenshot_2017-01-02-20-18_46_173_cn_wps_moffice_eng.jpg')" style="cursor: pointer;">Deportation of Rev. Udispattuwe Dhammawansha thero, Sri Lankan National and Mr. Malwadam Gedara Piyathissa, Sri Lankan Tour operator on their arrival at Chennai Airport.</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/scan0002.pdf')" style="cursor: pointer;">Scan-0002</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/scan0001.pdf')" style="cursor: pointer;">Feedback on Integration of Pak Tracking System(PTS) With ICS</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Required_Tags_for_entry_exit_loop.jpg')" style="cursor: pointer;">Required Tags For Entry Exit Loop</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/proposal_concept_paper_for_malidives.doc')" style="cursor: pointer;"> Proposal Concept Paper "Concept Note for Border Control System (Visa and Immigration Services) for Government of Maldives (GoM)" (DOC)</a>
					<a onClick="add_task('miscellaneous/proposal_concept_paper_for_malidives.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>19/09/2016</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Personal_Policy_GrA.pdf')" style="cursor: pointer;">Personnel Policy for Group 'A' S&T Officers of Ministry of Electronics and Information Technology</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/offload_consolidate.jpg')" style="cursor: pointer;">Offload Consolidate</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/New_PTS_Form.jpg')" style="cursor: pointer;">PAK New Arrival PTS Form</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/MOIA_XML_FILENAME_Errors.doc')" style="cursor: pointer;">Ministry of Overseas Indian Affairs (MOIA) XML Filename Errors (DOC)</a>
					<a onClick="add_task('miscellaneous/MOIA_XML_FILENAME_Errors.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/loc_Checklist.pdf')" style="cursor: pointer;">LOC Check-list Pdf Sample</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/maldives.pdf')" style="cursor: pointer;">Prime Minister's Delegation Level Talks with the President of Maldives</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/NIC_vimal2_2806201611151700.pdf')" style="cursor: pointer;">News Paper Cutting : "Tiruchi airport takes top spot in customer satisfaction survey"</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/laserjet_CP_1525.jpg')" style="cursor: pointer;">Laserjet CP 1525 Cartideges Picture</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/certofmerit_kuppu.pdf')" style="cursor: pointer;">Certificate of Merit Kuppu Samir (FRRO)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/EditPlus_Tricks.txt')" style="cursor: pointer;">EditPlus Tricks</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Enable_IE_F12_Developer_Tools.reg')" style="cursor: pointer;">Enable IE F12 Developer Tools Reg</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/dual_nationality.pdf')" style="cursor: pointer;">Foreign Nationals having Dual Citizenship Carrying two Passports of Different Nationalities</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/drils_flag_screen_shot.png')" style="cursor: pointer;">Drils Flag Screen Shot</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/guidelines of AWR-Part B.doc')" style="cursor: pointer;">Guidelines of AWR Part B (DOC)</a>
					<a onClick="add_task('miscellaneous/guidelines of AWR-Part B.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
					<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/pocketbook-do-dont-1.pdf')" style="cursor: pointer;">Pocket Book do dont 1</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/FSIS-v-2-4-d-31-01-2022.pdf')" style="cursor: pointer;">Integration Of Identity Proof Entry In Fsis In Lieu Of Passport Entry For Countries Nepal And Bhutan</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/FSIS-v-2-4-3-Changes.pdf')" style="cursor: pointer;">Course Duration Extension & Other Changes</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/FSIS-v-2-4-3.pdf')" style="cursor: pointer;">Course Duration Extension</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Integration_of_Video_Conference_system_with_VoIP.pdf')" style="cursor: pointer;">Integration of Video Conference System with VoIP</a></td> 
			</tr>
			<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/document.pdf')" style="cursor: pointer;">Integration of Video Conference system with VoIP</a></td> 
			</tr>
				<tr>
					<td></td>
					<td>16/09/2016</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/HAJ-Flights-Aurangabad-2016.jpg')" style="cursor: pointer;">HAJ Flights Aurangabad TO Jaddah</a></td>
				</tr>
				<tr>
					<td></td>
					<td>6/09/2016</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/HAJ_CLEARANCE_IN_AURANGABAD_REPLY016.pdf')" style="cursor: pointer;">Report Dated 13/09/2016 on Special Haj Immigration duty being performed at Aurangabad Airport</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/160630163525_LOC.pdf')" style="cursor: pointer;">Minutes of the meeting chaired by Joint Director/I on 3/06/2016 Regarding Pending Issue with NIC</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Automatic_Entry_Exit_Matching_For_Foreigner_Departure.doc')" style="cursor: pointer;">Automatic Entry Exit Matching For Foreigner             Departure (DOC)</a>
					<a onClick="add_task('miscellaneous/Automatic_Entry_Exit_Matching_For_Foreigner_Departure.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Indian_Foreigners_Yearwise_Count.jpg')" style="cursor: pointer;">Indian Foreigners Yearwise Count</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/implementation_of_pak_tracking_system_at_attari_(PTS).pdf')" style="cursor: pointer;">Implementation of Pak Tracking System at Attari         (Road & Rail) ICP (PTS)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Indian_Foreigners_Yearwise_Count.jpg')" style="cursor: pointer;">Indian Foreigners Yearwise Count</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Guidelines_for_Development_of_Applications_Data_Quality_V03.pdf')" style="cursor: pointer;">Guidelines for Development of Applications        Data Quality Ver 0.3</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Indian_Foreigners_Yearwise_Count.jpg')" style="cursor: pointer;">Indian Foreigners Yearwise Count</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Face_Authentication_Process_of_Jeevan_Pramaan_App.pdf')" style="cursor: pointer;">Face Authentication Process of Jeevan Pramaan App </a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/entry-exit_system_at_the_external_borders_of_the_european_union_feasibility_study.pdf')" style="cursor: pointer;">Entry Exit System at        the External Borders of the B Service Request European Commission DG Justice, Freedom and Security
					     3 Unit B3 – Large-scale IT systems Entry-Exit Feasibility Study 11 Final Report</a></td>
				</tr>
				<tr>
					<td></td>
					<td>09/12/2016</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Good Governance_Challenges_and_Opportunities_( 11 april)_action_points_emanating_from_report_of_group_of_secretaries_09Dec2016.doc')" style="cursor: pointer;">Good Governance Challenges and Opportunities Action Points Emanating from Report of Group of Secretaries (DOC)</a>
					<a onClick="add_task('miscellaneous/Good Governance_Challenges_and_Opportunities_( 11 april)_action_points_emanating_from_report_of_group_of_secretaries_09Dec2016.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2023</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/entry_refusal_off_loading_doportee_forgery_detection_emergency_certificate.pdf')" style="cursor: pointer;">Form of Entry Refusal off          Loading Doportee Forgery Detection Emergency Certificate</a></td>
				</tr>
				<tr>
					<td></td>
					<td>08/07/2022</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('eVissa/eta/eofficenoticeboard_download(3).pdf')" style="cursor: pointer;">E-Office Notice Board : Regarding Duty Incharge to be deployed at NIC Hqrs.        and NDC, Shastri Park</a></td>
				</tr>
				<tr>
					<td></td>
					<td>31/10/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/BCBP_Implementation_Guidev4_Jun2009.pdf')" style="cursor: pointer;">Simplifying the Business Bar Coded Boarding Pass Implementation Guide     (BCBP) </a></td>
				</tr>
				 <tr>
					<td></td>
					<td>31/10/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/how_to_add_any_application_to_the_windows_desktop_right-click_menu.jpg')" style="cursor: pointer;">How to Add Any Application to The Windows Desktop Right Click Menu</a></td>
				</tr>
				<tr>
					<td></td>
					<td>31/10/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Cruise_Itinerary_Mumbai_22_23.xls')" style="cursor: pointer;">Cruise Itinerary Mumbai 22-23 (XLS)</a></td>
				</tr>
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Rack_Automatic_Transfer_Switch_(AP7723)_Overview_and_Specifications_ASTE-6Z6KBE_R4_EN.pdf')" style="cursor: pointer;">Rack Automatic Transfer      Switch (AP7723) Overview and Specifications ASTE</a></td> 
				</tr>
				<tr>
					<td></td>
					<td>31/10/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/immigration-committee-reply.doc')" style="cursor: pointer;">Immigration Committee Reply "Steering Committee on Immigration in connection with Police Technology Mission (PTM)" (DOC)</a>
					<a onClick="add_task('miscellaneous/immigration-committee-reply.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>31/10/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Process_of_Trusted_Travelers_Programme.doc')" style="cursor: pointer;">Process Of Trusted Travelers Programme (TTTP) Registration By Applicant (DOC)</a>
					<a onClick="add_task('miscellaneous/Process_of_Trusted_Travelers_Programme.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>31/10/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/PUDUCHERY.pdf')" style="cursor: pointer;">Puducherry : Introduction Of Pak Tracking System</a></td>
				</tr>
				<tr>
					<td></td>
					<td>15/07/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Weekly-Progrees-Report-IVFRT-Project-dated-21.04.2020.xls')" style="cursor: pointer;">Weekly Progrees Report IVFRT Project Dated (XLS)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>15/07/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/SQL-Condition-Based-on-Flags.jpg')" style="cursor: pointer;">SQL Condition Based on Flags</a></td>
				</tr>
				<tr>
					<td></td>
					<td>21/06/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/CRS_introduction.pdf')" style="cursor: pointer;">Introduction Software Requirement & Design Specification Complaint Registration System (CRS) Shailendra IGI Airport</a></td>
				</tr>
				<tr>
					<td></td>
					<td>08/06/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/minutes_of_meeting.doc')" style="cursor: pointer;">Minutes of Meeting with NIC and BoI/IB Officers held on May 10, 2022 at IVFRT Centre Shastri Park (DOC)</a>
					<a onClick="add_task('miscellaneous/minutes_of_meeting.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>03/02/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Programme Schedule.pdf')" style="cursor: pointer;">Programme Schedule Inaugural Session Venue- Plenary Hall, Vigyan Bhawan, New Delhi</a></td>
				</tr>
				<tr>
					<td></td>
					<td>02/11/2021</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/server_details_madhavendra_whiteboard.doc')" style="cursor: pointer;">(Shastri Park IVFRT Servers) Details Madhavendra Whiteboard (DOC)</a>
					<a onClick="add_task('miscellaneous/server_details_madhavendra_whiteboard.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>02/11/2021</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Fast_color_scan to_a_PD_ file_1_20211102141937174.pdf')" style="cursor: pointer;">Output Outcome Monitoring Framework (OOMF) Document 2022-23 In Respect Of Central Sector(CS)Centrally Sponsored Schemes(CCS) of MHA Reg.</a></td>
				</tr>
				<tr>
					<td></td>
					<td>06/10/2021</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/server_details_madhavendra_whiteboard.doc')" style="cursor: pointer;">Shastri Park & IVFRT Servers Details Madhavendra Whiteboard (DOC)</a>
					<a onClick="add_task('miscellaneous/server_details_madhavendra_whiteboard.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				
				<tr>
					<td></td>
					<td>18/01/2021</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Artificial-Intelligence-Newsletter.pdf')" style="cursor: pointer;">Artificial Intelligence News Letter By Centre of Excellence in AI NIC</a></td>
				</tr>
				<tr>
					<td></td>
					<td>23/12/2020</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/20201016_MoM_TSC_BL.jpg')" style="cursor: pointer;">Minutes of Meeting with NIC & BOI/IP Officiers </a></td>
				</tr>
				<tr>
					<td></td>
					<td>28/09/2020</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Oracle DBA scripts pdf.pdf')" style="cursor: pointer;">Oracle DBA Scripts</a></td>
				</tr>
				<tr>
					<td></td>
					<td>06/08/2020</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/IVFRT_NEW.pdf')" style="cursor: pointer;">IVFRT (Based on Arrivals in India from 7 May onward)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>11/02/2020</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/editplus-regexp.pdf')" style="cursor: pointer;">EditPlus : Regular Expression quickie</a></td>
				</tr>
				<tr>
					<td></td>
					<td>09/09/2022</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('OfficeOrder/During_a_routine_checking_of_blinking_LOC_List.jpg')" style="cursor: pointer;">Tibetans Entering India Without Valid Travel Documents.</a></td> 
				</tr>
				<tr>
					<td></td>
					<td>29/01/2020</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/NEWS_LETTER_SOFTWARE-issues.doc')" style="cursor: pointer;">News Letter Software Issues (Newsletter Software Presently In Use Is Airport Centric) (DOC)</a>
					<a onClick="add_task('miscellaneous/NEWS_LETTER_SOFTWARE-issues.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>01/01/2020</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/missing-DE-Cards0001.pdf')" style="cursor: pointer;">Missing Destruction of old D/E Card Reg.</a></td>
				</tr>
				<tr>
					<td></td>
					<td>26/11/2019</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/minutes_of_meeting.pdf')" style="cursor: pointer;">Minutes of Meeting with NIC & BOI Officiers 4th Sept 2018</a></td>
				</tr>
				<tr>
					<td></td>
					<td>10/10/2019</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/Human_Trafficking_VoA.pdf')" style="cursor: pointer;">Human Traffic king Reg.</a></td>
				</tr>
				<tr>
					<td></td>
					<td>16/09/2019</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/R_9628_1542890930616.pdf')" style="cursor: pointer;">Minutes of Meeting 12/11/2018 Under The Chairmanship Of Shri Anil Malik</a></td>
				</tr>
				<tr>
					<td></td>
					<td>15/05/2019</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/1325_1(24)_2010-PS(PP)_4751.pdf')" style="cursor: pointer;">Procurement of E-Full Page Travel Document and Integrated Chip for IVFRT (Project No. :1325)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>29/03/2019</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/MoM 29-03-19.doc')" style="cursor: pointer;">Minutes of Meeting Data sharing and development of  an application for processing of Cruise Passengers (DOC)</a>
					<a onClick="add_task('miscellaneous/MoM 29-03-19.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
				<td></td>
				<td>04/04/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/nic_techconclave_march_2022_Programme_Schedule.pdf')" style="cursor: pointer;">NIC Techconclave March 2022 Programme Schedule</a></td> 
				</tr>
				<tr>
					<td></td>
					<td>23/03/2018</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/GuDApps_COVER_web.pdf')" style="cursor: pointer;">Guidelines Development Applications COVER e-GOVERNANCE (GuDApps)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>16/03/2018</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/GuDApps_inner_web.pdf')" style="cursor: pointer;">Guidelines for Development of e-Governance Applications (GuDApps)</a></td>
				</tr>
				<tr>
					<td></td>
					<td>16/03/2018</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/1516778325_GuDApps_-_Guidelines_for_Reports.pdf')" style="cursor: pointer;">Guidelines for Development of e-Governance Applications Reports</a></td>
				</tr>
				<tr>
					<td></td>
					<td>16/03/2018</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/IVFRT-Detailed-Project-Report.pdf')" style="cursor: pointer;">E-Governance Mission Mode Project (MMP) in Immigration, Visa and Foreigners Registration and Tracking  </a></td>
				</tr>
				<tr>
					<td></td>
					<td>06/06/2017</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/CyberSecurity.pdf')" style="cursor: pointer;">Cyber Security</a></td>
				</tr>
				<tr>
					<td></td>
					<td>06/06/2017</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/CyberSecurity.ppt')" style="cursor: pointer;">Cyber Security By Er. Amandeep Kaur A.P (CSE) (PPT)</a>
					<a onClick="add_task('miscellaneous/CyberSecurity.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>06/06/2017</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/utsa09.ppt')" style="cursor: pointer;">Prof. Ravi Sandhu Executive Director and Chief Scientist Institute for Cyber Security University of Texas at San Antonio October 2009 (PPT)</a>
					<a onClick="add_task('miscellaneous/utsa09.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
				<tr>
					<td></td>
					<td>10/03/2017</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/factsheet_-_entryexit_system_en.pdf')" style="cursor: pointer;">The Commission has Proposed The Establishment of an Entry-Exit System (EES)</a></td>
				</tr>
				<tr>
				<td></td>
				<td>28/01/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/pension-for-60-65-etc.pdf')" style="cursor: pointer;">Parliamentary Standing Committee 110th Report on Additional Quantum of Pension on Attaining the age of 65 Years, 70 Years and 75 Years</a></td> 
				</tr>
				
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/PDF_Tools.pdf')" style="cursor: pointer;">It Is A Usual Practice To Use Online Pdf Tools Available On The Internet For Various Day To Day Pdf Needs Such As Pdf To Word, Splitting, Merging Etc.</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>09/08/2021</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Sep-2021-Eng-final.pdf')" style="cursor: pointer;">Virtual Celebration Of World Tribal Day On 9th Aug 2021 From CM House</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/a_booklet_on_modus_operandi_of_financial_fraudsters.pdf')" style="cursor: pointer;">A Booklet On Modus Operandi Of Financial Fraudsters</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/5_6296318195036848978.pdf')" style="cursor: pointer;">RBI Nank Modus Operandi and Precautions to be taken against Fraudulent Transactions Banks </a></td> 
				</tr>
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/all_medical_test_description.pdf')" style="cursor: pointer;">Blood Tests(Normal Value And Its Importance ) Complete Blood Count</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>01/01/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Digital_Calendar_2022(Captions)_1_to_14.pdf')" style="cursor: pointer;">Digital Calendar 2022,&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/calender_F_2022_23.11.2021.pdf')" style="cursor: pointer;">Calender 2022,&nbsp;</a>
				<a onClick="add_task('MISCELLANEOUS/Calander_2022_Original.pdf')" style="cursor: pointer;">Calender 2022</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/how_to_enable_internet_explorer_mode_in_windows_11.jpg')" style="cursor: pointer;">How To Enable Internet Explorer Mode In Windows 11</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/Agastya_Ayurveda_Clinic_NewsLette__May_2022_Final_7th_july.pdf')" style="cursor: pointer;">I Am Pleased To Announce That Agasthya Ayurveda Clinic Is Releasing A Monthly Newsletter</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>17/08/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/how_technology_can_help_eliminate_fake_certificates.jpg')" style="cursor: pointer;">How Technology Can Help Eliminate Fake Certificates</a></td> 
				</tr>
				<tr>
				<td></td>
				<td>08/09/2022</td> 
				<td>&nbsp;&nbsp;&nbsp;</td>
				<td><a onClick="add_task('MISCELLANEOUS/4417318e-5274-4002-8199-d54357c70f5a.pdf')" style="cursor: pointer;">Compendium of Academic Courses After +2</a></td> 
				</tr>
				<tr>
					<td></td>
					<td>23/05/2016</td> 
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td><a onClick="add_task('miscellaneous/SOP-for-VOA-for-PAK-Nationals.doc')" style="cursor: pointer;">SOP For VOA For Pakishtan Nationals (DOC)</a>
					<a onClick="add_task('miscellaneous/SOP-for-VOA-for-PAK-Nationals.pdf')" style="cursor: pointer;">&nbsp;[pdf]</a></td>
				</tr>
			</tbody>
		</table>
		</div>
		</section>
		</div>
		<!--   ************************END miscellaneous DIV*******************END miscellaneous DIV*****************END miscellaneous***************END miscellaneous*******  -->
		<!--   ************END TTP_15_16_Dec_2016 DIV*******END TTP_15_16_Dec_2016 DIV*******END TTP_15_16_Dec_2016 DIV************END TTP_15_16_Dec_2016 DIV********  -->
		<!--
		<footer class="bg-dark footer">
		  <div class="container">
			<div class="row">
			  <div class="col-sm-4"><a href="https://boi.gov.in/"><img src="images/boi_logo.png" alt="boi-logo"/></a></div>
			  <div class="col-sm-4 text-white text-center mt-3"> Content managed by Ministry of Home Affairs(MHA)<br/>
				Designed &amp; Developed by NIC </div>
			  <div class="col-sm-4 text-end"><a href="https://www.nic.in/"><img src="images/nic-logo.png" alt="nic logo"/></a></div>
			</div>
		  </div>
		</footer> --> 

		<script>
/////////////////// Total Arrival Footfall /////////////////////
let counts_arr_total_pax = setInterval(updated_arr_total_pax);
        let upto_arr_total_pax = <%=(total_Arrival_Count)-2000%>;
        function updated_arr_total_pax() {
            upto_arr_total_pax = ++upto_arr_total_pax;
            document.getElementById('countArr').innerHTML = upto_arr_total_pax.toLocaleString('en-IN');
            if (upto_arr_total_pax === <%=total_Arrival_Count%>) {
                clearInterval(counts_arr_total_pax);
            }
        }

let counts_yest_arr_pax = setInterval(updated_yest_arr_pax);
        let upto_yest_arr_pax = <%=(yesterday_Arrival_Count)-2000%>;
        function updated_yest_arr_pax() {
            upto_yest_arr_pax = ++upto_yest_arr_pax;
            document.getElementById('countArrY').innerHTML = upto_yest_arr_pax.toLocaleString('en-IN');
            if (upto_yest_arr_pax === <%=yesterday_Arrival_Count%>) {
                clearInterval(counts_yest_arr_pax);
            }
        }

let counts_today_arr_pax = setInterval(updated_today_arr_pax);
        let upto_today_arr_pax = <%=(today_Arrival_Count)-2000%>;
        function updated_today_arr_pax() {
            upto_today_arr_pax = ++upto_today_arr_pax;
            document.getElementById('countArrT').innerHTML = upto_today_arr_pax.toLocaleString('en-IN');
            if (upto_today_arr_pax === <%=today_Arrival_Count%>) {
                clearInterval(counts_today_arr_pax);
            }
        }
/////////////////////////////////Total Departure Footfalls ///////////////////////////////////////


let counts_dep_pax = setInterval(updated_dep_pax);
        let upto_dep_pax = <%=(total_Dep_Count)-2000%>;
        function updated_dep_pax() {
            upto_dep_pax = ++upto_dep_pax;
            document.getElementById('count_total_Dep_Count').innerHTML = upto_dep_pax.toLocaleString('en-IN');
            if (upto_dep_pax === <%=total_Dep_Count%>) {
                clearInterval(counts_dep_pax);
            }
        }

let counts_yest_dep_pax = setInterval(updated_yest_dep_pax);
        let upto_yest_dep_pax = <%=(yest_Dep_Count)-2000%>;
        function updated_yest_dep_pax() {
            upto_yest_dep_pax = ++upto_yest_dep_pax;
            document.getElementById('count_total_Dep_CountY').innerHTML = upto_yest_dep_pax.toLocaleString('en-IN');
            if (upto_yest_dep_pax === <%=yest_Dep_Count%>) {
                clearInterval(counts_yest_dep_pax);
            }
        }

let counts_today_dep_pax = setInterval(updated_today_dep_pax);
        let upto_today_dep_pax = <%=(today_Dep_Count)-2000%>;
        function updated_today_dep_pax() {
            upto_today_dep_pax = ++upto_today_dep_pax;
            document.getElementById('count_total_Dep_CountT').innerHTML = upto_today_dep_pax.toLocaleString('en-IN');
            if (upto_today_dep_pax === <%=today_Dep_Count%>) {
                clearInterval(counts_today_dep_pax);
            }
        }
///////////////////////////// Total Footfalls ///////////////////////////////////

let counts_total_pax = setInterval(updated_total_pax);
        let upto_total_pax = <%=(total_PAX_Count)-2000%>;
        function updated_total_pax() {
            upto_total_pax = ++upto_total_pax;
            document.getElementById('total_PAX').innerHTML = upto_total_pax.toLocaleString('en-IN');
            if (upto_total_pax === <%=total_PAX_Count%>) {
                clearInterval(counts_total_pax);
            }
        }

let counts_yest_total_pax = setInterval(updated_yest_total_pax);
        let upto_yest_total_pax = <%=(total_Yest_Count)-2000%>;
        function updated_yest_total_pax() {
            upto_yest_total_pax = ++upto_yest_total_pax;
            document.getElementById('total_PAX_Y').innerHTML = upto_yest_total_pax.toLocaleString('en-IN');
            if (upto_yest_total_pax === <%=total_Yest_Count%>) {
                clearInterval(counts_yest_total_pax);
            }
        }

let counts_today_total_pax = setInterval(updated_today_total_pax);
        let upto_today_total_pax = <%=(total_Today_PAX_Count)-2000%>;
        function updated_today_total_pax() {
            upto_today_total_pax = ++upto_today_total_pax;
            document.getElementById('total_PAX_T').innerHTML = upto_today_total_pax.toLocaleString('en-IN');
            if (upto_today_total_pax === <%=total_Today_PAX_Count%>) {
                clearInterval(counts_today_total_pax);
            }
        }
///////////////////////////// Total Arrival Flights //////////////////////////////////////

let counts_arr_flights = setInterval(updated_arr_flights);
        let upto_arr_flights = <%=(total_Arrival_Flights)-2000%>;
        function updated_arr_flights() {
            upto_arr_flights = ++upto_arr_flights;
            document.getElementById('countArrFlt').innerHTML = upto_arr_flights.toLocaleString('en-IN');
            if (upto_arr_flights === <%=total_Arrival_Flights%>) {
                clearInterval(counts_arr_flights);
            }
        }

let counts_yest_flights = setInterval(updated_yest_flights);
        let upto_yest_flights = 10;
        function updated_yest_flights() {
            upto_yest_flights = ++upto_yest_flights;
            document.getElementById('countArrFltY').innerHTML = upto_yest_flights.toLocaleString('en-IN');
            if (upto_yest_flights === <%=yest_Flight_Count%>) {
                clearInterval(counts_yest_flights);
            }
        }

let counts_today_flights = setInterval(updated_today_flights);
        let upto_today_flights = 10;
        function updated_today_flights() {
            upto_today_flights = ++upto_today_flights;
            document.getElementById('countArrFltT').innerHTML = upto_today_flights.toLocaleString('en-IN');
            if (upto_today_flights === <%=arr_Flight_Count%>) {
                clearInterval(counts_today_flights);
            }
        }
//////////////////////////////////////// Total Departure Flights ////////////////////////////////////////


let counts_dep_flights = setInterval(updated_dep_flights);
        let upto_dep_flights = <%=(total_Dep_Flights)-2000%>;
        function updated_dep_flights() {
            upto_dep_flights = ++upto_dep_flights;
            document.getElementById('count_total_Dep_Flights').innerHTML = upto_dep_flights.toLocaleString('en-IN');
            if (upto_dep_flights === <%=total_Dep_Flights%>) {
                clearInterval(counts_dep_flights);
            }
        }
let counts_yest_dep_flights = setInterval(updated_yest_dep_flights);	
        let upto_yest_dep_flights = 10;
        function updated_yest_dep_flights() {
            upto_yest_dep_flights = ++upto_yest_dep_flights;
            document.getElementById('count_total_Dep_FlightsY').innerHTML = upto_yest_dep_flights.toLocaleString('en-IN');
            if (upto_yest_dep_flights === <%=yest_Dep_Flights%>) {
                clearInterval(counts_yest_dep_flights);
            }
        }

let counts_today_dep_flights = setInterval(updated_today_dep_flights);
        let upto_today_dep_flights = 10;
        function updated_today_dep_flights() {
            upto_today_dep_flights = ++upto_today_dep_flights;
            document.getElementById('count_total_Dep_FlightsT').innerHTML = upto_today_dep_flights.toLocaleString('en-IN');
            if (upto_today_dep_flights === <%=today_Dep_Flights%>) {
                clearInterval(counts_today_dep_flights);
            }
        }
/////////////////////////////////////// Total Flights //////////////////////////////////////////////////////////////////

let counts_total_flights = setInterval(updated_total_flights);
        let upto_total_flights = <%=(total_Flights_Count)-2000%>;
        function updated_total_flights() {
            upto_total_flights = ++upto_total_flights;
            document.getElementById('total_Flights').innerHTML = upto_total_flights.toLocaleString('en-IN');
            if (upto_total_flights === <%=total_Flights_Count%>) {
                clearInterval(counts_total_flights);
            }
        }

let counts_yest_total_flights = setInterval(updated_yest_total_flights);
        let upto_yest_total_flights = 10;
        function updated_yest_total_flights() {
            upto_yest_total_flights = ++upto_yest_total_flights;
            document.getElementById('total_Flights_Y').innerHTML = upto_yest_total_flights.toLocaleString('en-IN');
            if (upto_yest_total_flights === <%=total_Flights_Count_Yest%>) {
                clearInterval(counts_yest_total_flights);
            }
        }

let counts_today_total_flights = setInterval(updated_today_total_flights);
        let upto_today_total_flights = 10;
        function updated_today_total_flights() {
            upto_today_total_flights = ++upto_today_total_flights;
            document.getElementById('total_Flights_T').innerHTML = upto_today_total_flights.toLocaleString('en-IN');
            if (upto_today_total_flights === <%=total_Flights_Count_Today%>) {
                clearInterval(counts_today_total_flights);
            }
        }
//////////////////////////////////////////////////////////////////////////////////////////////

const counterAnim = (qSelector, start = 0, end, duration = 1000) => {
 const target = document.querySelector(qSelector);
 let startTimestamp = null;
 const step = (timestamp) => {
  if (!startTimestamp) startTimestamp = timestamp;
  const progress = Math.min((timestamp - startTimestamp) / duration, 1);
  target.innerText = Math.floor(progress * (end - start) + start);
  if (progress < 1) {
   window.requestAnimationFrame(step);
  }
 };
 window.requestAnimationFrame(step);
};

document.addEventListener("DOMContentLoaded", () => {		
 counterAnim("#count1", 10, 3500, 200);
 counterAnim("#count2", 1000, 54646, 2200);
 counterAnim("#count3", 5000, 9898, 2200);
 counterAnim("#count4", 500, 342329, 2200);
 counterAnim("#count5", 10, 5454, 2200);
 counterAnim("#count6", 50, 224, 2200);

counterAnim("#countArr", 50, <%=total_Arrival_Count%>, 2200);
counterAnim("#countArrY", 50, <%=yesterday_Arrival_Count%>, 2200);
counterAnim("#countArrT", 50, <%=today_Arrival_Count%>, 2200);

counterAnim("#count_total_Dep_Count", 50, <%=total_Dep_Count%>, 2200);
counterAnim("#count_total_Dep_CountY", 50, <%=yest_Dep_Count%>, 2200);
counterAnim("#count_total_Dep_CountT", 50, <%=today_Dep_Count%>, 2200);

counterAnim("#total_PAX", 50, <%=total_PAX_Count%>, 2200);
counterAnim("#total_PAX_Y", 50, <%=total_Yest_Count%>, 2200);
counterAnim("#total_PAX_T", 50, <%=total_Today_PAX_Count%>, 2200);



counterAnim("#countArrFlt", 50, <%=total_Arrival_Flights%>, 2200);
counterAnim("#countArrFltY", 50, <%=yest_Flight_Count%>, 2200);
counterAnim("#countArrFltT", 50, <%=arr_Flight_Count%>, 2200);

counterAnim("#count_total_Dep_Flights", 50, <%=total_Dep_Flights%>, 2200);
counterAnim("#count_total_Dep_FlightsY", 50, <%=yest_Dep_Flights%>, 2200);
counterAnim("#count_total_Dep_FlightsT", 50, <%=today_Dep_Flights%>, 2200);

counterAnim("#total_Flights", 50, <%=total_Flights_Count%>, 2200);
counterAnim("#total_Flights_Y", 50, <%=total_Flights_Count_Yest%>, 2200);
counterAnim("#total_Flights_T", 50, <%=total_Flights_Count_Today%>, 2200);



});
</script>

<%
} catch (Exception e) {
e.printStackTrace();
} finally {
if (con != null)
	con.close();

}

%>

		</body>
		</html>
