
function getContentString(details_url, image_url, name, rooms, price) {
  return contentString = '<div id="" style="width: 175px;">' + 
      '<a href="' + details_url + '">' +
      '<img src="' + image_url + '" style="width: 175px; height: 150px; max-width: none;" ' +
      '</img>' +
      '</a>' +
      '<div id="text" style="font-family: sans-serif; text-align:center; margin: 10px; color: #FFFFFF;">' +
                  '<strong>' +
                  name +
                  '</strong>' +
                '</div>' + 
                  '<span id="text" style="font-family: sans-serif; text-align:left; margin-left: 5px; color: #FFFFFF;">' +
                    '<i class="fa fa-bed" style="margin-right: 5px;"></i>' +
                    + rooms + ' bedrooms' +
                  '</span>' +
                  '<span id="text" class="pull-right" style="font-family: sans-serif; text-align:right; margin-right: 5px; color: #FFFFFF;">' +
                    '<i class="fa fa-dollar" style="margin-right: 5px;"></i>' +
                    price +
                  '</span>' +
      '</div>';
}

function removeMarkers() {
  for(var i = 0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers = [];
}

function setClusterListener(markerCluster) {
  google.maps.event.addListener(markerCluster, "clusterclick", function (cluster) {
 
    var clusterClicked = true;
    var clusterMarkers = cluster.getMarkers();
    var testString = "";
    var lat = clusterMarkers[0].getPosition().lat();
    var lng = clusterMarkers[0].getPosition().lng();
    var isCloseEnough = true;

    for(var i = 0; i < clusterMarkers.length; i++) {
      var clusterLatLng = clusterMarkers[i].getPosition();
      if(clusterLatLng.lat() >= (lat - 0.0001) && clusterLatLng.lat() <= (lat + 0.0001) &&
         clusterLatLng.lng() >= (lng - 0.0001) && clusterLatLng.lng() <= (lng + 0.0001) ) {
        isCloseEnough = true;
      } else {
        isCloseEnough = false;
        break;
      }
    }

    if(isCloseEnough) {

      this.setZoomOnClick(false);

      for (var i = 0; i < clusterMarkers.length; i++) {
        google.maps.event.trigger(clusterMarkers[i], 'click');
      }

    } else {
      this.setZoomOnClick(true);
    }
  });
}

function getInfoBoxOptions(contentString) {
  return myOptions = {
     content: contentString
    ,disableAutoPan: false
    ,maxWidth: 0
    ,pixelOffset: new google.maps.Size(-140, 0)
    ,zIndex: null
    ,boxStyle: { 
      background: "#000000"
      ,width: "175px"
     }
    ,closeBoxMargin: "2px 2px 2px 2px"
    ,closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
    ,infoBoxClearance: new google.maps.Size(1, 1)
    ,isHidden: false
    ,pane: "floatPane"
    ,enableEventPropagation: false
  };
}
  
  
  // Instantiate the sliders
  var price_slider = $('#price_slider').slider();
  var bedroom_slider = $('#bedroom_slider').slider();

  $("#filter_submit_btn").on("click", function(e) {
    e.preventDefault();

    var filter_price = price_slider.slider('getValue');
    var filter_num_rooms = bedroom_slider.slider('getValue');


    $.ajax({
      method: 'post',
      url: api_filter_housing_listing,
      data: {
        'min_price': filter_price[0],
        'max_price': filter_price[1],
        'min_num_bedrooms': filter_num_rooms[0],
        'max_num_bedrooms': filter_num_rooms[1],
        'city': current_city,
        'province': current_province,
        'country': current_country
      },
      success: function(response){
        responseCluster.clearMarkers();
        console.log(response);

        $("#housing_listing_results_wrapper").html("");
        removeMarkers();

        if(response.length == 0) {
          $("#housing_listing_results_wrapper").html("No housing listings available. Please use a broader range of filters to get more listings.");
        }

        for(var i = 0; i < response.length; i++) {
          var housing_listing = response[i];
          var section = "<section class='panel'><section class='panel-body'>";

          var image_div = "<a href='" + "'> <img src='" + housing_listing['url'] + "' style='width: 275px; height: 230px;'> </img></a>";

          var name_div = "<div id='text' style='font-family: sans-serif; text-align:center; margin: 10px;'> <strong style='font-size: 22px;'>" + housing_listing['name'] + "</strong></div>";

          if(housing_listing['location'].length > 32) {
            housing_listing_location = housing_listing['location'].substring(0, 31) + '...';
          } else {
            housing_listing_location = housing_listing['location'];
          }

          var location_div = "<div style='margin: 10px;'> <i class='fa fa-map-marker'></i> " + housing_listing_location + "</div>";

          var bedrooms_div = "<div id='text' class='col-md-6 col-xs-12' style='font-family: sans-serif; text-align:left;'><i class='fa fa-bed'></i> " + housing_listing['rooms_available'] + " bedrooms </div>";

          var price_div = "<div id='text' class='col-md-6 col-xs-12' style='font-family: sans-serif; text-align:right;'> <i class='fa fa-dollar'></i> " + housing_listing['price'] + "</div>"

          var section_end = "</section></section>";

          $("#housing_listing_results_wrapper").append(section + image_div + name_div + location_div + bedrooms_div + price_div + section_end);

          /*------------------------------------------
                      Google Maps Markers            |
          -------------------------------------------*/

          var myLatlng = new google.maps.LatLng(housing_listing['latitude'], housing_listing['longitude']);

          var contentString = getContentString(housing_listing['url'], housing_listing['name'], housing_listing['rooms_available'], housing_listing['price']);

          var infoBoxOptions = getInfoBoxOptions(contentString);

          // set the marker position and display it
          var marker = new google.maps.Marker({
              animation: google.maps.Animation.DROP,
              map: map,
              position: myLatlng
          });

          markers.push(marker);

          var infobox = new InfoBox(infoBoxOptions);
          var content = contentString;

          google.maps.event.addListener(marker,'click', (function(marker,content,infobox){ 
              return function() {
                infobox.open(map, marker);
              };
          })(marker,content,infobox));
        }

        var markerCluster = new MarkerClusterer(map, markers);

        setClusterListener(markerCluster);

        responseCluster = markerCluster;
        
      },
      error: function(response) {
        console.log(response);
      }
    });

  });
