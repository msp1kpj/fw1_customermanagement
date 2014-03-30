/**
*
* @author Ken John kjohn@kjsbh.com
*
*/

component output="false" displayname="Base Controller" accessors="true" {
	//DEPENDENCY INJECTION
	property name="SecurityService"
		setter="true"
		getter="false";

	property name="UserGateway"
		setter="true"
		getter="false";


	//PUBLIC METHODS
	void function init( required any fw ){
		variables.fw = arguments.fw;
	}


	public void function before( required struct rc ){
		if( not structKeyExists(arguments.rc, "currentUser") or IsNull(arguments.rc.currentUser.getUserID())) {
			if(structKeyExists(application, "EncryptionKey") and structKeyExists(cookie, "REMEMBERME") and len(trim(cookie.REMEMBERME)) gt 0 ) {
				local.rememberMe = decrypt(cookie.REMEMBERME, application['EncryptionKey'], "cfmx_compat", "hex");
				if(isJSON(local.rememberMe)) {
					local.rememberMe = deserializeJSON(local.rememberMe);
					if( structKeyExists(local.rememberMe, "userid") and len(trim(local.rememberMe.userid)) and isNumeric(local.rememberMe.userid) ){
						local.UserLookup = variables.UserGateway.getUser( local.rememberMe.userid );
						variables.SecurityService.setCurrentUser( local.UserLookup );
					}
				}
			}
		}
		arguments.rc.isallowed = variables.SecurityService.isAllowed( variables.fw.getFullyQualifiedAction() );



		if( !arguments.rc.isallowed ){
			if( isAjaxRequest() && !structKeyExists( session, 'user' ) ) {
				getpagecontext().getresponse().setstatus( 403 );
				abort;
			} else {
				variables.fw.redirect( "security" );
			}
		}else{
			arguments.rc.CurrentUser = variables.SecurityService.getCurrentUser();
		}
	}



	public boolean function isAjaxRequest() {
		local.RequestData = getHTTPRequestData();
		if(structKeyExists( local.RequestData.headers, 'X-Requested-With' ) and local.RequestData.headers[ 'X-Requested-With' ] eq 'XMLHttpRequest'){
			getPageContext().getResponse().getResponse().setContentType('application/json');
			return true;
		}
		return false;
	}
}