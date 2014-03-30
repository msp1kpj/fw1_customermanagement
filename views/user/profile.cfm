<cfset rc.title = "Default View" />	<!--- set a variable to be used in a layout --->
<cfoutput>
	<div class="container">
		<div class="row">
			<div class="page-header page-header-custom">
				<h3 class="fontZrnic">Edit User</h3>
			</div>
			<ul class="breadcrumb">
				<li><a class="tip-bottom" href="#buildURL( 'main' )#" data-original-title="Go to Home"><i class="icon-home"></i></a><span class="divider">/</span></li>
				<li><a class="tip-bottom" href="#buildURL( 'user' )#" data-original-title="Go to users">Users</a></li>
			</ul>
		</div>
		#view( "helpers/messages" )#
		<div class="row-fluid">
			<div class="span8">
				#view( "helpers/messages" )#
				<form action="#buildURL( 'user.save' )#" method="post" class="form-horizontal " id="user-form">
					<fieldset class="block">
						<div class="block-header fontZrnic">User Details</div>
						<div class="block-body">
							<div class="control-group">
								<label class="control-label" for="firstname">First Name *</label>
								<div class="controls">
									<input class="input-xxlarge" type="text" name="firstname" id="firstname" value="#HtmlEditFormat( rc.User.getFirstName() )#" maxlength="75" placeholder="First Name" required="true" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="lastname">Last Name *</label>
								<div class="controls">
									<input class="input-xxlarge" type="text" name="lastname" id="lastname" value="#HtmlEditFormat( rc.User.getLastName() )#" maxlength="75" placeholder="Last Name" required="true" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="emailaddress">E-Mail Address *</label>
								<div class="controls">
									<input class="input-xxlarge" type="text" name="emailaddress" id="emailaddress" value="#HtmlEditFormat( rc.User.getEmailAddress() )#" maxlength="255"  placeholder="E-Mail Address" required="true" />
								</div>
							</div>
							<div class="control-group ">
								<label class="control-label" for="password">New Password</label>
								<div class="controls">
									<input class="input-xxlarge" type="password" name="password" id="password" value="" maxlength="30"  placeholder="New Password" autocomplete="off" />
									<span class="help-block" for="password">Leave password blank to keep current password.</span>
								</div>
							</div>
							<div class="control-group ">
								<label class="control-label" for="passwordConfirm">Confirm Password</label>
								<div class="controls">
									<input class="input-xxlarge" type="password" name="passwordConfirm" id="passwordConfirm" value="" maxlength="30" placeholder="Confirm Password" autocomplete="off"  />
								</div>
							</div>
						</div>
						<div class="form-actions">
							<input type="submit" name="submit" value="Save" class="btn btn-primary">
							<a href="#buildURL( 'user' )#" class="btn cancel">Cancel</a>
						</div>
					</fieldset>
					<input type="hidden" name="userid" id="userid" value="#HtmlEditFormat( rc.User.getUserID() )#">
				</form>
			</div>
			<div class="span4">
				<div class="block">
					<div class="block-header fontZrnic">Extra Information</div>
					<div class="block-body">
						<p>This is the user edit screen. Adding users will give them access to the system.</p>
						<p>When editing a user keep the password blank in order to keep the current password.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</cfoutput>