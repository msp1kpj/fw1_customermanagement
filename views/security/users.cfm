<cfset rc.title = "Default View" />	<!--- set a variable to be used in a layout --->
<cfoutput>
	<div class="container">
		<div class="row">
			<div class="page-header page-header-custom">
				<h3 class="fontZrnic">Users</h3>
			</div>
			<ul class="breadcrumb">
				<li><a class="tip-bottom" href="#buildURL( 'main' )#" data-original-title="Go to Home"><i class="icon-home"></i></a><span class="divider">/</span></li>
			</ul>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<cfif ArrayLen( rc.users )>
					<table class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>Name</th>
								<th>E-Mail Address</th>
								<th>Last Updated</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="4">&nbsp;</td>
							</tr>
						</tfoot>
						<tbody>
							<cfloop array="#rc.users#" index="User">
								<cfset action = buildURL( action='security.user', queryString = { userid = User.getUserID() } ) />
								<tr>
									<td><a href="#action#" title="Edit #User.getName()#">#User.getName()#</a></td>
									<td><a href="mailto:#User.getEmailAddress()#" title="Send mail to #User.getName()# at #User.getEmailAddress()#">#User.getEmailAddress()#</a></td>
									<td>#DateFormat(User.getDateLastModified(), "full" )# #TimeFormat( User.getDateLastModified() )#</td>
									<td>
										<a href="#action#" title="Edit #User.getName()#"><i class="icon-edit"></i></a>
										<cfset action = buildURL( action ='secuity.userdelete', queryString = { userid = User.getUserID() } ) />
										<cfif User.getUserID() neq rc.CurrentUser.getUserID()><a href="#action#" title="Delete #User.getName()#"><i class="icon-remove"></i></a></cfif>
									</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				<cfelse>
					<p>There are no user accounts.</p>
				</cfif>
			</div>
		</div>
	</div>
</cfoutput>