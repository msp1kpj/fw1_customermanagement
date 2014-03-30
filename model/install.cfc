<cfcomponent output="false" displayname="install" accessors="true">


	<cffunction name="init" access="public" returntype="Any" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="installCustomerDate" returntype="void">
		<cfquery datasource="HomePlaceDB">
			<cfinclude template="customer.sql"/>
		</cfquery>
	</cffunction>

</cfcomponent>