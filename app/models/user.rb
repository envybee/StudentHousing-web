class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :housing_reviews, dependent: :destroy
  has_many :housing_listings
  has_many :housing_favorites
  has_many :housing_alerts

  def can_access_listing(housing_listing_id)
  	housing_listing = HousingListing.find(housing_listing_id)
  	if housing_listing.user_id == self.id
  		return true
  	else
  		return false
  	end
  end

  def can_access_favorite(favorite_id)
    housing_favorite = HousingFavorite.find(favorite_id)
    if housing_favorite.user_id == self.id
      return true
    else
      return false
    end
  end

  def can_access_alert(alert)
    housing_alert = HousingAlert.find(alert)
    if housing_alert.user_id == self.id
      return true
    else
      return false
    end
  end
end
