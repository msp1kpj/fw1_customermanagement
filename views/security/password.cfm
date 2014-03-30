<cfoutput>
  <div class="container">
    #view( "helpers/messages" )#
    <div class="row">
      <div class="offset4 span4">
      <div class="login-dailog">
        	<form class="" method="post" action="#buildURL('security.resetpassword')#">
            <fieldset class="block">
              <div class="block-header">Password Reset</div>
              <div class="block-body">
                <div class="control-group">
                  <label class="control-label" for="emailaddress">Enter your e-mail address below and we will send you instructions how to recover a password.</label>
                  <div class="controls">
                    <div class="input-prepend">
                      <span class="add-on"><i class="icon-envelope"></i></span>
                      <input class="input-xlarge" type="text" name="emailaddress" id="emailaddress" placeholder="Enter your e-mail address..." />
                    </div>
                  </div>
                </div>
                <div class="control-group">
                  <button type="submit" class="btn btn-primary pull-right">Recover</button>
                  <p class="help-block"><a href="#buildURL( 'security' )#">&lt; Back to Login</a></p>
                </div>
              </div>
            </fieldset>
          </form>
        </div>
      </div>
    </div>
  </div>
</cfoutput>