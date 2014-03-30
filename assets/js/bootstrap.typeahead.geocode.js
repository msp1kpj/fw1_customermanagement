!
function ($) {
    "use strict";
	var service = new google.maps.places.AutocompleteService();
	var pService = new google.maps.places.PlacesService($('#address')[0]);
	var map = new google.maps.Map($("#map_canvas1")[0], {
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	});
	var ne = new google.maps.LatLng(45.306768,-92.123322);
   	var sw = new google.maps.LatLng(44.554271,-93.952546);
   	var labels = [];
	var mapped = {};
	var placesDetails = ("id url website vicinity reference name rating international_phone_number icon formatted_phone_number").split(" ");
	var defaultBounds = new google.maps.LatLngBounds(sw, ne);
	 map.fitBounds(defaultBounds);
	 google.maps.event.trigger(map, 'resize');

	$.fn.typeahead.geoDefaults = {
		source: function(query, process) {

			service.getPlacePredictions({ input: query, types: ["geocode", "establishment"], componentRestrictions: {country: 'us'} , bounds: defaultBounds, location : new google.maps.LatLng(44.901909, -93.078772), radius: 80.47 }, function(predictions, status) {
				//console.log(['source', predictions]);
				if (status == google.maps.places.PlacesServiceStatus.OK) {
					labels = [];
					mapped = {};
					$.each(predictions, function(i,prediction) {
						mapped[prediction.description] = prediction;
						labels.push(prediction.description);
					});
					process(labels);
				}
			});
		}
		, matcher:function(){return true;}
		, updater: function (item) {
			//console.log('updater', item, mapped[item], mapped[item].reference);
			$('#city').val(mapped[item].terms[1].value);
			$('#state').val(mapped[item].terms[2].value);
			pService.getDetails(mapped[item], populate);


			return mapped[item].terms[0].value;
		}
	}

	function populate(place, status){
		//console.log('populate', place, status);
		if (status == google.maps.places.PlacesServiceStatus.OK) {
			var data = {}
				, geometry = place.geometry
				, viewport = geometry.viewport
				, bounds = geometry.bounds
			;

			var marker = new google.maps.Marker({
				map: map,
				title: place.geometry.formatted_address,
				position: place.geometry.location
				});
			google.maps.event.trigger(map, 'resize');
			map.setZoom(18);
			map.setCenter(place.geometry.location);

			// Create a simplified version of the address components.
			$.each(place.address_components, function(index, object){
				var name = object.types[0];
				data[name] = object.long_name;
				data[name + "_short"] = object.short_name;
			});


			  $.each(placesDetails, function(index, key){
			  	data[key] = place[key];
			  });

			//$('#address').val(data["name"]);
			//$('#city').val(data["locality"]);
			//$('#state').val(data["administrative_area_level_1_short"]);
			$('#postalCode').val(data["postal_code"]).focus();
			$("#frmAccountEdit").trigger('keyup');
		}

	}


}(window.jQuery);