<cfcomponent displayname="ConfigBean" output="false" hint="A configuration bean that reads XML config file and sets the Application scope.">
<cfsilent>
<!----
=======================================================================
Filename:       ConfigBean.cfc
Description:    A configuration bean that reads XML config file and sets the Application scope.
Client:            AdCalPos Demo
Author:          Michael Kear, AFP Webworks 
Date:             14/Jan/2015
=======================================================================
This bean was generated with the following template:
Bean Name: ConfigBean
Extends: 
Call super.init(): false
Global variables:
	hometimezone string Australia/Sydney
	mgmtReportCutoff numeric 5
Bean Template:
	dsn string adcalposnet
	bansdsn string hawkesburyradio
	ftpdsn string adcalstandalone
	sitename string DEVAdCalPOS
	currentversion numeric 1
	mailserver string mail.adcalpos.net.au
	mailuser string mkear@adcalpos.net.au
	mailpassword string dk68mq^g
	sitemailindex string dev_adcalpos_demo
	webmasteremail string mkear@afpwebworks.com
Create getSnapshot method: true
Create validate method: false
Create validate interior: false
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="ConfigBean" output="false">
	       <cfargument name="argsConfigXMLname" type="string" required="yes" />
		   <cfargument name="TimezoneCFC" type="any" required="yes" />
   <!---[ Global variable arguments  ]---> 
		<cfargument name="hometimezone" type="string" required="false" default="Australia/Sydney" />
		<cfargument name="mgmtReportCutoff" type="numeric" required="false" default="5" />
   <!---[ Siteversion-specific variable arguments  ]---> 
		<cfargument name="dsn" type="string" required="false" default="adcalposnet" />
		<cfargument name="bansdsn" type="string" required="false" default="hawkesburyradio" />
		<cfargument name="ftpdsn" type="string" required="false" default="adcalstandalone" />
		<cfargument name="sitename" type="string" required="false" default="DEVAdCalPOS" />
		<cfargument name="currentversion" type="numeric" required="false" default="1" />
		<cfargument name="mailserver" type="string" required="false" default="mail.adcalpos.net.au" />
		<cfargument name="mailuser" type="string" required="false" default="mkear@adcalpos.net.au" />
		<cfargument name="mailpassword" type="string" required="false" default="dk68mq^g" />
		<cfargument name="sitemailindex" type="string" required="false" default="dev_adcalpos_demo" />
		<cfargument name="webmasteremail" type="string" required="false" default="mkear@afpwebworks.com" />
		<cfargument name="timezone" type="any" required="false" default="cfcs.utilities.TimeZone" />
		<cfset var siteversion = application.siteversion />
			<cffile action="read" 
					file="#expandPath(arguments.argsConfigXMLname)#"	
					variable="rawconfigXML"/>
			<cfset configXML = xmlparse(rawconfigXML) />	
		<cfscript>
          	    // set the base paths and ABS paths 
                  thisapprootABS = "#ExpandPath( "/" )#"; 
	            // Remove the trailing slash from the ABS paths   
                  thisapprootABS = left(thisapprootABS, (len(thisapprootABS)-1) );
          		// set base paths
          		setApprootURL("http://" &  cgi.http_host  );
          		setApprootABS(thisapprootABS);
          		setCMSABS( thisapprootABS & "cms"    ) ;	
          		setCMSURL( "http://" & cgi.http_host & "/cms"   );	

               // run globals setters
			setHometimezone(configXML.settings.globals.hometimezone.xmltext);
			setMgmtReportCutoff(configXML.settings.globals.mgmtReportCutoff.xmltext);

               // run other setters
			setDsn(configXML.settings[#siteversion#].dsn.xmltext);
			setBansdsn(configXML.settings[#siteversion#].bansdsn.xmltext);
			setFtpdsn(configXML.settings[#siteversion#].ftpdsn.xmltext);
			setSitename(configXML.settings[#siteversion#].sitename.xmltext);
			setCurrentversion(configXML.settings[#siteversion#].currentversion.xmltext);
			setMailserver(configXML.settings[#siteversion#].mailserver.xmltext);
			setMailuser(configXML.settings[#siteversion#].mailuser.xmltext);
			setMailpassword(configXML.settings[#siteversion#].mailpassword.xmltext);
			setSitemailindex(configXML.settings[#siteversion#].sitemailindex.xmltext);
			setWebmasteremail(configXML.settings[#siteversion#].webmasteremail.xmltext);
			setTimezone(arguments.TimezoneCFC);
			return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<!---[ 	ACCESSORS 	  ]--->

   <!-----[   Global accessors   ] ---->  

	<cffunction name="setHometimezone" access="public" returntype="void" output="false">
		<cfargument name="hometimezone" type="string" required="true" />
		<cfset variables.instance.hometimezone = arguments.hometimezone />
		<cfset application.hometimezone = arguments.hometimezone />
	</cffunction>
	<cffunction name="getHometimezone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.hometimezone />
	</cffunction>

	<cffunction name="setMgmtReportCutoff" access="public" returntype="void" output="false">
		<cfargument name="mgmtReportCutoff" type="numeric" required="true" />
		<cfset variables.instance.mgmtReportCutoff = arguments.mgmtReportCutoff />
		<cfset application.mgmtReportCutoff = arguments.mgmtReportCutoff />
	</cffunction>
	<cffunction name="getMgmtReportCutoff" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.mgmtReportCutoff />
	</cffunction>


   <!-----[   Siteversion specific accessors   ] ---->  

	<cffunction name="setDsn" access="public" returntype="void" output="false">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.instance.dsn = arguments.dsn />
		<cfset application.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.dsn />
	</cffunction>

	<cffunction name="setBansdsn" access="public" returntype="void" output="false">
		<cfargument name="bansdsn" type="string" required="true" />
		<cfset variables.instance.bansdsn = arguments.bansdsn />
		<cfset application.bansdsn = arguments.bansdsn />
	</cffunction>
	<cffunction name="getBansdsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.bansdsn />
	</cffunction>

	<cffunction name="setFtpdsn" access="public" returntype="void" output="false">
		<cfargument name="ftpdsn" type="string" required="true" />
		<cfset variables.instance.ftpdsn = arguments.ftpdsn />
		<cfset application.ftpdsn = arguments.ftpdsn />
	</cffunction>
	<cffunction name="getFtpdsn" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ftpdsn />
	</cffunction>

	<cffunction name="setSitename" access="public" returntype="void" output="false">
		<cfargument name="sitename" type="string" required="true" />
		<cfset variables.instance.sitename = arguments.sitename />
		<cfset application.sitename = arguments.sitename />
	</cffunction>
	<cffunction name="getSitename" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sitename />
	</cffunction>

	<cffunction name="setCurrentversion" access="public" returntype="void" output="false">
		<cfargument name="currentversion" type="numeric" required="true" />
		<cfset variables.instance.currentversion = arguments.currentversion />
		<cfset application.currentversion = arguments.currentversion />
	</cffunction>
	<cffunction name="getCurrentversion" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.currentversion />
	</cffunction>

	<cffunction name="setMailserver" access="public" returntype="void" output="false">
		<cfargument name="mailserver" type="string" required="true" />
		<cfset variables.instance.mailserver = arguments.mailserver />
		<cfset application.mailserver = arguments.mailserver />
	</cffunction>
	<cffunction name="getMailserver" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailserver />
	</cffunction>

	<cffunction name="setMailuser" access="public" returntype="void" output="false">
		<cfargument name="mailuser" type="string" required="true" />
		<cfset variables.instance.mailuser = arguments.mailuser />
		<cfset application.mailuser = arguments.mailuser />
	</cffunction>
	<cffunction name="getMailuser" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailuser />
	</cffunction>

	<cffunction name="setMailpassword" access="public" returntype="void" output="false">
		<cfargument name="mailpassword" type="string" required="true" />
		<cfset variables.instance.mailpassword = arguments.mailpassword />
		<cfset application.mailpassword = arguments.mailpassword />
	</cffunction>
	<cffunction name="getMailpassword" access="public" returntype="string" output="false">
		<cfreturn variables.instance.mailpassword />
	</cffunction>

	<cffunction name="setSitemailindex" access="public" returntype="void" output="false">
		<cfargument name="sitemailindex" type="string" required="true" />
		<cfset variables.instance.sitemailindex = arguments.sitemailindex />
		<cfset application.sitemailindex = arguments.sitemailindex />
	</cffunction>
	<cffunction name="getSitemailindex" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sitemailindex />
	</cffunction>

	<cffunction name="setWebmasteremail" access="public" returntype="void" output="false">
		<cfargument name="webmasteremail" type="string" required="true" />
		<cfset variables.instance.webmasteremail = arguments.webmasteremail />
		<cfset application.webmasteremail = arguments.webmasteremail />
	</cffunction>
	<cffunction name="getWebmasteremail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.webmasteremail />
	</cffunction>

	<cffunction name="setApprootURL" access="public" returntype="void" output="false">
		<cfargument name="ApprootURL" type="any" required="true" />
		<cfset variables.instance.ApprootURL = arguments.ApprootURL />
		<cfset application.ApprootURL = arguments.ApprootURL />
	</cffunction>
	<cffunction name="getApprootURL" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ApprootURL />
	</cffunction> 

	<cffunction name="setApprootABS" access="public" returntype="void" output="false">
		<cfargument name="ApprootABS" type="any" required="true" />
		<cfset variables.instance.ApprootABS = arguments.ApprootABS />
		<cfset application.ApprootABS = arguments.ApprootABS />
	</cffunction>
	<cffunction name="getApprootABS" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ApprootABS />
	</cffunction> 

	<cffunction name="setCMSABS" access="public" returntype="void" output="false">
		<cfargument name="CMSABS" type="any" required="true" />
		<cfset variables.instance.CMSABS = arguments.CMSABS />
		<cfset application.CMSABS = arguments.CMSABS />
	</cffunction>
	<cffunction name="getCMSABS" access="public" returntype="any" output="false">
		<cfreturn variables.instance.CMSABS />
	</cffunction> 

	<cffunction name="setCMSURL" access="public" returntype="void" output="false">
		<cfargument name="CMSURL" type="any" required="true" />
		<cfset variables.instance.CMSURL = arguments.CMSURL />
		<cfset application.CMSURL = arguments.CMSURL />
	</cffunction>
	<cffunction name="getCMSURL" access="public" returntype="any" output="false">
		<cfreturn variables.instance.CMSURL />
	</cffunction> 


	<cffunction name="setTimezone" access="public" returntype="void" output="false">
		<cfargument name="timezone" type="any" required="true" />
		<cfset variables.instance.timezone = arguments.timezone />
	</cffunction>
	<cffunction name="getTimezone" access="public" returntype="any" output="false">
		<cfreturn variables.instance.timezone />
	</cffunction> 

	<cffunction name="getAustime" access="public" returntype="any" output="no" hint="returns the current time (i.e. Australian time) in the local time zone">
		<cfreturn	getTimezone().castFromServer(now(),gethometimezone() ) />
	</cffunction>

</cfcomponent>