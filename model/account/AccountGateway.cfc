component output="false" displayname="Account Gateway" extends="model.base.Gateway" {


	public struct function getAccountList(required struct data) {
		local["returnStruct"] = structNew();
		local.returnStruct["totalRecords"] = 0;
		local.returnStruct["data"] = ArrayNew(1);
		local["columnList"] = "";
		local["search"] = "";
		local["getAccountList"] = new Query(); // new query object
		local["getAccountListTotal"] =  new Query(); // new query object
		local["sqlString"] = "SELECT SQL_CALC_FOUND_ROWS c1.customerId , c1.customerIdOld, c1.firstName, c1.lastName, c1.address , c1.city, c1.state, c1.postalCode, c1.phone, c1.sourceCode FROM customer as c1 WHERE 1 = 1 ";

		if(structKeyExists(arguments.data, "sColumns") and len(trim(arguments.data.sColumns))){
			local["columnList"] = arguments.data.sColumns;
		}

		if(structKeyExists(arguments.data, "sSearch") and len(trim(arguments.data.sSearch))){
			local.search = trim(arguments.data.sSearch);
			if(left(local.search, 1) neq '%'){
				local.search = '%' & local.search;
			}
			if(right(local.search, 1) neq '%'){
				local.search = local.search & '%';
			}
			local["sqlString"] = local["sqlString"] & " AND (c1.firstName like :searchTerm OR c1.lastName like :searchTerm OR c1.address like :searchTerm OR c1.city like :searchTerm OR c1.state like :searchTerm OR c1.postalCode like :searchTerm OR c1.phone like :searchTerm OR c1.sourceCode like :searchTerm OR c1.notes like :searchTerm ) ";
			local.getAccountList.addParam(name="searchTerm",value=local.search,CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
		}

		// Column Filter
		if(structKeyExists(arguments.data, "iColumns") and isNumeric(arguments.data.iColumns) and arguments.data.iColumns gt 0){
			local["sqlString"] = local["sqlString"] & " AND ( 1 = 1 ";
			for(
				local.searchCol = 0;
				local.searchCol LTE (arguments.data.iColumns - 1);
				local.searchCol = local.searchCol + 1
			){
				if(structKeyExists(arguments.data, "sSearch_" & local.searchCol ) and len(trim(arguments.data["sSearch_" & local.searchCol])) AND (
						(structKeyExists(arguments.data, "mDataProp_" & local.searchCol) and len(arguments.data['mDataProp_' & local.searchCol]) gt 0)
						or (Len(trim(listGetAt(local["columnList"], local.searchCol+1))) gt 0))
					){
					local.tempColumn = trim(listGetAt(local["columnList"], local.searchCol+1));

					if(len(local.tempColumn) lte 0){
						local.tempColumn = arguments.data['mDataProp_' & local.searchCol];
					}

					local["sqlString"] = local["sqlString"] & " AND " & local.tempColumn & " like :" & arguments.data['mDataProp_' & local.searchCol];
					local.tempValue = arguments.data["sSearch_" & local.searchCol];
					// set search filter session
					session["search" & listLast(local.tempColumn, ".")] = local.tempValue;

					if(not Right(local.tempValue, 1) eq "%"){
						local.tempValue = local.tempValue & "%";
					}
					local.getAccountList.addParam(name=arguments.data['mDataProp_' & local.searchCol],value=local.tempValue,CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
				}
			}
			local["sqlString"] = local["sqlString"] & " ) ";
		}

		//Order by section
		local["sqlString"] = local["sqlString"] & " ORDER BY ";
		if(structKeyExists(arguments.data, "iSortingCols") and isNumeric(arguments.data.iSortingCols) and arguments.data.iSortingCols gt 0){
			for(
				local.sortCol = 0;
				local.sortCol LTE (arguments.data.iSortingCols - 1);
				local.sortCol=local.sortCol+1
			){
				if((structKeyExists(arguments.data, "iSortCol_" & local.sortCol ) AND (structKeyExists(arguments.data, "bSortable_" & arguments.data["iSortCol_" & local.sortCol]))) and
					(
						(structKeyExists(arguments.data, "mDataProp_" & arguments.data["iSortCol_" & local.sortCol]) and len(arguments.data['mDataProp_' & arguments.data["iSortCol_" & local.sortCol]]) gt 0)
						or (Len(trim(listGetAt(local["columnList"], arguments.data["iSortCol_" & local.sortCol]+1))) gt 0))
					)
				{
					if(local.sortCol gt 0){
						local["sqlString"] = local["sqlString"] & " , ";
					}
					local.tempColumn = trim(listGetAt(local["columnList"], arguments.data["iSortCol_" & local.sortCol]+1));
					if(len(local.tempColumn) lte 0){
						local.tempColumn = arguments.data['mDataProp_' & arguments.data["iSortCol_" & local.sortCol]];
					}
					local["sqlString"] = local["sqlString"] & local.tempColumn & " " & arguments.data["sSortDir_" & local.sortCol];
				}
			}
		} else {
			local["sqlString"] = local["sqlString"] & " lastName,  firstName";
		}


		if(structKeyExists(arguments.data, "iDisplayStart") and isNumeric(arguments.data.iDisplayStart) and arguments.data.iDisplayLength gt 0){
			local.sqlString = local.sqlString & " LIMIT " & val(arguments.data.iDisplayStart);
			if(structKeyExists(arguments.data, "iDisplayLength") and isNumeric(arguments.data.iDisplayLength) and arguments.data.iDisplayLength gt -1){
				local.sqlString = local.sqlString & " , " & val(arguments.data.iDisplayLength);
			}
		}


		local.getAccountList.setSQL(local.sqlString); //set query
		local.getAccountListTotal.setSQL("SELECT FOUND_ROWS() AS Total");

		local.returnStruct.data = local.getAccountList.execute().getResult();// execute query
		local.returnStruct["totalRecords"] = local.getAccountListTotal.execute().getResult().Total;

		local.getAccountListTotal.setSQL("SELECT COUNT(*) as Total FROM customer");
		local.returnStruct["allTotalRecords"] = local.getAccountListTotal.execute().getResult().Total;

		return local.returnStruct;
	}


	public Struct function getAccount(required numeric customerId) {
		local["returnStruct"] = structNew();
		local["getAccount"] = new Query();
		local["getAccountService"] = new Query();

		// Get account information
		local.getAccount.setSQL("SELECT customerId, firstName, lastName, address, city, state, postalCode, phone, sourceCode, notes FROM customer WHERE customerId = :customerId"); //set query
		local.getAccount.addParam(name="customerId",value=arguments.customerId,CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
		local.returnStruct["info"] = local.getAccount.execute().getResult();

		local.getAccountService.setSQL("SELECT serviceId, customerId, dateOfService, description, amount, technician, note FROM service WHERE customerId = :customerId ORDER BY dateOfService DESC");
		local.getAccountService.addParam(name="customerId",value=arguments.customerId,CFSQLTYPE="CF_SQL_VARCHAR"); // add query param
		local.returnStruct["data"] = local.getAccountService.execute().getResult();

		return local.returnStruct;
	}



	public model.account.Account function saveAccount(required model.account.Account account) {
		local.saveAccount = StructNew();
		local.saveAccount.query1 = new Query();
		local.saveAccount.query2 = new Query();

		if(val(arguments.account.getCustomerId()) eq 0){
			local.saveAccount.query1.setSQL("INSERT INTO customer (firstName, lastName, address, city, state, postalCode, phone, sourceCode, notes) VALUES ( :firstName , :lastName , :address , :city , :state , :postalCode , :phone , :sourceCode , :notes );");
			local.saveAccount.query2.setSQL("select last_insert_id() as customerId;");
		} else {
			local.saveAccount.query1.setSQL("UPDATE customer SET firstName = :firstName , lastName = :lastName , address = :address , city = :city, state = :state , postalCode = :postalCode , phone = :phone , sourceCode = :sourceCode , notes = :notes WHERE customerId = :customerId ;");
			local.saveAccount.query2.setSQL("SELECT :customerId As customerId");
			local.saveAccount.query1.addParam(name="customerId",value=account.getCustomerId() ,CFSQLTYPE="cf_sql_integer"); // add query param
			local.saveAccount.query2.addParam(name="customerId",value=account.getCustomerId() ,CFSQLTYPE="cf_sql_integer"); // add query param
		}
		local.saveAccount.query1.addParam(name="firstName",value=account.getFirstName() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="lastName",value=account.getLastName() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="address",value=account.getAddress() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="city",value=account.getCity() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="state",value=account.getState() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="postalCode",value=account.getPostalCode() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="phone",value=account.getPhone() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="sourceCode",value=account.getSourceCode() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveAccount.query1.addParam(name="notes",value=account.getNotes() ,CFSQLTYPE="cf_sql_varchar"); // add query param

		transaction {
			local.saveAccount.query1 = local.saveAccount.query1.execute().getResult();
			local.saveAccount.query2 = local.saveAccount.query2.execute().getResult();
		}
		arguments.account.setCustomerId(local.saveAccount.query2.customerId);

		return arguments.account;
	}

	public model.account.Service function saveService(required model.account.Service service) {
		local.saveService = StructNew();
		local.saveService.query1 = new Query();
		local.saveService.query2 = new Query();

		if(val(arguments.service.getServiceId()) eq 0){
			local.saveService.query1.setSQL("INSERT INTO service (customerId, dateOfService, description, amount, technician, note) VALUES ( :customerId , :dateOfService , :description , :amount , :technician , :note );");
			local.saveService.query2.setSQL("select last_insert_id() as serviceId;");
		} else {
			local.saveService.query1.setSQL("UPDATE service SET dateOfService = :dateOfService , description = :description , amount = :amount , technician = :technician , note = :note WHERE serviceId = :serviceId ;");
			local.saveService.query2.setSQL("SELECT :serviceId AS serviceId ");
			local.saveService.query1.addParam(name="serviceId",value=service.getServiceId() ,CFSQLTYPE="cf_sql_integer"); // add query param
			local.saveService.query2.addParam(name="serviceId",value=service.getServiceId() ,CFSQLTYPE="cf_sql_integer"); // add query param
		}
		local.saveService.query1.addParam(name="customerId",value=service.getCustomerId() ,CFSQLTYPE="cf_sql_integer"); // add query param
		local.saveService.query1.addParam(name="dateOfService",value=service.getDateOfService() ,CFSQLTYPE="cf_sql_date"); // add query param
		local.saveService.query1.addParam(name="description",value=service.getDescription() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveService.query1.addParam(name="amount",value=JavaCast("string", service.getAmount()).replaceAll('[^-?\d*(\.\d+)?]','') ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveService.query1.addParam(name="technician",value=service.getTechnician() ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.saveService.query1.addParam(name="note",value=service.getNotes() ,CFSQLTYPE="cf_sql_varchar"); // add query param

		transaction {
			local.saveService.query1 = local.saveService.query1.execute().getResult();
			local.saveService.query2 = local.saveService.query2.execute().getResult();
			arguments.service.setServiceId(local.saveService.query2.serviceId);
		}

		return arguments.service;
	}


	public boolean function removeService(required model.account.Service service) {
		local.removeService = new Query();

		if(val(arguments.service.getServiceId()) gt 0){
			local.removeService.setSQL("DELETE FROM service WHERE serviceId = :serviceId AND customerID = :customerId LIMIT 1;");
			local.removeService.addParam(name="serviceId",value=service.getServiceId() ,CFSQLTYPE="cf_sql_integer"); // add query param
			local.removeService.addParam(name="customerId",value=service.getCustomerId() ,CFSQLTYPE="cf_sql_integer"); // add query param
			local.removeService = local.removeService.execute().getPrefix();

			if(local.removeService.recordcount){
				return true;
			}
		} else {
			return false;
		}
		return false;
	}

	public boolean function removeAccount(required model.account.Account account) {
		local.removeAccount = structNew();
		local.removeAccount.query1 = new Query();
		local.removeAccount.query2 = new Query();
		if(val(arguments.account.getCustomerId()) gt 0){
			transaction {
				local.removeAccount.query1.setSQL("DELETE FROM service WHERE customerID = :customerId ;");
				local.removeAccount.query2.setSQL("DELETE FROM customer WHERE customerId = :customerId LIMIT 1;");
				local.removeAccount.query1.addParam(name="customerId",value=account.getCustomerId() ,CFSQLTYPE="cf_sql_integer"); // add query param
				local.removeAccount.query2.addParam(name="customerId",value=account.getCustomerId() ,CFSQLTYPE="cf_sql_integer"); // add query param

				local.removeAccount.query1 = local.removeAccount.query1.execute().getPrefix();
				local.removeAccount.query2 = local.removeAccount.query2.execute().getPrefix();

				if(local.removeAccount.query2.recordcount){
					return true;
				}
			}
		} else {
			return false;
		}
		return false;
	}


	public query function getSourceCodeList(required string q) {
		local.getSourceCodes = new Query();
		if(structKeyExists(arguments, "q") and right(arguments.q, 1) neq "%"){
			arguments.q = arguments.q & "%";
		}
		local.getSourceCodes.setSQL("SELECT sourceCode FROM customer WHERE sourceCode like :sourceCode GROUP BY sourceCode ORDER BY sourceCode");
		local.getSourceCodes.addParam(name="sourceCode",value=arguments.q ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.getSourceCodes = local.getSourceCodes.execute().getResult();
		return local.getSourceCodes;
	}

	public query function getCityList(required string q) {
		local.getCityList = new Query();
		if(structKeyExists(arguments, "q") and right(arguments.q, 1) neq "%"){
			arguments.q = arguments.q & "%";
		}
		local.getCityList.setSQL("SELECT city FROM customer WHERE city like :city GROUP BY city ORDER BY city");
		local.getCityList.addParam(name="city",value=arguments.q ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.getCityList = local.getCityList.execute().getResult();
		return local.getCityList;
	}

	public array function getTechnicianList(required string q) {
		local.getCityList = new Query();
		if(structKeyExists(arguments, "q") and right(arguments.q, 1) neq "%"){
			arguments.q = arguments.q & "%";
		}
		if(structKeyExists(arguments, "q") and left(arguments.q, 1) neq "%"){
			arguments.q = "%" & arguments.q;
		}
		local.getCityList.setSQL("SELECT GROUP_CONCAT(DISTINCT technician ORDER BY technician SEPARATOR ',') AS technician FROM service WHERE technician like :technician");
		local.getCityList.addParam(name="technician",value=arguments.q ,CFSQLTYPE="cf_sql_varchar"); // add query param
		local.getCityList = listToArray(local.getCityList.execute().getResult().technician);
		return local.getCityList;
	}
}
