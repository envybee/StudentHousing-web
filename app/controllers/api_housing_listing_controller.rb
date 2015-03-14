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
    housing_listing.street_address = params[:street_address]
    housing_listing.postal_code = params[:postal_code]
    housing_listing.city = params[:city]
    housing_listing.province = params[:province]
    housing_listing.country = params[:country]
    housing_listing.active = 1
    housing_listing.save
    if(HousingSetting.find_by(housing_listing_id: id) != nil)
    	housing_settings = HousingSetting.find_by(housing_listing_id: id)
    else
    	housing_settings = HousingSetting.new
    end
    housing_settings.housing_listing_id = id
    housing_settings.rental_type = params[:type]
    housing_settings.start_date = params[:start_date]
    housing_settings.end_date = params[:end_date]
    housing_settings.furnished = params[:furnished]
    housing_settings.rooms_available = params[:bedrooms]
    housing_settings.save
    render :json => {:status => 'success'}
  end

  def near
  	test = HousingListing.near([43, -79], 200)
  	render json:test
  end

  def housing_with_filters
    num_bedrooms = params[:num_bedrooms]
    min_price = params[:min_price]
    max_price = params[:max_price]
    city = params[:city]
    province = params[:province]
    country = params[:country]
    formatted_address = city + " " + province + ", " + country
    housing_listings = HousingListing.near(formatted_address, 50).where('active = ? AND price >= ? AND price <= ?', 1, min_price, max_price)
    render json:housing_listings
  end
end
