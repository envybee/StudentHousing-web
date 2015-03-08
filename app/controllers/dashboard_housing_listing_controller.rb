class DashboardHousingListingController < ApplicationController
  def new
  	new_housing_listing_id = params[:id]
  	@housing_listing = HousingListing.find(new_housing_listing_id)
  end
end
