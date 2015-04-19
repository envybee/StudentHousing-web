if(user_has_listings) {	
	function showPriceComparisonChart(avg_price, your_price, max_price, address) {

		var chart = AmCharts.makeChart("chartdiv", {
		    "type": "serial",
		    "theme": "none",
		    "titles": [
				{
					"text": "Comparison Of Listings Near " + address,
					"size": 20
				}
			],
		    "legend": {
		        "useGraphSettings": true,
		        "markerSize":12,
		        "valueWidth":0,
		        "verticalGap":0
		    },
		    "dataProvider": [{
		        "title": "Average Price",
		        "price": avg_price
		    }, {
		        "title": "Your Price",
		        "price": your_price
		    }, {
		        "title": "Max Price",
		        "price": max_price
		    }],
		    "valueAxes": [{
		        "minorGridAlpha": 0.08,
		        "minorGridEnabled": true,
		        "position": "top",
		        "axisAlpha":0
		    }],
		    "startDuration": 1,
		    "graphs": [{
		        "balloonText": "<span style='font-size:13px;'>[[title]]: <b>$[[value]]</b></span>",
		        "title": "Price",
		        "type": "column",
		        "fillAlphas": 0.8,
		         
		        "valueField": "price"
		    }],
		    "rotate": true,
		    "categoryField": "title",
		    "categoryAxis": {
		        "gridPosition": "start"
		    }
		});	
	}

	function showPageViewsByLocPie() {

		var chart = AmCharts.makeChart("pchart_pgviews", {
		    "type": "pie",
		    "theme": "none",
		    "dataProvider": [{
		        "title": "Toronto",
		        "value": 4852
		    }, {
		        "title": "Waterloo",
		        "value": 9899
		    }],
		    "titleField": "title",
		    "valueField": "value",
		    "labelRadius": 5,

		    "radius": "42%",
		    "innerRadius": "60%",
		    "labelText": "[[title]]"
		});	
	}

	function showSourcesbyLocPie() {

		var chart = AmCharts.makeChart("pchart_sources", {
		    "type": "pie",
		    "theme": "none",
		    "dataProvider": [{
		        "title": "Facebook",
		        "value": 4852
		    }, {
		        "title": "Referral",
		        "value": 899
		    }, {
		        "title": "Other",
		        "value": 9899
		    }],
		    "titleField": "title",
		    "valueField": "value",
		    "labelRadius": 5,

		    "radius": "42%",
		    "innerRadius": "60%",
		    "labelText": "[[title]]"
		});	
	}

	function callCompareNearbyListingsPrice(listing_id) {
		$.ajax({
	      method: 'get',
	      url: compare_nearby_listings_price_api,
	      data: {
	      	id: listing_id
	      },
	      success: function(response){
			showPriceComparisonChart(response.average_price, response.listing_price, response.max_price, response.address);
	      },
	      error: function(response) {
	      	console.log(response);
	      }
	    });
	}

	function callNumAlerts(listing_id) {
		$.ajax({
	      method: 'get',
	      url: num_alerts_api,
	      data: {
	      	id: listing_id
	      },
	      success: function(response){
			$("#num_alerts").text(response.num_alerts);
		  },
	      error: function(response) {
	      	console.log(response);
	      }
	    });
	}

	function callRating(listing_id) {
		$.ajax({
	      method: 'get',
	      url: rating_api,
	      data: {
	      	id: listing_id
	      },
	      success: function(response){
			$("#rating").text(response.rating);
		  },
	      error: function(response) {
	      	console.log(response);
	      }
	    });
	}

	function callFavorited(listing_id) {
		$.ajax({
	      method: 'get',
	      url: favorites_api,
	      data: {
	      	id: listing_id
	      },
	      success: function(response){
			$("#favorited").text(response.favorites);
		  },
	      error: function(response) {
	      	console.log(response);
	      }
	    });
	}

	function callPageViewsByLocation() {
		showPageViewsByLocPie();
	}

	function callSourcesByLocation() {
		showSourcesbyLocPie();
	}

	var compare_nearby_listings_price_api = "/api/v1/housing/listings/compare_nearby_listings_price";
	var num_alerts_api = '/api/v1/housing/listings/num_alerts';
	var rating_api = '/api/v1/housing/listings/rating';
	var favorites_api = '/api/v1/housing/listings/favorites';

	callCompareNearbyListingsPrice(compare_listing_id);
	callNumAlerts(compare_listing_id);
	callRating(compare_listing_id);
	callFavorited(compare_listing_id);
	callPageViewsByLocation();
	callSourcesByLocation();

	$(document).on('shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
		var listing_id = $(this).data('listing-id');
		callCompareNearbyListingsPrice(listing_id);
		callNumAlerts(listing_id);
		callRating(listing_id);
		callFavorited(listing_id);
		callPageViewsByLocation();
		callSourcesByLocation();
	});
}