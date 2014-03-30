component accessors="true" output="false" displayname="Report Service" extends="model.base.Service" {
	//DEPENDENCY INJECTION --->
	property name="ReportGateway" getter="false";

	public query function getCallData() {
		return variables.ReportGateway.getCallData( argumentCollection = arguments );
	}

	public query function getCallReportSummary() {
		return variables.ReportGateway.getCallReportSummary( argumentCollection = arguments );
	}

	public query function getCallReport(required date month) {
		return variables.ReportGateway.getCallReport( argumentCollection = arguments );
	}

	public struct function getNoPhone(){
		return variables.ReportGateway.getNoPhone( argumentCollection = arguments );
	}

	public query function getNoPhoneFull(){
		return variables.ReportGateway.getNoPhoneFull( argumentCollection = arguments );
	}

	public struct function getNoService() {
		return variables.ReportGateway.getNoService( argumentCollection = arguments );
	}

	public query function getNoServiceFull() {
		return variables.ReportGateway.getNoServiceFull( argumentCollection = arguments );
	}
}