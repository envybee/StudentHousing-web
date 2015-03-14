class HousingListing < ActiveRecord::Base
	geocoded_by :address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates
	has_one :housing_setting 

	def address
	  [street_address, city, province, postal_code].compact.join(', ')
	end
end
