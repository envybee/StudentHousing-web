class Dashboard::Housing::FavoritesController < ApplicationController
  def index
  	@my_favorites = current_user.housing_favorites
  end
end
