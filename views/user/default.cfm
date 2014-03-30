<cfset rc.title = "Default View" />	<!--- set a variable to be used in a layout --->
<cfset action = buildURL( action ='user.profile', queryString = { userid = 0, chk = session.userEdit } ) />
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
		#view( "helpers/messages" )#
		<div class="row-fluid">
			<div class="span12">
				<cfif ArrayLen( rc.users )>
					<table class="table table-striped table-bordered table-condensed" id="tblUserList">
						<thead>
							<tr>
								<th>Name</th>
								<th>E-Mail Address</th>
								<th>Last Updated</th>
								<th><a title="Click to add service information." class="btn add pull-right" href="#action#" ><i class="icon-plus"></i></a></th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="4">&nbsp;</td>
							</tr>
						</tfoot>
						<tbody>
							<cfloop array="#rc.users#" index="User">
								<cfset action = buildURL( action='user.profile', queryString = { userid = User.getUserID(), chk = session.userEdit } ) />
								<tr>
									<td><a href="#action#" title="Edit #User.getName()#">#User.getName()#</a></td>
									<td><a href="mailto:#User.getEmailAddress()#" title="Send mail to #User.getName()# at #User.getEmailAddress()#">#User.getEmailAddress()#</a></td>
									<td>#DateFormat(User.getDateLastModified(), "full" )# #TimeFormat( User.getDateLastModified() )#</td>
									<td>
										<div class="btn-group pull-right">
											<a href="#action#" title="Edit #User.getName()#" class="btn edit"><i class="icon-edit"></i></a>
											<cfset action = buildURL( action ='user.userdelete', queryString = { userid = User.getUserID(), chk = session.userEdit } ) />
											<cfif User.getUserID() neq rc.CurrentUser.getUserID()><a href="#action#" title="Delete #User.getName()#" class="btn delete"><i class="icon-remove"></i></a></cfif>
										</div>
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