<cfset rc.title = "Report No Phone" />	<!--- set a variable to be used in a layout --->
<cfoutput>
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li><a href="#buildURL( 'main' )#">Home</a> <span class="divider">/</span></li>
				<li><a href="#buildURL( 'report' )#">Report</a> <span class="divider">/</span></li><!-- /active -->
				<li class="active">No Phone</li><!-- /active -->
			</ul><!-- /breadcrumb -->
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	#view( "helpers/messages" )#
	<div class="row-fluid">
		<div class="page-header"><h4>Customers with No Phone Number</h4></div>
		<cfmodule template="/customtags/callreport.cfm" callLog="#rc.nophone#"/>
	</div>
</cfoutput>
<cfsavecontent variable="headerHTML">
	<link rel="stylesheet" type="text/css" href="/assets/css/callReport.css" media="print"/>
</cfsavecontent>
<cfhtmlhead text="#headerHTML#" />