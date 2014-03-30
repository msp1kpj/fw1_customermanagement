<cfparam name="request.context.footertext" default="" />

<cfswitch expression="#THISTAG.ExecutionMode#">
	<cfcase value="Start">
		<!--- Start tag processing --->
		<cfparam name="attributes.name" type="string" default="" />
	</cfcase>
	<cfcase value="End">
		<!--- End tag processing --->
		<cfif StructKeyExists(attributes, 'name') and len(trim(attributes.name)) gt 0>
  			<cfset name =	attributes.name />
  		<cfelse>
  			<cfset name =	hash(trim(ThisTag.generatedContent)) />
  		</cfif>
  		<cftry>
			<cfsavecontent variable="footertext">
				<cfoutput>
				<!-- #name# -->
				#stripWhiteSpace(ThisTag.generatedContent)#
				</cfoutput>
			</cfsavecontent>
			<!--- throws exception when already flushed or action read is not supported --->
			<cfcatch>
				<cfoutput>
					<!-- #name# -->
					#stripWhiteSpace(ThisTag.generatedContent)#
				</cfoutput>
				<cfreturn false>
			</cfcatch>
		</cftry>
		<cfset request.context.footertext = request.context.footertext & footertext />
		<cfset ThisTag.generatedContent = '' />
	</cfcase>
</cfswitch>

<!--- StripWhiteSpace --->
<cffunction name="stripWhiteSpace" output="no" returntype="string" hint="Strips whitespace outside tags from string">
	<cfargument name="str" type="string" default="" required="no"/>
	<cfreturn trim(reReplaceNoCase(arguments.str,"(</?.*?\b[^>]*>)[\s]{1,}|[\r]{1,}(</?.*?\b[^>]*>)","\1#chr(13)##chr(10)#\2","All"))/>
</cffunction>