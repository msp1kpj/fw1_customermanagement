<cfquery name="GroupCall" dbtype="query">
	SELECT customerId
	FROM rc.calllog
	GROUP BY customerId
</cfquery>
<style type="text/css"><cfinclude template="/assets/css/general.css"/></style>
<h5 class="recordcount">Total Records: <cfoutput>#GroupCall.recordCount#</cfoutput></h5>
<table cellpadding="0" cellspacing="0" border="1" width="100%"	>
	<tr class="subheader1">
		<td class="subheader1" width="100" style="background-color: #CCCCCC;text-align: left; color: #003399; font-family: verdana, arial; font-size: medium; font-weight: bold; border-top: 0px; border-left: 0px; border-right: 0px; border-bottom: 3px; border-color: #000000; border-style: solid;" >Name</td>
		<td class="subheader1" style="background-color: #CCCCCC;text-align: left; color: #003399; font-family: verdana, arial; font-size: medium; font-weight: bold; border-top: 0px; border-left: 0px; border-right: 0px; border-bottom: 3px; border-color: #000000; border-style: solid;">Address</td>
		<td class="subheader1" width="165" style="background-color: #CCCCCC;text-align: left; color: #003399; font-family: verdana, arial; font-size: medium; font-weight: bold; border-top: 0px; border-left: 0px; border-right: 0px; border-bottom: 3px; border-color: #000000; border-style: solid;">City</td>
		<td class="subheader1" width="100" style="background-color: #CCCCCC;text-align: left; color: #003399; font-family: verdana, arial; font-size: medium; font-weight: bold; border-top: 0px; border-left: 0px; border-right: 0px; border-bottom: 3px; border-color: #000000; border-style: solid;">Phone</td>
	</tr>
	<cfoutput query="rc.calllog" group="customerId">
	<tr>
		<td class="content1" rowspan="2" valign="top" style="color: ##000000; font-family: verdana, arial; font-size: small; font-weight: bold;">#rc.calllog.lastname#, #rc.calllog.firstname#</td>
		<td class="content1" nowrap="true" valign="top" style="color: ##000000; font-family: verdana, arial; font-size: small; font-weight: bold;">#rc.calllog.address#</td>
		<td class="content1" nowrap="true" valign="top" style="color: ##000000; font-family: verdana, arial; font-size: small; font-weight: bold;">#rc.calllog.city#</td>
		<td class="content1" nowrap="true" valign="top" style="color: ##000000; font-family: verdana, arial; font-size: small; font-weight: bold;"><font class="phone" style="color: ##FF0033;">#phoneFormat(rc.calllog.phone)#</font></td>
	</tr>
	<tr>
		<td colspan="3">
			<table cellpadding="2" cellspacing="0" border="1" width="100%">
				<cfoutput>
				<tr>
					<td class="content2" nowrap="true" valign="top" width="75" style="color: ##000000; font-family: verdana, arial; font-size: xx-small; font-weight: normal;">#DateFormat(rc.calllog.dateOfService, "mm/dd/yyyy")#</td>
					<td class="content2" nowrap="true" valign="top" width="150" style="color: ##000000; font-family: verdana, arial; font-size: xx-small; font-weight: normal;">#rc.calllog.ServiceDescription#</td>
					<td class="content2" nowrap="true" valign="top" width="75" align="right" style="padding-right:15px;color: ##000000; font-family: verdana, arial; font-size: xx-small; font-weight: normal;">#NumberFormat(rc.calllog.amount,"$,.00")#</td>
					<td class="content2" nowrap="true" valign="top" width="150"	 style="color: ##000000; font-family: verdana, arial; font-size: xx-small; font-weight: normal;">#rc.calllog.technician#&nbsp;</td>
					<td class="content2" style="color: ##000000; font-family: verdana, arial; font-size: xx-small; font-weight: normal;">#rc.calllog.ServiceNote#&nbsp;</td>
				</tr>
				</cfoutput>
			</table>
		</td>
	</tr>
	</cfoutput>
</table>
