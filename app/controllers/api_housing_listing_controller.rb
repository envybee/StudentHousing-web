class ApiHousingListingController < ApplicationController
  def index
  	housing_listing = HousingListing.find(1)
  	render json: housing_listing
  end
end
