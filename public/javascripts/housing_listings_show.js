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
  var myLatlng = new google.maps.LatLng(housing_listing_lat, housing_listing_long);

    // set the marker position and display it
    marker = new google.maps.Marker({
        animation: google.maps.Animation.DROP,
        map: map,
        position: myLatlng
    });

    map.setCenter(myLatlng);
    map.setZoom(17);

  var panoramaOptions = {
    position: myLatlng,
    pov: {
      heading: 0,
      pitch: 0
    }
  };

  var panorama = new google.maps.StreetViewPanorama(document.getElementById('pano'), panoramaOptions);
  map.setStreetView(panorama);

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

  /*-----------------------------------------
  |               Comments                   |
  -------------------------------------------*/

  $("#comment_submit_btn").on("click", function(e) {
    e.preventDefault();

    var comment = $("#comment_input").val();
    var rating = $("#rating_input").val();

    $.ajax({
      method: 'post',
      url: housing_listing_comment_api,
      data: {
        housing_listing_id: housing_listing_id,
        comment: comment,
        rating: rating
      },
      success: function(response){
        console.log(response);

        if(comment) {

          $("#comment_input").val('')
          $("#no_review_warning").hide();
          var rating_div = "<div class='col-xs-3'>";
          for (var counter = 0; counter < rating; counter++) {
            rating_div += "<i class='fa fa-star' style='font-size: 15px; padding: 0px; margin: 0px;'></i>";
          }
          rating_div += "</div>";
          var append_html = "<div class='col-xs-9'><span class='commenter_name' style='font-size: 20px;'>"+current_user_first_name+"</span> says</div>"+ rating_div + "<div class='col-xs-12 comment' style='font-size: 18px;'>" + comment + "</div>"
          $("#comments_body").append(append_html);
    
        }
      },
      error: function(response) {
        console.log(response);
      }
    });

  })

  /*--------------------------------------------
  |             Send Inquiry Email             |
  ---------------------------------------------*/

  $("#send_message_btn").on("click", function(e) {
    e.preventDefault();

    $("#housing_inquiry_email_modal").modal("show");
  });

  $("#send_email_btn").on("click", function(e) {
    var message = $("#message_input").val();
    var email = $("#email_input").val();

    $.ajax({
      method: 'post',
      url: housing_listing_send_inquiry_email_api,
      data: {
        housing_listing_id: housing_listing_id,
        message: message,
        email: email
      },
      success: function(response){
        console.log(response);
        $("#housing_inquiry_email_modal").modal("hide");
        alert('Email has been sent successfully!');
      },
      error: function(response) {
        console.log(response);
        $("#housing_inquiry_email_modal").modal("hide");
        alert('There was an error sending the email. Please try again later!');
      }
    });
  });

  /*--------------------------------------------
  |                  Favorite                  |
  ---------------------------------------------*/

  $("#favorite_btn").on("click", function(e) {
    e.preventDefault();

    $.ajax({
      method: 'post',
      url: housing_favorite_api,
      data: {
        housing_listing_id: housing_listing_id
      },
      success: function(response){
        console.log(response);
        $("#favorite_btn").slideUp();
        $("#already_in_favorites").slideDown();
      },
      error: function(response) {
        console.log(response);
      }
    });
  });
