<cfcomponent accessors="true" extends="model.base.Gateway">

	<cfscript>
		// ------------------------ PUBLIC METHODS ------------------------ //

		/**
		 * I return a new user
		 */
		model.user.User function newUser(){
			return new User();
		}
	</cfscript>

	<cffunction name="deleteUser" returntype="void" access="public" output="false" hint="I delete a user">
		<cfargument name="User" type="User" required="true" />
		<cfif arguments.User.getUserID() neq 0>
			<cfquery name="local.deleteUser">
				UPDATE user
					SET isActive = 0
				WHERE pkid = <cfqueryparam cfsqltype="cf_sql_int" maxlength="36" value="#arguments.User.getUserId()#" null="#NOT Len(arguments.User.getUserId())#" />
					AND isActive = 1
			</cfquery>
		</cfif>
		<cfreturn>
	</cffunction>

	<cffunction name="saveUser" returntype="model.user.User" access="public" output="false" hint="">
		<cfargument name="User" type="User" required="true" />
		<cfif arguments.User.getUserID() eq 0>
			<cfquery name="local.saveUser">
				INSERT INTO user (UserName, Password, emailAddress, firstName, lastName, passwordSalt, dateCreated)
				VALUES (
					<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="36" value="#arguments.User.getEMailAddress()#" null="#NOT Len(arguments.User.getEMailAddress())#" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="128" value="#arguments.User.getPassword()#" null="#NOT Len(arguments.User.getPassword())#" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.User.getEMailAddress()#" null="#NOT Len(arguments.User.getEMailAddress())#" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="75" value="#arguments.User.getFirstName()#" null="#NOT Len(arguments.User.getFirstName())#" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="75" value="#arguments.User.getLastName()#" null="#NOT Len(arguments.User.getLastName())#" />
					, <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="75" value="#arguments.User.getPasswordSalt()#" null="#NOT Len(arguments.User.getPasswordSalt())#" />
					, CURRENT_TIMESTAMP
					)
			</cfquery>
		<cfelse>
			<cfquery name="local.saveUser">
				UPDATE user
					SET UserName = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="36" value="#arguments.User.getUserName()#" null="#NOT Len(arguments.User.getUserName())#" />
					, Password = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="128" value="#arguments.User.getPassword()#" null="#NOT Len(arguments.User.getPassword())#" />
					, emailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.User.getEMailAddress()#" null="#NOT Len(arguments.User.getEMailAddress())#" />
					, firstName = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="75" value="#arguments.User.getFirstName()#" null="#NOT Len(arguments.User.getFirstName())#" />
					, lastName = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="75" value="#arguments.User.getLastName()#" null="#NOT Len(arguments.User.getLastName())#" />
					, passwordSalt = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="75" value="#arguments.User.getPasswordSalt()#" null="#NOT Len(arguments.User.getPasswordSalt())#" />
				WHERE 1 = 1
				AND pkid = <cfqueryparam cfsqltype="cf_sql_int" maxlength="36" value="#arguments.User.getUserId()#" null="#NOT Len(arguments.User.getUserId())#" />
			</cfquery>
		</cfif>
		<cfreturn arguments.User />
	</cffunction>

	<cffunction name="getUsers" returntype="model.user.User[]" access="public" output="false" hint="I return an array of users">
		<cfset var qryGetUsers = queryNew("pkid") />
		<cfset local.users = arrayNew(1) />
		<cfquery name="qryGetUsers">
			SELECT pkid
				, UserName
				, Password
				, emailAddress
				, firstName
				, lastName
				, passwordSalt
				, isActive
				, dateCreated
				, dateLastModified
			FROM user
			WHERE isActive = 1
		</cfquery>

		<cfloop query="qryGetUsers">
			<cfset local.user = newUser()/>
			<cfset local.user.setUserID(qryGetUsers.pkid) />
			<cfset local.user.setUserName(qryGetUsers.UserName) />
			<cfset local.user.setPassword(qryGetUsers.Password) />
			<cfset local.user.setEmailAddress(qryGetUsers.emailAddress) />
			<cfset local.user.setFirstName(qryGetUsers.firstName) />
			<cfset local.user.setLastName(qryGetUsers.lastName) />
			<cfset local.user.setPasswordSalt(qryGetUsers.passwordSalt) />
			<cfset local.user.setIsActive(qryGetUsers.isActive) />
			<cfset local.user.setDateCreated(qryGetUsers.dateCreated) />
			<cfset local.user.setDateLastModified(qryGetUsers.dateLastModified) />
			<cfset arrayAppend(local.users, local.user) />
		</cfloop>
		<cfreturn local.users />
	</cffunction>

	<cffunction name="getUser" returntype="model.user.User" access="public" output="false" hint="I return a user matching an id">
		<cfargument name="userid" type="numeric" required="true"/>
		<cfquery name="local.getUser">
			SELECT pkid
				, UserName
				, Password
				, emailAddress
				, firstName
				, lastName
				, passwordSalt
				, isActive
				, dateCreated
				, dateLastModified
			FROM user
			WHERE 1 = 1
				AND pkid = <cfqueryparam cfsqltype="cf_sql_int" maxlength="36" value="#arguments.userid#" null="#NOT Len(arguments.userid)#" />
			LIMIT 1
		</cfquery>
		<cfset local.user = newUser()/>
		<cfif isDefined('local.getUser') and isQuery(local.getUser) and local.getUser.recordCount gt 0>
			<cfset local.user.setUserID(local.getUser.pkid) />
			<cfset local.user.setUserName(local.getUser.UserName) />
			<cfset local.user.setPassword(local.getUser.Password) />
			<cfset local.user.setEmailAddress(local.getUser.emailAddress) />
			<cfset local.user.setFirstName(local.getUser.firstName) />
			<cfset local.user.setLastName(local.getUser.lastName) />
			<cfset local.user.setPasswordSalt(local.getUser.passwordSalt) />
			<cfset local.user.setIsActive(local.getUser.isActive) />
			<cfset local.user.setDateCreated(local.getUser.dateCreated) />
			<cfset local.user.setDateLastModified(local.getUser.dateLastModified) />
		</cfif>
		<cfreturn local.user />
	</cffunction>

	<cffunction name="getUserByEmailOrUsername" returntype="model.user.User" access="public" output="false" hint="I return a user matching a username or email address">
		<cfargument name="theUser" type="User"	required="true"/>
		<cfquery name="local.getUserByEmailOrUsername">
			SELECT pkid
				, UserName
				, Password
				, emailAddress
				, firstName
				, lastName
				, passwordSalt
				, isActive
				, dateCreated
				, dateLastModified
			FROM user
			WHERE 1 = 1
				AND (username = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="55" value="#arguments.theUser.getUserName()#" null="#NOT Len(arguments.theUser.getUserName())#" />
					or emailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="55" value="#arguments.theUser.getEmailAddress()#" null="#NOT LEN(arguments.theUser.getEmailAddress())#" />)
			LIMIT 1
		</cfquery>
		<cfset local.user = newUser()/>
		<cfif isDefined('local.getUserByEmailOrUsername') and isQuery(local.getUserByEmailOrUsername) and local.getUserByEmailOrUsername.recordCount gt 0>
			<cfset local.user.setUserID(local.getUserByEmailOrUsername.pkid) />
			<cfset local.user.setUserName(local.getUserByEmailOrUsername.UserName) />
			<cfset local.user.setPassword(local.getUserByEmailOrUsername.Password) />
			<cfset local.user.setEmailAddress(local.getUserByEmailOrUsername.emailAddress) />
			<cfset local.user.setFirstName(local.getUserByEmailOrUsername.firstName) />
			<cfset local.user.setLastName(local.getUserByEmailOrUsername.lastName) />
			<cfset local.user.setPasswordSalt(local.getUserByEmailOrUsername.passwordSalt) />
			<cfset local.user.setIsActive(local.getUserByEmailOrUsername.isActive) />
			<cfset local.user.setDateCreated(local.getUserByEmailOrUsername.dateCreated) />
			<cfset local.user.setDateLastModified(local.getUserByEmailOrUsername.dateLastModified) />
		</cfif>
		<cfreturn local.user />
	</cffunction>

	<cffunction name="getUserByCredentials" returntype="model.user.User" access="public" output="false" hint="I return a user matching a username or email address and password">
		<cfargument name="theUser" type="User"	required="true"/>
		<cfquery name="local.getUserByCredentials">
			SELECT pkid
				, UserName
				, Password
				, emailAddress
				, firstName
				, lastName
				, passwordSalt
				, isActive
				, dateCreated
				, dateLastModified
			FROM user
			WHERE 1 = 1
				AND (username = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="55" value="#arguments.theUser.getUserName()#" null="#NOT Len(arguments.theUser.getUserName())#" />
					or emailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="55" value="#arguments.theUser.getEmailAddress()#" null="#NOT LEN(arguments.theUser.getEmailAddress())#" />)
				AND Password = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="128"	value="#arguments.theUser.getPassword()#" null="#NOT LEN(arguments.theUser.getPassword())#"/>
			LIMIT 1
		</cfquery>
		<cfset local.user = newUser()/>
		<cfif isDefined('local.getUserByCredentials') and isQuery(local.getUserByCredentials) and local.getUserByCredentials.recordCount gt 0>
			<cfset local.user.setUserID(local.getUserByCredentials.pkid) />
			<cfset local.user.setUserName(local.getUserByCredentials.UserName) />
			<cfset local.user.setPassword(local.getUserByCredentials.Password) />
			<cfset local.user.setEmailAddress(local.getUserByCredentials.emailAddress) />
			<cfset local.user.setFirstName(local.getUserByCredentials.firstName) />
			<cfset local.user.setLastName(local.getUserByCredentials.lastName) />
			<cfset local.user.setPasswordSalt(local.getUserByCredentials.passwordSalt) />
			<cfset local.user.setIsActive(local.getUserByCredentials.isActive) />
			<cfset local.user.setDateCreated(local.getUserByCredentials.dateCreated) />
			<cfset local.user.setDateLastModified(local.getUserByCredentials.dateLastModified) />
		</cfif>
		<cfreturn local.user />
	</cffunction>
</cfcomponent>