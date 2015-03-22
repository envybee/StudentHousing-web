class HousingFavorite < ActiveRecord::Base
  belongs_to :housing_listing
  belongs_to :user
end
