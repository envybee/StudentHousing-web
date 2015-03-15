class DashboardController < ApplicationController
  def index
	find_listings_by_user_id = HousingListing.where(user_id: current_user.id).where.not(active: 0)
	@my_listings = find_listings_by_user_id
  end
  
  def edit
	find_listing_by_id = HousingListing.find(params[:id])
	@edit_listing = find_listing_by_id
  end 
end
