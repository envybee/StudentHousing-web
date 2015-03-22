class ChangeHousingSettings < ActiveRecord::Migration
  def change
  	add_column :housing_settings, :internet, :boolean, default: 0
  	add_column :housing_settings, :parking, :boolean, default: 0
  	add_column :housing_settings, :ensuite_washroom, :boolean, default: 0
  	add_column :housing_settings, :washer_dryer, :boolean, default: 0
  	add_column :housing_settings, :gym, :boolean, default: 0
  	add_column :housing_settings, :pet_friendly, :boolean, default: 0
  end
end
