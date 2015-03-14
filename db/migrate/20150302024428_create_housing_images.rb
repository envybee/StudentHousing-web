class CreateHousingImages < ActiveRecord::Migration
  def change
    create_table :housing_images do |t|
    	t.integer :housing_listing_id
    	t.string :url
    end
  end
end
