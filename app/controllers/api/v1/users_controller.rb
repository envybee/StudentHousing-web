class Api::V1::UsersController < ApplicationController
  def index
	user_list = User.find(1)
	render json: user_list
  end
end
