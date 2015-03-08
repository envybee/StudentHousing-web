class AddDescriptionToHousingImages < ActiveRecord::Migration
  def change
  	add_column :housing_images, :description, :string
  end
end
