class HousingListingController < ApplicationController
  def show
  	city = params[:city]
  	province = params[:province]
  	country = params[:country]
  	formatted_address = city + " " + province + ", " + country
  	@housing_listings = HousingListing.near(formatted_address, 50).where('active', 1)
  end
end
