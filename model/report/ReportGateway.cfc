component output="false" displayname="Report Gateway" extends="model.base.Gateway" {

	public query function getCallData() {
		local.getCallData = new Query();
		local.getCallData.setSQL("SELECT year(ServiceCallMonth) as ServiceCallYear, MONTHNAME(STR_TO_DATE(month(ServiceCallMonth), '%m')) ServiceCallMonthName, ServiceCallMonth, Count(*) as Calls FROM (SELECT DISTINCT STR_TO_DATE(CONCAT(month(s1.dateOfService), '/01/', year(s1.dateOfService)), '%m/%d/%Y') as ServiceCallMonth , s1.customerID FROM service as s1 INNER JOIN customer as c1 on s1.customerId = c1.customerId WHERE  NULLIF(TRIM(phone), '') is not null and s1.technician like '%Service Call%' AND STR_TO_DATE(CONCAT(month(s1.dateOfService), '/01/', year(s1.dateOfService)), '%m/%d/%Y') BETWEEN DATE_ADD(DATE_ADD(NOW(),INTERVAL -1 YEAR),INTERVAL -31 DAY) AND DATE_ADD(DATE_ADD(NOW(),INTERVAL 1 YEAR),INTERVAL 31 DAY) ) AS t1 GROUP BY ServiceCallMonth ORDER BY ServiceCallMonth;"); //set query
		local.getCallData = local.getCallData.execute().getResult();
		return local.getCallData;
	}


	public query function getCallReportSummary() {
		local.getCallReportSummary = new Query();
		local.getCallReportSummary.setSQL("SELECT year(ServiceCallMonth) as ServiceCallYear, MONTHNAME(STR_TO_DATE(month(ServiceCallMonth), '%m')) ServiceCallMonthName, ServiceCallMonth, Count(*) as Calls FROM (SELECT DISTINCT STR_TO_DATE(CONCAT(month(s1.dateOfService), '/01/', year(s1.dateOfService)), '%m/%d/%Y') as ServiceCallMonth , s1.customerID FROM service as s1 INNER JOIN customer as c1 on s1.customerId = c1.customerId WHERE NULLIF(TRIM(phone), '') is not null AND s1.technician like '%Service Call%' AND STR_TO_DATE(CONCAT(month(s1.dateOfService), '/01/', year(s1.dateOfService)), '%m/%d/%Y') BETWEEN DATE_ADD(NOW(),INTERVAL -1 MONTH) AND DATE_ADD(NOW(),INTERVAL 1 MONTH) ) AS t1 GROUP BY ServiceCallMonth ORDER BY ServiceCallMonth;"); //set query
		local.getCallReportSummary = local.getCallReportSummary.execute().getResult();
		return local.getCallReportSummary;
	}

	public query function getCallReport(required date month) {
		local.getCallReport = new Query();
		local.getCallReport.setSQL(" SELECT c1.customerId , c1.firstName , c1.lastName , c1.address , c1.city , c1.phone , s2.dateOfService , s2.description as ServiceDescription , IFNULL(NULLIF(TRIM(s2.note), ''), s1.note) as ServiceNote , s2.amount , s2.technician FROM service as s1 INNER JOIN customer as c1 on s1.customerId = c1.customerId LEFT JOIN service AS s2 on c1.customerId = s2.customerId AND (s2.technician not like '%Service Call%' OR s2.serviceId = s1.serviceId) WHERE NULLIF(TRIM(phone), '') is NOT null AND s1.technician like '%Service Call%' AND STR_TO_DATE(CONCAT(month(s1.dateOfService), '/01/', year(s1.dateOfService)), '%m/%d/%Y') = :dateOfService ORDER BY c1.lastName, c1.firstName, s2.dateOfService desc;"); //set query
		local.getCallReport.addParam(name="dateOfService",value=arguments.month,CFSQLTYPE="CF_SQL_DATE"); // add query param
		local.getCallReport = local.getCallReport.execute().getResult();
		return local.getCallReport;
	}

	public struct function getNoPhone(){
		local.getNoPhone = structNew();
		local.getNoPhone.query1 = new Query();
		local.getNoPhone.query2 = new Query();
		local.getNoPhone.query1.setSQL("SELECT SQL_CALC_FOUND_ROWS  c1.customerId, c1.firstName, c1.lastName, MAX(s1.dateOfService) AS dateOfService FROM customer as c1 LEFT JOIN service as s1 on c1.customerId = s1.customerId AND technician NOT like '%Service Call%' WHERE NULLIF(TRIM(phone), '') is null GROUP BY c1.customerId, c1.firstName, c1.lastName ORDER BY dateOfService desc, lastName, firstName LIMIT 5;"); //set query
		local.getNoPhone.query2.setSQL("SELECT FOUND_ROWS() AS Total");
		transaction{
			local.getNoPhone.query1 = local.getNoPhone.query1.execute().getResult();
			local.getNoPhone.query2 = local.getNoPhone.query2.execute().getResult();
		}
		return local.getNoPhone;
	}

	public query function getNoPhoneFull(){
		local.getNoPhone = new Query();
		local.getNoPhone.setSQL("SELECT c1.customerId , c1.firstName , c1.lastName , c1.address , c1.city , c1.phone , s1.dateOfService , s1.description as ServiceDescription , s1.note as ServiceNote , s1.amount , s1.technician FROM customer as c1 LEFT JOIN service as s1 on c1.customerId = s1.customerId AND technician NOT like '%Service Call%' WHERE NULLIF(TRIM(phone), '') is null ORDER BY lastName, firstName, dateOfService desc;"); //set query
		local.getNoPhone = local.getNoPhone.execute().getResult();
		return local.getNoPhone;
	}


	public struct function getNoService() {
		local.getNoService = StructNew();
		local.getNoService.query1 = new Query();
		local.getNoService.query2 = new Query();
		local.getNoService.query1.setSQL("SELECT SQL_CALC_FOUND_ROWS c1.customerId, c1.firstName, c1.lastName, MAX(s2.dateOfService) AS dateOfService FROM customer as c1 LEFT JOIN service as s1 on c1.customerId = s1.customerId AND technician like '%Service Call%' AND STR_TO_DATE(CONCAT(month(s1.dateOfService), '/01/', year(s1.dateOfService)), '%m/%d/%Y') >= :dateOfService LEFT JOIN service AS s2 on c1.customerId = s2.customerId AND s2.technician not like '%Service Call%' WHERE s1.serviceId IS NULL GROUP BY c1.customerId, c1.firstName, c1.lastName ORDER BY lastName, firstName, dateOfService LIMIT 5;"); //set query
		local.getNoService.query2.setSQL("SELECT FOUND_ROWS() AS Total");
		local.getNoService.query1.addParam(name="dateOfService",value=now(),CFSQLTYPE="CF_SQL_DATETIME"); // add query param
		transaction {
			local.getNoService.query1 = local.getNoService.query1.execute().getResult();
			local.getNoService.query2 = local.getNoService.query2.execute().getResult();
		}
		return local.getNoService;
	}

	public query function getNoServiceFull() {
		local.getNoService = new Query();
		local.getNoService.setSQL(" SELECT c1.customerId , c1.firstName , c1.lastName , c1.address , c1.city , c1.phone , s2.dateOfService , s2.description as ServiceDescription , IFNULL(NULLIF(TRIM(s2.note), ''), s1.note) as ServiceNote , s2.amount , s2.technician FROM customer as c1 LEFT JOIN service as s1 on c1.customerId = s1.customerId AND technician like '%Service Call%' AND STR_TO_DATE(CONCAT(month(s1.dateOfService), '/01/', year(s1.dateOfService)), '%m/%d/%Y') >= :dateOfService LEFT JOIN service AS s2 on c1.customerId = s2.customerId AND s2.technician not like '%Service Call%' WHERE s1.serviceId IS NULL ORDER BY lastName, firstName, dateOfService;"); //set query
		local.getNoService.addParam(name="dateOfService",value=now(),CFSQLTYPE="CF_SQL_DATE"); // add query param
		local.getNoService = local.getNoService.execute().getResult();
		return local.getNoService;
	}





}