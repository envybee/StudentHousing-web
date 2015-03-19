class DashboardController < ApplicationController
  def index
	find_listings_by_user_id = HousingListing.where(user_id: current_user.id).where.not(active: 0)
	@my_listings = find_listings_by_user_id
  end
end
