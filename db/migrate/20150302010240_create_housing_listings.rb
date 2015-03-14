class CreateHousingListings < ActiveRecord::Migration
  def change
    create_table :housing_listings do |t|
    	t.string :name, null: false
    	t.string :description
    	t.string :location
    	t.decimal :price, precision: 12, scale: 2
    	t.integer :overall_rating
    	t.integer :price_rating
    	t.string :postal_code, limit: 6
    	t.string :city, limit: 50
    	t.string :province, limit: 20
    	t.string :country, limit: 20
    	t.integer :lat, precision: 3, scale: 6
    	t.integer :lng, precision: 3, scale: 6
    	t.datetime :created_at
    	t.datetime :updated_at
    end

    add_index :housing_listings, [:lat, :lng]

  end
end
