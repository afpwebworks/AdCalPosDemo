<cfcomponent name="Application" displayname="Application Component.">
<cfsilent> 
<!----
==========================================================================================================
Filename:     Application.cfc
Description:  Application file for AdCalPos Demo V 2
Date:         14/1/2015
Author:       Michael Kear

Revision history: 

==========================================================================================================
--->
<cfsetting showdebugoutput="no" />
<!----[  Set up basic application settings, cross-version  ]---->
<cfset this.name = "AdCalPosDemo0000001">
<cfset this.applicationTimeout = CreateTimeSpan(0,0,20,0)>
<cfset this.sessionManagement = true>
<cfset this.sessionTimeout = CreateTimeSpan(0,0,20,0)>
<cfset this.clientManagement = true>
<cfset this.clientStorage = "cookie">
<cfset this.loginStorage = "session">
<cfset this.setClientCookies = true>
<cfset this.setDomainCookies = false>
<cfset this.scriptProtect = false>
<!---[   <cfset request.austime = now() />   ]---->

<cfif cgi.HTTP_HOST contains "venture62.com">
  <cfset this.Siteversion = "production">
  <cfelseif cgi.HTTP_HOST eq "dev.adcalpos">
  <cfset this.Siteversion = "development">
  <cfelse>
  <cfset this.Siteversion = "production">
</cfif>


<!----[  
============================================================================================================
Application start and end
============================================================================================================
 ]---->

<cffunction name="onApplicationStart" returntype="boolean" output="true">
  <!--- Set up Application variables. Locking the Application scope is not necessary in this method. --->
  <cfset Application.datetimeConfigured = TimeFormat(Now(), "hh:mm tt") & "  " & DateFormat(Now(), "dd/mmm/yyyy")>
  <cfscript>
			Application.sessions = 0;
			Application.siteversion = this.siteversion;
			//Start up the coldspring main component and feed it the bean definitions xml file.  Init the configbean.cfc will initialise all the application vars from the config.XML file or database
           application.BeanFactory = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init();
		   application.BeanFactory.loadBeansFromXmlFile(expandPath("/core/config/Coldspring.xml"),true) ;
           application.beanfactory.getbean("configbean") ;
       </cfscript>
  <cfreturn true>
</cffunction>
<cffunction name="onApplicationEnd" returnType="void" output="false">
  <cfargument name="ApplicationScope" required="true">
  <cfset var appDuration = DateDiff("n", arguments.ApplicationScope.datetimeConfigured, Now())>
  <cflog file="#this.name#" type="information" text="Application ended. It was active for #appDuration# minutes.">
</cffunction>

<!----[  
============================================================================================================
Session start and end
============================================================================================================
 ]---->

<cffunction name="onSessionStart" returnType="void" output="true">
  <cfset Session.datetimeConfigured = TimeFormat( now() , "hh:mm tt") & "  " & DateFormat(Now(), "dd/mmm/yyyy")>
  <!----[  Set up the default login bean for the guest user  ]---->
  <cfscript>
			session.User = application.beanfactory.getBean("User");			
		</cfscript>
</cffunction>
<cffunction name="onSessionEnd" returnType="void" output="false">
  <cfargument name="sessionScope" type="struct" required="true">
  <cfargument name="appScope" type="struct" required="false">
  <cfset var dur = dateDiff("n", arguments.sessionScope.startup, now())>
  <!----Kill the cookies and CFID/CFTOKEN ---->
  <cfcookie name="CFID"  expires="NOW">
  <cfcookie name="CFTOKEN" expires="NOW">
</cffunction>

<!----[  
============================================================================================================
Request start and end
============================================================================================================
 ]---->
<cffunction name="onRequestStart" returnType="boolean" output="true">
  <cfargument type="string" name="targetPage" required=true>
  <cfsetting showdebugoutput="no" />
  <cfinclude template="/includes/pages/blocker.cfm" />
  
  <!--- RENEW APPLICATION VARIABLES --->
  <cfif structKeyExists(URL, "reset") AND URL.reset IS "Yes">
    <cfset applicationstop() />
    <cfset this.onApplicationStart() />
    <!----[  <cfset this.onSessionEnd() />  ]----MK ---->
    <cfset this.onSessionStart() />
  </cfif>
  <!----[  <cfset request.austime = application.beanfactory.getbean("configbean").getAustime() />   ]----MK ---->
  <cfset request.austime = now() />
  <cfreturn true>
</cffunction>
<cffunction name="onRequestEnd" returntype="void" output="true">
  <cfargument name="targetPage" required="true">
</cffunction>

<!--- Begin OnRequest Method - Executes during the page request --->
<cffunction name="onRequest" returnType="void">
  <cfargument name="thePage" type="string" required="true">
  <cfinclude template="#arguments.thePage#">
</cffunction>

<!----[  
============================================================================================================
OnError method 
============================================================================================================
 ]---->

<cffunction name="onError" returnType="void" output="true">
  <cfargument name="Exception" required="true">
  <cfargument name="EventName" required="true">
  <!----[  <cfset var errMsg = Application.utils.exceptions.GetExceptionMessage(arguments.Exception)>  ]----MK ----> 
  <!--- <cfset Application.utils.exceptions.SendExceptionEmail(this.name, arguments.Exception)> ---> 
  
  <!--- The onError method gets two arguments:
            An exception structure, which is identical to a cfcatch variable.
            The name of the Application.cfc method, if any, in which the error
            happened.
    <cfargument name="Except" required=true/>
    <cfargument type="String" name = "EventName" required=true/>
    <!--- Log all errors in an application-specific log file. --->
    <cflog file="#This.Name#" type="error" text="Event Name: #Eventname#" >
    <cflog file="#This.Name#" type="error" text="Message: #except.message#">
    <!--- Throw validation errors to ColdFusion for handling. --->
    <cfif Find("coldfusion.filter.FormValidationException",
                     Arguments.Except.StackTrace)>
        <cfthrow object="#except#">
    <cfelse>
        <!--- You can replace this cfoutput tag with application-specific 
                error-handling code. --->
        <cfoutput>
            <p>Error Event: #EventName#</p>
            <p>Error details:<br>
            <cfdump var=#except#></p>
        </cfoutput>
    </cfif> ---->
  
  <h2>An error has occurred...</h2>
  <p>
  <cfdump var="#Exception#">
  </p>
</cffunction>
<cffunction name="isLoggedIn" access="public">
  <cfreturn session.userbean.getIsloggedin() neq "No" />
</cffunction>
</cfsilent>
</cfcomponent>
