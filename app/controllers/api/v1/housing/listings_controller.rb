class Api::V1::Housing::ListingsController < ApplicationController
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
    redirect_url = dashboard_housing_listing_new_url(housing_listing)
    housing_listing_id = housing_listing.id
    render :json => {:redirect_url => redirect_url, 
                                  :housing_listing_id => housing_listing_id }
  end

  def create
    housing_listing = HousingListing.new
    housing_listing.name = ""
    housing_listing.user_id = current_user.id
    housing_listing.active = 0
    housing_listing.save
    housing_listing_id = housing_listing.id
    housing_setting = HousingSetting.new
    housing_setting.housing_listing_id = housing_listing_id
    housing_setting.save
    redirect_url = edit_dashboard_housing_listing_url(housing_listing)
    render :json => {:redirect_url => redirect_url, 
                                  :housing_listing_id => housing_listing_id }
  end

  def near
  	test = HousingListing.near([43, -79], 200)
  	render json:test
  end

  def comment
    housing_listing_id = params[:housing_listing_id]
    comment = params[:comment]
    rating = params[:rating]
    housing_review = HousingReview.new
    housing_review.housing_listing_id = housing_listing_id
    housing_review.user_id = current_user.id
    housing_review.comment = comment
    housing_review.rating = rating
    housing_review.save
    housing_listing = HousingListing.find(housing_listing_id)
    housing_listing.overall_rating = (housing_listing.housing_reviews.sum("rating")) / housing_listing.housing_reviews.count
    housing_listing.save
    render :json => {:status => 'success'}
  end

  def send_inquiry_email
    housing_listing_id = params[:housing_listing_id]
    email = params[:email]
    message = params[:message]
    housing_listing = HousingListing.find(housing_listing_id)
    @user = housing_listing.user
    UserMailer.housing_inquiry_email(@user, email, message).deliver_now
    render :json => {:status => "success"}
  end
  
  def housing_with_filters
    min_num_bedrooms = params[:min_num_bedrooms]
    max_num_bedrooms = params[:max_num_bedrooms]
    min_price = params[:min_price]
    max_price = params[:max_price]
    city = params[:city]
    province = params[:province]
    country = params[:country]
    formatted_address = city + " " + province + ", " + country
    housing_listings = HousingListing.near(formatted_address, 50).joins('LEFT JOIN housing_images ON housing_listings.id = housing_images.housing_listing_id INNER JOIN housing_settings ON housing_listings.id = housing_settings.housing_listing_id').where('active = ? AND price >= ? AND price <= ? AND housing_settings.rooms_available >= ? AND housing_settings.rooms_available <= ?', 1, min_price, max_price, min_num_bedrooms, max_num_bedrooms).group('housing_listings.id').select('housing_listings.*, housing_images.*, housing_settings.*')
    render json:housing_listings
  end
  
  def update
    if current_user.can_access_listing(params[:id])
      id = params[:id]
      housing_listing = HousingListing.find(id)
      if housing_listing.active == 0
        send_alerts = false
      else
        send_alerts = true
      end
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
      
      housing_settings = HousingSetting.find_by(housing_listing_id: id)
      housing_settings.housing_listing_id = id
      housing_settings.rental_type = params[:type]
      housing_settings.start_date = params[:start_date]
      housing_settings.end_date = params[:end_date]
      housing_settings.furnished = params[:furnished]
      housing_settings.internet = params[:internet]
      housing_settings.parking = params[:parking]
      housing_settings.ensuite_washroom = params[:ensuite_washroom]
      housing_settings.washer_dryer = params[:washer_dryer]
      housing_settings.gym = params[:gym]
      housing_settings.pet_friendly = params[:pet_friendly]
      housing_settings.rooms_available = params[:bedrooms]
      housing_settings.num_washrooms = params[:bathrooms]
      housing_settings.save

      if send_alerts
        housing_listing.send_custom_alerts
      end
      render :json => {:status => 'success'}
    else
      render :json => {:message => "error"}, :status => 400
  end
  end
  
  def destroy 
    if current_user.can_access_listing(params[:id])
    	del_id = params[:id]
    	del_entry = HousingListing.find(del_id)
    	del_entry.destroy
      render :json => {:status => "success"}
    else
      render :json => {:message => "error"}, :status => 400
    end
  end

  def compare_nearby_listings_price
    listing_id = params[:id]
    housing_listing = HousingListing.find(listing_id)
    nearby_listings = HousingListing.near(housing_listing.location, 3)
    # render :json => {:status => nearby_listings.average(:price)}
    render :json => {:average_price => nearby_listings.average(:price), 
                    :listing_price => housing_listing.price,
                    :max_price => nearby_listings.maximum(:price),
                    :address => housing_listing.location.truncate(32)
                    }
  end
end
