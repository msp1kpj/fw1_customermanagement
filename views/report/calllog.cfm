<cfset rc.title = "Report Dashboard" />	<!--- set a variable to be used in a layout --->
<cfquery name="GroupCall" dbtype="query">
	SELECT customerId
	FROM rc.calllog
	GROUP BY customerId
</cfquery>
<cfoutput>
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li><a href="#buildURL( 'main' )#">Home</a> <span class="divider">/</span></li>
				<li><a href="#buildURL( 'report' )#">Report</a> <span class="divider">/</span></li><!-- /active -->
				<li class="active">Call Log Report</li><!-- /active -->
			</ul><!-- /breadcrumb -->
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	#view( "helpers/messages" )#
	<div class="row-fluid">
		<div class="page-header"><h4>Call Log Report for #DateFormat(rc.month, "yyyy-mmmm")# having #GroupCall.recordCount# Call records</h4></div>
		<cfmodule template="/customtags/callreport.cfm" callLog="#rc.calllog#"/>
	</div>
</cfoutput>
<cfsavecontent variable="headerHTML">
	<link rel="stylesheet" type="text/css" href="/assets/css/callReport.css" media="print"/>
</cfsavecontent>
<cfhtmlhead text="#headerHTML#" />