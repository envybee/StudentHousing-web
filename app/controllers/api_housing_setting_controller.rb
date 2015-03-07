class ApiHousingSettingController < ApplicationController
  def index 
	housing_setting_list = HousingSetting.find(1)
	render json: housing_setting_list
  end
end
