<cfcomponent accessors="true" extends="controllers.base.Controller" >
    <!------------------------- DEPENDENCY INJECTION ------------------------>
    <cfproperty name="UserService" setter="true" getter="false" />
    <cfproperty name="config" setter="true" getter="false" />
    <cfproperty name="JSONUtility" setter="true" getter="false" />


    <cfscript>
        // ------------------------ PUBLIC METHODS ------------------------ //
        void function default( required struct rc ){
            rc.loggedin = variables.SecurityService.hasCurrentUser();

            if( rc.loggedin ){
                variables.fw.redirect( "main" );
            }else{
                rc.User = variables.UserService.newUser();
                //rc.Validator = variables.UserService.getValidator( rc.User );
                //if( !StructKeyExists( rc, "result" ) ) rc.result = rc.Validator.newResult();
            }
        }

        void function login( required struct rc ){
            param name="arguments.rc.username" default="";
            param name="arguments.rc.password" default="";

            arguments.rc.response = variables.SecurityService.loginUser( arguments.rc );
            if( StructKeyExists(arguments.rc.response, "type") and arguments.rc.response.type neq "error" ){
                local.user = variables.SecurityService.getCurrentUser();

                if( structKeyExists(arguments.rc, "rememberMe") and arguments.rc.rememberMe eq 1 ){
                    local.cookieUser = structnew();
                    local.cookieUser['username'] = local.user.getUserName();
                    local.cookieUser['userid'] = local.user.getUserId();
                    SetCookie(name="rememberMe", value=encrypt(variables.JSONUtility.jsonencode(local.cookieUser), application['EncryptionKey'], "cfmx_compat", "hex"), httponly=true, secure=false, expires="365");
                } else {
                    structDelete(cookie, "REMEMBERME",true);
                }
                variables.fw.redirect( "main", "response" );

            } else {
                variables.fw.redirect( "security", "response" );
            }
        }

        void function logout( required struct rc ){
            arguments.rc.response = variables.SecurityService.deleteCurrentUser();

            if(structKeyExists(cookie, "REMEMBERME")){
                structDelete(cookie, "REMEMBERME",true);
            }

            variables.fw.redirect( "security", "response" );
        }

        void function password( required struct rc ){
            arguments.rc.User = variables.UserService.newUser();
        }

        void function resetpassword( required struct rc ){
            param name="rc.username" default="";
            arguments.rc.response = variables.SecurityService.resetPassword( rc, variables.config.name, variables.config.security, "../../views/email/resetpassword.cfm" );
            variables.fw.redirect( "security.password", "response" );
        }

    </cfscript>

    <cffunction name="setCookie" access="public" returnType="void" output="false">
        <cfargument name="name" type="string" required="true">
        <cfargument name="value" type="string" required="false">
        <cfargument name="expires" type="any" required="false">
        <cfargument name="domain" type="string" required="false">
        <cfargument name="httpOnly" type="boolean" required="false">
        <cfargument name="path" type="string" required="false">
        <cfargument name="secure" type="boolean" required="false">
        <cfset var args = {}>
        <cfset var arg = "">
        <cfloop item="arg" collection="#arguments#">
            <cfif not isNull(arguments[arg])>
                <cfset args[arg] = arguments[arg]>
            </cfif>
        </cfloop>

        <cfcookie attributecollection="#args#">
    </cffunction>
</cfcomponent>