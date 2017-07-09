<cfcomponent output="false">

    <!--- 	base64UrlUnescape(String) as String
			Description: restore base64 characters from an url escaped string 
	---> 
	<cffunction name="base64UrlUnescape" output="false" access="public">
		<cfargument name="str" required="true">

		<!--- Unescape url characters --->
		<cfset var base64String = reReplace(reReplace(arguments.str, "\-", "+", "all"), "\_", "/", "all")>
		<cfset var padding = repeatstring("=",4 - len(base64String) mod 4)>
        <cfscript>
           writeLog(text = "base64UrlUnescape amiks parsed amiks tag " & base64String & padding , file = "server",type="information");
        </cfscript>
        <cfset strBase64Value = ToString(ToBinary(base64String & padding)) />
         <cfscript>
           writeLog(text = "base64UrlUnescape amiks parsed " &  serializeJSON(strBase64Value) , file = "server",type="information");
        </cfscript>
		<cfreturn strBase64Value>
	</cffunction>


	<!--- 	base64UrlDecode(String) as String
			Description:  Decode a url encoded base64 string
	---> 
	<cffunction name="base64UrlDecode" output="false" access="public">

		<cfargument name="str" required="true">
		<cfscript>
           writeLog(text = "EncodeData base64UrlDecode amiks parsed amiks tag " & arguments.str , file = "server",type="information");
        </cfscript>

        <cfset strBase64Value = base64UrlUnescape(arguments.str) />
		<cfreturn strBase64Value>
	</cffunction>

</cfcomponent>