var housing_alert_create_api = "/api/v1/housing/alerts/";

$("#new_alert_btn").on("click", function(e) {
	$("#new_alert_modal").modal("show");
});

$("#alerts_table").DataTable();

var address_input = document.getElementById('alert_address_input');

address_autocomplete = new google.maps.places.Autocomplete(address_input, {
    types: ['geocode']
});

var place;
var address_parts = [];

google.maps.event.addListener(address_autocomplete, 'place_changed', function() {

  	place = address_autocomplete.getPlace();

    var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'short_name',
        administrative_area_level_1: 'short_name',
        postal_code: 'short_name',
        postal_code_prefix: 'short_name',
        country: 'short_name'
    };

    for (var i = 0; i < place.address_components.length; i++) {
        var addressType = place.address_components[i].types[0];

        if(componentForm[addressType]) {
            address_parts[addressType] = place.address_components[i][componentForm[addressType]];
        }
    }

});

$("#alert_submit_btn").on("click", function(e) {
	
	var name = $("#alert_name_input").val();

	if(place) {
	    var street_address = address_parts['street_number'] + " " + address_parts['route'];
	    var city = address_parts['locality'];
	    var postal_code = address_parts['postal_code'].replace(" ", "");
	    var province = address_parts['administrative_area_level_1'];
	    var country = address_parts['country'];
	}

	$.ajax({
	  async: false,
	  method: 'post',
	  url: housing_alert_create_api,
	  data: {
		name: name,
		street_address: street_address,
		city: city,
		province: province,
		country: country
	  },
	  success: function(response){
		window.location.reload();
		console.log(response);
	  },
	  error: function(response) {
		console.log(response);
	  }
	});
});

$(".alert-delete-btn").on("click", function(e) {
	e.preventDefault();

	var current_alert_id = $(this).data("alert-id");
		var housing_alert_delete_api = "/api/v1/housing/alerts/" + current_alert_id;

	$.ajax({
	  async: false,
	  method: 'delete',
	  url: housing_alert_delete_api,
	  success: function(response){
		window.location.reload();
		console.log(response);
	  },
	  error: function(response) {
		console.log(response);
	  }
	});
})