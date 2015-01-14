<cfsilent>
<!----
==========================================================================================================
Filename:     index.cfm
Description:  Main dashboard for public facing demo site - AdcalPos Demo V2
Date:         5/1/2015
Author:       Michael Kear, AFP Webworks

Revision history: 

==========================================================================================================
--->
<cfscript>

</cfscript>
<cfsetting showdebugoutput="no" />
<cfparam name="request.pagename" default="Dashboard">
<cfparam name="application.sitename" default="AdCalPos Demo">
</cfsilent>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<cfoutput><title>#application.sitename#<cfif len(request.pagename)>  -#request.pagename#</cfif></title></cfoutput>

<link href="/assets/css/AdcalPos.css" rel="stylesheet">
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<h1>Hello, world!</h1>

<cfdump var="#application#" />

<cfdump var="#session#" />


<script src="/assets/js/AdCalPos.js"></script>
</body>
</html>