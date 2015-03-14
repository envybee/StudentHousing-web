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
  
  def update
	u_id = params[:id]
	update_listing = HousingListing.find(u_id)
	update_listing.name = params[:name]
	update_listing.description = params[:description]
	update_listing.location = params[:location]
	update_listing.price = params[:price]
	update_listing.street_address = params[:street_address]
	update_listing.city = params[:city]
	update_listing.province = params[:province]
	update_listing.country = params[:country]
	update_listing.postal_code = params[:postal_code]
	update_listing.save
  end
  
  def delete 
	del_id = params[:id]
	del_entry = HousingListing.find(del_id)
	del_entry.destroy
  end
end
