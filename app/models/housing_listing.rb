class HousingListing < ActiveRecord::Base
	geocoded_by :address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates
	has_one :housing_setting
	has_many :housing_images, dependent: :destroy
	has_many :housing_reviews, dependent: :destroy
	has_many :housing_favorites, dependent: :destroy
	belongs_to :user
	acts_as_paranoid

	def address
	  [street_address, city, province, country].compact.join(', ')
	end

	def send_custom_alerts
		CustomAlertsEmailsJob.delay(run_at: 2.minutes.from_now).perform_later(latitude, longitude)
	end
end
