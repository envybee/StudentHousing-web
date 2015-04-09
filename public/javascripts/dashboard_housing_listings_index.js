var housing_listing_id = -1;

$(document).ready(function() {
	$("#entry_listings, #draft_listings_table").dataTable();
});

$("#click_here_create_listing").on("click", function(e) {
	e.preventDefault();

	createNewListing();
})

$(".del_btn").on("click", function(e) {
	housing_listing_id = $(this).parent().siblings('input').val();
});

$("#del_confirm").on("click", function(e) {
    deleteEntry();
    $("#confirm_diag").modal('hide');
});

function deleteEntry() {
	var housing_listing_delete_api = "/api/v1/housing/listings/" + housing_listing_id;

	$.ajax({
	  async: false,
	  method: 'delete',
	  url: housing_listing_delete_api,
	  data: {
	  	id: housing_listing_id
	  },
	  success: function(response){
		window.location.reload();
		console.log(response);
	  },
	  error: function(response) {
	  	console.log(response);
	  }
	});
}