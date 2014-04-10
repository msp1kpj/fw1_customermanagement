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
		/*
		for (cname in session) {
			if (cname != "cfid" && cname != "cftoken" && lcase(cname) contains "search"){
				session[cname] = "";
			}
		}
		*/

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
			variables.fw.redirect("main");
		}
	}

	public void function testAjax ( required struct rc){
		var melissaData = StructNew();
		var webPage = StructNew();
		var propertySearchXML = "";
		local.response = structNew();
		local.response["AddressKey"] = "";
		local.response["Property"] = StructNew();

		local.response.Property["PropertyAddress"] = StructNew();
		local.response.Property.PropertyAddress["Address"] = "";
		local.response.Property.PropertyAddress["City"] = "";
		local.response.Property.PropertyAddress["State"] = "";
		local.response.Property.PropertyAddress["Zip"] = "";
		local.response.Property.PropertyAddress["Latitude"] = "";
		local.response.Property.PropertyAddress["Longitude"] = "";

		local.response.Property["Building"] = StructNew();
		local.response.Property.Building["SquareFootage"] = "";
		local.response.Property.Building["YearBuilt"] = "";
		local.response.Property.Building["BedRooms"] = "";
		local.response.Property.Building["TotalBaths"] = "";
		local.response.Property.Building["AirConditioningCode"] = "";
		local.response.Property.Building["BasementCode"] = "";
		local.response.Property.Building["BuildingCode"] = "";
		local.response.Property.Building["Fireplace"] = "";
		local.response.Property.Building["Fireplaces"] = 0;
		local.response.Property.Building["FireplaceCode"] = "";
		local.response.Property.Building["HeatingCode"] = "";
		local.response.Property.Building["Units"] = "";
		local.response.Property.Building["ElectricityCode"] = "";
		local.response.Property.Building["FuelCode"] = "";
		local.response.Property.Building["SewerCode"] = "";
		local.response.Property.Building["WaterCode"] = "";


		local.response.Property["Owner"] = StructNew();
		local.response.Property.Owner["CorporateOwner"] = false;
		local.response.Property.Owner["Name"] = "";
		local.response.Property.Owner["Name2"] = "";
		local.response.Property.Owner["Phone"] = "";
		local.response.Property.Owner["PhoneOptOut"] = false;

		local.response.Property["OwnerAddress"] = StructNew();
		local.response.Property.OwnerAddress["Address"] = "";
		local.response.Property.OwnerAddress["Suite"] = "";
		local.response.Property.OwnerAddress["City"] = "";
		local.response.Property.OwnerAddress["State"] = "";
		local.response.Property.OwnerAddress["Zip"] = "";
		local.response.Property.OwnerAddress["MailOptOut"] = false;



		melissaData["urlRest"] = "https://addresscheck.melissadata.net/v2/REST/Service.svc/doAddressCheck?t=";
		melissaData.urlRest = melissaData.urlRest & "&id=" & arguments.rc.id;
		melissaData.urlRest = melissaData.urlRest & "&opt=" & arguments.rc.opt;
		melissaData.urlRest = melissaData.urlRest & "&comp=" & arguments.rc.comp;
		melissaData.urlRest = melissaData.urlRest & "&a1=" & arguments.rc.a1;
		melissaData.urlRest = melissaData.urlRest & "&a2=" & arguments.rc.a2;
		melissaData.urlRest = melissaData.urlRest & "&city=" & arguments.rc.city;
		melissaData.urlRest = melissaData.urlRest & "&state=" & arguments.rc.state;
		melissaData.urlRest = melissaData.urlRest & "&zip=" & arguments.rc.zip;


		http method="GET" url=melissaData.urlRest result="webPage";

		if(webPage.status_code eq 200){
			propertySearchXML = webPage.filecontent;
		}

		if(isXML(propertySearchXML)){
			propertySearchXML = XmlParse(propertySearchXML);
			local.response.AddressKey = propertySearchXML.ResponseArray.Record.Address.AddressKey.XmlText;
		}

		if(len(trim(local.response.AddressKey))) {
			melissaData.urlRest = "https://property.melissadata.net/v3/REST/Service.svc/doLookup?t=";
			melissaData.urlRest = melissaData.urlRest & "&id=" & arguments.rc.id;
			melissaData.urlRest = melissaData.urlRest & "&opt=" & arguments.rc.opt;
			melissaData.urlRest = melissaData.urlRest & "&AddressKey=" & local.response.AddressKey;

			http method="GET" url=melissaData.urlRest result="webPage";

			if(webPage.status_code eq 200){
				propertySearchXML = webPage.filecontent;
			}

			if(isXML(propertySearchXML)){
				propertySearchXML = XmlParse(propertySearchXML);

				local.response.Property.PropertyAddress["Address"] = propertySearchXML.ResponseArray.Record.PropertyAddress.Address.XmlText;
				local.response.Property.PropertyAddress["City"] = propertySearchXML.ResponseArray.Record.PropertyAddress.City.XmlText;
				local.response.Property.PropertyAddress["State"] = propertySearchXML.ResponseArray.Record.PropertyAddress.State.XmlText;
				local.response.Property.PropertyAddress["Zip"] = propertySearchXML.ResponseArray.Record.PropertyAddress.Zip.XmlText;
				local.response.Property.PropertyAddress["Latitude"] = propertySearchXML.ResponseArray.Record.PropertyAddress.Latitude.XmlText;
				local.response.Property.PropertyAddress["Longitude"] = propertySearchXML.ResponseArray.Record.PropertyAddress.Longitude.XmlText;

				local.response.Property.Owner["CorporateOwner"] = propertySearchXML.ResponseArray.Record.Owner.CorporateOwner.XmlText;
				local.response.Property.Owner["Name"] = propertySearchXML.ResponseArray.Record.Owner.Name.XmlText;
				local.response.Property.Owner["Name2"] = propertySearchXML.ResponseArray.Record.Owner.Name2.XmlText;
				local.response.Property.Owner["Phone"] = propertySearchXML.ResponseArray.Record.Owner.Phone.XmlText;
				local.response.Property.Owner["PhoneOptOut"] = propertySearchXML.ResponseArray.Record.Owner.PhoneOptOut.XmlText;

				local.response.Property.OwnerAddress["Address"] =  propertySearchXML.ResponseArray.Record.OwnerAddress.Address.XmlText;
				local.response.Property.OwnerAddress["Suite"] = propertySearchXML.ResponseArray.Record.OwnerAddress.Suite.XmlText;
				local.response.Property.OwnerAddress["City"] = propertySearchXML.ResponseArray.Record.OwnerAddress.City.XmlText;
				local.response.Property.OwnerAddress["State"] = propertySearchXML.ResponseArray.Record.OwnerAddress.State.XmlText;
				local.response.Property.OwnerAddress["Zip"] = propertySearchXML.ResponseArray.Record.OwnerAddress.Zip.XmlText;
				local.response.Property.OwnerAddress["MailOptOut"] = propertySearchXML.ResponseArray.Record.OwnerAddress.MailOptOut.XmlText;

				local.response.Property.Building["SquareFootage"] = propertySearchXML.ResponseArray.Record.SquareFootage.BuildingArea.XmlText;
				local.response.Property.Building["YearBuilt"] = propertySearchXML.ResponseArray.Record.Building.YearBuilt.XmlText;
				local.response.Property.Building["BedRooms"] = propertySearchXML.ResponseArray.Record.Building.BedRooms.XmlText;
				local.response.Property.Building["TotalBaths"] = propertySearchXML.ResponseArray.Record.Building.TotalBaths.XmlText;
				local.response.Property.Building["AirConditioningCode"] = propertySearchXML.ResponseArray.Record.Building.AirConditioningCode.XmlText;
				local.response.Property.Building["BasementCode"] = propertySearchXML.ResponseArray.Record.Building.BasementCode.XmlText;
				local.response.Property.Building["BuildingCode"] = propertySearchXML.ResponseArray.Record.Building.BuildingCode.XmlText;
				local.response.Property.Building["Fireplace"] = propertySearchXML.ResponseArray.Record.Building.Fireplace.XmlText;
				local.response.Property.Building["Fireplaces"] = propertySearchXML.ResponseArray.Record.Building.Fireplaces.XmlText;
				local.response.Property.Building["FireplaceCode"] = propertySearchXML.ResponseArray.Record.Building.FireplaceCode.XmlText;
				local.response.Property.Building["HeatingCode"] = propertySearchXML.ResponseArray.Record.Building.HeatingCode.XmlText;
				local.response.Property.Building["Units"] = propertySearchXML.ResponseArray.Record.Building.Units.XmlText;
				local.response.Property.Building["ElectricityCode"] = propertySearchXML.ResponseArray.Record.Building.ElectricityCode.XmlText;
				local.response.Property.Building["FuelCode"] = propertySearchXML.ResponseArray.Record.Building.FuelCode.XmlText;
				local.response.Property.Building["SewerCode"] = propertySearchXML.ResponseArray.Record.Building.SewerCode.XmlText;
				local.response.Property.Building["WaterCode"] = propertySearchXML.ResponseArray.Record.Building.WaterCode.XmlText;
			}
		}
		dump(local.response);
		dump(webPage);
		abort;

		// aJax exception
		if(isAjaxRequest()){
			variables.fw.disableTrace();
			variables.fw.setView( "ajax.json" );
			arguments.rc.response = variables.JSONUtility.jsonencode(data=local.response);
		} else {
			variables.fw.redirect("main");
		}

	}



}
