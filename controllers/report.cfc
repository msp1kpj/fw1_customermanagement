component accessors="true" output="false" displayname="Account" extends="controllers.base.Controller" {
	//DEPENDENCY INJECTION
	property name="ReportService"
		setter=true
		getter=false;

	property name="FormatUtility"
		setter=true
		getter=false;


	public void function default(required struct rc) {
		local.callData = variables.ReportService.getCallData();
		arguments.rc["chart"] = StructNew();
		arguments.rc.chart["callData"] = local.callData;
		arguments.rc.callSummary = variables.ReportService.getCallReportSummary();
		arguments.rc.nophone = variables.ReportService.getNoPhone();
		arguments.rc.noservice = variables.ReportService.getNoService();

	}


	public void function calllog(required struct rc) {
		if(isDate(arguments.rc.month)){
			arguments.rc.calllog = variables.ReportService.getCallReport(month = arguments.rc.month);
			arguments.rc.formatUtil = variables.FormatUtility;
		} else {
			arguments.rc.response["type"] = "error"; //warn, info, success, and error
			arguments.rc.response["message"] = "Need to select a valid date.";
			variables.fw.redirect( action="account.edit", preserve = "response");
		}
		return;
	}

	public void function calllogprint(required struct rc) {
		calllog(arguments.rc);
		variables.fw.setLayout("pdf");
	}

	public void function nophone(required struct rc) {
		arguments.rc.nophone = variables.ReportService.getNoPhoneFull();
	}

	public void function noservicecall(required struct rc) {
		arguments.rc.noservicecall = variables.ReportService.getNoPhoneFull();
	}





}