class HousingListingController < ApplicationController
  def index
  	@city = params[:city]
  	@province = params[:province]
  	@country = params[:country]
  	formatted_address = @city + " " + @province + ", " + @country
  	@housing_listings = HousingListing.near(formatted_address, 50).where('active', 1)
  end

  def show
  	housing_listing_id = params[:id]
  	@housing_listing = HousingListing.find(housing_listing_id)
    if current_user.housing_favorites.exists?(:housing_listing_id => housing_listing_id)
      @show_favorite = false
    else
      @show_favorite = true
    end
  end
  def new
  	if current_user.can_access_listing(params[:id])
	  	new_housing_listing_id = params[:id]
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
