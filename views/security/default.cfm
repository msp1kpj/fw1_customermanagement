<cfoutput>

	<div class="container">
		#view( "helpers/messages" )#
		<div class="row">
			<div class="offset4 span4">
				<div class="login-dailog">

					<form id="login-form" class="" method="post" action="#buildURL('security.login')#" autocomplete="off">

						<p>Enter username and password to continue.</p>
						<div class="control-group">
							<label class="control-label fontZrnic" for="id_username">User Name</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-user"></i></span>
									<input name="username" maxlength="100" placeholder="Enter your user name..." type="email" class="input-xlarge" id="id_username" accesskey="U" autofocus="true" autocomplete="off" required="required"/>
								</div>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label fontZrnic" for="id_password">Password</label>
							<div class="controls">
								<div class="input-prepend">
									<span class="add-on"><i class="icon-lock"></i></span>
									<input name="password" maxlength="100" placeholder="Enter your password..." type="password" class="input-xlarge " id="id_password" accesskey="P" autocomplete="off" required="required"/>
								</div>
							</div>
						</div>
						<div class="control-group">
							<button type="submit" class="btn btn-primary pull-right">Sign In</button>
							<label class="checkbox remember-me"><input type="checkbox" name="rememberMe" id="rememberMe" value="1" /> Remember me</label>
							<p class="help-block"><a href="#buildURL( 'security.password' )#">Forgotten your password?</a></p>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
<cfmodule template="/customtags/htmlfoot.cfm">
	<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.validate.bootstrap.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#login-form").validate({ onkeyup: false });
		});
	</script>
</cfmodule>