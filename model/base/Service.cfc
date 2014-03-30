component output="false" displayname="Base Service"{

	/**
     * I populate an entity
	*/
	private void function populate( required Entity, required struct memento, boolean trustedSetter=false, string include="", string exclude="" ){
		var populate = true;
		for( var key in arguments.memento ){
			populate = true;
			if( Len( arguments.include ) && !ListFindNoCase( arguments.include, key ) ) populate = false;
			if( Len( arguments.exclude ) && ListFindNoCase( arguments.exclude, key ) ) populate = false;
			if( populate && ( StructKeyExists( arguments.Entity, "set" & key ) || arguments.trustedSetter ) ) Evaluate( "arguments.Entity.set#key#(arguments.memento[key])" );
		}
	}
}