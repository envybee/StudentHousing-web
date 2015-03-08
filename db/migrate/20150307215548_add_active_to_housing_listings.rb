class AddActiveToHousingListings < ActiveRecord::Migration
  def change
  	add_column :housing_listings, :active, :boolean
  end
end
