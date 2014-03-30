<cfcomponent accessors="true" persistent="true" table="user" cacheuse="transactional" extends="model.base.Model" hint="This is the User Model component" displayname="User model component">
	<!------------------------ PROPERTIES ------------------------>
	<cfproperty name="userid" column="pkid" fieldtype="id" generator="native" default="0"/>
	<cfproperty name="firstname" column="firstname" ormtype="string" length="75" />
	<cfproperty name="lastname" column="lastname" ormtype="string" length="75"/>
	<cfproperty name="emailaddress" column="emailaddress" ormtype="string" length="255" default='' />
	<cfproperty name="username" column="username" ormtype="string" length="75" />
	<cfproperty name="password" column="password" ormtype="string" length="75" />
	<cfproperty name="passwordsalt" column="passwordsalt" ormtype="string" length="36" />
	<cfproperty name="isactive" column="isactive" ormtype="boolean" default="true" />
	<cfproperty name="datecreated" column="datecreated" ormtype="timestamp" />
	<cfproperty name="datelastmodified" column="datalastmodified" ormtype="timestamp"/>

	<cfparam name="variables.datecreated" type="date" default="#now()#" />
	<cfparam name="variables.datelastmodified" type="date" default="#now()#" />

	<cfscript>

		// ------------------------ CONSTRUCTOR ------------------------ //

		/**
		 * I initialise this component
		 */
		User function init(){
			return this;
		}

		// ------------------------ PUBLIC METHODS ------------------------ //



		/**
		 * I return true if the user is persisted
		 */
		boolean function isPersisted(){
			return !IsNull( variables.userid );
		}

		/**
		* I return the users name salutation
		*/
		public string function getName() {
			return trim(getFirstName() & " " & getLastName());
		}


	</cfscript>
</cfcomponent>