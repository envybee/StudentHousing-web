class Dashboard::Housing::ListingsController < ApplicationController

  def index
	find_listings_by_user_id = HousingListing.where(user_id: current_user.id).where.not(active: 0)
	@my_listings = find_listings_by_user_id
	@my_inactive_listings = current_user.housing_listings.where.not(active: 1)
  end

  def edit
  	if current_user.can_access_listing(params[:id])
		find_listing_by_id = HousingListing.find(params[:id])
		@housing_listing = find_listing_by_id

		find_setting_by_id = HousingSetting.find_by(housing_listing_id: params[:id])
		@housing_setting = find_setting_by_id
	else
		render plain: "No permission to access this listing", status: 404
	end
  end
end
