class Dashboard::Housing::ListingsController < ApplicationController

  def edit
  	if current_user.can_access_listing(params[:id])
		find_listing_by_id = HousingListing.find(params[:id])
		@housing_listing = find_listing_by_id
	else
		render plain: "No permission to access this listing", status: 404
	end
  end
end
