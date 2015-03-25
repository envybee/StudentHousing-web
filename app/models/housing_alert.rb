class HousingAlert < ActiveRecord::Base
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  belongs_to :user

  def address
    [street_address, city, province, country].compact.join(', ')
  end
end
