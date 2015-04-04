$(document).ready(function() {
	$("#entry_listings").DataTable();
});

$("#click_here_create_listing").on("click", function(e) {
	e.preventDefault();

	createNewListing();
});

$("#favorite_remove_btn").on("click", function(e) {
	e.preventDefault();

	var favorite_id = $(this).data('favorite-id');
	var housing_favorite_delete_api = "/api/v1/housing/favorites/" + favorite_id;
	
	$.ajax({
	  async: false,
	  method: 'delete',
	  url: housing_favorite_delete_api,
	  success: function(response){
		window.location.reload();
		console.log(response);
	  },
	  error: function(response) {
		console.log(response);
	  }
	});
});