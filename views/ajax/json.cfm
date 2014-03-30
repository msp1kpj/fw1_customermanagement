<!--- turn debugging off --->
<cfsetting showdebugoutput="false" />
<!--- Set the response header --->
<cfheader name="Content-Type" value="application/json" />
<!---Prevent any layouts from being applied--->
<cfset request.layout=false>
<!--- Minimize white space by resetting the output buffer and only returning the following cfoutput --->
<cfcontent type="text/html; charset=utf-8" reset="yes"><cfoutput>#rc.response#</cfoutput>