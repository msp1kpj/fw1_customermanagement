component accessors="true" displayname="Main" extends="controllers.base.Controller" {
	//DEPENDENCY INJECTION
	property name="AccountService"
		setter=true
		getter=false;

	property name="JSONUtility"
		setter=true
		getter=false;

	//PUBLIC METHODS
	public void function default( required struct rc ){
		session.userDelete = CreateUUID();
	}


	public void function accountList(required struct rc) {
		var col = 0;
		var i = 0;
		param name='arguments.rc.sEcho' default='' type='string';
		// Clear Search cookies
		for (cname in session) {
			if (cname != "cfid" && cname != "cftoken" && lcase(cname) contains "search"){
				session[cname] = "";
			}
		}

		local.query = variables.AccountService.getAccountList( arguments.rc );

		local.data = local.query.data;
		local.aColumns = listToArray(local.data.ColumnList);

		local.response = structNew();
		local.response['aaData'] = ArrayNew(1);

		for (i=1; i <= local.data.RecordCount; i++) {
			local.row = arrayNew(1);
			local.colObject = structNew();

			for (col=1; col lte arrayLen(local.aColumns); col++) {
				//arrayAppend(local.row, local.data[local.aColumns[col]][i]);
				local.colObject[local.aColumns[col]] = local.data[local.aColumns[col]][i];
			}
			local.colObject['hashCheck'] = hash(local.data['customerId'][i]);
			arrayAppend(local.response['aaData'], local.colObject);
		}

		local.response['sEcho'] = arguments.rc.sEcho;
		local.response['iTotalRecords'] = local.query.allTotalRecords;
		local.response['iTotalDisplayRecords'] = local.query.totalRecords;


		arguments.rc.response = local.response;

		// aJax exception
		if(isAjaxRequest()){
			variables.fw.disableTrace();
			variables.fw.setView( "ajax.json" );
			arguments.rc.response = variables.JSONUtility.jsonencode(data=arguments.rc.response);
		} else {
			variables.fw.redirect("main");
		}
		return;
	}

	public void function accountDetail( required struct rc ){
		local.response = structNew();
		if(structKeyExists(arguments.rc, "customerId")) {
			local.response["account"] = variables.AccountService.getAccount(arguments.rc.customerId);
		}


		// aJax exception
		if(isAjaxRequest()){
			variables.fw.disableTrace();
			variables.fw.setView( "ajax.json" );
			arguments.rc.response = variables.JSONUtility.jsonencode(data=local.response);
		} else {
			dump(local);
			abort;
			variables.fw.redirect("main");
		}
	}



}
