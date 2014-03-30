component output="false" displayname="Geo Coding Utility Gateway" {
	// ------------------------ CONSTRUCTOR ------------------------ //

	public model.Utility.GeoCodingUtility function init() {
		return this;
	}


	public struct function getGeoCode(required string address) {
		var i = 0;
		local.baseURL = "http://maps.googleapis.com/maps/api/geocode/xml?sensor=false&";
		local.result = structNew();

		local.baseURL = local.baseURL & "address=" & urlEncodedFormat(arguments.address);
		try{
			local.httpResult = new http(url=local.baseURL);
			local.xmlResult = xmlParse(local.httpResult.fileContent);
		} catch(any e) {
			return local.result;
		}

		if(structKeyExists(local, "httpResult") and local.httpResult.status_code eq 200 and structKeyExists(local, "xmlResult") and isXML(local.xmlResult)){
			local.result["originaladdress"] = arguments.address;
			local.geocode = local.xmlResult.GeocodeResponse.result[arrayLen(local.xmlResult.GeocodeResponse.result)];
			local.result["formattedaddress"] = local.geocode.formatted_address.XmlText;
			local.result["longitude"] = local.geocode.geometry.location.lng.XmlText;
			local.result["latitude"]  = local.geocode.geometry.location.lat.XmlText;
			for(i=1; i <= arrayLen(local.geocode.address_component); i++) {
				local.AddressComponent = local.geocode.address_component[i];
				switch(lcase(local.AddressComponent.type[1].XmlText)){
					case "country":
						local.result["countrynamecode"]  = local.AddressComponent.short_name.XmlText;
						break;
					case "administrative_area_level_1":
						local.result["statenamecode"]  = local.AddressComponent.short_name.XmlText;
						break;
					case "administrative_area_level_2":
						local.result["countynamecode"] = local.AddressComponent.short_name.XmlText;
						break;
					case "locality":
						local.result["cityName"] = local.AddressComponent.short_name.XmlText;
						break;
					case "route":
						local.result["streetName"] = local.AddressComponent.short_name.XmlText;
						break;
					case "street_number":
						local.result["streetNumber"] = local.AddressComponent.short_name.XmlText;
						break;
					case "postal_code":
						local.result["postalCode"] = local.AddressComponent.short_name.XmlText;
						break;
				}
			}
		} else {
			return local.result;
		}
		return local.result;
	}


}