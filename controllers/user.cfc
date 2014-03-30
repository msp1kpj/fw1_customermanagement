component accessors="true" output="false" displayname="User" extends="controllers.base.Controller" {
	//DEPENDENCY INJECTION
	property name="UserService"
		setter=true
		getter=false;



	public void function default( required struct rc) {
        session.userEdit = CreateUUID();
		arguments.rc.users = variables.UserService.getUsers();
		return;
	}


	public void function profile( required struct rc) {

		arguments.rc.User = variables.UserService.newUser();
		if(structKeyExists(arguments.rc, "userid")) {
			arguments.rc.User = variables.UserService.getUser( arguments.rc.userid );
		}

		return;
	}

	public void function save( required struct rc) {
            //validate the user
            arguments.rc['user'] = variables.UserService.getUser(argumentCollection=arguments.rc);
            arguments.rc['message'] = variables.UserService.validate(argumentCollection=arguments.rc);

            //if there were validation errors, grab a blank user to populate and send back to the form
            if(structkeyExists(arguments.rc.message, "type") AND arguments.rc.message.type neq "success"){
			arguments.rc.user = variables.UserService.newUser();
            } else {
            	if(len(trim(arguments.rc.password)) eq 0){
            		arguments.rc.password = arguments.rc.user.getPassword();
            	}
            }

            //update the user object with the data entered
            variables.fw.populate(cfc = arguments.rc.user, trim=true);

            //if there were error, redirect the user to the form
            if(structkeyExists(arguments.rc.message, "type") AND arguments.rc.message.type neq "success"){
                variables.fw.redirect('user.profile','user,message');
            }


            //if the password is new, update the user object with the password hash and salt
            if(structKeyExists(arguments.rc, "password") and len(arguments.rc.password)){
                local.newPassHash = variables.UserService.hashPassword(arguments.rc.password);
                arguments.rc.user.setPassword(local.newPassHash.hash);
                arguments.rc.user.setPasswordSalt(local.newPassHash.salt);
            }

            arguments.rc["response"] = variables.UserService.save(arguments.rc.user);
            session.userEdit = CreateUUID();

            //user saved so by default lets go back to the users list page
            variables.fw.redirect("user.default", "response");
	}

    public void function userdelete( required struct rc) {


        if(structKeyExists(arguments.rc, "userid")) {
            arguments.rc["response"] = variables.UserService.deleteUser( arguments.rc.userid );
        }
        session.userEdit  = CreateUUID();
        //user saved so by default lets go back to the users list page
        variables.fw.redirect("user.default", "response");

        return;
    }
}
