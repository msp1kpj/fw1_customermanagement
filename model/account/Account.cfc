component accessors="true" extends="model.base.Model" hint="This is the Account Model component" displayname="Account model component" {
	property name="customerId" type="numeric";
	property name="firstName" type="string";
	property name="lastName" type="string";
	property name="address" type="string";
	property name="city" type="string";
	property name="state" type="string";
	property name="postalCode" type="string";
	property name="phone" type="string";
	property name="sourceCode" type="string";
	property name="notes" type="string";

	// ------------------------ CONSTRUCTOR ------------------------ //

	public model.account.Account function init() {
		if(structKeyExists(arguments, "customerId") or ArrayLen(arguments) gte 1 ){
			setCustomerID((isDefined('arguments.customerId')?arguments.customerId : arguments[1]));
		}
		return this;
	}

	// ----------------------- Accessors -------------------------- //

	public void function setPhone(required string phone) {
		//strip non-numeric numbers
		variables.phone = ReReplaceNoCase(arguments.phone,"[^0-9]","","ALL");
		return;
	}


}