class HousingListing < ActiveRecord::Base
	geocoded_by :address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates
	has_one :housing_setting 
	has_many :housing_images, dependent: :destroy
	has_many :housing_reviews, dependent: :destroy
	belongs_to :user

	def address
	  [street_address, city, province, country].compact.join(', ')
	end
end
