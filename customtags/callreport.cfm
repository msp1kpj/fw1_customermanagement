
<cfswitch expression="#THISTAG.ExecutionMode#">
	<cfcase value="Start">
		<!--- Start tag processing --->
		<cfparam name="attributes.calllog" type="query"/>
	</cfcase>
	<cfcase value="End">
		<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="tblCallList">
			<tbody>
				<cfoutput query="attributes.calllog" group="customerId">
				<tr>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered">
							<tr>
								<th width="200px" rowspan="2"><a href="/?action=account.edit&customerId=#attributes.calllog.customerId#">#attributes.calllog.lastname#, #attributes.calllog.firstname#</a></th>
								<th width="40%">#attributes.calllog.address#</th>
								<th width="40%">#attributes.calllog.city#</th>
								<th width="150px" nowrap="true">#phoneFormat(attributes.calllog.phone)#</th>
							</tr>
							<tr>
								<td colspan="3">
									<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered">
										<tr class="noprint">
											<th>Date</th>
											<th>Service</th>
											<th>Amount</th>
											<th>Tech</th>
											<th>Notes</th>
										</tr>
										<cfoutput>
										<tr>
											<td width="75px">#DateFormat(attributes.calllog.dateOfService, "mm/dd/yyyy")#</td>
											<td width="30%">#attributes.calllog.ServiceDescription#</td>
											<td width="75px">#NumberFormat(attributes.calllog.amount,"$,.00")#</td>
											<td width="150px">#attributes.calllog.technician#</td>
											<td>#attributes.calllog.ServiceNote#</td>
										</tr>
										</cfoutput>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				</cfoutput>
			</tbody>
		</table>

	</cfcase>
</cfswitch>

<cfscript>
	/**
	 * Allows you to specify the mask you want added to your phone number.
	 * v2 - code optimized by Ray Camden
	 * v3.01
	 * v3.02 added code for single digit phone numbers from John Whish
	 * v4 make a default format - by James Moberg
	 *
	 * @param varInput      Phone number to be formatted. (Required)
	 * @param varMask      Mask to use for formatting. x represents a digit. Defaults to (xxx) xxx-xxxx (Optional)
	 * @return Returns a string.
	 * @author Derrick Rapley (adrapley@rapleyzone.com)
	 * @version 4, February 11, 2011
	 */
	public string function phoneFormat(varInput) {
		var curPosition = "";
		var i = "";
		var varMask = "(xxx) xxx-xxxx";
		var newFormat = "";
		var startpattern = "";
		if (arrayLen(arguments) gte 2){ varMask = arguments[2]; }
		newFormat = trim(ReReplace(varInput, "[^[:digit:]]", "", "all"));
		startpattern = ReReplace(ListFirst(varMask, "- "), "[^x]", "", "all");
		if (Len(newFormat) gte Len(startpattern)) {
			varInput = trim(varInput);
			newFormat = " " & reReplace(varInput,"[^[:digit:]]","","all");
			newFormat = reverse(newFormat);
			varmask = reverse(varmask);
			for (i=1; i lte len(trim(varmask)); i=i+1) {
				curPosition = mid(varMask,i,1);
				if(curPosition neq "x") newFormat = insert(curPosition,newFormat, i-1) & " ";
			}
			newFormat = reverse(newFormat);
			varmask = reverse(varmask);
		}
		return trim(newFormat);
	}
</cfscript>