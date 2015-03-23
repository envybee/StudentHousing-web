class Dashboard::Housing::ListingsController < ApplicationController

  def new
  	if current_user.can_access_listing(params[:listing_id])
	  	new_housing_listing_id = params[:listing_id]
	  	@housing_listing = HousingListing.find(new_housing_listing_id)
	else
		render plain: "No permission to access this listing", status: 404
	end
  end

  def edit
  	if current_user.can_access_listing(params[:id])
		find_listing_by_id = HousingListing.find(params[:id])
		@edit_listing = find_listing_by_id
	else
		render plain: "No permission to access this listing", status: 404
	end
  end
end
