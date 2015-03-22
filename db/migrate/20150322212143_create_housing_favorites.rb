class CreateHousingFavorites < ActiveRecord::Migration
  def change
    create_table :housing_favorites do |t|
      t.integer :housing_listing_id
      t.integer :user_id
    end
    add_foreign_key :housing_favorites, :users
    add_foreign_key :housing_favorites, :housing_listings
  end
end
