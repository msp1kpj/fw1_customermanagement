<cfsetting showdebugoutput="false"/>
<cfscript>
	disableTrace();
</cfscript>
<!---
<cfheader name="Content-disposition" value="attachment;filename=your_filename.pdf" />
<cfcontent type="application/pdf" />
--->
<!---
<cfdocument format="PDF" pagetype="letter" orientation="portrait" fontembed="true" marginleft=".25" marginright=".25">
	--->
	<!doctype html>
	<html lang="en">
		<head>
			<meta charset="utf-8" />
			<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<meta name="description" content="">
			<meta name="author" content="">

			<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" />
			<link rel="stylesheet" type="text/css" href="/assets/css/callReport.css" />
		</head>
		<body>
			<header class="navbar navbar-fixed-top">
				<div class="navbar-inner">
					<div class="container-fluid">
						<a class="brand" href="<cfoutput>#buildURL('main')#</cfoutput>"><h1 class="logo fontZrnic">Homeplace Mechanical</h1></a>
					</div>
				</div>
			</header>
			<div class="container-fluid"><cfoutput>#body#</cfoutput></div>
			<footer class="row">
				<p class="pull-right muted">Copyright &copy; <cfoutput>#year(now())#</cfoutput> All Rights</p>
			</footer>
		</body>
	</html>
<!---
</cfdocument>
--->
<cfscript>
	 request.layout = false;
</cfscript>