<cfcomponent accessors="true" extends="model.base.Service">
	<!--- DEPENDENCY INJECTION --->
	<cfproperty name="UserGateway" getter="false" />
	<cfproperty name="MessageResult" getter="false" />
	<cfscript>
	// ------------------------ PUBLIC METHODS ------------------------ //

	/**
	 * I delete a user
	 */
	struct function deleteUser( required userid ){
		transaction{
			var User = variables.UserGateway.getUser( Val( arguments.userid ) );
			local.result = structNew();

			if( User.isPersisted() ){
				variables.UserGateway.deleteUser( User );
				local.result.type = "success";
				local.result.message = "The user &quot;#User.getName()#&quot; has been deleted.";
			}else{
				local.result.type = "success";
				local.result.message = "The user could not be deleted.";
			}
		}
		return local.result;
	}

	/**
	 * I return a user matching an id
	 */
	User function getUser( required userid ){
		return variables.UserGateway.getUser( Val( arguments.userid ) );
	}

	/**
	 * I return a user matching a username or email address and password
	 */
	User function getUserByCredentials( required User theUser ){
		return variables.UserGateway.getUserByCredentials( theUser );
	}

	/**
	 * I return a user matching a username or email address
	 */
	User function getUserByEmailOrUsername( required User theUser ){
		return variables.UserGateway.getUserByEmailOrUsername( theUser );
	}

	/**
	 * I return an array of users
	 */
	array function getUsers(){
		return variables.UserGateway.getUsers();
	}

	/**
	 * I return a new password
	 */
	string function newPassword(){
		return Left( CreateUUID(), 8 );
	}

	/**
	 * I return a new user
	 */
	User function newUser(){
		return variables.UserGateway.newUser();
	}

	/**
	 * I validate and save a user
	 */
	struct function save( required model.user.user user){
		local.result = structNew();
		local.result["type"] = "success";
		transaction{
			arguments.User = variables.UserGateway.saveUser( arguments.User );
			if( arguments.User.getUserId() gt 0 ){
				local.result.type = "success";
				local.result.message = "The user &quot;#User.getName()#&quot; has been saved.";
			}else{
				local.result.type = "error";
				local.result.message = "The user could not be saved.";
			}
		}
		return local.result;
	}

	/**
	 * I return true if the email address is unique
	 */
	struct function isEmailUnique(){
		var matches = [];
		var result = { type="error", message="The email address '#variables.email#' is registered to an existing account." };
		if( isPersisted() ) matches = ORMExecuteQuery( "from User where userid <> :userid and email = :email", { userid=variables.userid, email=variables.email } );
		else matches = ORMExecuteQuery( "from User where email=:email", { email=variables.email } );
		if( !ArrayLen( matches ) ) result.type = "success";
		return result;
	}

	/**
	 * I return true if the username is unique
	 */
	struct function isUsernameUnique(){
		var matches = [];
		var result = { type = "error", failuremessage = "The username '#variables.username#' is registered to an existing account." };
		if( isPersisted() ) matches = ORMExecuteQuery( "from User where userid <> :userid and username = :username", { userid=variables.userid, username=variables.username } );
		else matches = OrmExecuteQuery( "from User where username = :username", { username=variables.username } );
		if( !ArrayLen( matches ) ) result.type = "success";
		return result;
	}


	/**
	* I return a structure of a salted and hased password and the salt string that was used
	*/
	public struct function hashPassword( required string password ) {
		local.returnVar = structNew();
		local.passwordHash = "";

		// Salt password string
		local.salt = createUUID();

		local.passwordHash = hash(trim(arguments.password) & trim(local.salt), 'SHA-512');

		local.returnVar['hash'] = local.passwordHash;
		local.returnVar['Salt'] = local.salt;

		return local.returnVar;
	}

	/**
	* I return an array of errors for validating a User object
	*/

	public any function validate( required User user, string firstName, string lastName, string emailAddress, string password, string passwordConfirm) {
		// check to see if a user exists with the email address
		var userByEmail = getUserByEmailOrUsername(arguments.user);

		local.aErrors = StructNew();
		local.aErrors["type"] = "success";
		local.aErrors["message"] = "";

		//if the user is new, make sure there is a password
		if(not len(arguments.user.getUserName()) and not len(arguments.password)){
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "Please enter the a new password for a new user";
		} else if(len(arguments.user.getPassword())){
			local.aError = checkPassword(user=arguments.user, newPassword=arguments.password, retypePassword=arguments.passwordConfirm);
		}

		// First name is required.
		if(not len(trim(arguments.user.getFirstName())) and not len(trim(arguments.firstName))){
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "Please enter the user's first name";
		}

		// Last name is required.
		if(not len(trim(arguments.user.getLastName())) and not len(trim(arguments.lastName))){
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "Please enter the user's last name";
		}

		// E-Mail address is required
		if(not len(trim(arguments.user.getEmailAddress())) and not len(trim(arguments.emailAddress))){
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "Please enter the user's email address";
		} else if(len(trim(arguments.emailAddress)) and not isValid("email", arguments.emailAddress)){
			// verify the email is a valid format
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "Please enter the user's email address";
		} else if(len(trim(arguments.emailAddress)) and compareNoCase(arguments.emailAddress, arguments.user.getEmailAddress()) and userByEmail.getUserId()){
			// verify the email address is unique for this user
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "A user already exists with this email address, please enter a new address.";
		}

		return local.aErrors;
	}

	/**
	* @hint "I check password strength and determine if it is up to snuff, I return an array of error messages"
	* @param user "User Object"
	* @param currentPassword "Send in current user's password for validation when user is changing password"
	* @param newPassword "Send in password1 as a string, default is a blank string, which will fail"
	* @param retypePassword "Send in password2 as a string, default is a blank string, which will fail"
	*/

	private any function checkPassword(required User user, string currentPassword = "", string newPassword= "", string retypePassword = "") {
		var inputHash = "";
		var count = 0;

		local.aErrors = StructNew();

		// if the password fields to not have values, add an error and return
		if (not len(arguments.newPassword) or not len(arguments.retypePassword)) {
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "Please confirm password";
			return local.aErrors;
		}

		if(len(trim(arguments.currentPassword)) and isObject(arguments.user)){
			// If the user is changing their password, compare the current password to the saved hash
			inputHash = hash(trim(arguments.currentPassword) & trim(arguments.user.getPasswordSalt()), 'SHA-512');
			/**
			* Compare the inputHash with the hash in the user object. if they do not match,
			* then the correct password was not passed in
			*/
			if (not compare(inputHash, user.getPasswordHash()) IS 0) {
				local.aErrors["type"] = "error";
				local.aErrors["message"] = "Your current password does not match the current password entered";
				// Return now, there is no point testing further
				return local.aErrors;
			}

			// Compare the current password to the new password, if they match add an error
			if (compare(arguments.currentPassword, arguments.newPassword) IS 0){
				local.aErrors["type"] = "error";
				local.aErrors["message"] = "The new password can not match your current password";
			}
		}

		// Check the password rules
		// *** to change the strength of the password required, uncomment as needed

		// Check to see if the two passwords match
		if (not compare(arguments.newPassword, arguments.retypePassword) IS 0) {
			local.aErrors["type"] = "error";
			local.aErrors["message"] = "The new passwords you entered do not match";
			// Return now, there is no point testing further
			return local.aErrors;
		}


		return local.aErrors;
	}







	</cfscript>
</cfcomponent>