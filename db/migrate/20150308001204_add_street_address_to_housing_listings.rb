class AddStreetAddressToHousingListings < ActiveRecord::Migration
  def change
  	add_column :housing_listings, :street_address, :string
  end
end
