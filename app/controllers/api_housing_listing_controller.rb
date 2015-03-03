class ApiHousingListingController < ApplicationController
  def index
  	housing_listing = HousingListing.find(1)
  	render json: housing_listing
  end

  def near
  	test = HousingListing.near([48, 76], 200)
  	render json:test
  end
end
