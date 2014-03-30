<cfoutput>
	<cfif StructKeyExists( rc, "response" ) and len(rc.response.message)>
    	<div class="alert alert-#rc.response.type#">#rc.response.message#</div>
    	<cfset structDelete(rc, "response") />
	</cfif>
</cfoutput>