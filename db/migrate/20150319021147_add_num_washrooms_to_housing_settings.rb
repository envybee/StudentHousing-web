class AddNumWashroomsToHousingSettings < ActiveRecord::Migration
  def change
  	add_column :housing_settings, :num_washrooms, :integer
  end
end
