<cfimport prefix="ui" taglib="/customtags/" />
<cfset rc.title = "Default View" />	<!--- set a variable to be used in a layout --->
<cfparam name="session.searchAll" default="" />
<cfparam name="session.searchLastName" default="" />
<cfparam name="session.searchFirstName" default="" />
<cfparam name="session.searchAddress" default="" />
<cfparam name="session.searchCity" default="" />
<cfparam name="session.searchPostalCode" default="" />
<cfparam name="session.searchTelephone" default="" />
<cfoutput>
	<div class="row-fluid">
		<div class="span12">
			<ul class="breadcrumb">
				<li class="active">Home</li><!-- /active -->
			</ul><!-- /breadcrumb -->
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	#view( "helpers/messages" )#
	<div class="row-fluid">
		<div class="span12">
			<table cellpadding="0" cellspacing="0" border="0" width="100%" class="table table-striped table-bordered" id="tblCustomerList">
				<thead>
					<tr>
						<th colspan="2"><div class="btn-group pull-right"><button title="Click to view or hide search columns." class="btn clear" data-customerid="0"  data-index="1"><i class="icon-remove-sign"></i></button><button title="Click to view or hide search columns." class="btn view" data-customerid="0"  data-index="1"><i class="icon-eye-close"></i></button></div></th>
						<th><input type="text" name="search_lastName" value="" class="span12" placeholder="Search Last Name" data-search="c1.lastName" data-index="2"/></th>
						<th><input type="text" name="search_firstName" value="" class="span12" placeholder="Search First Name" data-search="c1.firstName"  data-index="3"/></th>
						<th><input type="text" name="search_address" value="" class="span12" placeholder="Search Street Address" data-search="c1.address" data-index="4"/></th>
						<th><input type="text" name="search_city" value="" class="span12" placeholder="Search City" data-search="c1.city" data-index="5"/></th>
						<th><input type="text" name="search_postalCode" value="" class="span12" placeholder="Search Postal Code" data-search="c1.postalCode"  data-index="6"/></th>
						<th><input type="text" name="search_telephone" value="" class="span12"  placeholder="Search Telephone" data-search="c1.phone" data-index="7"/></th>
					</tr>
					<tr>
						<th><button title="Click to add service information." class="btn add pull-right" data-customerid="0"><i class="icon-plus"></i></button></th>
						<th>Service Account Id</th>
  						<th>Last Name / Company Name</th>
  						<th>First Name</th>
  						<th>Street Address</th>
  						<th>City</th>
  						<th>Postal Code</th>
  						<th>Telephone</th>
  					</tr>
  				</thead>
				<tfoot>
					<tr>
						<th colspan="8">&nbsp;</th>
					</tr>
				</tfoot>
			</table>
		</div><!-- /span12 -->
	</div><!-- /row-fluid -->
	<!-- Modals --->
	<div id="modal-edit-account" class="modal hide fade" tabindex="-1" data-focus-on=":input:not(input[type=button],input[type=submit],button):visible:first" data-backdrop="static">
		<div class="modal-header">
			<a href="javascript:;" class="close" data-dismiss="modal">&times;</a>
			<h3>New Account</h3>
		</div>
		<form id="frmAccountEdit" class="form-horizontal" action="#buildurl('account.saveCustomer')#" method="post" autocomplete="off" data-editing="false">
		<div class="modal-body">
			<input type="hidden" name="customerId" id="customerId" value="0" />
			<input type="hidden" id="latitude" name="latitude" placeholder="Latitude" value="" data-rule-required="true" data-placement="left" data-geo="lat"/>
			<input type="hidden" id="longitude" name="longitude" placeholder="Longitude" value="" data-rule-required="true" data-placement="left" data-geo="lng"/>
			<input type="hidden" id="county" name="county" placeholder="County" value="" data-rule-required="true" data-placement="left" data-geo="administrative_area_level_2"/>

			<div class="control-group ">
				<label class="control-label" for="lastName">Last Name</label>
				<div class="controls">
					<input type="text" class="input-xlarge" id="lastName" name="lastName" placeholder="Last Name / Company Name" value="" data-rule-required="true" data-placement="bottom" autofocus="true" autocomplete="off" />
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group ">
				<label class="control-label" for="firstName">First Name</label>
				<div class="controls">
					<input type="text" class="input-xlarge" id="firstName" name="firstName" placeholder="First Name" value="" />
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group ">
				<label class="control-label" for="phone">Telephone</label>
				<div class="controls">
					<input type="text" class="input-xlarge" id="phone" name="phone" placeholder="(___) ___-____ x_____" value="" data-rule-required="true" data-placement="bottom"/>
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group ">
				<label class="control-label" for="sourceCode">Source Code</label>
				<div class="controls">
					<input type="text" class="input-xlarge typeahead" id="sourceCode" name="sourceCode" placeholder="Source Code e.g.(Yellow Pages, Internet)" value="" autocomplete="off" data-link="#buildurl('account.getSourceCodeList')#" />
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="address">Address</label>
				<div class="controls">
					<input type="text" class="input-xlarge" id="address" name="address" placeholder="Address" value="" data-rule-required="true" data-placement="bottom" />
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="city">City</label>
				<div class="controls">
					<input type="text" class="input-xlarge typeahead" id="city" name="city" placeholder="City" value="" data-rule-required="true" data-placement="bottom" data-link="#buildurl('account.getCityList')#" />
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="state">State</label>
				<div class="controls">
					<select id="state" class="input-xlarge" name="state" data-rule-required="true" data-placement="bottom">
						<option value="">Select a State</option>
						<option value="MN" >MN - Minnesota</option>
						<option value="WI" >WI - Wisconsin</option>
					</select>
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div class="control-group">
				<label class="control-label" for="postalCode">Postal Code</label>
				<div class="controls">
					<input class="zipcodeUS input-xlarge" type="text" id="postalCode" name="postalCode" placeholder="Postal Code" value="" data-rule-required="true" data-placement="bottom"/>
				</div><!-- /controls -->
			</div><!-- /control-group -->
			<div id="map_canvas" style=" height: 150px; width: 500px;">
			<div id="map_canvas1" style=" height: 100%;"></div>
			</div>
		</div>
		</form>
		<div class="modal-footer">
			<button type="button" class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button type="button" id="serviceEditSave" class="btn btn-primary" disabled>Save changes</button>
		</div>

	</div>
	<div id="modal-remove-account" class="modal hide fade" tabindex="-1" data-focus-on=":input:not(input[type=button],input[type=submit],button):visible:first">
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
	<div id="modal-view-column" class="modal hide fade" tabindex="-1" data-focus-on=":input:not(input[type=button],input[type=submit],button):visible:first">
		<div class="modal-header">
			<a href="javascript:;" class="close" data-dismiss="modal">&times;</a>
			<h3>View or Remove Columns</h3>
		</div>
		<div class="modal-body">
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
		</div>
	</div>

	<div id="modal-account-detail" class="modal hide fade" tabindex="-1" data-focus-on=":input:not(input[type=button],input[type=submit],button):visible:first">
		<div class="modal-header">
			<a href="javascript:;" class="close" data-dismiss="modal">&times;</a>
			<h3>View Account Detail</h3>
		</div>
		<div class="modal-body">
			<address id="customerAddress">
				<strong>Twitter, Inc.</strong><br>
				795 Folsom Ave, Suite 600<br>
				San Francisco, CA 94107<br>
				<abbr title="Phone">P:</abbr> (123) 456-7890
			</address>
			<h2>Notes:</h2>
			<pre id="customerNote">
			</pre>
			<table class="table table-striped table-bordered table-condensed" id="tblAccountServices">
				<thead>
					<tr>
						<th>Date</th>
						<th>Amount</th>
						<th>Description</th>
						<th>Tech / Call</th>
						<th>Note</th>
					</tr>
				</thead>
				<tfoot>
					<tr><td colspan="5">&nbsp;</td></tr>
				</tfoot>
				<tbody></tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
		</div>
	</div>
	<!-- /Modals -->
