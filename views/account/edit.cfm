<cfimport prefix="ui" taglib="/customtags/" />
<cfset rc.title = "Account Edit" />	<!--- set a variable to be used in a layout --->
<cfoutput>
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li><a href="#buildURL( 'main' )#">Home</a> <span class="divider">/</span></li>
				<li class="active">Account</li><!-- /active -->
			</ul><!-- /breadcrumb -->
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	#view( "helpers/messages" )#
	<div class="row-fluid">
		<div class="span12">
			<form id="frmAccount" class="form" action="#buildURL( 'account.saveCustomer' )#" method="post" data-editing="false" autocomplete="off">
				<input type="hidden" value="#rc.account.info.customerId#" name="customerId" id="customerId" />
				<fieldset>
					<legend>Account Edit</legend>
					<h4>Essential information is marked with an asterisk (<span class="required">*</span>)</h4>
					<div class="span5">
						<div class="control-group ">
							<label class="control-label" for="lastName"><span class="required">*</span>Last Name / Company Name</label>
							<div class="controls">
								<input type="text" class="span12" id="lastName" name="lastName" placeholder="Last Name" value="#rc.account.info.lastName#" required="true" />
							</div><!-- /controls -->
						</div><!-- /control-group -->
						<div class="control-group ">
							<label class="control-label" for="firstName">First Name (optional)</label>
							<div class="controls">
								<input type="text" class="span12" id="firstName" name="firstName" placeholder="First Name" value="#rc.account.info.firstName#" />
							</div><!-- /controls -->
						</div><!-- /control-group -->
						<div class="control-group ">
							<label class="control-label" for="phone">Telephone (optional)</label>
							<div class="controls">
								<input type="tel" class="span12" id="phone" name="phone" placeholder="(___) ___-____ x_____" value="#rc.account.info.phone#" pattern="^[\\(]{0,1}([0-9]){3}[\\)]{0,1}[ ]?([^0-1]){1}([0-9]){2}[ ]?[-]?[ ]?([0-9]){4}[ ]*((x){0,1}([0-9_]){1,5}){0,1}$"/>
							</div><!-- /controls -->
						</div><!-- /control-group -->
						<div class="control-group ">
							<label class="control-label" for="sourceCode">Source Code (optional)</label>
							<div class="controls">
								<input type="text" class="span12 typeahead" id="sourceCode" name="sourceCode" placeholder="Source Code e.g.(Yellow Pages, Internet)" value="#rc.account.info.sourceCode#" autocomplete="off" data-link="#buildurl('account.getSourceCodeList')#" />
							</div><!-- /controls -->
						</div><!-- /control-group -->
					</div><!-- /controls-row -->
					<div class="offset1 span5">
						<div class="control-group">
							<label class="control-label" for="address"><span class="required">*</span>Address</label>
							<div class="controls">
								<input type="text" class="span12" id="address" name="address" placeholder="Address" value="#rc.account.info.address#" required="true" />
							</div><!-- /controls -->
						</div><!-- /control-group -->
						<div class="control-group">
							<label class="control-label" for="city"><span class="required">*</span>City</label>
							<div class="controls">
								<input type="text" class="span12 typeahead" id="city" name="city" placeholder="City" value="#rc.account.info.city#" required="true" autocomplete="off" data-link="#buildurl('account.getCityList')#" />
							</div><!-- /controls -->
						</div><!-- /control-group -->
						<div class="control-group">
							<label class="control-label" for="state"><span class="required">*</span>State</label>
							<div class="controls">
								<select class="span12" id="state" name="state" required="true">
									<option value="">Select a State</option>
									<option value="MN" <cfif rc.account.info.state eq "MN">selected="true"</cfif> >MN - Minnesota</option>
									<option value="WI" <cfif rc.account.info.state eq "WI">selected="true"</cfif> >WI - Wisconsin</option>
								</select>
							</div><!-- /controls -->
						</div><!-- /control-group -->
						<div class="control-group">
							<label class="control-label" for="postalCode"><span class="required">*</span>Postal Code</label>
							<div class="controls">
								<input class="span12 zipcodeUS" type="text" id="postalCode" name="postalCode" placeholder="Postal Code" value="#rc.account.info.postalCode#"  required="true"/>
							</div><!-- /controls -->
						</div><!-- /control-group -->
					</div><!-- /controls-row -->
					<div class="controls-row">
						<div class="control-group span12">
							<label class="control-label" for="notes">Note (optional)</label>
							<div class="controls">
								<textarea class="span12" id="notes" name="notes" placeholder="Note" rows="5" style="resize: none;">#rc.account.info.notes#</textarea>
							</div><!-- /controls -->
						</div><!-- /control-group -->
					</div><!-- /controls-row -->
					<div class="form-actions">
						<button type="submit" class="btn btn-primary" disabled>Save changes</button>
						<button type="button" class="btn btn-danger pull-right delete" data-customerid="#rc.account.info.customerid#">Delete Account</button>
					</div>
				</fieldset>
			</form>
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	<div class="row-fluid">
		<div class="span12">
			<table cellpadding="0" cellspacing="0" border="0"  width="100%" class="table table-striped table-bordered" id="tblServiceList">
				<thead>
					<tr>
						<th colspan="2"><div class="btn-group pull-right"><button title="Click to create a new service call." class="btn add-service-call"><i class="icon-briefcase"></i></button><button title="Click to add service information." class="btn add "><i class="icon-plus"></i></button></th>
						<th>Date</th>
						<th>Amount</th>
						<th>Description</th>
						<th>Technician/Service Call</th>
						<th>Note</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th colspan="7">&nbsp;</th>
					</tr>
				</tfoot>
				<cfif StructKeyExists(rc.account, "data") and isQuery(rc.account.data) and rc.account.data.recordCount gt 0>
					<tbody>
						<cfloop query="rc.account.data">
							<tr>
								<td>&nbsp;</td>
								<td>#rc.account.data.serviceId#</td>
								<td>#DateFormat(rc.account.data.dateOfService, "mm/dd/yyyy")#</td>
								<td style="text-align:right;">#LSCurrencyFormat(rc.account.data.Amount)#</td>
								<td>#rc.account.data.description#</td>
								<td>#rc.account.data.technician#</td>
								<td>#rc.account.data.note#</td>
							</tr>
						</cfloop>
					</tbody>
				</cfif>
			</table>
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	<!-- Modals --->
	<div id="modal-edit-service" class="modal hide fade" tabindex="-1" data-focus-on=":input:not(input[type=button],input[type=submit],input[type=reset],button,[readonly='readonly']):visible:enabled:first" data-backdrop="static" autocomplete="off">
		<div class="modal-header">
			<a href="javascript:;" class="close" data-dismiss="modal">&times;</a>
			<h3 id="modal-edit-service-label">Edit Service Information</h3>
		</div>
		<form id="frmServiceEdit" class="form-horizontal" action="#buildurl('account.saveservice')#" method="post" enctype="multipart/form-data" data-editing="false">
		<div class="modal-body">
			<input type="hidden" name="serviceId" id="serviceId" value="" />
			<input type="hidden" value="#rc.account.info.customerId#" name="customerId" id="customerId">
			<div class="control-group">
				<label class="control-label" for="dateOfService">Date</label>
				<div class="controls">
					<div class="input-append date" id="dp3" data-date-format="mm/dd/yyyy">
					    <input id="dateOfService" name="dateOfService" class="input-xlarge" size="16" type="text" value="" placeholder="Date" data-date-autoclose="true" readonly="true"/>
					    <span class="add-on"><i class="icon-th"></i></span>
					</div>
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="technician" data-toggle="tooltip" title="Use &ldquo;Service Call&rdquo; to indicate the date of a service call" data-placement="bottom">Technician</label>
				<div class="controls">
					<input type="text" class="input-xlarge" id="technician" name="technician" placeholder="Technician" value=""  autocomplete="off" data-link="#buildurl('account.getTechnicianList')#"/>
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="notes">Notes</label>
				<div class="controls">
					<textarea id="notes" class="input-xlarge" name="notes" placeholder="Notes" rows="4" style="resize: none;"></textarea>
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="">Service(s)</label>
			</div><!-- /control-group -->

			<div class="control-group">
				<div class=" form-inline">
					<input type="text" class="span4" id="description[0]" name="description" placeholder="Description" value=""  autocomplete="off" />
					<div class="input-prepend">
						<span class="add-on">$</span>
						<input type="text" class="input-small" id="amount[0]" name="amount" placeholder="_,___.__" value="" data-a-sign=""/>
					</div>
				</div><!-- /controls -->
			</div><!-- /control-group -->

		</div>
		</form>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button type="submit" id="serviceEditSave" class="btn btn-primary" disabled>Save changes</button>
		</div>

	</div>
	<div id="modal-add-service-call" class="modal hide fade" tabindex="-1" data-focus-on=":input:not(input[type=button],input[type=submit],input[type=reset],button,[readonly='readonly']):visible:enabled:first" data-backdrop="static" autocomplete="off">
		<div class="modal-header">
			<a href="javascript:;" class="close" data-dismiss="modal">&times;</a>
			<h3 id="modal-edit-service-label">Add Service Call Information</h3>
		</div>
		<form id="frmServiceCallNew" class="form-horizontal" action="#buildurl('account.saveservice')#" method="post">
		<div class="modal-body">
			<input type="hidden" name="serviceId" id="serviceId" value="" />
			<input type="hidden" value="#rc.account.info.customerId#" name="customerId" id="customerId" />
			<input type="hidden" id="technician" name="technician" value="Service Call"/>
			<div class="control-group">
				<label class="control-label" for="dateOfService">Date</label>
				<div class="controls">
					<div class="input-append date" id="dp4" data-date-format="mm/dd/yyyy">
					    <input id="dateOfService" name="dateOfService" class="input-xlarge" size="16" type="text" value="#dateAdd("yyyy", 2, Now())#" placeholder="Date" data-date-autoclose="true" readonly="true"/>
					    <span class="add-on"><i class="icon-th"></i></span>
					</div>
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="notes">Notes</label>
				<div class="controls">
					<textarea id="notes" class="input-xlarge" name="notes" placeholder="Notes" rows="4" style="resize: none;"></textarea>
				</div><!-- /controls -->
			</div><!-- /control-group -->
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button type="submit" id="serviceCallNewSave" class="btn btn-primary">Save changes</button>
		</div>
	 </form
	</div>
	<div id="modal-remove-service" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-remove-service" aria-hidden="true">
		<div class="modal-header">
			<a href="javascript:;" class="close" data-dismiss="modal">&times;</a>
			<h3>Delete Service Record</h3>
		</div>
		<div class="modal-body">
			<p>You are about to delete one service record, this procedure is irreversible.</p>
			<p>Do you want to proceed?</p>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal">No</button>
			<a href="#buildURL( 'account.removeService' )#&serviceId=0&customerId=0" class="btn btn-danger">Yes</a>
		</div>
	</div>
	<div id="modal-remove-account" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-remove-account" aria-hidden="true">
		<div class="modal-header">
			<a href="javascript:;" class="close" data-dismiss="modal">&times;</a>
			<h3>Delete Account Record</h3>
		</div>
		<div class="modal-body">
			<p>You are about to delete this account record, this procedure is irreversible.</p>
			<p>Do you want to proceed?</p>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal">No</button>
			<a href="#buildURL( 'account.removeAccount' )#&customerId=0&chk=#hash(session.userDelete)#" class="btn btn-danger">Yes</a>
		</div>
	</div>
	<!-- /Modals -->
