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
  end
  def new
  	new_housing_listing_id = params[:id]
  	@housing_listing = HousingListing.find(new_housing_listing_id)
  end

  def edit
	find_listing_by_id = HousingListing.find(params[:id])
	@edit_listing = find_listing_by_id
  end
end
