component accessors="true" extends="model.base.Model" hint="This is the Service Model component" displayname="Service model component" {
	property name="serviceId" type="numeric";
	property name="customerId" type="numeric";
	property name="amount" type="string";
	property name="dateOfService" type="string";
	property name="notes" type="string";
	property name="technician" type="string";
	property name="description" type="string";

	// ------------------------ CONSTRUCTOR ------------------------ //

	public model.account.Service function init() {
		if(structKeyExists(arguments, "customerId") or ArrayLen(arguments) gte 1 ){
			setCustomerID((isDefined('arguments.customerId')?arguments.customerId : arguments[1]));
		}
		return this;
	}

	// -------------------- accessors ------------------------------ //

	public numeric function getAmount() {
		if(!structKeyExists(variables, "amount") or len(variables.amount) lte 0){
			variables.amount = 0;
		}
		return variables.amount;
	}

	public string function getTechnician() {
		if(getAmount() eq 0 AND (!structKeyExists(variables, "technician") or len(variables.technician) lte 0)){
			variables.technician = "Service Call";
		}
		return ArrayToList(ListToArray(variables.technician));
	}


}