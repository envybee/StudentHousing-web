class Api::V1::Housing::FavoritesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
  	housing_favorite = HousingFavorite.new
  	housing_favorite.housing_listing_id = params[:housing_listing_id]
  	housing_favorite.user_id = current_user.id
  	housing_favorite.save
  	render :json => {:message => "success"} 
  end

  def destroy
    del_id = params[:id]
    del_entry = HousingFavorite.find(del_id)
    del_entry.destroy
    render :json => {:status => "success"}
  end
end
