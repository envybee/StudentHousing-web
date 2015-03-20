class CreateHousingReviews < ActiveRecord::Migration
  def change
    create_table :housing_reviews do |t|
	    t.integer :housing_listing_id
	    t.integer :user_id
	    t.string :comment
	    t.integer :rating
		t.datetime :created_at
		t.datetime :updated_at
    end
  end
end
