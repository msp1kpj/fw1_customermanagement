/**
*
* @file  Application.cfc
* @author Ken John kjohn@kjsbh.com
* @description Default application component to extend the root application framework.
*
*/

component output="false" displayname="Application" extends="frameworks.org.corfield.framework" {
	this.applicationroot = getDirectoryFromPath( getCurrentTemplatePath() );
	this.name = "HomeplaceAdmin_" & Hash( this.applicationroot );
	this.sessionManagement  = true;
	this.mappings[ "/model" ] = this.applicationroot & "model/";
	this.customtagpaths = this.applicationroot & "customtags\";
	this.datasource = "HomePlaceDB";
	this.ormenabled = false;
	// note: IsLocalHost on CF returns YES|NO which can't be passed to hibernate
	this.development = IsLocalHost(CGI.REMOTE_ADDR) ? true : false;
	/*
	this.ormsettings = {
		flushatrequestend = false
		, automanagesession = false
		, cfclocation = this.mappings[ "/model" ]
		, eventhandling = true
		, eventhandler = "model.aop.GlobalEventHandler"
		, logsql = true
		, dialect = "MySQL5"
		// secondary cache temporarily disabled for application to work in Railo 4
		// bug reported to Railo team - https://issues.jboss.org/browse/RAILO-2233
		//, secondarycacheenabled = true
	};
	*/
	variables.framework = {
		SESOmitIndex = true
		, cacheFileExists = false
		, trace = false
		, reloadApplicationOnEveryRequest = this.development
	};

	// ------------------------ PUBLIC METHODS ------------------------ //

	public void function setupApplication() {
		var inet = CreateObject("java", "java.net.InetAddress").getLocalHost();
		application.server_hostname = inet.getHostName();
		application['datasource'] = this.datasource;
		application['EncryptionKey'] = 'j65wGLy7cYGjE4zEJ31gm5KrOW8h2Yzm';

		// setup bean factory
		var beanfactory = new frameworks.org.corfield.ioc( "/model", { singletonPattern = "(Service|Gateway)$" } );
		setBeanFactory( beanfactory );

		// add config bean to factory
		beanFactory.addBean( "config", getConfiguration() );
		/*
		beanFactory.addBean( "JSONUtility", new model.utility.JSONUtility() );
		beanFactory.addBean( "GeoCodingUtility", new model.utility.GeoCodingUtility() );
		beanFactory.addBean( "FormatUtility", new model.utility.FormatUtility() );
		beanFactory.addBean( "_", new model.utility.Underscore() );
		*/

	}


	public void function setupRequest() {
		request.context['server_hostname'] = application.server_hostname;
		controller('security.authorize');
	}

	public void function disableTrace(){
		variables.framework.trace = false;
	}

	public void function enableTrace(){
		variables.framework.trace = true;
	}

	/**
	 * Allows you to specify the mask you want added to your phone number.
	 * v2 - code optimized by Ray Camden
	 * v3.01
	 * v3.02 added code for single digit phone numbers from John Whish
	 * v4 make a default format - by James Moberg
	 *
	 * @param varInput      Phone number to be formatted. (Required)
	 * @param varMask      Mask to use for formatting. x represents a digit. Defaults to (xxx) xxx-xxxx (Optional)
	 * @return Returns a string.
	 * @author Derrick Rapley (adrapley@rapleyzone.com)
	 * @version 4, February 11, 2011
	 */
	public string function phoneFormat(varInput) {
		var curPosition = "";
		var i = "";
		var varMask = "(xxx) xxx-xxxx";
		var newFormat = "";
		var startpattern = "";
		if (arrayLen(arguments) gte 2){ varMask = arguments[2]; }
		newFormat = trim(ReReplace(varInput, "[^[:digit:]]", "", "all"));
		startpattern = ReReplace(ListFirst(varMask, "- "), "[^x]", "", "all");
		if (Len(newFormat) gte Len(startpattern)) {
			varInput = trim(varInput);
			newFormat = " " & reReplace(varInput,"[^[:digit:]]","","all");
			newFormat = reverse(newFormat);
			varmask = reverse(varmask);
			for (i=1; i lte len(trim(varmask)); i=i+1) {
				curPosition = mid(varMask,i,1);
				if(curPosition neq "x") newFormat = insert(curPosition,newFormat, i-1) & " ";
			}
			newFormat = reverse(newFormat);
			varmask = reverse(varmask);
		}
		return trim(newFormat);
	}


	// ------------------------ PRIVATE METHODS ------------------------ //

	private struct function getConfiguration(){
		var config = {
			name = application.applicationname
			, development = false
			, enquiry = {
				enabled = true
				, subject = "Enquiry"
				, emailto = ""
			}
			, exceptiontracker = {
				emailnewexceptions = true
				, emailnewexceptionsto = ""
				, emailnewexceptionsfrom = ""
				, emailexceptionsashtml = true
			}
			, revision = Hash( Now() )
			, security = {
				resetpasswordemailfrom = "homeplaceapp@homeplacefurnace.com"
				, resetpasswordemailsubject = "Password Reset for Homeplace"
				, whitelist = "^security,main.error" // list of unsecure actions - by default all requests require authentication
			}
			, storage = "session"
			, version = "2013.1.6"
		};
		// override config in development mode
		if( config.development ){
			config.enquiry.emailto = "";
			config.exceptiontracker.emailnewexceptions = false;
			config.security.resetpasswordemailfrom = "";
		}


		return config;
	}
}
