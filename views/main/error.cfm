<cfsilent>
	<cfset RootCause = request.exception.RootCause />
	<cfif arrayLen(RootCause.tagContext) gt 0 >
		<cfset exception = RootCause.tagContext[1] />
	</cfif>
	<cfmail to="kjohn@kjsbh.com" from="homeplace-support@homeplacefurnace.com" username="homeplace-support@homeplacefurnace.com" subject="Error - #RootCause.message#" server="smtp.gmail.com" type="html" password="Asdfg5432!" port="465" usessl="true">
		<cfdump var="#request#" label="request" />
		<cfdump var="#cgi#" label="cgi" />
	</cfmail>
</cfsilent>
<cfoutput>
	<div class="container">
		<div class="page-header">
			<h1>#application.applicationname#</h1>
		</div>
		<div class="alert alert-error">
			<h3 class="alert-heading">Error!</h3>
			<p>
				<ul>
					<li><strong>Action:</strong> #request.action#</li>
					<li><strong>Message:</strong> #RootCause.message#</li>
					<li><strong>Event Name:</strong> #request.exception.name#</li>
					<li><strong>Type:</strong> #RootCause.type#</li>
					<cfif len(request.exception.detail)>
						<li><strong>Detail:</strong> #request.exception.detail#</li>
					</cfif>

				</ul>
			</p>
		</div>
		<cfif isDefined("exception")>
			<div class="well">
				<h4>More Details:</h4>
				<ul>
					<li>Line: <span>#exception.line#</span></li>
					<li>Template: <span>#exception.template#</span></li>
					<li>Type: <span>#exception.type#</span></li>
					<cfif structKeyExists(RootCause, "SQLState") AND len(RootCause.SQLState)>
						<li>SQL State: #RootCause.SQLState#</li>
					</cfif>
					<cfif structKeyExists(RootCause, "detail") AND len(RootCause.detail)>
						<li><strong>Detail:</strong> #RootCause.detail#</li>
					</cfif>
				</ul>

				<cfif structKeyExists(exception, "codePrintHTML") >
					<h5>Code</h5>
					<pre class="prettyprint">#exception.codePrintHTML#</pre>
				</cfif>
				<cfif structKeyExists(RootCause, "sql") >
					<h5>SQL</h5>
					<pre class="prettyprint lang-sql">#RootCause.sql#</pre>
				</cfif>
				<h5>Stack Trace</h5>
				<pre class="">#RootCause.StackTrace#</pre>
			</div>
		</cfif>
	</div>
</cfoutput>
