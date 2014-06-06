<cfimport prefix="ui" taglib="/customtags/" />
<cfset rc.title = "Report Dashboard" />	<!--- set a variable to be used in a layout --->
<cfquery name="GroupYear" dbtype="query">
	SELECT ServiceCallYear
	FROM rc.chart.callData
	GROUP BY ServiceCallYear
</cfquery>
<cfoutput>
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li><a href="#buildURL( 'main' )#">Home</a> <span class="divider">/</span></li>
				<li class="active">Report</li><!-- /active -->
			</ul><!-- /breadcrumb -->
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	#view( "helpers/messages" )#
	<div class="row-fluid">
		<div class="span6">
			<div class="page-header"><h4>Call Volume</h4></div>
			<div class="chart">
				<div id="placeholder" class="placeholder"></div>
			</div>
		</div>
		<div class="span6">
			<div class="page-header"><h4>Montly Call Reports</h4></div>
			<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="tblCallList">
				<thead>
					<tr>
						<th>Month</th>
						<th>Call Volume</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
				</tfoot>
				<tbody>
					<cfif structkeyexists(rc, "callSummary") and isQuery(rc.callSummary) and rc.callSummary.recordcount gt 0>
						<cfloop query="rc.callSummary">
							<tr>
								<td>#DateFormat(rc.callSummary.ServiceCallMonth, "yyyy-mmmm")#</td>
								<td>#rc.callSummary.Calls#</td>
								<td width="75px">
									<div class="btn-group pull-right">
										<a class="btn" href="#buildURL(  action = "report.calllog",  queryString = "month=" & DateFormat(rc.callSummary.ServiceCallMonth, "mm/dd/yyyy"))#"><i class="icon-list"></i></a>
										<a class="btn" href="#buildURL(  action = "report.calllogprint",  queryString = "month=" & DateFormat(rc.callSummary.ServiceCallMonth, "mm/dd/yyyy"))#"><i class="icon-print"></i></a>
									</div>
								</td>
							</tr>
						</cfloop>
					<cfelse>
						<tr>
							<td colspan="3">No Records Found.</td>
						</tr>
					</cfif>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row-fluid">
		<div class="span6">
			<cfset topX = 0 />
			<cfset ofX = 0 />
			<cfif structKeyExists(rc, "nophone") and structKeyExists(rc.nophone, "query1")  and isQuery(rc.nophone.query1)>
				<cfset topX = rc.nophone.query1.recordcount />
			</cfif>
			<cfif structKeyExists(rc, "nophone") and structKeyExists(rc.nophone, "query2")  and isQuery(rc.nophone.query2)>
				<cfset ofX = rc.nophone.query2.Total />
			</cfif>
			<div class="page-header"><a class="btn pull-right" href="#buildURL(  action = "report.nophone" )#"><i class="icon-list"></i></a><h4>Customers With No Phone (Top #topX# of #ofX#)</h4></div>
			<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="tblCallList">
				<thead>
					<tr>
						<th>Customer</th>
						<th>Last Service Date</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
				</tfoot>
				<tbody>
					<cfif structKeyExists(rc, "nophone") and structKeyExists(rc.nophone, "query1")  and structKeyExists(rc.nophone, "query2") and isQuery(rc.nophone.query1) and isQuery(rc.nophone.query2) and rc.nophone.query1.recordcount gt 0>
						<cfloop query="rc.nophone.query1" endrow="5">
							<tr>
								<td><a href="#buildURL(  action = "account.edit", queryString = "customerId=" & rc.nophone.query1.customerId & "&chk=" & hash(rc.nophone.query1.customerId) )#">#rc.nophone.query1.lastName#</a></td>
								<td width="135px">#DateFormat(rc.nophone.query1.dateOfService, "yyyy-mmmm")#</td>
								<td width="45px"><a class="btn pull-right" href="#buildURL(  action = "account.edit", queryString = "customerId=" & rc.nophone.query1.customerId & "&chk=" & hash(rc.nophone.query1.customerId) )#"><i class="icon-edit"></i></a></td>
							</tr>
						</cfloop>
					<cfelse>
						<tr>
							<td colspan="3">Congratulation No records Found</td>
						</tr>
					</cfif>
				</tbody>
			</table>
		</div>
		<cfset topX = 0 />
		<cfset ofX = 0 />
		<cfif structKeyExists(rc, "noservice") and structKeyExists(rc.noservice, "query1") and isQuery(rc.noservice.query1) and rc.noservice.query1.recordcount gt 0>
			<cfset topX = rc.noservice.query1.recordcount />
		</cfif>
		<cfif structKeyExists(rc, "noservice") and structKeyExists(rc.noservice, "query2")  and isQuery(rc.noservice.query2)>
			<cfset ofX = rc.noservice.query2.Total />
		</cfif>
		<div class="span6">
			<div class="page-header"><a class="btn pull-right" href="#buildURL(  action = "report.noservicecall" )#"><i class="icon-list"></i></a><h4>Customers With No Future Service Call (Top #topX# of #ofX#)</h4></div>
			<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="tblCallList">
				<thead>
					<tr>
						<th>Customer</th>
						<th width="135px">Last Service Date</th>
						<th width="45px">&nbsp;</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
				</tfoot>
				<tbody>
					<cfif structKeyExists(rc, "noservice") and structKeyExists(rc.noservice, "query1") and isQuery(rc.noservice.query1) and rc.noservice.query1.recordcount gt 0>
						<cfloop query="rc.noservice.query1" endrow="5">
							<tr>
								<td><a href="#buildURL(  action = "account.edit", queryString = "customerId=" & rc.noservice.query1.customerId & "&chk=" & hash(rc.noservice.query1.customerId) )#">#rc.noservice.query1.lastName#</a></td>
								<td width="135px">#DateFormat(rc.noservice.query1.dateOfService, "yyyy-mmmm")#</td>
								<td width="45px"><a class="btn pull-right" href="#buildURL(  action = "account.edit", queryString = "customerId=" & rc.noservice.query1.customerId & "&chk=" & hash(rc.noservice.query1.customerId) )#"><i class="icon-edit"></i></a></td>
							</tr>
						</cfloop>
					<cfelse>
						<tr>
							<td colspan="3">Congratulation No records Found</td>
						</tr>
					</cfif>
				</tbody>
			</table>
		</div>
	</div>
</cfoutput>
<cfmodule template="/customtags/htmlfoot.cfm">
	<script type="text/javascript" src="/assets/js/excanvas.min.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.flot.min.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.flot.canvas.min.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.flot.time.min.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.flot.resize.min.js"></script>
	<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/datejs/1.0/date.min.js"></script>

	<cfset ServiceCallYearList = valueList(rc.chart.callData.ServiceCallYear) />
	<cfset ServiceCallYearMin = listFirst(ServiceCallYearList) />
	<cfset ServiceCallYearMax = listLast(ServiceCallYearList) />
	<cfset ServiceCallData = StructNew() />

	<!--- create year month struct to hold data --->
	<cfloop from="#ServiceCallYearMin#" to="#ServiceCallYearMax#" index="ServiceCallYear">
		<cfset ServiceCallData[ServiceCallYear] = StructNew() />
		<cfset CallMonth = 0 />
		<cfloop from="1" to="12" index="CallMonth">
			<cfset ServiceCallData[ServiceCallYear][CallMonth] = 0 />
		</cfloop>
	</cfloop>

	<!--- Populate year month struct with actual data --->
	<cfloop query="rc.chart.callData">
		<cfset ServiceCallData[rc.chart.callData.ServiceCallYear][Month(rc.chart.callData.ServiceCallMonth)] = rc.chart.callData.calls />
	</cfloop>

	<script type="text/javascript">

	$(function() {

		var data = [
			//{ data: oilPrices, label: "Oil price ($)" },
			//{ data: exchangeRates, label: "USD/EUR exchange rate", yaxis: 2 }
			<cfloop from="#ServiceCallYearMin#" to="#ServiceCallYearMax#" index="ServiceCallYear">
			<cfoutput>
				{
					label:"#ServiceCallYear# Calls"
					, data:[
					<cfloop from="1" to="12" index="CallMonth">
						[#int(DateDiff("s",DateConvert("utc2Local", "January 1 1970 00:00"), (CallMonth&"/02/"&Year(now())) )*1000)#, #ServiceCallData[ServiceCallYear][CallMonth]#],
					</cfloop>
					]
				},
				</cfoutput>
			</cfloop>
		];

		var options = {
			canvas: true
			, xaxes: [ { mode: "time", timeformat: "%b"} ]
			, legend: { position: "sw" }
			, lines: { show: true, fill: true}
			, points: { show: true }
			, grid: { hoverable: true, clickable: true, borderWidth: 1}
		}

		$.plot("#placeholder", data, options);

		// Add the Flot version string to the footer
		$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");

		var previousPoint = null;
		$("#placeholder").bind("plothover", function (event, pos, item) {
			if (item) {
				if (previousPoint != item.datapoint) {
					previousPoint = item.datapoint;
					$("#tooltip").remove();
					showTooltip(item.pageX, item.pageY, '(' + $.plot.formatDate(new Date(item.datapoint[0]),"%b") + ', ' + item.datapoint[1]+')');
				}
			} else {
				$("#tooltip").remove();
				previousPoint = null;
			}
		});

		$("#placeholder").bind("plotclick", function (event, pos, item) {
			if (item) {
				var href = "<cfoutput>#buildURL(  action = "report.calllog" )#</cfoutput>&month=" + new Date(item.datapoint[0]).toString("MM/dd/") + item.series.label.replace(/[^0-9]+/g, '')
				;
				window.location.href = href;
			}
		});

		function showTooltip(x, y, contents) {
		    $('<div id="tooltip">' + contents + '</div>').css( {
		        position: 'absolute',
		        display: 'none',
		        top: y + 5,
		        left: x + 5,
		        border: '1px solid #fdd',
		        padding: '2px',
		        'background-color': '#fee',
		        opacity: 0.80
		    }).appendTo("body").fadeIn(200);
		}
	});

	</script>
</cfmodule>
<cfsavecontent variable="headerHTML">
	<style>
		.chart {margin: 10px auto; width: 100%; height: 300px; min-height: 150px; }
		.placeholder {width: 100%;height: 100%;font-size: 14px;line-height: 1.2em;}
		.page-header {color: #5a5a5a;}
	</style>
</cfsavecontent>
<cfhtmlhead text="#headerHTML#" />
