<cfoutput>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
		<meta name="description" content="Homeplace Mechanical: Customer Management System">
		<meta name="author" content="Ken John <kjohn@kjsbh.com>">

		<title>Homeplace Mechanical: Customer Management System</title>

		<link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" />
		<link rel="stylesheet" type="text/css" href="/assets/css/homeplace.min.css" />
		<link rel="icon" type="image/jpeg" href="/assets/images/favicon.jpg" />

		<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
		<!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

	</head>
	<!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
	<!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
	<!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
	<!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
	<!--[if (gt IE 9)|!(IE)]><!-->
	<body class="">
	<!--<![endif]-->
		<header class="navbar" role="banner">
			<div class="navbar-inner">
				<div class="container-fluid">
					<cfif structKeyExists(rc, "currentUser") and not IsNull(rc.currentUser.getUserID())>
					<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			          </button>
			          </cfif>
			          <a class="brand" href="#buildURL('main')#"><h1 class="logo fontZrnic">Homeplace Mechanical</h1></a>
			          <cfif structKeyExists(rc, "currentUser") and not IsNull(rc.currentUser.getUserID())>
			          <div class="nav-collapse collapse">
						<ul class="nav pull-right">
							<li><a href="#buildurl("report")#">Reports</a></li>
							<li><a href="#buildurl("user.default")#">Security</a></li>
							<li class="dropdown">
                					<a href="##" class="dropdown-toggle" data-toggle="dropdown">Hi, #rc.currentUser.getName()# <b class="caret"></b></a>
                					<ul class="dropdown-menu">
                						<li><a href="#buildURL('user.profile?userid=' & rc.currentUser.getUserID())#"><span class="icon-edit"></span> Edit Profile</a></li>
									<li class="divider"></li>
									<li><a href="#buildURL('security.logout')#"><span class="icon-off"></span> Sign Out</a></li>
                					</ul>
                				</li>
						</ul>
			          </div><!--/.nav-collapse -->
			          </cfif>
				</div>
			</div>

		</header>
		<div class="container-fluid">#body#</div>
		<div id="footer" role="contentinfo">
			<div class="container">
				<div class="row">
					<div class="span12">
						<p>
							<a href="#buildURL('main')#">Copyright</a>  &copy; #year(now())# All Rights. Powered by FW/1 version #variables.framework.version#.
							<a href="##" id="top-of-page" class="pull-right">Back to top <i class="icon-chevron-up"></i></a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript" src="//code.jquery.com/jquery.js"></script>
		<script type="text/javascript" src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			$( document ).ready( function() {
				$( this ).ajaxError( function( e, jqXHR, settings, exception ) {
					if( jqXHR.status == 403 ) {
						location.href = '#buildURL("security.logout")#';
						throw new Error( 'Login Required' );
					} else if ( jqXHR.status == 417 ) {
						alert("An error occurred. System administrator has been notified.");
						throw new Error( 'Exception Occurred' );
					} else if( !jqXHR.statusText == 'abort' && jqXHR.getAllResponseHeaders() ) {
						alert( 'There was an error processing your request.\nPlease try again or contact customer service.\nError: ' + jqXHR.statusText );
					}
				});
			});
		</script>
		<cfif structKeyExists(request, "context") and structKeyExists(request.context, "footertext")>#request.context.footertext#</cfif>
	</body>
</html>
</cfoutput>
