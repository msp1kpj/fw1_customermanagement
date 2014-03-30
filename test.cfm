    <cfquery datasource="HomePlaceDB" name="qryCoupons">
			SELECT *
			FROM user
		</cfquery>



    <!--- Dump out the server scope. --->
    <cfdump var="#qryCoupons#" />

    <!--- Store the ColdFusion version. --->
    <cfset strVersion = SERVER.ColdFusion.ProductVersion />

    <!--- Store the ColdFusion level. --->
    <cfset strLevel = SERVER.ColdFusion.ProductLevel />
