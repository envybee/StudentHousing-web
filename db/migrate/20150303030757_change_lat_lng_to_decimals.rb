class ChangeLatLngToDecimals < ActiveRecord::Migration
  def change
  	rename_column :housing_listings, :lat, :latitude
  	rename_column :housing_listings, :lng, :longitude
  	change_column :housing_listings, :latitude, :float, precision: 9, scale: 6
  	change_column :housing_listings, :longitude, :float, precision: 9, scale: 6
  end
end
