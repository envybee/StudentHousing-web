class AddUserIdToHousingListings < ActiveRecord::Migration
  def change
  	add_column :housing_listings, :user_id, :integer
  end
end
