$("#post_new_place_btn").on("click", function(e) {
	e.preventDefault();

  createNewListing();
});

function createNewListing() {
  var l = Ladda.create( document.querySelector( '#post_new_place_btn' ) );

  $.ajax({
    method: 'post',
    url: api_new_housing_listing,
    beforeSend: function() {
      l.start();
    },
    success: function(response){
      console.log(response);
      window.location.href = response.redirect_url;
    },
    error: function(response) {
      console.log(response);
    },
    complete: function() {
      l.stop();
    }
  });
}
