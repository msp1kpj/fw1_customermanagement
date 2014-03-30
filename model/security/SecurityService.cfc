<cfcomponent accessors="true" extends="model.base.Service">
	<!------------------------ DEPENDENCY INJECTION ------------------------>
	<cfproperty name="UserGateway" getter="false" />
	<cfproperty name="UserService" getter="false" />
	<cfproperty name="NotificationService" getter="false" />
	<cfproperty name="config" getter="false" />

	<cfscript>

		variables.userkey = "userid";

		/**
		 * I return the current storage mechanism
		 */
		function getCurrentStorage(){
			return evaluate(variables.config.storage);
		}

		// ------------------------ PUBLIC METHODS ------------------------ //
		/**
		 * I add a user to the session
		 */
		void function setCurrentUser( required any User ){
			getCurrentStorage()[ variables.userkey ] = arguments.User.getUserID();
		}



		function getCurrentUser(){
			if( hasCurrentUser() ){
				local.map = getCurrentStorage();
				local.userkey = local.map[ variables.userkey ];
				return variables.UserGateway.getUser( local.userkey );
			}
		}

		/**
		 * I delete the current user from the session
		 */
		struct function deleteCurrentUser(){
			local.response  = structNew();
			if( hasCurrentUser() ){
				StructDelete( getCurrentStorage(), variables.userkey );
				local.response["type"] = "success"; //warn, info, success, and error
				local.response["message"] = "You have been logged out.";
			}else{
				local.response["type"] = "error"; //warn, info, success, and error
				local.response["message"] = "You are not logged in.";
			}
			return local.response;
		}


		/**
		 * I return true if the session has a user
		 */
		boolean function hasCurrentUser(){
			return StructKeyExists( getCurrentStorage(), variables.userkey );
		}

		boolean function isAllowed( required string action, string whitelist = variables.config.security.whitelist ){
			param name="arguments.whitelist" default=variables.config.security.whitelist;
			// user is not logged in
			if( !hasCurrentUser() ){
				// if the requested action is in the whitelist allow access
				for ( var unsecured in ListToArray( arguments.whitelist ) ){
					if( ReFindNoCase( unsecured, arguments.action ) ) return true;
				}
			// user is logged in so allow access to requested action
			}else if( hasCurrentUser() ){
				return true;
			}
			// previous conditions not met so deny access to requested action
			return false;
		}

		/**
		 * I verify and login a user
		 */
		public struct function loginUser( required struct properties ){
			param name="arguments.properties.username" default="";
			param name="arguments.properties.password" default="";

			local.User = variables.UserGateway.newUser();
			populate( local.User, arguments.properties );
			local.response = validate( theObject=User, context="login" );
			// Get User by user name to get password salt
			local.UserLookup = variables.UserGateway.getUserByEmailOrUsername( local.User );
			if( local.UserLookup.isPersisted() && validatePassword(local.UserLookup, local.User.getPassword()) ){
				setCurrentUser( local.UserLookup );
				local.response["type"] = "success"; //warn, info, success, and error
				local.response["message"] = "Welcome #local.UserLookup.getFirstName()#. You have been logged in.";
			}else{
				local.message = "Sorry, your login details have not been recognized.";
				local.response["type"] = "error"; //warn, info, success, and error
				local.response["message"] = local.message;
			}
			return local.response;
		}

		private any function validate(required model.user.User theObject,  string context = "create"){
			local.aErrors = StructNew();
			// User name is required
			if( not len(arguments.theObject.getuserName())){
				local.aErrors["type"] = "error"; //warn, info, success, and error
				local.aErrors["message"] = "Please enter the user name";
			}

			// Password is required
			if( not len(arguments.theObject.getPassword())) {
				local.aErrors["type"] = "error"; //warn, info, success, and error
				local.aErrors["message"] = "Please enter the password";
			}

			return local.aErrors;
		}

		private boolean function validatePassword(required model.user.User theObject, required string password) {
			local.validPass = false;
			local.inputHash = hash(trim(arguments.password) & trim(arguments.theObject.getPasswordSalt()), 'SHA-512');
			if(not compare(local.inputHash, arguments.theObject.getPassword())){
				local.validPass = true;
			}

			return local.validPass;
		}

		/**
		 * I reset the password of a user and send a notification email
		 */
		struct function resetPassword( required struct properties, required string name, required struct config, required string emailtemplatepath ){
			transaction{
				param name="arguments.properties.email" default="";
				var User = variables.UserGateway.newUser();
				populate( User, arguments.properties );
				var result = validate( theObject=User, context="password" );
				User = variables.UserGateway.getUserByEmailOrUsername( User );
				if( User.isPersisted() ){
					var password = variables.UserService.newPassword();
					var passwordHashed = variables.UserService.hashPassword(password);
					User.setPassword( passwordHashed.hash );
					User.setPasswordSalt( passwordHashed.Salt );
					savecontent variable="emailtemplate"{ include arguments.emailtemplatepath; }
					variables.UserGateway.saveUser( User );
					variables.NotificationService.send( arguments.config.resetpasswordemailsubject, User.getEmailAddress(), arguments.config.resetpasswordemailfrom, emailtemplate );
					result["type"] = 'success';
					result["message"] = "A new password has been sent to #User.getEmailAddress()#.";
					result["password"] = password;
				}else{
					result["type"] = 'error';
					result["message"] = "Sorry, your email address has not been recognised.";
				}
			}
			return result;
		}
	</cfscript>
</cfcomponent>