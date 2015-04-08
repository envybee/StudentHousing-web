class Housing::ListingsController < ApplicationController
  def index
  	@city = params[:city]
  	@province = params[:province]
  	@country = params[:country]
  	formatted_address = @city + " " + @province + ", " + @country
  	@housing_listings = HousingListing.near(formatted_address, 50).where('active', 1)
  end

  def show
  	housing_listing_id = params[:id]
    if HousingListing.exists?(housing_listing_id)
    	@housing_listing = HousingListing.find(housing_listing_id)
      if !user_signed_in?
        @show_favorite = false
      else
        @show_favorite = true
        if current_user.housing_favorites.exists?(:housing_listing_id => housing_listing_id)
          @already_in_favorites = true
        else
          @already_in_favorites = false
        end
      end
    else
      render plain: "This listing is either not available or has been removed.", status: 404
    end
  end
end