</cfoutput>
<cfmodule template="/customtags/htmlfoot.cfm">
	<!-- datatables -->
	<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
	<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.min.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap.datatable.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.validate.bootstrap.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap.datepicker.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.maskedinput.min.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap-modalmanager.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap-modal.js"></script>
	<script type="text/javascript" src="/assets/js/bootbox.min.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.autoNumeric.js"></script>

	<script type="text/javascript">


		function actionRender ( data, type, full ) {
			if ( type === 'display' ) {
				if(full[5].toLowerCase() === "service call") {
					return '<div class="btn-group pull-right"><button title="Click to edit this service information." class="btn edit"><i class="icon-edit"></i></button>';
				}
				return '<div class="btn-group pull-right"><button title="Click to edit this service information." class="btn edit"><i class="icon-edit"></i></button><button title="Click to remove this service information." class="btn delete" data-serviceId="' + full[1] + '" data-customerId="<cfoutput>#rc.customerId#</cfoutput>" ><i class="icon-trash"></i></button></div>';
			}
			return data;
		}

		function extractor(query) {
			var result = /([^,]+)$/.exec(query);
			if(result && result[1]) return result[1].trim();
			return '';
		}



		jQuery.extend( jQuery.fn.dataTableExt.oSort, {
			"currency-pre": function ( a ) {
				a = (a==="-") ? 0 : a.replace( /[^\d\-\.]/g, "" );
				return parseFloat( a );
			}
			, "currency-asc": function ( a, b ) {
				return a - b;
			}
			, "currency-desc": function ( a, b ) {
				return b - a;
			}
		} );

		$(document).ready(function() {
			var nEditing = function(){return $("#frmAccount").data("editing");}
				, aoColumnDefs = []
			;

			$("#phone").mask("(999) 999-9999? x99999");
			$('#amount').autoNumeric('init');
			$("label").tooltip().on('show shown hide hidden', function(e){e.stopPropagation();});
			$('.typeahead').typeahead({
				source: function(query, process) {
					return $.ajax({
							url: $($(this)[0].$element[0]).data('link'),
							type: 'get',
							data: {q: query},
							dataType: 'json',
							success: function(json) {
								return typeof json.options == 'undefined' ? false : process(json.options);
							}
						});
					}
				, updater: function (item) {
					$("#frmAccount").trigger("keyup");
					return item
				}
			});
			$("#technician").typeahead(
				{
					source: function(query, process) {
						$("#frmServiceEdit").trigger("keyup");
						return <cfoutput>#SerializeJSON(rc.techlist)#</cfoutput>;
					}
					, updater: function(item) {
						$("#frmServiceEdit").trigger("keyup");
						return this.$element.val().replace(/[^,]*$/,'')+item+',';
					}
					, matcher: function (item) {
						var tquery = extractor(this.query);
						if(!tquery) return false;
						return ~item.toLowerCase().indexOf(tquery.toLowerCase())
					}
					, highlighter: function (item) {
						var query = extractor(this.query).replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
						return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
							return '<strong>' + match + '</strong>'
						});
					}
				}
			);


			aoColumnDefs.push({"aTargets":[0], "bSearchable":true, "bSortable":false, "bVisible":true, "sWidth":"70px", "mRender":actionRender});
			aoColumnDefs.push({"aTargets":[1], "bSearchable":false, "bSortable":false, "bVisible":false, "sClass":"hide", "sType":"numeric"});
			aoColumnDefs.push({"aTargets":[2], "bSearchable":true, "bSortable":true, "bVisible":true, "sWidth":"84px", "sType":"date"});
			aoColumnDefs.push({"aTargets":[3], "bSearchable":true, "bSortable":true, "bVisible":true, "sWidth":"70px", "sType":"currency"});
			aoColumnDefs.push({"aTargets":[4], "bSearchable":true, "bSortable":true, "bVisible":true});
		  	aoColumnDefs.push({"aTargets":[5], "bSearchable":true, "bSortable":true, "bVisible":true});
		  	aoColumnDefs.push({"aTargets":[6], "bSearchable":true, "bSortable":true, "bVisible":true});



			var oTable = $('#tblServiceList').dataTable({
				"sPaginationType": 'bootstrap'
				, "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
				, "iDisplayLength": 10
				, "sDom": 'T<"clear">lfrtip'
				, "aaSorting": [[2, 'desc']]
				, "aoColumnDefs": aoColumnDefs

			});

			$("#frmAccount").keyup(function(e){
				var self = $(this)
					, bntSubmit = $("[type='submit']")
				;
				if(self.data("current") !== self.serialize()){
					bntSubmit.removeAttr("disabled");
					 $("#frmAccount").data("editing", true);
				} else {
					bntSubmit.attr("disabled", "true");
					$("#frmAccount").data("editing", false);
				}
			}).data("current", $("#frmAccount").serialize());

			$("#frmServiceEdit").on("keyup", function(e){
				var self = $(this)
					, bntSubmit = $("#serviceEditSave")
				;
				if(self.data("current") !== self.serialize()){
					bntSubmit.removeAttr("disabled");
					$("#frmServiceEdit").data("editing", true);
				} else {
					bntSubmit.attr("disabled", "true");
					$("#frmServiceEdit").data("editing", false);
				}
			}).data("current", $("#frmServiceEdit").serialize());


			function editService(e, iRow){
				var iRow = (iRow===undefined? oTable.fnGetPosition($(this).parents('tr')[0]) : iRow)
				;
				if(nEditing()){
					bootbox.dialog("<p>You have started entering in data for a new account. You will lose all data entered if you cancel now.</p><p>Do you want to proceed?</p>"
						, [
							{
								"label" : "No"
								, "class" : "btn-primary"
								, "callback": null
							}
							, {
								"label" : "Yes"
								, "class" : "btn-danger"
								, "callback": function(){
									$("#frmAccount").data("editing", false);
									editService(e, iRow);
								}
							}
						]
						, {header:'Edit Account Cancel'}
					);
					return
				}

				var self = $(this)
					, serviceId = self.data('serviceid')
					, customerId = self.data('customerid')
				;

				/* Get the row as a parent of the link that was clicked on */

				var aData = oTable.fnGetData(iRow)
					, serviceId = aData[1]
					, dateOfService = aData[2]
					, amount = String(aData[3]).replace(/[^0-9\.,]+/g,'')
					, description = aData[4]
					, technician = aData[5]
					, notes = aData[6]
				;

				$('#dp3').datepicker('update', dateOfService);
				$("#frmServiceEdit input[name='serviceId']").val(serviceId);
				$("#frmServiceEdit input[name='dateOfService']").val(dateOfService);
				$("#frmServiceEdit input[id^='amount']").val(amount);
				$("#frmServiceEdit input[id^='description']").val(description);
				$("#frmServiceEdit input[name='technician']").val(technician);
				$("#frmServiceEdit textarea[name='notes']").val(notes);

				$("#frmServiceEdit").data("current", $("#frmServiceEdit").serialize());
				$("#frmServiceEdit").trigger('keyup');

				$('#modal-edit-service').modal({ backdrop: 'static', keyboard: true });

			}
			$("#serviceEditSave").on("click", function(e){
				$("#frmServiceEdit").submit();
			});

			$('#modal-edit-service')
				.on('shown', function(e) {
					$("#amount").autoNumeric('update');
					$("#frmServiceEdit").data("current", $("#frmServiceEdit").serialize());
				})
				.on("hide", function(e){
					var frm = $("#frmServiceEdit")
						, modalHide = false
					;

					if(frm.data("editing")){
						bootbox.dialog("<p>The data in this form has changed you will lose your work if you close this form.</p><p>Do you want to proceed and close the form?</p>"
							, [
								{
									"label" : "No"
									, "class" : "btn-primary"
									, "callback": null
								}
								, {
									"label" : "Yes"
									, "class" : "btn-danger"
									, "callback": function(){
										$("#frmServiceEdit").data("editing", false);
										$('#modal-edit-service').modal('hide');
									}
								}
							]
							, {header:'Edit Account Cancel'}
						);
						modalHide = false;
					} else {
						modalHide = true;
					}

					if(modalHide){
						$.Event('hide');
						$("#frmServiceEdit input[name='serviceId']").val('');
						$("#frmServiceEdit input[name='dateOfService']").val();
						$("#frmServiceEdit input[name='amount']").val('');
						$("#frmServiceEdit textarea[name='description']").val('');
						$("#frmServiceEdit input[name='technician']").val('');
						$("#frmServiceEdit textarea[name='notes']").val('');

						frm.data("current", frm.serialize());
					} else {
						e.preventDefault();
					}
				})
				.on("hidden", function(e){
					$('#dp3').datepicker('hide');
					$("#frmAccount").trigger("keyup");
				});

			$('#modal-remove-service')
				.on('show', function(e) {
					var self = $(this)
						, serviceId = self.data('serviceId')
						, customerId = self.data('customerId')
						, removeBtn = self.find('.btn-danger')
						, href = removeBtn.attr('href')
					;
					removeBtn.attr('href', href.replace(/&serviceId=\d*/, '&serviceId=' + serviceId).replace(/&customerId=\d*/, '&customerId=' + customerId));
				})
				.on('shown', function(){
					$(this).find("button.btn-primary:first").focus();
				})
				.on('hidden', function(){
					var self = $(this)
						, removeBtn = self.find('.btn-danger')
						, href = removeBtn.attr('href')
					;
					removeBtn.attr('href', href.replace(/&serviceId=\d*/, '&serviceId=0').replace(/&customerId=\d*/, '&customerId=0'));
				});

			$('#modal-remove-account')
				.on('show', function(e) {
					var self = $(this)
						, customerId = self.data('customerId')
						, removeBtn = self.find('.btn-danger')
						, href = removeBtn.attr('href')
					;
					removeBtn.attr('href', href.replace(/&customerId=\d*/, '&customerId=' + customerId));
				})
				.on('shown', function(){
					$(this).find("button.btn-primary:first").focus();
				})
				.on('hidden', function(){
					var self = $(this)
						, removeBtn = self.find('.btn-danger')
						, href = removeBtn.attr('href')
					;
					removeBtn.attr('href', href.replace(/&customerId=\d*/, '&customerId=0'));
				});

			function addServiceCall() {
				var self = $(this)
					, serviceId = self.data('serviceid')
					, customerId = self.data('customerid')
					, frm = $("#frmServiceCallNew")
					, serviceCallDate = new Date()
				;
				serviceCallDate = new Date(serviceCallDate.setFullYear(serviceCallDate.getFullYear()+2,serviceCallDate.getMonth(),0));

				$("#frmServiceCallNew input[name='serviceId']").val('0');
				$("#frmServiceCallNew input[name='dateOfService']").val('');
				$("#frmServiceCallNew input[name='technician']").val('Service Call');
				$("#frmServiceCallNew textarea[name='notes']").val('');
				$('#frmServiceCallNew #dp4').datepicker('update', serviceCallDate);

				$('#modal-add-service-call')
					.data('serviceId', 0)
				 	.data('customerId', customerId)
				 	.modal({ backdrop: 'static', keyboard: true });
				return ;
			}

			function addService(){
				if(nEditing()){
					bootbox.dialog("<p>You have started entering in data for a new account. You will lose all data entered if you cancel now.</p><p>Do you want to proceed?</p>"
						, [
							{
								"label" : "No"
								, "class" : "btn-primary"
								, "callback": null
							}
							, {
								"label" : "Yes"
								, "class" : "btn-danger"
								, "callback": function(){
									$("#frmAccount").data("editing", false);
									addService();
								}
							}
						]
						, {header:'Edit Account Cancel'}
					);
					return
				}
				var self = $(this)
					, serviceId = self.data('serviceid')
					, customerId = self.data('customerid')
					, frm = $("#frmServiceEdit")
				;

				$("#frmServiceEdit input[name='serviceId']").val('0');
				$("#frmServiceEdit input[name='dateOfService']").val('');
				$("#frmServiceEdit input[name='amount']").val('');
				$("#frmServiceEdit textarea[name='description']").val('');
				$("#frmServiceEdit input[name='technician']").val('');
				$("#frmServiceEdit textarea[name='notes']").val('');
				$('#dp3').datepicker('update', new Date());
				frm.data("current", frm.serialize());
				frm.trigger('keyup');

				$('#modal-edit-service')
					.data('serviceId', 0)
				 	.data('customerId', customerId)
				 	.modal({ backdrop: 'static', keyboard: true });
			}


			function removeService(){
				if(nEditing()){
					bootbox.dialog("<p>You have started entering in data for a new account. You will lose all data entered if you cancel now.</p><p>Do you want to proceed?</p>"
						, [
							{
								"label" : "No"
								, "class" : "btn-primary"
								, "callback": null
							}
							, {
								"label" : "Yes"
								, "class" : "btn-danger"
								, "callback": function(){
									$("#frmAccount").data("editing", false);
									removeService();
								}
							}
						]
						, {header:'Edit Account Cancel'}
					);
					return
				}
				var self = $(this)
					, serviceId = self.data('serviceid')
					, customerId = self.data('customerid')
				;

				$('#modal-remove-service')
					.data('serviceId', serviceId)
				 	.data('customerId', customerId)
				 	.modal({ backdrop: 'static', keyboard: true });
			}

			$("#tblServiceList")
				.delegate(".delete", 'click', removeService)
				.delegate(".edit", 'click', editService)
				.delegate(".add", 'click', addService)
				.delegate(".add-service-call", 'click', addServiceCall)
			;

			$('#dp3').datepicker({
				autoclose: true
			}).on("changeDate", function(e){
				var frm = $("#frmServiceEdit")
				;
				frm.trigger("keyup");
				frm.find("input[name='amount']").focus();
			});

			function removeAccount(){
				if(nEditing()){
					bootbox.dialog("<p>You have started entering in data for a new account. You will lose all data entered if you cancel now.</p><p>Do you want to proceed?</p>"
						, [
							{
								"label" : "No"
								, "class" : "btn-primary"
								, "callback": null
							}
							, {
								"label" : "Yes"
								, "class" : "btn-danger"
								, "callback": function(){
									$("#frmAccount").data("editing", false);
									removeAccount();
								}
							}
						]
						, {header:'Edit Account Cancel'}
					);
					return
				}
				var self = $(this)
					, customerId = self.data('customerid')
				;

				$('#modal-remove-account')
				 	.data('customerId', customerId)
				 	.modal({ backdrop: 'static', keyboard: true });
			}

			$("#frmAccount")
				.delegate(".delete", "click", removeAccount)
				.validate({ onkeyup: false })
			;

			$("#frmServiceEdit").on("keyup", "input[name^='description']", function(e){
				var self = $(this)
					, inputs = $("input[name^='description']")
					, lastInput = inputs.last()
				;


				// add a new line if the description is not blank
				if(lastInput.val().length > 0){
					self.parent().parent().parent().append('<div class="control-group"><div class=" form-inline"><input type="text" class="span4" id="description[' + inputs.size() + ']" name="description" placeholder="Description" value=""  autocomplete="off" />&nbsp;<div class="input-prepend"><span class="add-on">$</span><input type="text" class="input-small" id="amount[' + inputs.size() + ']" name="amount" placeholder="_,___.__" value="" data-a-sign=""/></div></div><!-- /controls --></div><!-- /control-group -->');
				};

				// remove a line if the description and the amount is blank
				$.each(inputs, function(index, val) {
					var localSelf = $(val)
					if(localSelf.val().length === 0 && localSelf.parent().find("input[name^='amount']").last().val().length === 0  && localSelf.attr('id') !== lastInput.attr('id') && localSelf.attr('id') !== self.attr('id')){
						localSelf.parent().parent().remove();
					}
				});
			});

		});


	</script>
</cfmodule>
<cfsavecontent variable="headerHTML">
	<link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.dataTables.css" />
	<link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.datepicker.css" />
	<link rel="stylesheet" type="text/css" href="/assets/css/bootstrap-modal.css" />
</cfsavecontent>
<cfhtmlhead text="#headerHTML#" />
