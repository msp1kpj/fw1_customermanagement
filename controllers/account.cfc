component accessors="true" output="false" displayname="Account" extends="controllers.base.Controller" {
	//DEPENDENCY INJECTION
	property name="AccountService"
		setter=true
		getter=false;

	property name="JSONUtility"
		setter=true
		getter=false;

	property name="_"
		setter=true
		getter=false;


	//PUBLIC METHODS



	public void function edit(required struct rc) {
		if(structKeyExists(arguments.rc, "chk") AND structKeyExists(arguments.rc, "customerId") AND hash(arguments.rc.customerId) eq arguments.rc.chk) {
			session.userDelete = CreateUUID();
			arguments.rc.account = variables.AccountService.getAccount(arguments.rc.customerId);
			if(arguments.rc.account.info.recordcount eq 0){
				variables.fw.redirect( action="main.default", preserve = "response" );
			}
			arguments.rc.techlist = variables.AccountService.getTechnicianList(q = "");
			arrayAppend(arguments.rc.techlist, "Service Call");
			arguments.rc.techlist = deDupeArray(arguments.rc.techlist);
			ArraySort(arguments.rc.techlist, "textNoCase");
		} else {
			arguments.rc.response["type"] = "error"; //warn, info, success, and error
			arguments.rc.response["message"] = "Security alert unable to view account.";
			variables.fw.redirect( action="main.default", preserve = "response");
		}

		return;
	}


	public void function saveCustomer(required struct rc) {
		arguments.rc.response = structNew();
		//update the user object with the data entered
		arguments.rc.account = variables.AccountService.newAccount();

		variables.fw.populate(cfc = arguments.rc.account, trim=true);

		variables.AccountService.saveAccount(arguments.rc.account);

		arguments.rc.response["type"] = "success"; //warn, info, success, and error
		arguments.rc.response["message"] = "Account was successfully saved.";

		variables.fw.redirect( action="account.edit", preserve = "response", queryString="customerId=#arguments.rc.account.getCustomerId()#&chk=#hash(arguments.rc.account.getCustomerId())#" );
          return;
	}


	public void function saveService(required struct rc) {
		arguments.rc.response = structNew();
		// update the service object with data entered
		arguments.rc.service = variables.AccountService.newService();


		if(IsArray(form.getPartsArray())){
			local.formData = structNew();

			for(parts in form.getPartsArray()){
				if(structKeyExists(local.formData, parts.getName())){
					if(isArray(local.formData[parts.getName()])){
						arrayAppend(local.formData[parts.getName()], parts.getStringValue());
					} else {
						local.tempVal = duplicate(local.formData[parts.getName()]);
						local.formData[parts.getName()] = arrayNew(1);
						arrayAppend(local.formData[parts.getName()], local.tempVal);
						arrayAppend(local.formData[parts.getName()], parts.getStringValue());
					}
				} else {
					local.formData[parts.getName()] = parts.getStringValue();
				}
			}
			structAppend(arguments.rc, local.formData, true);
		}

		if(StructKeyExists(arguments.rc, "amount") and IsArray(arguments.rc.amount)){
			for(local.i = 1; local.i lte ArrayLen(arguments.rc.amount); local.i = local.i + 1) {
				if(len(trim(arguments.rc.description[local.i])) or LEN(TRIM(arguments.rc.amount[local.i]))) {
					local.serviceForm = arguments.rc.service;
					local.serviceForm.setCustomerId(arguments.rc.customerId);
					local.serviceForm.setServiceId(arguments.rc.serviceId);
					local.serviceForm.setDateOfService(arguments.rc.dateOfService);
					local.serviceForm.setTechnician(arguments.rc.technician);
					local.serviceForm.setNotes(arguments.rc.notes);
					local.serviceForm.setAmount(arguments.rc.amount[local.i]);
					local.serviceForm.setDescription(arguments.rc.description[local.i]);

					variables.AccountService.saveService( arguments.rc.service );
				}
			}
		} else {
			variables.fw.populate(cfc = arguments.rc.service, trim=true);
			variables.AccountService.saveService( arguments.rc.service );
		}

		arguments.rc.response["type"] = "success"; //warn, info, success, and error
		arguments.rc.response["message"] = "Service was successfully saved.";
		variables.fw.redirect( action="account.edit", preserve = "response", queryString="customerId=#arguments.rc.service.getCustomerId()#&chk=#hash(arguments.rc.service.getCustomerId())#" );
		return;
	}


	public void function removeService(required struct rc) {
		arguments.rc.response = structNew();
		arguments.rc.service = variables.AccountService.newService();
		variables.fw.populate(cfc = arguments.rc.service, trim=true);
		if(variables.AccountService.removeService(arguments.rc.service)){
			arguments.rc.response["type"] = "success"; //warn, info, success, and error
			arguments.rc.response["message"] = "Service was successfully removed.";
		} else {
			arguments.rc.response["type"] = "success"; //warn, info, success, and error
			arguments.rc.response["message"] = "Service was unable to be removed.";
		}
		variables.fw.redirect( action="account.edit", preserve = "response", queryString="customerId=#arguments.rc.service.getCustomerId()#&chk=#hash(arguments.rc.service.getCustomerId())#" );
		return;
	}


	public void function removeAccount(required struct rc) {
		if(structKeyExists(arguments.rc, "chk") AND hash(session.userDelete) eq arguments.rc.chk){
			session.userDelete = CreateUUID();
			arguments.rc.response = StructNew();
			arguments.rc.account = variables.AccountService.newAccount();

			variables.fw.populate(cfc = arguments.rc.account, trim=true);

			if(variables.AccountService.removeAccount( arguments.rc.account )) {
				arguments.rc.response["type"] = "success"; //warn, info, success, and error
				arguments.rc.response["message"] = "Account was successfully removed.";
				variables.fw.redirect( action="main.default", preserve = "response", queryString="customerId=#arguments.rc.account.getCustomerId()#" );
			} else {
				arguments.rc.response["type"] = "error"; //warn, info, success, and error
				arguments.rc.response["message"] = "Account was unable to be removed.";
				variables.fw.redirect( action="account.edit", preserve = "response", queryString="customerId=#arguments.rc.account.getCustomerId()#" );
			}
		} else {
			arguments.rc.response["type"] = "error"; //warn, info, success, and error
			arguments.rc.response["message"] = "Security alert unable to remove account.";
			variables.fw.redirect( action="account.edit", preserve = "response,customerId");
		}
		return;
	}


	public void function getSourceCodeList(required struct rc) {
		local.response["options"] = arrayNew(1);

		local.data = variables.AccountService.getSourceCodeList(q = arguments.rc.q);

		for (i=1; i <= local.data.RecordCount; i++) {
			arrayAppend(local.response.options, local.data.sourceCode[i]);
		}

		arguments.rc.response = local.response;

		// aJax exception
		if(isAjaxRequest()){
			variables.fw.disableTrace();
			variables.fw.setView( "ajax.json" );
			arguments.rc.response = variables.JSONUtility.jsonencode(data=arguments.rc.response);
		}
		return;
	}


	public void function getCityList(required struct rc) {
		local.response["options"] = arrayNew(1);

		local.data = variables.AccountService.getCityList(q = arguments.rc.q);

		for (i=1; i <= local.data.RecordCount; i++) {
			arrayAppend(local.response.options, local.data.city[i]);
		}

		arguments.rc.response = local.response;

		// aJax exception
		if(isAjaxRequest()){
			variables.fw.disableTrace();
			variables.fw.setView( "ajax.json" );
			arguments.rc.response = variables.JSONUtility.jsonencode(data=arguments.rc.response);
		}
		return;
	}




	/**
	 * Removes duplicate values from an array.
	 *
	 * @param inputArray      Array to dedupe. (Required)
	 * @return Returns an array.
	 * @author Dave Anderson (the.one.true.dave.anderson@gmail.com)
	 * @version 1, April 26, 2012
	 */
	public array function deDupeArray(required array inputArray) {
	    local.arrList = arrayToList(inputArray);
	    local.retArr = inputArray;
	    for (local.i = arrayLen(inputArray);i gte 1;i=i-1) {
	        if (listValueCountNoCase(arrList,inputArray[i]) gt 1) {
	            arrayDeleteAt(retArr,i);
	            arrList = arrayToList(retArr);
	        }
	    }
	    return retArr;
	}
}
