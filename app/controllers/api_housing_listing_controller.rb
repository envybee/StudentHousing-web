class ApiHousingListingController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
  	housing_listing = HousingListing.find(1)
  	render json: housing_listing
  end

  def new
  	housing_listing = HousingListing.new
    housing_listing.name = ""
    housing_listing.user_id = current_user.id
    housing_listing.save
    redirect_url = new_housing_listing_url(housing_listing)
    housing_listing_id = housing_listing.id
    render :json => {:redirect_url => redirect_url, 
                                  :housing_listing_id => housing_listing_id }
  end

  def create
  	id = params[:id]
  	housing_listing = HousingListing.find(id)
  	housing_listing.name = params[:name]
    housing_listing.description = params[:description]
    housing_listing.location = params[:street_address] + " " + params[:city] + " " + params[:province] + " " + params[:country] + " " + params[:postal_code]
    housing_listing.price = params[:price]
    housing_listing.postal_code = params[:postal_code]
    housing_listing.city = params[:city]
    housing_listing.province = params[:province]
    housing_listing.country = params[:country]
    housing_listing.active = 1
    housing_listing.save
    render :json => {:status => 'success'}
  end

  def near
  	test = HousingListing.near([43, -79], 200)
  	render json:test
  end
end
