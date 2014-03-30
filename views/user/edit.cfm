<cfset rc.title = "Default View" />	<!--- set a variable to be used in a layout --->
<cfoutput>
	<div class="container">
		<div class="row">
			<div class="page-header clear"><h2>Edit User</h2></div>
			#view( "helpers/messages" )#
			<form action="#buildURL( 'users.save' )#" method="post" class="form-horizontal" id="user-form">
				<fieldset>
					<legend>User Details</legend>
					<div class="control-group">
						<label class="control-label" for="firstname">First Name *</label>
						<div class="controls">
							<input class="input-xlarge" type="text" name="firstname" id="firstname" value="#HtmlEditFormat( rc.User.getFirstName() )#" maxlength="75">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="lastname">Last Name *</label>
						<div class="controls">
							<input class="input-xlarge" type="text" name="lastname" id="lastname" value="#HtmlEditFormat( rc.User.getLastName() )#" maxlength="75">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="emailaddress">E-Mail Address *</label>
						<div class="controls">
							<input class="input-xlarge" type="text" name="emailaddress" id="emailaddress" value="#HtmlEditFormat( rc.User.getEmailAddress() )#" maxlength="255">
						</div>
					</div>
					<div class="control-group ">
						<label class="control-label" for="password">Password</label>
						<div class="controls">
							<input class="input-xlarge" type="password" name="password" id="password" value="" maxlength="30">
							<span class="help-inline" for="password">Leave password blank to keep current password.</span>
						</div>
					</div>
					<div class="control-group ">
						<label class="control-label" for="passwordConfirm">Password Confirm</label>
						<div class="controls">
							<input class="input-xlarge" type="password" name="passwordConfirm" id="passwordConfirm" value="" maxlength="30">
						</div>
					</div>
				</fieldset>
				<div class="form-actions">
					<input type="submit" name="submit" value="Save" class="btn btn-primary">
					<a href="#buildURL( 'user' )#" class="btn cancel">Cancel</a>
				</div>
				<input type="hidden" name="userid" id="userid" value="#HtmlEditFormat( rc.User.getUserID() )#">
			</form>
		</div>
	</div>
</cfoutput>