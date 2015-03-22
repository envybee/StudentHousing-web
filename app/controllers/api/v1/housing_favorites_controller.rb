class Api::V1::HousingFavoritesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
  	housing_favorite = HousingFavorite.new
  	housing_favorite.housing_listing_id = params[:housing_listing_id]
  	housing_favorite.user_id = current_user.id
  	housing_favorite.save
  	render :json => {:message => "success"} 
  end

  def destroy

  end
end
