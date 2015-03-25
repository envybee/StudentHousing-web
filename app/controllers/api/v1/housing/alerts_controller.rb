class Api::V1::Housing::AlertsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
  	housing_alert = HousingAlert.new
    housing_alert.name = params[:name]
  	housing_alert.user_id = current_user.id
    housing_alert.location = params[:street_address] + " " + params[:city] + " " + params[:province] + " " + params[:country]
    housing_alert.street_address = params[:street_address]
    housing_alert.city = params[:city]
    housing_alert.province = params[:province]
    housing_alert.country = params[:country]
    housing_alert.kilometers = 3
  	housing_alert.save
  	render :json => {:message => "success"} 
  end

  def destroy
    del_id = params[:id]
    del_entry = HousingAlert.find(del_id)
    del_entry.destroy
    render :json => {:status => "success"}
  end

end
