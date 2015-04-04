/*----------------------------------------------------------
|                Load form (edit mode)                      |
-----------------------------------------------------------*/
// If we are not in the edit mode, then we don't need to load the form
if (housing_listing_is_active) {
  $(function() {
    var isFurnished = is_furnished_active;
    $("#furnished_checkbox").bootstrapSwitch('state', isFurnished);
    var rental_type = ((rental_active_active == "Apartment") ? 1 : 0);
    $("#housing_type_checkbox").bootstrapSwitch('state', rental_type);
    $("#internet_checkbox").bootstrapSwitch('state', internet_active);
    $("#parking_checkbox").bootstrapSwitch('state', parking_active);
    $("#ensuite_washroom_checkbox").bootstrapSwitch('state', ensuite_washroom_active);
    $("#washer_dryer_checkbox").bootstrapSwitch('state', washer_dryer_active);
    $("#gym_checkbox").bootstrapSwitch('state', gym_active);
    $("#pet_friendly_checkbox").bootstrapSwitch('state', pet_friendly_active);

    var startDatePcs = start_date_active;
    startDatePcs = startDatePcs.split("-");
    $('#housing_listing_start_date').datepicker('setDate', new Date(startDatePcs[0], startDatePcs[1]-1, startDatePcs[2].split(" ")[0]));

    var endDatePcs = end_date_active;
    endDatePcs = endDatePcs.split("-");
    $('#housing_listing_end_date').datepicker('setDate', new Date(endDatePcs[0], endDatePcs[1]-1, endDatePcs[2].split(" ")[0]));

    $("#address_input").val(address_active);
    $("#housing_listing_title").val(title_active);
    $("#housing_listing_bedrooms").val(bedrooms_avail_active);
    $("#housing_listing_bathrooms").val(bathrooms_avail_active);
    $("#housing_listing_price").val(price_active);
    $("#housing_listing_details").text(details_active);
  });
}

/*----------------------------------------------------------
|                     Validation                            |
-----------------------------------------------------------*/

$("#create_listing_form").validate({
  rules: {
    address_input: 'required',
    housing_listing_title: 'required',
    housing_listing_bedrooms: {
      required: true,
      number: true
    },
    housing_listing_bathrooms: {
      required: true,
      number: true
    },
    housing_listing_details: 'required',
    housing_listing_price: {
      required: true,
      number: true
    },
    housing_listing_start_date: 'required',
    housing_listing_end_date: 'required'
  }
});

$('.datepicker').datepicker({
  format: "M dd, yyyy",
  autoclose: true,
  showToday: true,
  sideBySide: true,
  pickerPosition: "bottom-right"
})

/*----------------------------------------------------------
|                     Google Maps                          |
-----------------------------------------------------------*/

var mapOptions = {
    center: new google.maps.LatLng(43.4304343, -80.4763151),
    minZoom: 10,
    zoom: 14,
    maxZoom: 17,
    scrollwheel: false,
    streetViewControl: false,
    panControl: false,
    mapTypeControl: false
};

var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);


var address_input = document.getElementById('address_input');

address_autocomplete = new google.maps.places.Autocomplete(address_input, {
    types: ['geocode']
});

var marker;

var address_parts = {};

google.maps.event.addListener(address_autocomplete, 'place_changed', function() {

  var place = address_autocomplete.getPlace();

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

  if(marker) {
    marker.setMap(null);
  }

  // set the marker position and display it
  marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP,
      map: map,
      position: place.geometry.location
  });

  map.setCenter(place.geometry.location);
  map.setZoom(17);

});

/*---------------------------------------
|           Click listeners             |
----------------------------------------*/

$("#upload_photos_btn").on("click", function(e) {
  e.preventDefault();

  $("#photos_modal").modal("show");

});

$("#custom_photo_upload_submit_btn").on("click", function(e) {
  e.preventDefault();

  $("#photo_upload_submit_btn").click();
});

$('#publish_confirm').on("click", function(e) {
    e.preventDefault();
    $("#publish_diag").modal("hide");
    window.location.href = dashboard_index;

});

$('#cancel_btn').on("click", function(e) {
  e.preventDefault();
  window.location.href = dashboard_index;
});

$("#publish_confirm").on("click", function(e) {
    window.location.href = dashboard_index;
});

$("#more_amenities_btn").on("click", function(e) {
  e.preventDefault();

  if($("#amenities_btn_text").text() === 'More Amenities') {
    $("#more_amenities").slideDown();
    $("#amenities_btn_text").html('Less Amenities');
  } else {
    $("#more_amenities").slideUp();
    $("#amenities_btn_text").html('More Amenities');
  }
})

