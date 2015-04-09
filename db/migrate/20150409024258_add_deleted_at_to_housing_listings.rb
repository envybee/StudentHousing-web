class AddDeletedAtToHousingListings < ActiveRecord::Migration
  def change
    add_column :housing_listings, :deleted_at, :datetime
    add_index :housing_listings, :deleted_at
  end
end
