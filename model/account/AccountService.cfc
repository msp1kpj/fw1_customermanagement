component accessors="true" output="false" displayname="Account Service" extends="model.base.Service" {
	//DEPENDENCY INJECTION --->
	property name="AccountGateway" getter="false";


	public struct function getAccountList(required struct data) {
		return variables.AccountGateway.getAccountList( argumentCollection = arguments );
	}


	public struct function getAccount(required numeric customerId) {
		return variables.AccountGateway.getAccount( argumentCollection = arguments );
	}

	public model.account.Account function newAccount() {
		return new Account( argumentCollection = arguments );
	}


	public model.account.Account function saveAccount(required model.account.Account account) {
		return variables.AccountGateway.saveAccount( argumentCollection = arguments );
	}


	public model.account.Service function newService() {
		return new Service( argumentCollection = arguments );
	}


	public model.account.Service function saveService(required model.account.Service service) {
		return variables.AccountGateway.saveService( argumentCollection = arguments );
	}

	public boolean function removeService(required model.account.Service service) {
		return variables.AccountGateway.removeService( argumentCollection = arguments );
	}

	public boolean function removeAccount(required model.account.Account account) {
		return variables.AccountGateway.removeAccount( argumentCollection = arguments );
	}

	public query function getSourceCodeList(required string q) {
		return variables.AccountGateway.getSourceCodeList( argumentCollection = arguments );
	}

	public query function getCityList(required string q) {
		return variables.AccountGateway.getCityList( argumentCollection = arguments );
	}

	public array function getTechnicianList(required string q) {
		return variables.AccountGateway.getTechnicianList( argumentCollection = arguments );
	}

}