component accessors="true"{

	/**
	 * I send an email
	 */
	void function send( required string subject, required string to, required string from, required string body, string type="html", numeric port=587 ){
		var Email = new mail();
		Email.setServer("smtp.gmail.com");
		Email.setPort(arguments.port);
		Email.setUsername( "webmaster@homeplacefurnace.com" );
		Email.setPassword( "CMtkt93snvip" );
		Email.setUseTLS(true);
		Email.setSubject( arguments.subject );
		Email.setTo( arguments.to );
		Email.setFrom( arguments.from );
		Email.setBody( arguments.body );
		Email.setType( arguments.type );

		Email.send();
	}

}