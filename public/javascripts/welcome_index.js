$( document ).ready(function() {

	var address_input = document.getElementById('address_input');

    address_autocomplete = new google.maps.places.Autocomplete(address_input, {
        types: ['(cities)']
    });

    $("#sign_in_btn").on("click", function(e) {
    	e.preventDefault();

    	$("#login_modal").modal("show");
    });

    $("#register_btn").on("click", function(e) {
    	e.preventDefault(); 

    	$("#login_modal").modal("hide");
    	$("#register_modal").modal("show");
    });

    var place;

    google.maps.event.addListener(address_autocomplete, 'place_changed', function() {

	  place = address_autocomplete.getPlace();

	});

	$("#location_search_btn").on("click", function(e) {

		e.preventDefault();
			var l = Ladda.create( document.querySelector( '#location_search_btn' ) );
			l.start();

		if(place) {
			var address_components = place.address_components;
			var city, province, country;

		  for(var i = 0; i < place.address_components.length; i++) {
			  var addressType = place.address_components[i].types[0];
			  if(addressType == 'locality') {
			  	city = place.address_components[i].short_name;
			  } else if (addressType == 'administrative_area_level_1') {
			  	province = place.address_components[i].short_name;
			  } else if (addressType == 'country') {
			  	country = place.address_components[i].long_name;
			  }
		  }

		  console.log(city);
		  console.log(province);
		  console.log(country);

		  window.location.href = "/housing/listings/index/" + city + "/" + province + "/" + country;

		}

		l.stop();
	})
});