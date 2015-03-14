class CreateHousingSettings < ActiveRecord::Migration
  def change
    create_table :housing_settings do |t|
    	t.integer :housing_listing_id
    	t.string :rental_type
    	t.datetime :start_date
    	t.datetime :end_date
    	t.boolean :furnished
    	t.integer :total_rooms
    	t.integer :rooms_available
    end
  end
end
