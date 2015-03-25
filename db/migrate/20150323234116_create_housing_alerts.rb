class CreateHousingAlerts < ActiveRecord::Migration
  def change
    create_table :housing_alerts do |t|
      t.string :name
      t.integer :user_id
      t.string :location
      t.string :street_address
	    t.string :city, limit: 50
	    t.string :province, limit: 20
	    t.string :country, limit: 20
	    t.string :postal_code, limit: 6
      t.integer :kilometers
  	  t.float :latitude, precision: 9, scale: 6
  	  t.float :longitude, precision: 9, scale: 6
    end
    add_foreign_key :housing_alerts, :users
  end
end