</cfoutput>
<cfmodule template="/customtags/htmlfoot.cfm">
	<!-- datatables -->
	<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
	<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/additional-methods.min.js"></script>
	<script type="text/javascript" src="//maps.google.com/maps/api/js?sensor=false&libraries=places"></script>
	<script type="text/javascript" src="/assets/js/bootstrap.datatable.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.validate.bootstrap.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.validate.custom-methods.js"></script>
	<script type="text/javascript" src="/assets/js/jquery.maskedinput.min.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap.typeahead.geocode.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap-modalmanager.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap-modal.js"></script>
	<script type="text/javascript" src="/assets/js/bootbox.min.js"></script>
	<script type="text/javascript" src="/assets/js/bootstrap.datepicker.js"></script>

	<script type="text/javascript">
		Number.prototype.formatMoney = function(c, d, t){
			var n = this,
			    c = isNaN(c = Math.abs(c)) ? 2 : c,
			    d = d == undefined ? "." : d,
			    t = t == undefined ? "," : t,
			    s = n < 0 ? "-" : "",
			    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "",
			    j = (j = i.length) > 3 ? j % 3 : 0;
			   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
			 };

		function actionRender ( data, type, full ) {
			if ( type === 'display' ) {
				var URLString = '<div class="btn-group pull-right"><a href="<cfoutput>#buildURL(  action = "account.edit",  queryString = "customerId=0&chk=a")#</cfoutput>" title="Click to edit this customer." class="btn" ><i class="icon-edit"></i></a><button title="Click to remove this service information." class="btn delete" data-customerId="0" ><i class="icon-trash"></i></button><button title="Click to view this service information." class="btn view-detail" data-customerId="0" ><i class="icon-eye-open"></i></button></div>';
				URLString = URLString.replace(/&customerId=\d*/g, '&customerId=' + data)
							.replace(/data-customerId="\d"*/g, 'data-customerId="' + data + '"')
							.replace(/&chk=\w*/, '&chk=' + full.hashCheck );
				return URLString;
			}
			return data;
		}

		function phoneRender( data, type, full ) {
			if ( type === 'display' ) {
				var val = String(data).replace(/[^0-9]/g,'');
				if(val.length === 7) {
					return val.replace(/(\d{3})(\d{4})/, '$1-$2');
				} else if(val.length === 10){
					return String(val).replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
				} else if(val.length > 10){
					return String(val).replace(/(\d{3})(\d{3})(\d{4})(\d+)/, '($1) $2-$3 x$4');
				}
			}
			return data;
		}


		$(document).ready(function() {
			var $oTable= {}
				, aoColumnDefs = []
				, frmAccountEdit = $('#frmAccountEdit')
				, validator= null
			;

			$("input[name=search_lastName]").val("<cfoutput>#trim(session.searchLastName)#</cfoutput>");
			$("input[name=search_firstName]").val("<cfoutput>#trim(session.searchFirstName)#</cfoutput>");
			$("input[name=search_address]").val("<cfoutput>#trim(session.searchAddress)#</cfoutput>");
			$("input[name=search_city]").val("<cfoutput>#trim(session.searchCity)#</cfoutput>");
			$("input[name=search_postalCode]").val("<cfoutput>#trim(session.searchPostalCode)#</cfoutput>");
			$("input[name=search_telephone]").val("<cfoutput>#trim(session.searchTelephone)#</cfoutput>");

			$("#phone").mask("(999) 999-9999? x99999");
			$("#frmAccountEdit input[name='address']").typeahead($.fn.typeahead.geoDefaults);
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
			});

			aoColumnDefs.push({"aTargets":[0], "bSearchable":true, "bSortable":false, "bVisible":true, "sWidth":"75px", "mRender":actionRender, "mData":"CUSTOMERID", "sName":"c1.customerId"});
			aoColumnDefs.push({"aTargets":[1], "bSearchable":false, "bSortable":false, "bVisible":false, "sClass":"hide", "sType":"numeric", "mData":"CUSTOMERID", "sName":"c1.customerId"});
			aoColumnDefs.push({"aTargets":[2], "bSearchable":true, "bSortable":true, "bVisible":true, "mData":"LASTNAME", "sName":"c1.lastName"});
			aoColumnDefs.push({"aTargets":[3], "bSearchable":true, "bSortable":true, "bVisible":true, "mData":"FIRSTNAME", "sName":"c1.firstName"});
		  	aoColumnDefs.push({"aTargets":[4], "bSearchable":true, "bSortable":true, "bVisible":true, "mData":"ADDRESS", "sName":"c1.address"});
		  	aoColumnDefs.push({"aTargets":[5], "bSearchable":true, "bSortable":true, "bVisible":true, "mData":"CITY", "sName":"c1.city"});
		  	aoColumnDefs.push({"aTargets":[6], "bSearchable":true, "bSortable":true, "bVisible":false, "mData":"POSTALCODE", "sName":"c1.postalCode"});
		  	aoColumnDefs.push({"aTargets":[7], "bSearchable":true, "bSortable":true, "bVisible":true, "mRender":phoneRender, "mData":"PHONE", "sName":"c1.phone"});


		  	$oTable['tblCustomerList'] = $('#tblCustomerList').dataTable({
		  		"bProcessing": true
		  		, "bServerSide": true
		  		, "bFilter": true
		  		, "bStateSave": true
				, "sAjaxSource": '<cfoutput>#buildURL(  "main.accountlist")#</cfoutput>'
				, "sPaginationType": 'bootstrap'
				, "aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
				, "iDisplayLength": 10
				,"sDom": "<'row-fluid'<'span6'Tl><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
				, "aoColumnDefs": aoColumnDefs
				, "aaSorting": [[2, 'asc'],[3, 'asc']]
				, "oLanguage": {
					"sSearch": "Search all columns:"
				}
				, "oColVis": {
							"aiExclude": [ 0 ]
						}
				, "fnDrawCallback" : function( oSettings ) {
    				$("thead input").keyup( function () {
    					filterColumn(this);
    				} );
	    		}
			});

		  	$("#tblCustomerList input[name='search_lastName']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[2].sSearch);
		  	$("#tblCustomerList input[name='search_firstName']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[3].sSearch);
		  	$("#tblCustomerList input[name='search_address']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[4].sSearch);
		  	$("#tblCustomerList input[name='search_city']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[5].sSearch);
		  	$("#tblCustomerList input[name='search_postalCode']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[6].sSearch);
		  	$("#tblCustomerList input[name='search_telephone']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[7].sSearch);




			$('#modal-remove-account')
				.on('show', function() {
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
				})
			;

			$('#modal-account-detail')
				.on('show', function(){
					var self = $(this)
						, customerId = self.data('customerId')
					;

					$.ajax({
							url: "<cfoutput>#buildURL(  "main.accountDetail")#</cfoutput>",
							type: 'post',
							data: {customerId: customerId},
							dataType: 'json',
							success: function(json) {

								var customerAddress = $("#customerAddress")
									tblAccountServices = $("#tblAccountServices").find('tbody').first()
									addressString = "<strong>{name}</strong><br/>{address}<br/>{city}, {state} {postalCode}<br/>"
									name = json.account.info.data.lastname[0] + (json.account.info.data.firstname[0].length ? ", " + json.account.info.data.firstname[0] : "")
									address = json.account.info.data.address[0].length ? json.account.info.data.address[0] : "[No Address on File]"
								;

								addressString = addressString.replace(/{name}/g, name)
												.replace(/{address}/g, address)
												.replace(/{address}/g, address)
												.replace(/{city}/g, json.account.info.data.city[0])
												.replace(/{state}/g, json.account.info.data.state[0])
												.replace(/{postalCode}/g, json.account.info.data.postalcode[0])
								;

								customerAddress.html(addressString);
								$("#customerNote").text(json.account.info.data.notes[0].length?json.account.info.data.notes[0]:"[No Account Notes]");
								tblAccountServices.html("");
								var maxRoecords = json.account.data.recordcount > 5 ? 5 : json.account.data.recordcount;

								for(var i = 0; i < maxRoecords; i++){
									var dateofservice = json.account.data.data.dateofservice[i].replace("{ts '", "").replace("'}", "").replace(" 00:00:00", "")
										, amount = (json.account.data.data.amount[i]).formatMoney()
										, description = json.account.data.data.description[i]
										, technician = json.account.data.data.technician[i]
										, note = json.account.data.data.note[i]

									;
									tblAccountServices.append("<tr><td>" + dateofservice + "</td><td align='right'>$" + amount + "</td><td>" + description + "</td><td>" + technician + "</td><td>" + note + "</td></tr>");
								}
								return typeof json.options == 'undefined' ? false : process(json.options);
							}
						});
				})
				.on("shown", function(){
					$('#modal-account-detail').css({top:'50%',left:'50%',margin:'-'+($('#modal-account-detail').height() / 2)+'px 0 0 -'+($('#modal-account-detail').width() / 2)+'px'});
				})
				.on('hidden', function(){

				})
			;


			var pacContainerInitialized = false;
			var editAccount = $('#modal-edit-account').on('show', function(){
				$(".error").removeClass("error");
				$(".popover").remove();
			}).on('hide', function(e){
				var editing = frmAccountEdit.data("editing")
				;
				if(editing !== undefined && editing){
					bootbox.dialog("<p>You have started entering in data for a new account. You will lose all data entered if you cancel now.</p><p>Do you want to proceed?</p>", [{
						"label" : "No",
						"class" : "btn-primary",
						"callback": null
					}, {"label" : "Yes",
						"class" : "btn-danger",
						"callback": function(){
							frmAccountEdit.data("editing", false);
							$("#modal-edit-account").modal('hide');
						}}], {header:'New Account Cancel'});
					e.preventDefault();
				}
			});

			frmAccountEdit.on("keyup", function(e){
				var self = $(this)
					, bntSubmit = $("#serviceEditSave")
				;
				if(self.data("current") !== self.serialize()){
					bntSubmit.removeAttr("disabled");
					frmAccountEdit.data("editing", true);
				} else {
					bntSubmit.attr("disabled", "true");
					frmAccountEdit.data("editing", false);
				}
			}).data("current", frmAccountEdit.serialize());

			$("#serviceEditSave").on('click', function(e){
				frmAccountEdit.submit();
			});

			$('#modal-view-column')
				.on('show', function() {
					var list  = $('#modal-view-column').find(".modal-body:last")
						listColumn = $oTable['tblCustomerList'].fnSettings().aoColumns
					;

					list.html("");

					$.each(listColumn, function( index, value ) {
						var chkBox;
						if(index > 1) {
							chkBox = $('<label class="checkbox"/>')
									.append(
											$('<input type="checkbox" />')
												.attr('id', value.sName)
												.attr('name', value.sName)
												.attr('value', index)
											)
									.append(value.sTitle)
							;

							if(value.bVisible){
								chkBox.find("input").first().attr('checked', 'true');
							}
							chkBox.find("input").on('change', function(){
								var self = $(this)
									, objInput = $('*[data-search="' + self.attr('id') + '"]')
								;

								if(objInput.size()){
									objInput.first().val('');
								}
								fnShowHide(self.val());
							});
							list.append(chkBox);
						};
					});
				})

			function viewColumnOption(){
				var self = $(this)

				$('#modal-view-column')
				 	.modal({ backdrop: 'static', keyboard: true });
			}

			function filterColumn(col){
				var self = $(col)
					, oTable = $oTable['tblCustomerList']
					, visibleColumn = $.grep(oTable.fnSettings().aoColumns, function( column, index){
						return column.bVisible;
					});
				/* Filter on the column (the index) of this element */
				var val = self.val();

				if(visibleColumn[self.parent().index()].mData === "POSTALCODE" || visibleColumn[self.parent().index()].mData === "PHONE"){
					val = String(val).replace(/[^\d%]/g,''); // remove non-numerics
				}

				oTable.fnFilter( val, self.data("index") );
			}

			function removeAccount(){
				var self = $(this)
					, customerId = self.data('customerid')
				;

				$('#modal-remove-account')
				 	.data('customerId', customerId)
				 	.modal({ backdrop: 'static', keyboard: true });
			}

			function addAccount(){
				var self = $(this)
					, customerId = self.data('customerid')
				;

				$("#frmAccountEdit input[name='firstName']").val("");
				$("#frmAccountEdit input[name='lastName']").val("");
				$("#frmAccountEdit input[name='phone']").val("");
				$("#frmAccountEdit input[name='sourceCode']").val("");
				$("#frmAccountEdit input[name='address']").val("");
				$("#frmAccountEdit input[name='fulladdress']").val("");
				$("#frmAccountEdit input[name='city']").val("");
				$("#frmAccountEdit input[name='state']").val("");
				$("#frmAccountEdit input[name='postalCode']").val("");
				$("#frmAccountEdit input[name='latitude']").val("");
				$("#frmAccountEdit input[name='longitude']").val("");
				$("#frmAccountEdit input[name='county']").val("");


				frmAccountEdit.data("current", frmAccountEdit.serialize());
				frmAccountEdit.trigger('keyup');

				$('#modal-edit-account')
				 	.data('customerId', customerId)
				 	.modal({ backdrop: 'static', keyboard: true });
			}

			function viewAccountDetail(){
				var self = $(this)
					, customerId = self.data('customerid')
				;

				$('#modal-account-detail')
				 	.data('customerId', customerId)
				 	.modal({ backdrop: 'static', keyboard: true, width: '50%' });
			}

			$("#tblCustomerList")
				.delegate(".add", "click", addAccount)
				.delegate(".delete", "click", removeAccount)
				.delegate(".view", "click", viewColumnOption)
				.delegate(".view-detail", "click", viewAccountDetail)
				.delegate('.clear', 'click', function(event) {
					$oTable['tblCustomerList'].fnResetAllFilters();
					$("#tblCustomerList input[name='search_lastName']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[2].sSearch);
					$("#tblCustomerList input[name='search_firstName']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[3].sSearch);
					$("#tblCustomerList input[name='search_address']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[4].sSearch);
					$("#tblCustomerList input[name='search_city']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[5].sSearch);
					$("#tblCustomerList input[name='search_postalCode']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[6].sSearch);
					$("#tblCustomerList input[name='search_telephone']").val($oTable['tblCustomerList'].fnSettings().aoPreSearchCols[7].sSearch);
					$("#tblCustomerList_filter input").val($oTable['tblCustomerList'].fnSettings().oPreviousSearch.sSearch);
				})
			;

			$("#tblCustomerList_filter input").tooltip({'html': true,'trigger':'focus', 'title': 'Use the "%" as a wildcard search. eg.("John%", "%Doe").<br/><ul><li>like "TOT%" is true for any string that begins with "TOT".</li><li>like "%ZERO%" is true for any string that contains "ZERO".</li><li>like "%FRESH" is true for any string that ends with "FRESH"</li></ul>'});


			validator = frmAccountEdit.validate({ onkeyup: false });

			 // Add validation rules to the FullAddress field
			 /*
                $("#fulladdress").rules("add", {
                    fulladdress: true,
                    required: true,
                    messages: {
                        fulladdress: "Google cannot locate this address. Please verify that it is a home or business."
                    }
                });
			*/

			function fnShowHide( iCol ) {
				/* Get the DataTables object again - this is not a recreation, just a get of the object */
				var oTable = $oTable['tblCustomerList'];

				var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
				oTable.fnSetColumnVis(iCol, bVis ? false : true);
				oTable.fnSettings().aoColumns[iCol].bSearchable = oTable.fnSettings().aoColumns[iCol].bVisible;
				oTable.fnFilter( "", iCol );
				oTable.fnSettings().aoColumns[iCol].sSearch = "";
				//oTable.fnAdjustColumnSizing();
				oTable.fnDraw();
				$("thead input").keyup( function () {
					filterColumn(this);
				} );

			}

		});
	</script>
</cfmodule>
<cfsavecontent variable="headerHTML">
	<link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.dataTables.css" />
	<link rel="stylesheet" type="text/css" href="/assets/css/bootstrap-modal.css" />
</cfsavecontent>
<cfhtmlhead text="#headerHTML#" />