$("#submit_btn").on("click", function(e) {
  e.preventDefault();

  if($("#create_listing_form").valid()) {

    var street_address = address_parts['street_number'] + " " + address_parts['route'];
    var city = address_parts['locality'];
    var postal_code = address_parts['postal_code'].replace(" ", "");
    var province = address_parts['administrative_area_level_1'];
    var country = address_parts['country'];
    var title = $("#housing_listing_title").val();
    var description = $("#housing_listing_details").val(); 
    var bedrooms = $("#housing_listing_bedrooms").val();
    var bathrooms = $("#housing_listing_bathrooms").val();
    var furnished = $("#furnished_checkbox").is(":checked") ? 1 : 0;
    var type = $("#housing_type_checkbox").is(":checked") ? 'Apartment' : 'House';
    var internet = $("#internet_checkbox").is(":checked") ? 1 : 0;
    var parking = $("#parking_checkbox").is(":checked") ? 1 : 0;
    var ensuite_washroom = $("#ensuite_washroom_checkbox").is(":checked") ? 1 : 0;
    var washer_dryer = $("#washer_dryer_checkbox").is(":checked") ? 1 : 0;
    var gym = $("#gym_checkbox").is(":checked") ? 1 : 0;
    var pet_friendly = $("#pet_friendly_checkbox").is(":checked") ? 1 : 0;
    var price = $("#housing_listing_price").val();
    var start_date = $("#housing_listing_start_date").val();
    var end_date = $("#housing_listing_end_date").val();

    $.ajax({
      async: false,
      method: 'put',
      url: housing_listing_update_api,
      data: {
        id: current_housing_listing_id,
        street_address: street_address,
        city: city,
        postal_code: postal_code,
        province: province,
        country: country,
        name: title,
        description: description,
        bedrooms: bedrooms,
        bathrooms: bathrooms,
        furnished: furnished,
        type: type,
        internet: internet,
        parking: parking,
        ensuite_washroom: ensuite_washroom,
        washer_dryer: washer_dryer,
        gym: gym,
        pet_friendly: pet_friendly,
        price: price,
        start_date: start_date,
        end_date: end_date
      },
      success: function(response){
        console.log(response);
        $("#publish_diag").modal("show");
      },
      error: function(response) {
        console.log(response);
      }
    });
  } else {
    console.log('error in creating listing');
  }

});

/*-----------------------------------------
|            Bootstrap Switches           |
------------------------------------------*/

$("#furnished_checkbox").bootstrapSwitch({
  onText: 'Furnished',
  offText: 'Unfurnished',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

$("#housing_type_checkbox").bootstrapSwitch({
  onText: 'Apartment',
  offText: 'House',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

$("#internet_checkbox").bootstrapSwitch({
  onText: 'Yes',
  offText: 'No',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

$("#parking_checkbox").bootstrapSwitch({
  onText: 'Yes',
  offText: 'No',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

$("#ensuite_washroom_checkbox").bootstrapSwitch({
  onText: 'Yes',
  offText: 'No',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

$("#washer_dryer_checkbox").bootstrapSwitch({
  onText: 'Yes',
  offText: 'No',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

$("#gym_checkbox").bootstrapSwitch({
  onText: 'Yes',
  offText: 'No',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

$("#pet_friendly_checkbox").bootstrapSwitch({
  onText: 'Yes',
  offText: 'No',
  onColor: 'success',
  offColor: 'info',
  size: 'small',
});

/*------------------------------------------------------------  
|                       Cloudinary Upload                    |
-------------------------------------------------------------*/

$(".cloudinary-fileupload").on("cloudinarydone", function(e, data) {

  child_logo_uploaded = true; // Set the flag so that users know when to 
  var cloudinary_upload_response = data.jqXHR.responseJSON;
  var cl_image_public_id = cloudinary_upload_response.public_id;
  var cl_image_id; // Corresponds to the row id of the image in the database

  if(e.currentTarget.id == 'default_banner_image_file_upload') {
    image_category = 'banner';
  }

  // Store the cloudinary upload information in the database
  $.ajax({
    async: false,
    method: 'post',
    url: cloudinary_image_new_api,
    data: {
      cloudinary_upload_response: cloudinary_upload_response,
      housing_listing_id: current_housing_listing_id,
      image_title: $("#image_title").val(),
      image_description: $("#image_description").val()
    },
    success: function(response){
      console.log(response);
      var cloudinary_image_response = response.image_response;
      var housing_image = response.housing_image;
      
      var data_slide_to = $("#carousel_indicators").children().length;
      var $cloudinary_image_transformed = $.cloudinary.image(cloudinary_image_response.public_id, 
                                          { width: 555, height: 315, crop: 'fill' });
      
      $("#carousel_indicators").append("<li data-target='#carousel-example-generic' data-slide-to= " + data_slide_to + "></li>");

      var $title_description_html = $("<div class='carousel-caption'><h3>" + housing_image['title'] + "</h3><p>" + housing_image['description'] + "</p></div>");

      var $div_item = $("<div class='item'></div>");

      $div_item.append($cloudinary_image_transformed).append($title_description_html);

      $("#carousel_inner").append($div_item);

    },
    error: function(response) {
      console.log(response);
    },
    complete: function() {
      $("#photos_modal").modal("hide");
    }
  });

});

